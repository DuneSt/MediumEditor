Class {
	#name : #MEditorAbstractDemo,
	#superclass : #WAComponent,
	#category : #'MediumEditor-Demo'
}

{ #category : #rendering }
MEditorAbstractDemo class >> description [
	^ self subclassResponsibility
]

{ #category : #rendering }
MEditorAbstractDemo class >> title [
	^ self subclassResponsibility
]

{ #category : #accessing }
MEditorAbstractDemo >> description [
	^ self class description
]

{ #category : #rendering }
MEditorAbstractDemo >> renderCodeOfDemoOn: html [
	html heading
		level3;
		with: 'Code:'.
	html div
		class: 'meditor-demo-snippet-code';
		with: [ html text: #TODO"html
				render:
					(PrismComponent new
						sourceCode: [ (self class >> #renderPrismComponentOn:) sourceCode ];
						language: #smalltalk;
						enableCopyOnClick;
						yourself)" ]
]

{ #category : #rendering }
MEditorAbstractDemo >> renderContentOn: html [
	self renderTitleOn: html.
	html div
		class: 'meditor-demo-snippet-group';
		with: [ self renderDemoOn: html.
			self renderCodeOfDemoOn: html ].
]

{ #category : #rendering }
MEditorAbstractDemo >> renderDemoOn: html [
	html div
		class: 'meditor-demo-snippet-demo';
		with: [ self renderMEditorComponentOn: html ]
]

{ #category : #rendering }
MEditorAbstractDemo >> renderMEditorComponentOn: html [
	^ self subclassResponsibility
]

{ #category : #rendering }
MEditorAbstractDemo >> renderTitleOn: html [
	html div
		class: 'monaco-demo-page-title';
		with: [ html heading
				level3;
				with: self title.
			html paragraph: self description.
			self warningDescription ifNotNil: [ :desc | html strong: desc ] ]
]

{ #category : #accessing }
MEditorAbstractDemo >> title [
	^ self class title
]

{ #category : #rendering }
MEditorAbstractDemo >> warningDescription [
	"If a demo needs a warning, override this method."

	^ nil
]
