Class {
	#name : #GitMediumEditor,
	#superclass : #GitBridge,
	#category : #'MediumEditor-Dev'
}

{ #category : #accessing }
GitMediumEditor class >> resources [
	^ self root / 'resources'
]
