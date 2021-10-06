class MediumEditorSt {
  static singleton

  static init() {
    MediumEditorSt.getInstance()
  }

  static getInstance() {
    if (!this.singleton) {
      this.singleton = new MediumEditorSt()
    }
    return this.singleton
  }

  elementNodeListOf = this.formatNewEditors()

  constructor() {
    this.delayMap = new Map()
    let editors = this.elementNodeListOf
    this.mediumEditors = new MediumEditor(editors)

    this.mediumEditors.subscribe("editableInput", (event, editable)=> {
      this.delay( "onInputChange", 1000,()=> {
        this.onInputChange(event, editable)
      })
    })
  }

  formatNewEditors() {
    let editors = document.querySelectorAll(".meditor-editable.not-loaded")
    editors.forEach(html => {
      html.innerHTML = this.convertor().makeHtml(html.innerHTML)
    })
    return editors
  }

  onInputChange(event, editable) {
    console.log(editable, event)
  }

  getValueForEditor(htmlRootEditor) {
    return this.convertor().makeMarkdown(htmlRootEditor.innerHTML)
  }

  addNotLoadedEditors() {
    let editors = document.querySelectorAll(".meditor-editable.not-loaded")
    this.mediumEditors.addElements(editors)
  }

  removeEditors(elements) {
    this.mediumEditors.removeElements(elements)
  }

  delay(key, duration, fct) {
    if(this.delayMap.has(key)) {
      clearTimeout(this.delayMap.get(key))
    }
    this.delayMap.set(key, setTimeout(fct, duration))
  }

  convertor() {
    if (!this.showdownConvertor) {
      this.showdownConvertor = new showdown.Converter({extensions: ['xssfilter']})
    }
    return this.showdownConvertor
  }
}

window.addEventListener("load", MediumEditorSt.init)