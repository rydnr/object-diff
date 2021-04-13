Extension { #name : #OrderedCollection }

{ #category : #'*Object-Diff' }
OrderedCollection >> odDiff: aCollection [
	^ aCollection
		ifNil: [ ODOrderedCollectionDiff left: self right: nil ]
		ifNotNil: [ :c | c odDiffOrderedCollection: self ]
]

{ #category : #'*Object-Diff' }
OrderedCollection >> odDiffArray: aCollection [
	^ (aCollection
		odDiffCollection: self
		withDiffClass: ODOrderedCollectionDiff) reversed
]

{ #category : #'*Object-Diff' }
OrderedCollection class >> odDiffClass [
	^ ODOrderedCollectionDiff
]

{ #category : #'*Object-Diff' }
OrderedCollection >> odDiffObject: anInstance [
	^ self class odDiffClass incompatibleLeft: anInstance right: self
]

{ #category : #'*Object-Diff' }
OrderedCollection >> odDiffOrderedCollection: aCollection [
	| result |
	result := nil.
	aCollection
		ifNil: [ result := ODOrderedCollectionDiff left: nil right: self ]
		ifNotNil: [ :d | 
			result := ODOrderedCollectionDiff left: d right: self.
			self
				keysAndValuesDo: [ :i :v | 
					| selfValue |
					selfValue := self at: i ifAbsent: [ nil ].
					d size >= i
						ifTrue: [ | otherValue |
							otherValue := d at: i.
							selfValue = otherValue
								ifTrue: [ result addMatch: otherValue at: i ]
								ifFalse: [ result addDiff: (otherValue odDiff: selfValue) at: i ] ]
						ifFalse: [ result
								ifNil: [ result := ODOrderedCollectionDiff left: d right: self ].
							result addDiff: (selfValue odDiff: nil) at: i ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
OrderedCollection >> odIdenticalToOrderedCollection: anOrderedCollection [
	| result |
	result := self odWildcardMatch.
	result
		ifFalse: [ anOrderedCollection
				ifNotNil: [ :arg | result := arg odWildcardMatch or: [ arg = self ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
OrderedCollection >> odPrintDiffOn: aStream [
	aStream nextPut: $[.
	self
		doWithIndex: [ :v :i | 
			aStream nextPutAll: i asString.
			aStream nextPut: $:.
			v printOn: aStream ]
		separatedBy: [ aStream nextPut: Character space ].
	aStream nextPut: $]
]
