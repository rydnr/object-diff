Class {
	#name : #StringDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
StringDiffTest >> testStringDiff [
	| diff |
	diff := 'a b c' diff: 'a b d'.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 5.
	self assert: diff match equals: 'a b '.
	self assert: diff leftDiff equals: 'c'.
	self assert: diff rightDiff equals: 'd'
]

{ #category : #tests }
StringDiffTest >> testStringDiff_identical [
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
StringDiffTest >> testStringDiff_with_nil_argument [
	| diff |
	diff := 'a b c' diff: nil.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 1.
	self assert: diff match equals: ''.
	self assert: diff leftDiff equals: 'a b c'.
	self assert: diff rightDiff equals: nil
]
