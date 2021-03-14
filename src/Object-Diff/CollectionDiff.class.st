Class {
	#name : #CollectionDiff,
	#superclass : #Object,
	#instVars : [
		'left',
		'right',
		'valueDiffs',
		'positionDiffs',
		'matches',
		'identical'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
CollectionDiff class >> left: leftCollection right: rightCollection [
	| result |
	result := self new.
	result left: leftCollection; right: rightCollection.
	^ result
]

{ #category : #api }
CollectionDiff >> = anObject [
	^ self class = anObject class
		and: [ self left = anObject left
				and: [ self right = anObject right
						and: [ self matches = anObject matches
								and: [ self positionDiffs = anObject positionDiffs and: [ self valueDiffs = anObject valueDiffs ] ] ] ] ]
]

{ #category : #api }
CollectionDiff >> addMatch: anInteger [
	self matches add: anInteger
]

{ #category : #api }
CollectionDiff >> addPositionDiff: anObject [
	self positionDiffs add: anObject
]

{ #category : #api }
CollectionDiff >> addValueDiff: aStringDiff [
	self valueDiffs add: aStringDiff
]

{ #category : #private }
CollectionDiff >> identical [
	^ identical
		ifNil: [ self identical: left = right.
			identical ]
]

{ #category : #accessing }
CollectionDiff >> identical: aBoolean [
	identical := aBoolean
]

{ #category : #accessing }
CollectionDiff >> left [
	^ left
]

{ #category : #accessing }
CollectionDiff >> left: anObject [
	left := anObject
]

{ #category : #api }
CollectionDiff >> matches [
	^ matches ifNil: [ self matches: OrderedCollection new. matches ]
]

{ #category : #api }
CollectionDiff >> matches: aCollection [
	matches := aCollection
]

{ #category : #accessing }
CollectionDiff >> positionDiffs [
	^ positionDiffs
		ifNil: [ self positionDiffs: OrderedCollection new.
			positionDiffs ]
]

{ #category : #accessing }
CollectionDiff >> positionDiffs: anObject [
	positionDiffs := anObject
]

{ #category : #printing }
CollectionDiff >> printOn: aStream [
	| addSpace |
	addSpace := false.
	self identical
		ifTrue: [ aStream
				nextPutAll: 'Exact match between ';
				nextPutAll: self left greaseString;
				nextPutAll: ' and ';
				nextPutAll: self right greaseString ]
		ifFalse: [ 
			self valueDiffs
				ifNotNilAndNotEmpty: [ aStream
						nextPutAll: 'Value diffs: ';
						nextPutAll: self valueDiffs greaseString;
						nextPut: $. ].
		
			self positionDiffs
				ifNotNilAndNotEmpty: [ addSpace
				ifTrue: [ aStream nextPutAll: ' '.
					addSpace := false ]. aStream
						nextPutAll: 'Position diffs: ';
						nextPutAll: self positionDiffs greaseString;
						nextPut: $..
					addSpace := true. ].
				self matches
				ifNotNilAndNotEmpty: [ addSpace
				ifTrue: [ aStream nextPutAll: ' '.
					addSpace := false ]. aStream
						nextPutAll: 'Matches: ';
						nextPutAll: self matches greaseString;
						nextPut: $..
					addSpace := true ]. ]
]

{ #category : #accessing }
CollectionDiff >> right [
	^ right
]

{ #category : #accessing }
CollectionDiff >> right: anObject [
	right := anObject
]

{ #category : #accessing }
CollectionDiff >> valueDiffs [
	^ valueDiffs
		ifNil: [ self valueDiffs: OrderedCollection new.
			valueDiffs ]
]

{ #category : #accessing }
CollectionDiff >> valueDiffs: anObject [
	valueDiffs := anObject
]
