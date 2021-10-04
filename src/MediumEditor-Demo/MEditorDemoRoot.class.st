Class {
	#name : #MEditorDemoRoot,
	#superclass : #WAComponent,
	#instVars : [
		'currentDemo'
	],
	#category : #'MediumEditor-Demo'
}

{ #category : #'class initialization' }
MEditorDemoRoot class >> initialize [
	"WAAdmin applicationDefaults removeParent: WADevelopmentConfiguration instance."
	(WAAdmin register: self asApplicationAt: 'MediumEditorDemo')
		addLibrary: JQDeploymentLibrary;
		addLibrary: MonacoFileLibrary 
]

{ #category : #'class initialization' }
MEditorDemoRoot class >> version [
	^ 'v0.0.1'
]

{ #category : #accessing }
MEditorDemoRoot >> currentDemo [
	^ currentDemo
]

{ #category : #accessing }
MEditorDemoRoot >> currentDemo: anObject [
	currentDemo := anObject
]
