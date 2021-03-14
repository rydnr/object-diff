Extension { #name : #Dictionary }

{ #category : #'*Object-Diff' }
Dictionary >> diff: aCollection [
	^ aCollection
		ifNil:
			[ DictionaryDiff left: self right: nil ]
		ifNotNil: [ :c | c diffDictionary: self ]
]

{ #category : #'*Object-Diff' }
Dictionary >> diffDictionary: aDictionary [
	| result |
	result := nil.
	aDictionary
		ifNil: [ result := DictionaryDiff left: nil right: self ]
		ifNotNil: [ :d | 
			result := DictionaryDiff left: d right: self.
			self
				keysAndValuesDo: [ :k :v | 
					| selfValue |
					selfValue := self at: k ifAbsent: [ nil ].
					d
						at: k
						ifPresent: [ :otherValue | 
							selfValue = otherValue
								ifTrue: [ result addMatch: (self class with: k -> selfValue) ]
								ifFalse: [ result addValueDiff: (otherValue diff: selfValue) ] ]
						ifAbsent: [ result ifNil: [ result := DictionaryDiff left: d right: self ].
							result addKeyDiff: k ] ] ].
	^ result
]
