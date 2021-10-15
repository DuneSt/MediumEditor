Class {
	#name : #MEditorComponent,
	#superclass : #WAComponent,
	#instVars : [
		'saveCallback',
		'text',
		'waitingMessage',
		'extensions',
		'buttons'
	],
	#category : #'MediumEditor-Core-MediumEditor-Core'
}

{ #category : #js }
MEditorComponent class >> ajaxInitScript [
	^ 'MediumEditorSt.initNotLoadedEditor()' js
]

{ #category : #accessing }
MEditorComponent >> buttons [
	^ buttons ifNil: [ buttons := OrderedCollection new ]
]

{ #category : #accessing }
MEditorComponent >> buttons: anObject [
	buttons := anObject
]

{ #category : #accessing }
MEditorComponent >> buttonsString [
	self buttons size = 0
		ifTrue: [ ^ '[]' ]
		ifFalse: [ ^ String
				streamContents: [ :s | 
					s
						<< '["';
						<< (self buttons joinUsing: '","');
						<< '"]' ] ]
]

{ #category : #rendering }
MEditorComponent >> defaultWaitingHtml [
	^ [ :html | 
	html div
		class: 'waiting';
		with: [ 
					html image
						style: 'height: 50px; width: 50px;';
						url: (MEditorLibrary urlOf: 'cog.gif').
					html heading
						level1;
						with: 'Please wait, loading in progress' ];
		yourself ]
]

{ #category : #accessing }
MEditorComponent >> extensions [
	^ extensions ifNil: [ extensions := OrderedCollection new ]
]

{ #category : #accessing }
MEditorComponent >> extensions: aStringColl [
	extensions := aStringColl
]

{ #category : #accessing }
MEditorComponent >> extensionsString [
	self extensions size = 0
		ifTrue: [ ^ '[]' ]
		ifFalse: [ ^ String
				streamContents: [ :s | 
					s
						<< '["';
						<< (self extensions joinUsing: '","');
						<< '"]' ] ]
]

{ #category : #accessing }
MEditorComponent >> renderContentOn: html [
	| id |
	id := html nextId.
	html div
		id: id;
		class: 'meditor-editable';
		attributeAt: #'data-loaded' put: #false;
		attributeAt: #'data-extensions' put: self extensionsString;
		attributeAt: #'data-buttons' put: self buttonsString;
		attributeAt: #'data-save-callback'
			put:
			(html jQuery ajax
				type: 'POST';
				callback: [ :aString | self text: aString ]
					value: (JSStream on: 'MediumEditorSt.save("#' , id , '.meditor-editable")');
				onComplete: 'MediumEditorSt.saveCompleted()';
				onError: 'MediumEditorSt.saveFailed()');
		style: 'box-shadow: 2px 2px 5px #8c8c8c;margin: 5px 10px;padding: 15px;';
		with: self text
]

{ #category : #accessing }
MEditorComponent >> saveCallback [
	^ saveCallback
]

{ #category : #accessing }
MEditorComponent >> saveCallback: anObject [
	saveCallback := anObject
]

{ #category : #accessing }
MEditorComponent >> text [
	^ text
]

{ #category : #accessing }
MEditorComponent >> text: anObject [
	text := anObject
]

{ #category : #accessing }
MEditorComponent >> waitingMessage [
	^ waitingMessage
]

{ #category : #accessing }
MEditorComponent >> waitingMessage: anObject [
	waitingMessage := anObject
]
