Extension { #name : #Number }

{ #category : #'*Object-Diff' }
Number >> diffString: aString [
	| result |
	result := nil.
	aString
		ifNil: [ result := NumberDiff
				left: nil
				right: self
				match: nil ]
		ifNotNil: [ :s | 
			result := self greaseString = aString
				ifTrue: [ NumberDiff
						left: aString
						right: self
						match: self ]
				ifFalse: [ NumberDiff
						left: aString
						right: self
						match: nil ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Number >> printNameOn: aWriteStream [
	^ super printOn: aWriteStream
]
