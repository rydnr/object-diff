Class {
	#name : #ODStringDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODStringDiffTest >> test_identical [
	| diff value |
	value := 'a b c'.
	diff := value odDiff: value.
	self assert: diff isNotNil.
	self assert: diff startsAt isNil.
	self assert: diff match equals: value.
	self assert: diff leftDiff equals: nil.
	self assert: diff rightDiff equals: nil.
	self assert: diff identical
]

{ #category : #tests }
ODStringDiffTest >> test_printOn_identical [
	| diff value |
	value := 'a'.
	diff := value odDiff: value.
	self assert: diff greaseString equals: ''
]

{ #category : #tests }
ODStringDiffTest >> test_printOn_string_string [
	| diff left right |
	left := 'aaa'.
	right := 'aab'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''aaa''~=''aab'''
]

{ #category : #tests }
ODStringDiffTest >> test_printOn_string_string_completely_different [
	| diff left right |
	left := 'acc'.
	right := 'xyy'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''acc''~=''xyy'''
]

{ #category : #tests }
ODStringDiffTest >> test_string1_diff_string2 [
	| diff |
	diff := 'a b c' odDiff: 'a b d'.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 5.
	self assert: diff match equals: 'a b '.
	self assert: diff leftDiff equals: 'c'.
	self assert: diff rightDiff equals: 'd'
]

{ #category : #tests }
ODStringDiffTest >> test_string_diff_Array [
	| diff left right |
	left := 'a'.
	right := Array with: '1' with: '2'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''a''~=[1:''1'' 2:''2'']'
]

{ #category : #tests }
ODStringDiffTest >> test_string_diff_Dictionary [
	| diff left right |
	left := 'a'.
	right := Dictionary new.
	right at: '1' put: '2'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''a''~=[''1''->''2'']'
]

{ #category : #tests }
ODStringDiffTest >> test_string_diff_nil [
	| diff |
	diff := 'a b c' odDiff: nil.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 1.
	self assert: diff match equals: ''.
	self assert: diff leftDiff equals: 'a b c'.
	self assert: diff rightDiff equals: nil
]

{ #category : #tests }
ODStringDiffTest >> test_string_diff_smallinteger [
	| diff left right |
	left := 'a'.
	right := 1.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''a''~=1'
]
