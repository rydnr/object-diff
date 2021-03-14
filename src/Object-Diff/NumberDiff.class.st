Class {
	#name : #NumberDiff,
	#superclass : #Object,
	#instVars : [
		'left',
		'right',
		'match',
		'identical'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
NumberDiff class >> left: left right: right match: aString [
	| result |
	result := self new.
	result
		left: left;
		right: right;
		match: aString.
	^ result
]

{ #category : #accessing }
NumberDiff >> identical [
	^ identical
		ifNil: [ self identical: left = right.
			identical ]
]

{ #category : #accessing }
NumberDiff >> identical: aBoolean [
	identical := aBoolean
]

{ #category : #accessing }
NumberDiff >> left [
	^ left
]

{ #category : #accessing }
NumberDiff >> left: anObject [
	left := anObject
]

{ #category : #accessing }
NumberDiff >> match [
	^ match
]

{ #category : #accessing }
NumberDiff >> match: anObject [
	match := anObject
]

{ #category : #printing }
NumberDiff >> printOn: aStream [
	| addDistinct |
	addDistinct := false.
	self match
		ifNotNil: [ :m | 
			m printNameOn: aStream.
			aStream nextPut: $(.
			m printOn: aStream.
			aStream nextPut: $) ].
	aStream nextPut: $(.
	self identical
		ifFalse: [ self left
				ifNotNil: [ :l | 
					l printNameOn: aStream.
					aStream nextPut: $(.
					l printOn: aStream.
					aStream nextPut: $).
					addDistinct := true ].
			self right
				ifNotNil: [ :r | 
					addDistinct
						ifTrue: [ aStream nextPutAll: ' ~= ' ].
					r printNameOn: aStream.
					aStream nextPut: $(.
					r printOn: aStream.
					aStream nextPut: $).
					 ] ].
	aStream nextPut: $)
]

{ #category : #accessing }
NumberDiff >> right [
	^ right
]

{ #category : #accessing }
NumberDiff >> right: anObject [
	right := anObject
]
