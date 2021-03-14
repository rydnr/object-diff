Class {
	#name : #StringDiff,
	#superclass : #Object,
	#instVars : [
		'startsAtPosition',
		'right',
		'left',
		'match',
		'startsAt',
		'identical'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
StringDiff class >> left: left right: right startsAt: anInteger match: aString [
	| result |
	result := self new.
	result
		startsAt: anInteger;
		left: left;
		right: right;
		match: aString.
	^ result
]

{ #category : #comparing }
StringDiff >> = anObject [
^ self class = anObject class 
and: [ self left = anObject left and: [ self right = anObject right and: [ self startsAt = anObject startsAt and: [ self match = anObject match ] ] ] ]
]

{ #category : #private }
StringDiff >> diff: leftOrRight [
	^ leftOrRight
		ifNil: [ nil ]
		ifNotNil: [ :lr | 
			self startsAt
				ifNil: [ nil ]
				ifNotNil: [ :s | 
					s <= lr size
						ifTrue: [ lr copyFrom: s to: lr size ]
						ifFalse: [ lr ] ] ]
]

{ #category : #accessing }
StringDiff >> identical [
	^ identical
		ifNil: [ self identical: (left = right).
			identical ]
]

{ #category : #private }
StringDiff >> identical: aBoolean [
	identical := aBoolean
]

{ #category : #accessing }
StringDiff >> left [
	^ left
]

{ #category : #private }
StringDiff >> left: aString [
	left := aString
]

{ #category : #api }
StringDiff >> leftDiff [
	^ self diff: self left
]

{ #category : #accessing }
StringDiff >> match [
	^ match
]

{ #category : #private }
StringDiff >> match: aString [
	match := aString
]

{ #category : #printing }
StringDiff >> printOn: aStream [
	| addDistinct |
	addDistinct := false.
	self match
		ifNotNil: [ :m | m ifNotEmpty: [ m printNameOn: aStream.
			aStream nextPut: $(.
			m printOn: aStream.
			aStream nextPut: $) ] ].
	aStream nextPut: $(.
	self identical
		ifFalse: [ self leftDiff
				ifNotNil: [ :l | 
					l printNameOn: aStream.
					aStream nextPut: $(.
					l printOn: aStream.
					aStream nextPut: $).
					addDistinct := true ].
			self rightDiff
				ifNotNil: [ :r | 
					addDistinct
						ifTrue: [ aStream nextPutAll: ' ~= ' ].
					r printNameOn: aStream.
					aStream nextPut: $(.
					r printOn: aStream.
					aStream nextPut: $) ] ].
	aStream nextPut: $)
]

{ #category : #accessing }
StringDiff >> right [
	^ right
]

{ #category : #private }
StringDiff >> right: aString [
	right := aString
]

{ #category : #api }
StringDiff >> rightDiff [
	^ self diff: self right
]

{ #category : #accessing }
StringDiff >> startsAt [
	^ startsAt
]

{ #category : #private }
StringDiff >> startsAt: anInteger [
	startsAt := anInteger
]
