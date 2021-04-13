Extension { #name : #Number }

{ #category : #'*Object-Diff' }
Number >> odDiff: anObject [
	^ anObject
		ifNil: [ ODNumberDiff left: self right: nil ]
		ifNotNil: [ :s | s odDiffNumber: self ]
]

{ #category : #'*Object-Diff' }
Number class >> odDiffClass [
	^ ODNumberDiff
]

{ #category : #'*Object-Diff' }
Number >> odDiffNumber: aNumber [
	^ ODNumberDiff left: aNumber right: self
]

{ #category : #'*Object-Diff' }
Number >> odDiffObject: anInstance [
	^ self class odDiffClass incompatibleLeft: anInstance right: self
]

{ #category : #'*Object-Diff' }
Number >> odIdenticalToNumber: aNumber [
	| result |
	result := self odWildcardMatch.
	result
		ifFalse: [ aNumber
				ifNotNil: [ :arg | result := arg odWildcardMatch or: [ arg = self ] ] ].
	^ result
]

{ #category : #'*Object-Diff' }
Number >> printNameOn: aWriteStream [
	^ super printOn: aWriteStream
]
