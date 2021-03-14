Extension { #name : #String }

{ #category : #'*Object-Diff' }
String >> diff: aString [
	^ aString
		ifNil: [ StringDiff
				left: self
				right: nil
				startsAt: 1
				match: '' ]
		ifNotNil: [ :s | s diffString: self ]
]

{ #category : #'*Object-Diff' }
String >> diffDictionary: aDictionary [
	^ DictionaryDiff left: aDictionary right: self
]

{ #category : #'*Object-Diff' }
String >> diffString: aString [
	| result |
	result := nil.
	aString
		ifNil: [ result := StringDiff
				left: nil
				right: self
				startsAt: 1
				match: '' ]
		ifNotNil: [ :s | 
			self
				keysAndValuesDo: [ :i :c | 
					result
						ifNil: [ s size >= i
								ifTrue: [ c ~= (s at: i)
										ifTrue: [ result := i = 1
												ifTrue: [ StringDiff
														left: s
														right: self
														startsAt: i
														match: nil ]
												ifFalse: [ StringDiff
														left: s
														right: self
														startsAt: i
														match: (s copyFrom: 1 to: i - 1) ] ] ] ] ].
			result
				ifNil: [ result := self size = s size
						ifTrue: [ StringDiff
								left: s
								right: self
								startsAt: nil
								match: self ] ] ].
	^ result
]
