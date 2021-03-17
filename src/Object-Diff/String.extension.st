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
String >> odDiffArray: aCollection [
	^ self odWildcardMatch
		ifTrue: [ ODStringDiff identicalLeft: aCollection right: self ]
		ifFalse: [ self class odDiffClass incompatibleLeft: aCollection right: self ]
]

{ #category : #'*Object-Diff' }
String class >> odDiffClass [
	^ ODStringDiff
]

{ #category : #'*Object-Diff' }
String >> odDiffDictionary: aDictionary [
	| result |
	self odWildcardMatch
		ifTrue: [ result := ODStringDiff identicalLeft: aDictionary right: self ]
		ifFalse: [ result := ODStringDiff
		left: aDictionary
		right: self
		startsAt: 1
		match: nil.
	result
		addDiff: (ODDictionaryDiff left: aDictionary right: self)
		at: 1 ].
	^ result
]

{ #category : #'*Object-Diff' }
String >> odDiffNumber: aNumber [
	^ self odWildcardMatch
		ifTrue: [ ODStringDiff identicalLeft: aNumber right: self ]
		ifFalse: [ aNumber
		ifNil: [ ODStringDiff
				left: nil
				right: self
				startsAt: 1
				match: '' ]
		ifNotNil: [ :s | 
			self greaseString = aNumber greaseString
				ifTrue: [ ODStringDiff
						left: s
						right: self
						startsAt: self size + 1
						match: self ]
				ifFalse: [ ODStringDiff
						left: s
						right: self
						startsAt: 1
						match: nil ] ] ]
]

{ #category : #'*Object-Diff' }
String >> odDiffObject: anInstance [
	^ self class odDiffClass incompatibleLeft: anInstance right: self
]

{ #category : #'*Object-Diff' }
String >> odDiffOrderedCollection: aCollection [
	^ self odWildcardMatch
		ifTrue: [ ODStringDiff identicalLeft: aCollection right: self ]
		ifFalse: [ self class odDiffClass incompatibleLeft: aCollection right: self ]
]

{ #category : #'*Object-Diff' }
String >> odDiffString: aString [
	^ self odWildcardMatch ifTrue: [ ODStringDiff identicalLeft: aString right: self ] ifFalse: [ aString
		ifNil: [ ODStringDiff incompatibleLeft: nil right: self ]
		ifNotNil: [ :s | 
			s = self
				ifTrue: [ ODStringDiff left: aString right: self ]
				ifFalse: [ s odWildcardMatch
						ifTrue: [ ODStringDiff identicalLeft: aString right: self ]
						ifFalse: [ ODStringDiff incompatibleLeft: aString right: self ] ] ] ]
]
