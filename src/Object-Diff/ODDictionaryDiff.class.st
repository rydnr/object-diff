Class {
	#name : #ODDictionaryDiff,
	#superclass : #ODCollectionDiff,
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
ODDictionaryDiff class >> left: leftDict right: rightDict [
	| result |
	result := self new.
	result
		left: leftDict;
		right: rightDict.
	^ result
]

{ #category : #printing }
ODDictionaryDiff >> printOnDifferent: aStream diffs: aCollection [
	aCollection
		ifNotNilAndNotEmpty: [ aCollection sorted
				do: [ :d | d printOn: aStream ]
				separatedBy: [ aStream nextPut: Character space ] ]
]

{ #category : #printing }
ODDictionaryDiff >> printOnIdentical: aStream matches: aDict [
	aStream nextPut: $[.
	aDict
		ifNotNilAndNotEmpty: [ aDict keys sorted
				do: [ :k | 
					k printOn: aStream.
					aStream nextPutAll: '->'.
					(aDict at: k) printOn: aStream ]
				separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $]
]
