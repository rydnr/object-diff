Extension { #name : #Array }

{ #category : #'*Object-Diff' }
Array >> odDiff: aCollection [
	^ aCollection
		ifNil: [ ODArrayDiff left: self right: nil ]
		ifNotNil: [ :c | c odDiffArray: self ]
]

{ #category : #'*Object-Diff' }
Array >> odDiffArray: aCollection [
	^ self odDiffCollection: aCollection withDiffClass: ODArrayDiff

]

{ #category : #'*Object-Diff' }
Array class >> odDiffClass [
	^ ODArrayDiff
]

{ #category : #'*Object-Diff' }
Array >> odDiffCollection: aCollection withDiffClass: aClass [
	| result |
	result := nil.
	aCollection
		ifNil: [ result := aClass left: nil right: self ]
		ifNotNil: [ :d | 
			result := aClass left: d right: self.
			self
				keysAndValuesDo: [ :i :v | 
					| selfValue |
					selfValue := self at: i ifAbsent: [ nil ].
					d size >= i
						ifTrue: [ | otherValue |
							otherValue := d at: i.
							selfValue = otherValue
								ifTrue: [ result addMatch: selfValue at: i ]
								ifFalse: [ result addDiff: (otherValue odDiff: selfValue) at: i ] ]
						ifFalse:
							[ selfValue ifNotNil: [ :sv | result addDiff: (sv odDiff: nil) at: i ] ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Array >> odDiffObject: anInstance [
	^ self class odDiffClass incompatibleLeft: anInstance right: self
]

{ #category : #'*Object-Diff' }
Array >> odDiffOrderedCollection: aCollection [
	^ self odDiffCollection: aCollection withDiffClass: ODOrderedCollectionDiff

]

{ #category : #'*Object-Diff' }
Array >> odIdenticalToArray: anArray [
	| result |
	result := self odWildcardMatch.
	result
		ifFalse: [ anArray
				ifNotNil: [ :arg | result := arg odWildcardMatch or: [ arg = self ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Array >> odPrintDiffOn: aStream [
	aStream nextPut: $[.
	self
		doWithIndex: [ :v :i | 
			aStream nextPutAll: i asString.
			aStream nextPut: $:.
			v odPrintDiffOn: aStream ]
		separatedBy: [ aStream nextPut: Character space ].
	aStream nextPut: $]
]
