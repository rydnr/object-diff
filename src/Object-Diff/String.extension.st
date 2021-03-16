Extension { #name : #String }

{ #category : #'*Object-Diff' }
String >> odDiff: aString [
	^ aString
		ifNil: [ ODStringDiff
				left: self
				right: nil
				startsAt: 1
				match: '' ]
		ifNotNil: [ :s | s odDiffString: self ]
]

{ #category : #'*Object-Diff' }
String class >> odDiffClass [
	^ ODStringDiff
]

{ #category : #'*Object-Diff' }
String >> odDiffDictionary: aDictionary [
	| result |
	result := ODStringDiff
		left: aDictionary
		right: self
		startsAt: 1
		match: nil.
	result
		addDiff:
			(ODDictionaryDiff
				left: aDictionary
				right: self)
		at: 1.
	^ result
]

{ #category : #'*Object-Diff' }
String >> odDiffNumber: anInteger [
	^ anInteger
		ifNil: [ ODStringDiff
				left: nil
				right: self
				startsAt: 1
				match: '' ]
		ifNotNil: [ :s | 
			self greaseString = anInteger greaseString
				ifTrue: [ ODStringDiff
						left: s
						right: self
						startsAt: self size + 1
						match: self ]
				ifFalse: [ ODStringDiff
						left: s
						right: self
						startsAt: 1
						match: nil ] ]
]

{ #category : #'*Object-Diff' }
String >> odDiffString: aString [
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
