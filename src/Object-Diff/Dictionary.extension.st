Extension { #name : #Dictionary }

{ #category : #'*Object-Diff' }
Dictionary >> diff: aCollection [
	^ aCollection
		ifNil:
			[ ODDictionaryDiff left: self right: nil ]
		ifNotNil: [ :c | c diffDictionary: self ]
]

{ #category : #'*Object-Diff' }
Dictionary >> diffDictionary: aDictionary [
	| result |
	result := nil.
	aDictionary
		ifNil: [ result := ODDictionaryDiff left: nil right: self ]
		ifNotNil: [ :d | 
			result := ODDictionaryDiff left: d right: self.
			self
				keysAndValuesDo: [ :k :v | 
					| selfValue |
					selfValue := self at: k ifAbsent: [ nil ].
					d
						at: k
						ifPresent: [ :otherValue | 
							selfValue = otherValue
								ifTrue: [ result addMatch: selfValue at: k ]
								ifFalse: [ result addDiff: (otherValue diff: selfValue) at: k ] ]
						ifAbsent: [ result ifNil: [ result := ODDictionaryDiff left: d right: self ].
							result addDiff: (selfValue diff: nil) at: k ] ] ].
	^ result
]
