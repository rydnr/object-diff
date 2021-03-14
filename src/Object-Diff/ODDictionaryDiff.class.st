Class {
	#name : #ODDictionaryDiff,
	#superclass : #ODCollectionDiff,
	#category : #'Object-Diff'
}

{ #category : #meta }
ODDictionaryDiff class >> diffCollectionClass [
	^ Dictionary
]

{ #category : #'instance creation' }
ODDictionaryDiff class >> left: leftDict right: rightDict [
	| result |
	result := self new.
	result
		left: leftDict;
		right: rightDict.
	^ result
]

{ #category : #api }
ODDictionaryDiff >> addDiff: anObject at: positionOrKey [
	self diffs at: positionOrKey put: anObject
]

{ #category : #api }
ODDictionaryDiff >> addMatch: anObject at: key [
	self matches at: key put: anObject
]

{ #category : #api }
ODDictionaryDiff >> printOnDifferent: aStream diffs: aCollection [
	| index |
	index := 1.
	aStream nextPut: $[.
	aCollection
		ifNotNilAndNotEmpty: [ aCollection sorted
				do: [ :d | 
					aStream nextPutAll: index greaseString.
					aStream nextPutAll: ':'.
					d printOn: aStream ]
				separatedBy: [ aStream nextPutAll: ' '.
					index := index + 1 ] ].
	aStream nextPut: $]
]

{ #category : #printing }
ODDictionaryDiff >> printOnIdentical: aStream matches: aDict [
	aStream nextPut: $[.
	aDict
		ifNotNilAndNotEmpty: [ aDict keys sorted
				do: [ :k | k printOn: aStream.
					aStream nextPutAll: '->'.
					(aDict at: k) printOn: aStream ]
				separatedBy: [ aStream nextPutAll: ' ' ] ].
	aStream nextPut: $]
]
