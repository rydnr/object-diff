Class {
	#name : #ODAbstractDiff,
	#superclass : #Object,
	#traits : 'ODTPrintOn',
	#classTraits : 'ODTPrintOn classTrait',
	#instVars : [
		'left',
		'right',
		'identical',
		'diffs',
		'matches',
		'incompatible'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
ODAbstractDiff class >> incompatibleLeft: left right: right [
	| result |
	result := self left: left right: right.
	result incompatible: true.
	^ result
]

{ #category : #'instance creation' }
ODAbstractDiff class >> left: left right: right [
	| result |
	result := self new.
	result left: left; right: right.
	^ result
]

{ #category : #meta }
ODAbstractDiff class >> reversed [
	^ false
]

{ #category : #comparing }
ODAbstractDiff >> = anObject [
	^ self class = anObject class
		and: [ self left = anObject left
				and: [ self right = anObject right
						and: [ self matches = anObject matches
								and: [ self diffs = anObject diffs
										] ] ] ]
]

{ #category : #private }
ODAbstractDiff >> addDiff: anObject at: key [
	 self diffs at: key put: anObject
]

{ #category : #private }
ODAbstractDiff >> addMatch: anObject at: key [ 
	self matches at: key put: anObject
]

{ #category : #accessing }
ODAbstractDiff >> diffs [
	^ diffs
		ifNil: [ self diffs: Dictionary new.
			diffs ]
]

{ #category : #accessing }
ODAbstractDiff >> diffs: anObject [
	diffs := anObject
]

{ #category : #accessing }
ODAbstractDiff >> identical [
	^ identical
		ifNil: [ self identical: (left = right).
			identical ]
]

{ #category : #accessing }
ODAbstractDiff >> identical: anObject [
	identical := anObject
]

{ #category : #accessing }
ODAbstractDiff >> incompatible [
	^ incompatible ifNil: [ self incompatible: false. incompatible ]
]

{ #category : #accessing }
ODAbstractDiff >> incompatible: aBoolean [
	incompatible := aBoolean
]

{ #category : #accessing }
ODAbstractDiff >> left [
	^ left
]

{ #category : #accessing }
ODAbstractDiff >> left: anObject [
	left := anObject
]

{ #category : #comparing }
ODAbstractDiff >> lessOrEqualThanString: aString [
	self diffs ifEmpty: [ ^ false ].
	^ self diffs lessOrEqualThanString: aString
]

{ #category : #accessing }
ODAbstractDiff >> matches [
	^ matches
		ifNil: [ self matches: Dictionary new.
			matches ]
]

{ #category : #accessing }
ODAbstractDiff >> matches: aCollection [
	matches := aCollection
]

{ #category : #accessing }
ODAbstractDiff >> reversed [
	^ ODReversedDiff for: self
]

{ #category : #accessing }
ODAbstractDiff >> right [
	^ right
]

{ #category : #accessing }
ODAbstractDiff >> right: anObject [
	right := anObject
]
