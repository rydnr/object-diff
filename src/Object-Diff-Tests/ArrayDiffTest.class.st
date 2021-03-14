Class {
	#name : #ArrayDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ArrayDiffTest >> testArrayDiff [
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
ArrayDiffTest >> testArrayDiff_complex_2 [
	| diff left right nestedLeft nestedRight |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	nestedLeft := Array new: 2.
	nestedLeft atWrap: 1 put: '1'.
	nestedLeft
		atWrap: 2
		put: (Dictionary with: 'd' -> 'D' with: 'e' -> 'E').
	left atWrap: 2 put: nestedLeft.
	right := Array new: 2.
	right atWrap: 1 put: 'a'.
	nestedRight := Array new: 2.
	nestedRight atWrap: 1 put: 'x'.
	nestedRight atWrap: 2 put: '2'.
	right atWrap: 2 put: nestedRight.
	diff := left diff: right.
	self
		assert: diff greaseString
		equals:
			'2->(1->(a SmallInteger (2) ~= a ByteString (x),2->(a Dictionary [2 items] (''d''->''D'',''e''->''E'') != a ByteString ''2'')'
]

{ #category : #tests }
ArrayDiffTest >> testArrayDiff_identical [
	| diff left right |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	left atWrap: 2 put: 'b'.
	right := Array new: 2.
	right atWrap: 1 put: 'a'.
	right atWrap: 2 put: 'b'.
	diff := left diff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 2.
	self assert: diff matches first equals: (1 -> 'a').
	self assert: diff matches second equals: (2 -> 'b').
	self assert: diff positionDiffs isEmpty.
	self assert: diff valueDiffs isEmpty.
	self assert: diff identical
]

{ #category : #tests }
ArrayDiffTest >> testArrayDiff_printOn_identical [
	| diff left right |
	left := 'a'.
	right := left.
	diff := left diff: right.
	self assert: diff greaseString equals: 'a ByteString(''a'')()'
]

{ #category : #tests }
ArrayDiffTest >> testArrayDiff_printOn_string_smallinteger [
	| diff left right |
	left := 'a'.
	right := 1.
	diff := left diff: right.
	self
		assert: diff greaseString
		equals: '(a ByteString(''a'') ~= a SmallInteger(1))'
]

{ #category : #tests }
ArrayDiffTest >> testArrayDiff_printOn_string_string [
	| diff left right |
	left := 'aaa'.
	right := 'aab'.
	diff := left diff: right.
	self
		assert: diff greaseString
		equals: 'a ByteString(''aa'')(a ByteString(''a'') ~= a ByteString(''b''))'
]

{ #category : #tests }
ArrayDiffTest >> testArrayDiff_printOn_string_string_completely_different [
	| diff left right |
	left := 'acc'.
	right := 'xyy'.
	diff := left diff: right.
	self
		assert: diff greaseString
		equals: '(a ByteString(''acc'') ~= a ByteString(''xyy''))'
]

{ #category : #tests }
ArrayDiffTest >> testArrayDiff_with_nested_arrays [
	| diff left right nestedLeft nestedRight |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	nestedLeft := Array new: 2.
	nestedLeft atWrap: 1 put: '1'.
	nestedLeft atWrap: 2 put: '2'.
	left atWrap: 2 put: nestedLeft.
	right := Array new: 2.
	right atWrap: 1 put: 'a'.
	nestedRight := Array new: 2.
	nestedRight atWrap: 1 put: 'x'.
	nestedRight atWrap: 2 put: '2'.
	right atWrap: 2 put: nestedRight.
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
	self assert: diff valueDiffs first equals: (nestedLeft diff: nestedRight)
]

{ #category : #tests }
ArrayDiffTest >> testArrayDiff_with_nested_dictionaries [
	| diff left right nestedLeft nestedRight |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	nestedLeft := Array new: 2.
	nestedLeft atWrap: 1 put: '1'.
	nestedLeft
		atWrap: 2
		put: (Dictionary with: 'd' -> 'D' with: 'e' -> 'E').
	left atWrap: 2 put: nestedLeft.
	right := Array new: 2.
	right atWrap: 1 put: 'a'.
	nestedRight := Array new: 2.
	nestedRight atWrap: 1 put: 'x'.
	nestedRight atWrap: 2 put: '2'.
	right atWrap: 2 put: nestedRight.
	diff := left diff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 1.
	self assert: diff matches first equals: 1 -> 'a'.
	self assert: diff positionDiffs isNotEmpty.
	self assert: diff positionDiffs size equals: 1.
	self assert: diff positionDiffs first equals: 2.
	self assert: diff valueDiffs isNotEmpty.
	self assert: diff valueDiffs size equals: 1.
	self
		assert: diff valueDiffs first
		equals: (nestedLeft diff: nestedRight).
	self assert: diff valueDiffs first left equals: nestedLeft.
	self assert: diff valueDiffs first right equals: nestedRight
]

{ #category : #tests }
ArrayDiffTest >> testArrayDiff_with_nil_arguments [
	| diff left |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	left atWrap: 2 put: 'b'.
	diff := left diff: nil.
	self assert: diff isNotNil.
	self assert: diff matches isEmpty
]
