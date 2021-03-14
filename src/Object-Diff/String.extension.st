Extension { #name : #String }

{ #category : #'*Object-Diff' }
String >> diff: aString [
	^ aString
		ifNil: [ ODStringDiff
				left: self
				right: nil
				startsAt: 1
				match: '' ]
		ifNotNil: [ :s | s diffString: self ]
]

{ #category : #'*Object-Diff' }
String >> diffDictionary: aDictionary [
	| result |
	result := ODDictionaryDiff left: aDictionary right: self.
	result
		addDiff:
			(ODStringDiff
				left: aDictionary
				right: self
				startsAt: 1
				match: nil)
		at: 1.
	^ result
]

{ #category : #'*Object-Diff' }
String >> diffString: aString [
	| result |
	result := nil.
	aString
		ifNil: [ result := ODStringDiff
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
												ifTrue: [ ODStringDiff
														left: s
														right: self
														startsAt: i
														match: nil ]
												ifFalse: [ ODStringDiff
														left: s
														right: self
														startsAt: i
														match: (s copyFrom: 1 to: i - 1) ] ] ] ] ].
			result
				ifNil: [ result := self size = s size
						ifTrue: [ ODStringDiff
								left: s
								right: self
								startsAt: nil
								match: self ] ] ].
	^ result
]
