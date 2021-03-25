Trait {
	#name : #ODTPrintOn,
	#category : #'Object-Diff'
}

{ #category : #printing }
ODTPrintOn classSide >> printOnSeparator [
	^ ':'
]

{ #category : #printing }
ODTPrintOn >> printOn: aStream [
	self incompatible
		ifTrue:
			[ self printOnIncompatible: aStream left: self left right: self right ]
		ifFalse: [ self identical
				ifTrue: [ self
						printOnIdentical: aStream
						matches: self matches
						separator: self class printOnSeparator ]
				ifFalse: [ self
						printOnDifferent: aStream
						diffs: self diffs
						separator: self class printOnSeparator reversed: self class reversed ] ]
]

{ #category : #printing }
ODTPrintOn >> printOnDifferent: aStream diffs: aDict separator: aSeparator reversed: reversed [
	| lastOneWasIdentical |
	lastOneWasIdentical := false.
	aStream nextPut: $[.
	aDict
		ifNotNil: [ :d | 
			d
				ifNotEmpty: [ d associations sorted
						do: [ :assoc | 
							| value |
							value := assoc value.
							value identical
								ifTrue: [ lastOneWasIdentical := true ]
								ifFalse: [ assoc key printOn: aStream.
									aStream nextPutAll: aSeparator.
									reversed
										ifTrue: [ value := value reversed ].
									value printOn: aStream ] ]
						separatedBy: [ lastOneWasIdentical
								ifFalse: [ aStream nextPut: Character space ] ] ] ].
	aStream nextPut: $]
]

{ #category : #printing }
ODTPrintOn >> printOnIdentical: aStream matches: aDict separator: aSeparator [
	"aStream nextPut: $[.
	aDict
		ifNotNilAndNotEmpty: [ aDict keys sorted
				do: [ :k | 
					k printOn: aStream.
					aStream nextPutAll: aSeparator.
					(aDict at: k) printOn: aStream ]
				separatedBy: [ aStream nextPut: Character space ] ].
	aStream nextPut: $]"
]

{ #category : #printing }
ODTPrintOn >> printOnIncompatible: aStream left: left right: right [
	left odPrintDiffOn: aStream.
	aStream nextPutAll: '~='.
	right odPrintDiffOn: aStream
]
