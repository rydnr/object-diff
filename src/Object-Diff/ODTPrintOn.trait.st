Trait {
	#name : #ODTPrintOn,
	#category : #'Object-Diff'
}

{ #category : #printing }
ODTPrintOn classSide >> printOnSeparator [
	^ ':'
]

{ #category : #printing }
ODTPrintOn >> printOn: aStream [
	self identical
		ifTrue: [ self
				printOnIdentical: aStream
				matches: self matches
				separator: self class printOnSeparator ]
		ifFalse: [ self
				printOnDifferent: aStream
				diffs: self diffs
				separator: self class printOnSeparator ]
]

{ #category : #printing }
ODTPrintOn >> printOnDifferent: aStream diffs: aDict separator: aSeparator [
	aStream nextPut: $[.
	aDict
		ifNotNilAndNotEmpty: [ aDict associations sorted
				do: [ :assoc | 
					assoc key printOn: aStream.
					aStream nextPutAll: aSeparator.
					assoc value printOn: aStream ]
				separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $]
]

{ #category : #printing }
ODTPrintOn >> printOnIdentical: aStream matches: aDict separator: aSeparator [
	aStream nextPut: $[.
	aDict
		ifNotNilAndNotEmpty: [ aDict keys sorted
				do: [ :k | 
					k printOn: aStream.
					aStream nextPutAll: aSeparator.
					(aDict at: k) printOn: aStream ]
				separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $]
]
