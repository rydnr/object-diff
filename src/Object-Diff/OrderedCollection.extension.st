Extension { #name : #OrderedCollection }

{ #category : #'*Object-Diff' }
OrderedCollection >> diff: aCollection [
	^ aCollection
		ifNil: [ OrderedCollectionDiff left: self right: nil ]
		ifNotNil: [ :c | c diffOrderedCollection: self ]
]

{ #category : #'*Object-Diff' }
OrderedCollection >> diffOrderedCollection: aCollection [
	| result |
	result := nil.
	aCollection
		ifNil: [ result := OrderedCollectionDiff left: nil right: self ]
		ifNotNil: [ :d | 
			result := OrderedCollectionDiff left: d right: self.
			self
				keysAndValuesDo: [ :i :v | 
					| selfValue |
					selfValue := self at: i ifAbsent: [ nil ].
					d size >= i
						ifTrue: [ | otherValue |
							otherValue := d at: i.
							selfValue = otherValue
								ifTrue: [ result addMatch: i ]
								ifFalse: [ result addValueDiff: (otherValue diff: selfValue).
									result addPositionDiff: i ] ]
						ifFalse: [ result ifNil: [ result := OrderedCollectionDiff left: d right: self ].
							result addPositionDiff: i ] ] ].
	^ result
]
