Extension { #name : #Dictionary }

{ #category : #'*Object-Diff' }
Dictionary >> lessOrEqualThanString: aString [ 
	self ifEmpty: [ ^ false ].
	^ self associations first key greaseString <= aString
]

{ #category : #'*Object-Diff' }
Dictionary >> odDiff: aCollection [
	^ aCollection
		ifNil:
			[ ODDictionaryDiff left: self right: nil ]
		ifNotNil: [ :c | c odDiffDictionary: self ]
]

{ #category : #'*Object-Diff' }
Dictionary class >> odDiffClass [
	^ ODDictionaryDiff
]

{ #category : #'*Object-Diff' }
Dictionary >> odDiffDictionary: aDictionary [
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
								ifFalse: [ result addDiff: (otherValue odDiff: selfValue) at: k ] ]
						ifAbsent: [ result ifNil: [ result := ODDictionaryDiff left: d right: self ].
							result addDiff: (selfValue odDiff: nil) at: k ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Dictionary >> odDiffObject: anInstance [
	^ self class odDiffClass incompatibleLeft: anInstance right: self
]

{ #category : #'*Object-Diff' }
Dictionary >> odDiffString: aString [ 
	^ ODDictionaryDiff incompatibleLeft: aString right: self
]

{ #category : #'*Object-Diff' }
Dictionary >> odIdenticalToDictionary: aDictionary [
	| result |
	result := self odWildcardMatch.
	result
		ifFalse: [ aDictionary
				ifNotNil: [ :arg | result := arg odWildcardMatch or: [ arg = self ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Dictionary >> odPrintDiffOn: aStream [
	aStream nextPut: $[.
	self associations sorted
		do: [ :assoc | assoc printOn: aStream ]
		separatedBy: [ aStream nextPut: Character space ].
	aStream nextPut: $]
]
