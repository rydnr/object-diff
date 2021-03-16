Class {
	#name : #ODNumberDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODNumberDiffTest >> test_Number_diff_Array [
	| diff right |
	right := #('a').
	diff := 1 odDiff: right.
	self assert: diff isNotNil.
	self assert: diff left equals: 1.
	self assert: diff right equals: right.
	self assert: diff greaseString equals: '1~=[1:''a'']'
]

{ #category : #tests }
ODNumberDiffTest >> test_Number_diff_Dictionary [
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
ODNumberDiffTest >> test_Number_diff_Number [
	| diff |
	diff := 1 odDiff: 2.
	self assert: diff isNotNil.
	self assert: diff left equals: 1.
	self assert: diff right equals: 2
]

{ #category : #tests }
ODNumberDiffTest >> test_Number_diff_String [
	| diff |
	diff := 1 odDiff: 'a'.
	self assert: diff isNotNil.
	self assert: diff left equals: 1.
	self assert: diff right equals: 'a'.
	self assert: diff greaseString equals: '1~=''a'''
]

{ #category : #tests }
ODNumberDiffTest >> test_identical_Numbers [
	| diff value |
	value := 1.
	diff := value odDiff: value.
	self assert: diff isNotNil.
	self assert: diff identical
]

{ #category : #tests }
ODNumberDiffTest >> test_printOn_Number_Number [
	| diff left right |
	left := 1.
	right := 2.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '1~=2'
]

{ #category : #tests }
ODNumberDiffTest >> test_printOn_identical_Numbers [
	| diff value |
	value := 1.
	diff := value odDiff: value.
	self assert: diff greaseString equals: ''
]
