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
