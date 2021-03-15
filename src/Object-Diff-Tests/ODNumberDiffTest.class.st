Class {
	#name : #ODNumberDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODNumberDiffTest >> test_identical [
	| diff value |
	value := 1.
	diff := value odDiff: value.
	self assert: diff isNotNil.
	self assert: diff identical
]

{ #category : #tests }
ODNumberDiffTest >> test_number1_diff_Array [
	| diff right |
	right := #('a').
	diff := 1 odDiff: right.
	self assert: diff isNotNil.
	self assert: diff left equals: 1.
	self assert: diff right equals: right.
	self assert: diff greaseString equals: '1~=[''a'']'
]

{ #category : #tests }
ODNumberDiffTest >> test_number1_diff_Dictionary [
	| diff right |
	right := Dictionary new.
	right at: 'a' put: 'b'.
	diff := 1 odDiff: right.
	self assert: diff isNotNil.
	self assert: diff left equals: 1.
	self assert: diff right equals: right.
	self assert: diff greaseString equals: '1~=[''a''->''b'']'
]

{ #category : #tests }
ODNumberDiffTest >> test_number1_diff_String [
	| diff |
	diff := 1 odDiff: 'a'.
	self assert: diff isNotNil.
	self assert: diff left equals: 1.
	self assert: diff right equals: 'a'.
	self assert: diff greaseString equals: '1~=''a'''
]

{ #category : #tests }
ODNumberDiffTest >> test_number1_diff_number2 [
	| diff |
	diff := 1 odDiff: 2.
	self assert: diff isNotNil.
	self assert: diff left equals: 1.
	self assert: diff right equals: 2
]

{ #category : #tests }
ODNumberDiffTest >> test_printOn_identical [
	| diff value |
	value := 1.
	diff := value odDiff: value.
	self assert: diff greaseString equals: ''
]

{ #category : #tests }
ODNumberDiffTest >> test_printOn_number_number [
	| diff left right |
	left := 1.
	right := 2.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '1~=2'
]
