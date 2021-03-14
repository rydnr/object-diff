Trait {
	#name : #ODTPrintOn,
	#category : #'Object-Diff'
}

{ #category : #printing }
ODTPrintOn >> printOnDifferent: aStream diffs: aDict [
	aStream nextPut: $[.
	aDict
		ifNotNilAndNotEmpty: [ aDict associations sorted
				do: [ :assoc | 
					aStream nextPutAll: assoc key greaseString.
					aStream nextPut: $:.
					assoc value printOn: aStream ]
				separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $]
]

{ #category : #printing }
ODTPrintOn >> printOnIdentical: aStream matches: aDict [
	aStream nextPut: $[.
	aDict
		ifNotNilAndNotEmpty: [ aDict keys sorted
				do: [ :k | 
					k printOn: aStream.
					aStream nextPut: $:.
					(aDict at: k) printOn: aStream ]
				separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $]
]
