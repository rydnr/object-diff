Extension { #name : #Object }

{ #category : #'*Object-Diff' }
Object >> diff: anObject [
	| result |
	result := OrderedCollection new.
	self class instVarNames
		do: [ :varName | 
			| otherValue selfValue diff |
			diff := nil.
			otherValue := anObject
				instVarNamed: varName
				ifAbsent: [ nil ].
			selfValue := self instVarNamed: varName.
			selfValue
				ifNil: [ otherValue ifNotNil: [ :v | diff := v diff: selfValue ] ]
				ifNotNil: [ :s | 
					otherValue
						ifNotNil: [ :arg | 
							s = otherValue
								ifFalse: [ diff := s diff: otherValue ] ] ].
			diff
				ifNotNil: [ :d | 
					(d value isNotNil and: [ d value identical ])
						ifFalse: [ result add: varName -> diff ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Object >> instVarNamed: aString [
	"Return the value of the instance variable in me with that name.  Slow and unclean, but very useful. "

	^ self instVarNamed: aString ifAbsent: [ self error: 'no such inst var' ]
]

{ #category : #'*Object-Diff' }
Object >> instVarNamed: aString ifAbsent: aBlock [
	"Return the value of the instance variable in me with that name.  Slow and unclean, but very useful. "

	^ self
		instVarAt:
			(self class
				instVarIndexFor: aString asString
				ifAbsent: aBlock)
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
