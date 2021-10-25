class MediumEditorSt {
  static instancesMap = new WeakMap()
  static extensions = {}

  static initNotLoadedEditor() {
    let editors = Array.from(document.querySelectorAll(`.meditor-editable[data-loaded="false"]`))
    editors.forEach(html => {
      new MediumEditorSt(html)
    })
  }

  static getInstance(querySelector) {
    return this.instancesMap.get(document.querySelector(querySelector))
  }

  static convertor() {
    if (!this.showdownConvertor) {
      this.showdownConvertor = new showdown.Converter({extensions: ['xssfilter']})
    }
    return this.showdownConvertor
  }

  static save(selector) {
    document.body.style.cursor = "progress"
    return MediumEditorSt.getInstance(selector).getValue()
  }

  static saveCompleted() {
    document.body.style.cursor = "default"
  }

  static saveFailed() {
    document.body.style.cursor = "default"
  }

  constructor(editor) {
    this.delayMap = new Map()
    this.editor = editor
    let options = {
      relativeContainer: editor.parentElement,
      extensions: {}
    }
    let extensions = JSON.parse(this.editor.dataset["extensions"])
    if (extensions && extensions.length) {
      extensions.forEach(extName => {
        options.extensions[extName.toLowerCase()] = Function(`return new ${extName}()`)()
      })
    }
    let buttons = JSON.parse(this.editor.dataset["buttons"])
    if (buttons && buttons.length) {
      options.toolbar = {
        buttons: []
      }
      buttons.forEach(extName => {
        options.toolbar.buttons.push(extName.toLowerCase())
      })
    }
    console.log(options)
    this.editor.innerHTML = this.constructor.convertor().makeHtml(this.editor.innerHTML)
    this.mediumEditors = new MediumEditor([this.editor], options)

    this.mediumEditors.subscribe("editableInput", (event, editable) => {
      this.delay("onInputChange", 1000, () => {
        this.onInputChange(event, editable)
      })
    })

    MediumEditorSt.instancesMap.set(editor, this)
  }

  onInputChange(event, editable) {
    console.log(editable, event)
  }

  getValue() {
    return this.constructor.convertor().makeMarkdown(this.editor.innerHTML)
      .replace(/<(\/)?br>/g, "")
      .replace(/\(<([.\w\/]*)>\)/g, "($1)")
  }

  delay(key, duration, fct) {
    if (this.delayMap.has(key)) {
      clearTimeout(this.delayMap.get(key))
    }
    this.delayMap.set(key, setTimeout(() => {
      this.delayMap.delete(key)
      fct()
    }, duration))
  }
}

window.addEventListener("load", MediumEditorSt.initNotLoadedEditor)

let SaveButton = MediumEditor.extensions.button.extend({
  name: 'savebutton',
  contentDefault: '<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24"><path fill="currentColor" d="M15.004 3h2.996v5h-2.996v-5zm8.996 1v20h-24v-24h20l4 4zm-19 5h14v-7h-14v7zm16 4h-18v9h18v-9zm-2 2h-14v1h14v-1zm0 2h-14v1h14v-1zm0 2h-14v1h14v-1z"/></svg>', // default innerHTML of the button
  aria: 'save',
  action: 'save',
  init: function () {
    MediumEditor.extensions.button.prototype.init.call(this)
  },
  handleClick: function (event) {
    Function('"use strict";return ('+this.base.elements[0].dataset["saveCallback"]+ ')')(this)
  }
})

window.addEventListener("load", MediumEditorSt.init)