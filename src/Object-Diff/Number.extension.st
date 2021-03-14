Extension { #name : #Number }

{ #category : #'*Object-Diff' }
Number >> odDiffString: aString [
	| result |
	result := nil.
	aString
		ifNil: [ result := ODNumberDiff
				left: nil
				right: self
				match: nil ]
		ifNotNil: [ :s | 
			result := self greaseString = aString
				ifTrue: [ ODNumberDiff
						left: aString
						right: self
						match: self ]
				ifFalse: [ ODNumberDiff
						left: aString
						right: self
						match: nil ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Number >> printNameOn: aWriteStream [
	^ super printOn: aWriteStream
]
