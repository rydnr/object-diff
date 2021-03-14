Class {
	#name : #ODCollectionDiff,
	#superclass : #Object,
	#traits : 'ODTPrintOn',
	#classTraits : 'ODTPrintOn classTrait',
	#instVars : [
		'left',
		'right',
		'matches',
		'identical',
		'diffs'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
ODCollectionDiff class >> left: leftCollection right: rightCollection [
	| result |
	result := self new.
	result left: leftCollection; right: rightCollection.
	^ result
]

{ #category : #api }
ODCollectionDiff >> = anObject [
	^ self class = anObject class
		and: [ self left = anObject left
				and: [ self right = anObject right
						and: [ self matches = anObject matches
								and: [ self diffs = anObject diffs
										] ] ] ]
]

{ #category : #api }
ODCollectionDiff >> addDiff: anObject at: key [
	 self diffs at: key put: anObject
]

{ #category : #api }
ODCollectionDiff >> addMatch: anObject at: key [ 
	self matches at: key put: anObject
]

{ #category : #accessing }
ODCollectionDiff >> diffs [
	^ diffs
		ifNil: [ self diffs: Dictionary new.
			diffs ]
]

{ #category : #accessing }
ODCollectionDiff >> diffs: anObject [
	diffs := anObject
]

{ #category : #private }
ODCollectionDiff >> identical [
	^ identical
		ifNil: [ self identical: left = right.
			identical ]
]

{ #category : #accessing }
ODCollectionDiff >> identical: aBoolean [
	identical := aBoolean
]

{ #category : #accessing }
ODCollectionDiff >> left [
	^ left
]

{ #category : #accessing }
ODCollectionDiff >> left: anObject [
	left := anObject
]

{ #category : #comparing }
ODCollectionDiff >> lessOrEqualThanString: aString [
	self diffs ifEmpty: [ ^ false ].
	^ self diffs lessOrEqualThanString: aString
]

{ #category : #api }
ODCollectionDiff >> matches [
	^ matches
		ifNil: [ self matches: Dictionary new.
			matches ]
]

{ #category : #api }
ODCollectionDiff >> matches: aCollection [
	matches := aCollection
]

{ #category : #printing }
ODCollectionDiff >> printOn: aStream [
	self identical
		ifTrue: [ self printOnIdentical: aStream matches: self matches ]
		ifFalse: [ self printOnDifferent: aStream diffs: self diffs ]
]

{ #category : #accessing }
ODCollectionDiff >> right [
	^ right
]

{ #category : #accessing }
ODCollectionDiff >> right: anObject [
	right := anObject
]
