Extension { #name : #Object }

{ #category : #'*Object-Diff' }
Object >> instVarNamed: aString [
	"Return the value of the instance variable in me with that name.  Slow and unclean, but very useful. "

	^ self instVarNamed: aString ifAbsent: [ self error: 'no such inst var' ]
]

{ #category : #'*Object-Diff' }
Object >> instVarNamed: aString ifAbsent: aBlock [
	"Return the value of the instance variable in me with that name.  Slow and unclean, but very useful. "

	| index |
	index := self class
		instVarIndexFor: aString asString
		ifAbsent: [ nil ].
	^ index ifNil: [ aBlock value: aString ] ifNotNil: [ :i | self instVarAt: i ]
]

{ #category : #'*Object-Diff' }
Object >> instVarNamed: aString put: aValue [
	"Store into the value of the instance variable in me of that name.  Slow and unclean, but very useful. "

	^ self instVarNamed: aString put: aValue ifAbsent: [ self error: 'no such inst var' ]
]

{ #category : #'*Object-Diff' }
Object >> instVarNamed: aString put: aValue ifAbsent: aBlock [
	"Store into the value of the instance variable in me of that name.  Slow and unclean, but very useful. "

	^ self
		instVarAt:
			(self class
				instVarIndexFor: aString asString
				ifAbsent: aBlock)
		put: aValue
]

{ #category : #'*Object-Diff' }
Object >> odDiff: anObject [
	^ anObject odDiffObject: self
]

{ #category : #'*Object-Diff' }
Object >> odDiffArray: anInstance [
	^ self class odDiffClass incompatibleLeft: anInstance right: self
]

{ #category : #'*Object-Diff' }
Object class >> odDiffClass [
	^ ODObjectDiff 
]

{ #category : #'*Object-Diff' }
Object >> odDiffDictionary: anInstance [
	^ self class odDiffClass incompatibleLeft: anInstance right: self
]

{ #category : #'*Object-Diff' }
Object >> odDiffNumber: aNumber [
	^ self class odDiffClass incompatibleLeft: aNumber right: self
]

{ #category : #'*Object-Diff' }
Object >> odDiffObject: anObject [
	| result |
	result := nil.
	anObject
		ifNil: [ result := ODObjectDiff incompatibleLeft: nil right: self ]
		ifNotNil: [ :o | 
			result := ODObjectDiff left: o right: self.
			self odDiffObject: anObject into: result.
			anObject
				odDiffObject: self
				into: result
				skipMatches: true
				swapLeftRight: true ].
	^ result
]

{ #category : #'*Object-Diff' }
Object >> odDiffObject: anObject into: aDiff [
	^ self odDiffObject: anObject into: aDiff skipMatches: false swapLeftRight: false
]

{ #category : #'*Object-Diff' }
Object >> odDiffObject: anObject into: aDiff skipMatches: skipMatches swapLeftRight: swap [
	anObject
		ifNotNil: [ :o | 
			| varNames |
			varNames := self class allInstVarNames.
			varNames
				ifNotEmpty: [ varNames
						do: [ :varName | 
							| otherValue selfValue |
							otherValue := anObject
								instVarNamed: varName
								ifAbsent: [ :name | nil ].
							selfValue := self instVarNamed: varName.
							selfValue
								ifNil: [ otherValue
										ifNotNil: [ :v | 
											| diff |
											diff := v odDiff: selfValue.
											swap
												ifTrue: [ diff := diff reversed ].
											aDiff addDiff: diff at: varName ] ]
								ifNotNil: [ :s | 
									otherValue
										ifNil: [ | diff |
											diff := s odDiff: nil.
											swap
												ifFalse: [ diff := diff reversed ].
											aDiff addDiff: diff at: varName ]
										ifNotNil: [ :other | 
											(s odIdenticalTo: otherValue)
												ifTrue: [ | diff |
													diff := ODObjectDiff identicalLeft: otherValue right: s.
													aDiff addDiff: diff at: varName ]
												ifFalse: [ s = other
														ifTrue: [ skipMatches
																ifFalse: [ aDiff addMatch: s at: varName ] ]
														ifFalse: [ | diff |
															diff := s odDiff: other.
															aDiff addDiff: diff at: varName ] ] ] ] ] ] ]
]

{ #category : #'*Object-Diff' }
Object >> odDiffOrderedCollection: anInstance [
	^ self class odDiffClass incompatibleLeft: anInstance right: self
]

{ #category : #'*Object-Diff' }
Object >> odDiffString: aString [
	^ self class odDiffClass incompatibleLeft: aString right: self 
]

{ #category : #'*Object-Diff' }
Object >> odIdenticalTo: anObject [
	| result |
	result := false.
	anObject
		ifNotNil: [ :o | | varNames |
			varNames := 
			self class allInstVarNames.
			varNames ifEmpty: [ result := anObject = self ] ifNotEmpty: [ varNames
				do: [ :varName | 
					| otherValue selfValue |
					otherValue := anObject
						instVarNamed: varName
						ifAbsent: [ :name | nil ].
					selfValue := self instVarNamed: varName.
					selfValue
						ifNil: [ otherValue
								ifNotNil: [ :v | result := otherValue odIdenticalTo: nil ] ]
						ifNotNil: [ :s | result := s odIdenticalTo: otherValue ] ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Object >> odIdenticalToString: aString [
	^ aString odWildcardMatch
]

{ #category : #'*Object-Diff' }
Object >> odPrintDiffOn: aStream [
	^ self printOn: aStream
]

{ #category : #'*Object-Diff' }
Object >> odWildcardMatch [
	^ ODWildcards compareWith: self
]
