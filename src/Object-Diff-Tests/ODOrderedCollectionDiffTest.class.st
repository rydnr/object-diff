Class {
	#name : #ODOrderedCollectionDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_OrderedCollection_diff_Array [
	| diff left right |
	left := OrderedCollection with: '1' with: '2'.
	right := Array with: '3' with: '4'.
	diff := left odDiff: right.
	self
		assert: diff greaseString
		equals: '[1:''1''~=''3'' 2:''2''~=''4'']'
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_OrderedCollection_diff_Dictionary [
	| diff left right |
	left := Dictionary new.
	left at: '1' put: '2'.
	right := 3.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '[''1''->''2'']~=3'
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_OrderedCollection_diff_Number [
	| diff left right |
	left := OrderedCollection with: '1' with: '2'.
	right := ODDummyObject new.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '[1:''1'' 2:''2'']~=an ODDummyObject'
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_OrderedCollection_diff_String [
	| diff left right |
	left := OrderedCollection with: '1' with: '2'.
	right := 'a'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '[1:''1'' 2:''2'']~=''a'''
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_OrderedCollection_diff_anything_wildcard_disabled [
	| previouslyEnabled |
	previouslyEnabled := ODWildcards enabled.
	ODWildcards disable.
	[ | diff left right |
	left := OrderedCollection with: '1' with: '2'.
	right := '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff incompatible ]
		ensure: [ previouslyEnabled
				ifTrue: [ ODWildcards enable ] ]
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_OrderedCollection_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := OrderedCollection with: '1' with: '2'.
	right := '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff identical ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_OrderedCollection_diff_nil [
	| diff left |
	left := OrderedCollection with: 'a' with: 'b'.
	diff := left odDiff: nil.
	self assert: diff isNotNil.
	self assert: diff matches isEmpty
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_diff_partially_matching_OrderedCollections [
	| diff left right |
	left := OrderedCollection with: 'a' with: 'b'.
	right := OrderedCollection with: 'a' with: 'c'.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 1.
	self assert: (diff matches at: 1) equals: 'a'.
	self assert: diff diffs isNotEmpty.
	self assert: diff diffs size equals: 1.
	self assert: (diff diffs at: 2) equals: ('b' odDiff: 'c')
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_identical_OrderedCollections [
	| diff left right |
	left := OrderedCollection with: 'a' with: 'b'.
	right := OrderedCollection with: 'a' with: 'b'.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 2.
	self assert: (diff matches at: 1) equals: 'a'.
	self assert: (diff matches at: 2) equals: 'b'.
	self assert: diff diffs isEmpty.
	self assert: diff identical
]

{ #category : #tests }
ODOrderedCollectionDiffTest >> test_printOn_identical_OrderedCollections [
	| diff value |
	value := OrderedCollection with: 'a' with: 'b'.
	diff := value odDiff: value.
	self assert: diff isNotNil.
	self assert: diff greaseString equals: ''
]
