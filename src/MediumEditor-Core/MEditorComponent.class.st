Class {
	#name : #MEditorComponent,
	#superclass : #WAComponent,
	#instVars : [
		'saveCallback',
		'text',
		'waitingMessage'
	],
	#category : #'MediumEditor-Core-MediumEditor-Core'
}

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
MEditorComponent >> renderContentOn: html [
	html div
		class: 'meditor-editable';
		class: 'not-loaded';
		style: 'box-shadow: 2px 2px 5px #8c8c8c;margin: 5px 10px;padding: 15px;';
		with:	self text
		
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
