Class {
	#name : #DictionaryDiff,
	#superclass : #Object,
	#instVars : [
		'left',
		'right',
		'match',
		'valueDiffs',
		'keyDiffs',
		'matches',
		'identical'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
DictionaryDiff class >> left: leftDict right: rightDict [
	| result |
	result := self new.
	result
		left: leftDict;
		right: rightDict.
	^ result
]

{ #category : #comparing }
DictionaryDiff >> = anObject [
	^ self class = anObject class
		and: [ self left = anObject left
				and: [ self right = anObject right
						and: [ self matches = anObject matches
								and: [ self keyDiffs = anObject keyDiffs and: [  self valueDiffs = anObject valueDiffs ] ] ] ] ] 
]

{ #category : #accessing }
DictionaryDiff >> addKeyDiff: aString [
	self keyDiffs add: aString
]

{ #category : #accessing }
DictionaryDiff >> addMatch: anObject [
	self matches add: anObject
]

{ #category : #accessing }
DictionaryDiff >> addValueDiff: aString [
	self valueDiffs add: aString
]

{ #category : #accessing }
DictionaryDiff >> identical [
	^ identical
		ifNil: [ self identical: left = right.
			identical ]
]

{ #category : #private }
DictionaryDiff >> identical: aBoolean [
	identical := aBoolean
]

{ #category : #accessing }
DictionaryDiff >> keyDiffs [
	^ keyDiffs
		ifNil: [ self keyDiffs: OrderedCollection new.
			keyDiffs ]
]

{ #category : #private }
DictionaryDiff >> keyDiffs: aCollection [
	keyDiffs := aCollection
]

{ #category : #accessing }
DictionaryDiff >> left [
	^ left
]

{ #category : #private }
DictionaryDiff >> left: aDict [ 
	left := aDict
]

{ #category : #accessing }
DictionaryDiff >> matches [
	^ matches
		ifNil: [ self matches: OrderedCollection new.
			matches ]
]

{ #category : #private }
DictionaryDiff >> matches: aCollection [
	matches := aCollection
]

{ #category : #printing }
DictionaryDiff >> printOn: aStream [
	| addSpace |
	addSpace := false.
	self identical
		ifTrue: [ aStream
				nextPutAll: 'Exact match between ';
				nextPutAll: self left greaseString;
				nextPutAll: ' and ';
				nextPutAll: self right greaseString;
				nextPut: $. ]
		ifFalse: [ self keyDiffs
				ifNotNilAndNotEmpty: [ aStream
						nextPut: $(;
						nextPutAll: self keyDiffs greaseString;
						nextPut: $).
					addSpace := true ].
			self valueDiffs
				ifNotNilAndNotEmpty: [ addSpace
						ifTrue: [ aStream nextPutAll: ' '.
							addSpace := false ].
					aStream
						nextPut: $(;
						nextPutAll: self valueDiffs greaseString;
						nextPut: $).
					addSpace := true ].
			self matches
				ifNotNilAndNotEmpty: [ addSpace
						ifTrue: [ aStream nextPutAll: ' '.
							addSpace := false ].
					aStream
						nextPutAll: self matches greaseString ] ]
]

{ #category : #accessing }
DictionaryDiff >> right [
	^ right
]

{ #category : #private }
DictionaryDiff >> right: aDict [ 
	right := aDict
]

{ #category : #accessing }
DictionaryDiff >> valueDiffs [
	^ valueDiffs ifNil: [ self valueDiffs: OrderedCollection new. valueDiffs ]
]

{ #category : #private }
DictionaryDiff >> valueDiffs: aCollection [
	valueDiffs := aCollection
]
