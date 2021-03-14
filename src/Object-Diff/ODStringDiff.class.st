Class {
	#name : #ODStringDiff,
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
ODStringDiff class >> left: left right: right startsAt: anInteger match: aString [
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
ODStringDiff >> <= anInstance [
	^ anInstance lessOrEqualThanString: self left
]

{ #category : #comparing }
ODStringDiff >> = anObject [
^ self class = anObject class 
and: [ self left = anObject left and: [ self right = anObject right and: [ self startsAt = anObject startsAt and: [ self match = anObject match ] ] ] ]
]

{ #category : #accessing }
ODStringDiff >> identical [
	^ identical
		ifNil: [ self identical: (left = right).
			identical ]
]

{ #category : #private }
ODStringDiff >> identical: aBoolean [
	identical := aBoolean
]

{ #category : #accessing }
ODStringDiff >> left [
	^ left
]

{ #category : #private }
ODStringDiff >> left: aString [
	left := aString
]

{ #category : #api }
ODStringDiff >> leftDiff [
	^ self odDiff: self left
]

{ #category : #accessing }
ODStringDiff >> match [
	^ match
]

{ #category : #private }
ODStringDiff >> match: aString [
	match := aString
]

{ #category : #private }
ODStringDiff >> odDiff: leftOrRight [
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

{ #category : #printing }
ODStringDiff >> printOn: aStream [
	^ self identical
		ifTrue: [ self printOnIdentical: aStream ]
		ifFalse: [ self printOnDifferent: aStream ]
]

{ #category : #printing }
ODStringDiff >> printOnDifferent: aStream [
	self left odPrintDiffOn: aStream.
	aStream nextPutAll: '~='.
	self right odPrintDiffOn: aStream
]

{ #category : #printing }
ODStringDiff >> printOnIdentical: aStream [
	aStream nextPut: $[.
		self left printOn: aStream.
		aStream nextPut: $]
]

{ #category : #accessing }
ODStringDiff >> right [
	^ right
]

{ #category : #private }
ODStringDiff >> right: aString [
	right := aString
]

{ #category : #api }
ODStringDiff >> rightDiff [
	^ self odDiff: self right
]

{ #category : #accessing }
ODStringDiff >> startsAt [
	^ startsAt
]

{ #category : #private }
ODStringDiff >> startsAt: anInteger [
	startsAt := anInteger
]
