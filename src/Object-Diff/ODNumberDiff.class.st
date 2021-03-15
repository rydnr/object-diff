Class {
	#name : #ODNumberDiff,
	#superclass : #ODAbstractDiff,
	#instVars : [
		'match'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
ODNumberDiff class >> left: left right: right match: aString [
	| result |
	result := self new.
	result
		left: left;
		right: right;
		match: aString.
	^ result
]

{ #category : #accessing }
ODNumberDiff >> match [
	^ match
]

{ #category : #accessing }
ODNumberDiff >> match: anObject [
	match := anObject
]

{ #category : #printing }
ODNumberDiff >> printOn: aStream [
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
