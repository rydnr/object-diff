Class {
	#name : #OrderedCollectionDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
OrderedCollectionDiffTest >> test_diff_nil [
	| diff left |
	left := OrderedCollection with: 'a' with: 'b'.
	diff := left diff: nil.
	self assert: diff isNotNil.
	self assert: diff matches isEmpty
]

{ #category : #tests }
OrderedCollectionDiffTest >> test_diff_partially_matching_orderedcollections [
	| diff left right |
	left := OrderedCollection with: 'a' with: 'b'.
	right := OrderedCollection with: 'a' with: 'c'.
	diff := left diff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 1.
	self assert: diff matches first equals: 1.
	self assert: diff positionDiffs isNotEmpty.
	self assert: diff positionDiffs size equals: 1.
	self assert: diff positionDiffs first equals: 2.
	self assert: diff valueDiffs isNotEmpty.
	self assert: diff valueDiffs size equals: 1.
	self assert: diff valueDiffs first equals: ('b' diff: 'c')
]

{ #category : #tests }
OrderedCollectionDiffTest >> test_identical [
	| diff left right |
	left := OrderedCollection with: 'a' with: 'b'.
	right := OrderedCollection with: 'a' with: 'b'.
	diff := left diff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 2.
	self assert: diff matches first equals: 1.
	self assert: diff matches second equals: 2.
	self assert: diff positionDiffs isEmpty.
	self assert: diff valueDiffs isEmpty.
	self assert: diff identical
]

{ #category : #tests }
OrderedCollectionDiffTest >> test_printOn_identical [
	| diff value |
	value := OrderedCollection with: 'a' with: 'b'.
	diff := value diff: value.
	self assert: diff isNotNil.
	self
		assert: diff greaseString
		equals: 'two OrderedCollections(''a'' ''b'')'
]
