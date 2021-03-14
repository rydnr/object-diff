Extension { #name : #Array }

{ #category : #'*Object-Diff' }
Array >> diff: aCollection [
	^ aCollection
		ifNil: [ ODArrayDiff left: self right: nil ]
		ifNotNil: [ :c | c diffArray: self ]
]

{ #category : #'*Object-Diff' }
Array >> diffArray: aCollection [
	^ self diffCollection: aCollection withDiffClass: ODArrayDiff

]

{ #category : #'*Object-Diff' }
Array >> diffCollection: aCollection withDiffClass: aClass [
	| result |
	result := nil.
	aCollection
		ifNil: [ result := aClass left: nil right: self ]
		ifNotNil: [ :d | 
			result := ODArrayDiff left: d right: self.
			self
				keysAndValuesDo: [ :i :v | 
					| selfValue |
					selfValue := self at: i ifAbsent: [ nil ].
					d size >= i
						ifTrue: [ | otherValue |
							otherValue := d at: i.
							selfValue = otherValue
								ifTrue: [ result addMatch: selfValue at: i ]
								ifFalse: [ result addDiff: (otherValue diff: selfValue) at: i ] ]
						ifFalse: [ selfValue ifNotNil: [ :sv | result addDiff: (sv diff: nil) at: i ] ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Array >> diffOrderedCollection: aCollection [
	^ self diffCollection: aCollection withDiffClass: ODOrderedCollectionDiff

]

{ #category : #'*Object-Diff' }
Array >> diffString: aString [
	^ aString
		ifNil: [ ODArrayDiff left: self right: nil ]
		ifNotNil: [ :c | ODArrayDiff left: aString right: self ]
]
