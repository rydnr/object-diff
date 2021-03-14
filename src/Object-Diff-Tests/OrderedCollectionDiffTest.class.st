Class {
	#name : #OrderedCollectionDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
OrderedCollectionDiffTest >> testArrayDiff [
	| diff left right |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	left atWrap: 2 put: 'b'.
	right := Array new: 2.
	right atWrap: 1 put: 'a'.
	right atWrap: 2 put: 'c'.
	diff := left diff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 1.
	self assert: diff matches first equals: (1 -> 'a').
	self assert: diff positionDiffs isNotEmpty.
	self assert: diff positionDiffs size equals: 1.
	self assert: diff positionDiffs first equals: 2.
	self assert: diff valueDiffs isNotEmpty.
	self assert: diff valueDiffs size equals: 1.
	self assert: diff valueDiffs first equals: ('b' diff: 'c')
]

{ #category : #tests }
OrderedCollectionDiffTest >> testOrderedCollectionDiff [
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
OrderedCollectionDiffTest >> testOrderedCollectionDiff_identical [
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
OrderedCollectionDiffTest >> testOrderedCollectionDiff_with_nil_arguments [
	| diff left |
	left := OrderedCollection with: 'a' with: 'b'.
	diff := left diff: nil.
	self assert: diff isNotNil.
	self assert: diff matches isEmpty
]

{ #category : #tests }
OrderedCollectionDiffTest >> testStringDiff [
	| diff |
	diff := 'a b c' diff: 'a b d'.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 5.
	self assert: diff match equals: 'a b '.
	self assert: diff leftDiff equals: 'c'.
	self assert: diff rightDiff equals: 'd'
]

{ #category : #tests }
OrderedCollectionDiffTest >> testStringDiff_identical [
	| diff value |
	value := 'a b c'.
	diff := value diff: value.
	self assert: diff isNotNil.
	self assert: diff startsAt isNil.
	self assert: diff match equals: value.
	self assert: diff leftDiff equals: nil.
	self assert: diff rightDiff equals: nil.
	self assert: diff identical
]

{ #category : #tests }
OrderedCollectionDiffTest >> testStringDiff_with_nil_argument [
	| diff |
	diff := 'a b c' diff: nil.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 1.
	self assert: diff match equals: ''.
	self assert: diff leftDiff equals: 'a b c'.
	self assert: diff rightDiff equals: nil
]
