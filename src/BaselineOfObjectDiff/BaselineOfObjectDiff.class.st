Class {
	#name : #BaselineOfObjectDiff,
	#superclass : #BaselineOf,
	#category : #BaselineOfObjectDiff
}

{ #category : #baselines }
BaselineOfObjectDiff >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			self declarePackagesIn: spec.
			self declareGroupsIn: spec ]
]

{ #category : #meta }
BaselineOfObjectDiff >> declareGroupsIn: spec [
	spec
		group: 'core'
			with:
			#(#'Object-Diff');
		group: 'tests'
			with:
			#(#'Object-Diff-Tests');
		group: 'default' with: #('core' 'tests')
]

{ #category : #meta }
BaselineOfObjectDiff >> declarePackagesIn: spec [
	spec
		package: #'Object-Diff';
		package: #'Object-Diff-Tests'
			with: [ spec requires: #('Object-Diff') ]
 
]
