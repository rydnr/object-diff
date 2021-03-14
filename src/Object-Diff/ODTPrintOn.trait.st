Trait {
	#name : #ODTPrintOn,
	#category : #'Object-Diff'
}

{ #category : #printing }
ODTPrintOn >> printOnDifferent: aStream diffs: aCollection [
	| index |
	index := 1.
	aStream nextPut: $[.
	aCollection
		ifNotNilAndNotEmpty: [ aCollection sorted
				do: [ :d |
					aStream nextPutAll: index greaseString.
					aStream nextPutAll: ':'.
					d printOn: aStream ]
				separatedBy: [ aStream nextPutAll: ' '. index := index + 1 ] ].
	aStream nextPut: $]
]

{ #category : #printing }
ODTPrintOn >> printOnIdentical: aStream matches: aCollection [
	| index |
	index := 1.
	aStream nextPut: $[.
	aCollection
		ifNotNilAndNotEmpty: [ aCollection
				do: [ :d | 
					aStream nextPutAll: index greaseString.
					aStream nextPutAll: ':'.
					d printOn: aStream ]
				separatedBy: [ aStream nextPutAll: ' '.
					index := index + 1 ] ].
	aStream nextPut: $]
]
