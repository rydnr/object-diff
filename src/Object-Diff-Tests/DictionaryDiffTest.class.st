Class {
	#name : #DictionaryDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
DictionaryDiffTest >> test_diff_nil [
	| diff left |
	left := Dictionary new.
	left at: 'firstKey' put: 'a'.
	left at: 'secondKey' put: 'b'.
	diff := left diff: nil.
	self assert: diff isNotNil.
	self assert: diff matches isEmpty
]

{ #category : #tests }
DictionaryDiffTest >> test_diff_partially_matching_dictionaries [
	| diff left right |
	left := Dictionary new.
	left at: 'firstKey' put: 'a'.
	left at: 'secondKey' put: 'b'.
	right := Dictionary new.
	right at: 'firstKey' put: 'a'.
	right at: 'secondKey' put: 'c'.
	diff := left diff: right.
	self assert: diff isNotNil.
	self assert: diff keyDiffs size equals: 0.
	self assert: diff valueDiffs size equals: 1.
	self
		assert: diff valueDiffs first
		equals:
			('b' diff: 'c').
	self assert: diff matches size equals: 1.
	self
		assert: diff matches first
		equals: (Dictionary with: 'firstKey' -> 'a')
]

{ #category : #tests }
DictionaryDiffTest >> test_identical [
	| diff value |
	value := Dictionary new.
	value at: 'firstKey' put: 'a'.
	value at: 'secondKey' put: 'b'.
	diff := value diff: value.
	self assert: diff isNotNil.
	self assert: diff keyDiffs size equals: 0.
	self assert: diff valueDiffs size equals: 0.
	self assert: diff matches size equals: 2.
	self
		assert: (diff matches select: [ :m | m includesKey: 'firstKey' ]) first
		equals: (Dictionary with: 'firstKey' -> 'a').
	self
		assert: (diff matches select: [ :m | m includesKey: 'secondKey' ]) first
		equals: (Dictionary with: 'secondKey' -> 'b').
	self assert: diff identical
]

{ #category : #tests }
DictionaryDiffTest >> test_printOn_identical [
	| diff value |
	value := Dictionary new.
	value at: 'firstKey' put: 'a'.
	value at: 'secondKey' put: 'b'.
	diff := value diff: value.
	self
		assert: diff greaseString
		equals: 'two Dictionaries(''firstKey''->''a'' ''secondKey''->''b'')'
]
