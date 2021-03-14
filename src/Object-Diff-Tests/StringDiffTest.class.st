Class {
	#name : #StringDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
StringDiffTest >> test_identical [
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
StringDiffTest >> test_printOn_identical [
	| diff value |
	value := 'a'.
	diff := value diff: value.
	self
		assert: diff greaseString
		equals: 'two ByteStrings(''' , value , ''')'
]

{ #category : #tests }
StringDiffTest >> test_printOn_string_string [
	| diff left right |
	left := 'aaa'.
	right := 'aab'.
	diff := left diff: right.
	self
		assert: diff greaseString
		equals: 'a ByteString(''aa'')(a ByteString(''a'') ~= a ByteString(''b''))'
]

{ #category : #tests }
StringDiffTest >> test_printOn_string_string_completely_different [
	| diff left right |
	left := 'acc'.
	right := 'xyy'.
	diff := left diff: right.
	self
		assert: diff greaseString
		equals: '(a ByteString(''acc'') ~= a ByteString(''xyy''))'
]

{ #category : #tests }
StringDiffTest >> test_string1_diff_string2 [
	| diff |
	diff := 'a b c' diff: 'a b d'.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 5.
	self assert: diff match equals: 'a b '.
	self assert: diff leftDiff equals: 'c'.
	self assert: diff rightDiff equals: 'd'
]

{ #category : #tests }
StringDiffTest >> test_string_diff_nil [
	| diff |
	diff := 'a b c' diff: nil.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 1.
	self assert: diff match equals: ''.
	self assert: diff leftDiff equals: 'a b c'.
	self assert: diff rightDiff equals: nil
]

{ #category : #tests }
StringDiffTest >> test_string_diff_smallinteger [
	| diff left right |
	left := 'a'.
	right := 1.
	diff := left diff: right.
	self
		assert: diff greaseString
		equals: '(a ByteString(''a'') ~= a SmallInteger(1))'.
	self assert: diff match isNil
]
