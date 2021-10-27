Class {
	#name : #BaselineOfMediumEditor,
	#superclass : #BaselineOf,
	#category : #BaselineOfMediumEditor
}

{ #category : #baselines }
BaselineOfMediumEditor >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ "Dependencies"
			self
				seaside3: spec;
				gitBridge: spec;
				fileLibraryHelper: spec.

			"Packages"
			spec
				package: 'MediumEditor-Core' with: [ spec requires: #('Seaside3') ];
				package: 'MediumEditor-Dev'
					with: [ spec requires: #('MediumEditor-Core' 'GitBridge' 'FileLibraryHelper') ];
				package: 'MediumEditor-Demo'
					with: [ spec requires: #('MediumEditor-Core') ].
					
			"Groups"		
			spec group: 'core' with: #('MediumEditor-Core') ]
]

{ #category : #dependencies }
BaselineOfMediumEditor >> fileLibraryHelper: spec [
	"I small project to help developers to manage the files in the FileLibrary."

	spec
		baseline: 'FileLibraryHelper'
		with: [ spec repository: 'github://jecisc/FileLibraryHelper:v1.x.x/src' ]
]

{ #category : #dependencies }
BaselineOfMediumEditor >> gitBridge: spec [
	spec
    	baseline: 'GitBridge'
    	with: [ spec repository: 'github://jecisc/GitBridge:v1.x.x/src' ]
]

{ #category : #dependencies }
BaselineOfMediumEditor >> seaside3: spec [
	spec
		baseline: 'Seaside3'
		with: [ spec
				loads: #('Core' 'JQuery' 'Zinc');
				repository: 'github://SeasideSt/Seaside/repository' ]
]
