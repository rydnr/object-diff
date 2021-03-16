Class {
	#name : #ODNumberDiff,
	#superclass : #ODAbstractDiff,
	#category : #'Object-Diff'
}

{ #category : #printing }
ODNumberDiff >> printOn: aStream [
	self identical
		ifTrue: [ ^ self ].
	self left ifNotNil: [ :l | l odPrintDiffOn: aStream ].
	aStream nextPutAll: '~='.
	self right ifNotNil: [ :r | r odPrintDiffOn: aStream ]
]
