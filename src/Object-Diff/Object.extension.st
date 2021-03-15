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
		instVarIndexFor: aString greaseString
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
Object >> odDiffObject: anObject [
	| result |
	result := nil.
	anObject
		ifNil: [ result := ODObjectDiff left: nil right: self ]
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
			self class instVarNames
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
									swap ifFalse: [ diff := diff reversed ].
									aDiff addDiff: diff at: varName ]
								ifNotNil: [ :other | 
									s = other
										ifTrue: [ skipMatches
												ifFalse: [ aDiff addMatch: s at: varName ] ]
										ifFalse: [ | diff |
											diff := s odDiff: other.
											aDiff addDiff: diff at: varName ] ] ] ] ]
]
