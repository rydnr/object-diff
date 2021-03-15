Extension { #name : #Number }

{ #category : #'*Object-Diff' }
Number >> odDiff: anObject [
	^ anObject
		ifNil: [ ODNumberDiff left: self right: nil ]
		ifNotNil: [ :s | s odDiffNumber: self ]
]

{ #category : #'*Object-Diff' }
Number >> odDiffNumber: aNumber [
	^ ODNumberDiff left: aNumber right: self
]

{ #category : #'*Object-Diff' }
Number >> odDiffString: aString [
	| result |
	result := nil.
	aString
		ifNil: [ result := ODNumberDiff left: nil right: self ]
		ifNotNil: [ :s | 
			result := self greaseString = aString
				ifTrue: [ ODNumberDiff left: aString right: self ]
				ifFalse: [ ODNumberDiff left: aString right: self ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Number >> printNameOn: aWriteStream [
	^ super printOn: aWriteStream
]
