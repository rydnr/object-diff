Extension { #name : #OrderedCollection }

{ #category : #'*Object-Diff' }
OrderedCollection >> diff: aCollection [
	^ aCollection
		ifNil: [ ODOrderedCollectionDiff left: self right: nil ]
		ifNotNil: [ :c | c diffOrderedCollection: self ]
]

{ #category : #'*Object-Diff' }
OrderedCollection >> diffOrderedCollection: aCollection [
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
								ifTrue: [ result addMatch: otherValue at: i]
								ifFalse: [ result addDiff: (otherValue diff: selfValue) at: i ] ]
						ifFalse: [ result
								ifNil: [ result := ODOrderedCollectionDiff left: d right: self ].
							result addDiff: (selfValue diff: nil) at: i ] ] ].
	^ result
]
