Extension { #name : #Array }

{ #category : #'*Object-Diff' }
Array >> diff: aCollection [
	^ aCollection
		ifNil: [ ArrayDiff left: self right: nil ]
		ifNotNil: [ :c | c diffArray: self ]
]

{ #category : #'*Object-Diff' }
Array >> diffArray: aCollection [
	^ self diffCollection: aCollection withDiffClass: ArrayDiff

]

{ #category : #'*Object-Diff' }
Array >> diffCollection: aCollection withDiffClass: aClass [
	| result |
	result := nil.
	aCollection
		ifNil: [ result := aClass left: nil right: self ]
		ifNotNil: [ :d | 
			result := ArrayDiff left: d right: self.
			self
				keysAndValuesDo: [ :i :v | 
					| selfValue |
					selfValue := self at: i ifAbsent: [ nil ].
					d size >= i
						ifTrue: [ | otherValue |
							otherValue := d at: i.
							selfValue = otherValue
								ifTrue: [ result addMatch: (i -> selfValue) ]
								ifFalse: [ result addValueDiff: (otherValue diff: selfValue).
									result addPositionDiff: i ] ]
						ifFalse: [ selfValue ifNotNil: [ :sv | result addValueDiff: (sv diff: nil) ].
							result addPositionDiff: i ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Array >> diffOrderedCollection: aCollection [
	^ self diffCollection: aCollection withDiffClass: OrderedCollectionDiff

]

{ #category : #'*Object-Diff' }
Array >> diffString: aString [
	^ aString
		ifNil: [ ArrayDiff left: self right: nil ]
		ifNotNil: [ :c | ArrayDiff left: aString right: self ]
]
