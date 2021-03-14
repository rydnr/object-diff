Class {
	#name : #ODOrderedCollectionDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_diff_nil [
	| diff left |
	left := OrderedCollection with: 'a' with: 'b'.
	diff := left diff: nil.
	self assert: diff isNotNil.
	self assert: diff matches isEmpty
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_diff_partially_matching_orderedcollections [
	| diff left right |
	left := OrderedCollection with: 'a' with: 'b'.
	right := OrderedCollection with: 'a' with: 'c'.
	diff := left diff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 1.
	self assert: diff matches first equals: 'a'.
	self assert: diff diffs isNotEmpty.
	self assert: diff diffs size equals: 1.
	self assert: diff diffs first equals: ('b' diff: 'c')
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_identical [
	| diff left right |
	left := OrderedCollection with: 'a' with: 'b'.
	right := OrderedCollection with: 'a' with: 'b'.
	diff := left diff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 2.
	self assert: diff matches first equals: 'a'.
	self assert: diff matches second equals: 'b'.
	self assert: diff diffs isEmpty.
	self assert: diff identical
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_printOn_identical [
	| diff value |
	value := OrderedCollection with: 'a' with: 'b'.
	diff := value diff: value.
	self assert: diff isNotNil.
	self
		assert: diff greaseString
		equals: '[1:''a'' 2:''b'']'
]
