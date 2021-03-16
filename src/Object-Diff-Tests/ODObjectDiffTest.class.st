Class {
	#name : #ODObjectDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODObjectDiffTest >> test_diff_different_classes [
	| left right diff |
	left := ODDummyObject new.
	left
		a: 'A';
		b: 'B'.
	right := ODDummyObject2 new.
	right
		c: 'C';
		d: 'D'.
	diff := left odDiff: right.
	self assert: diff identical not.
	self assert: diff matches isEmpty.
	self assert: diff diffs isNotEmpty.
	self assert: (diff diffs at: 'a') isNotNil.
	self assert: (diff diffs at: 'a') left equals: 'A'.
	self assert: (diff diffs at: 'a') right isNil.
	self assert: (diff diffs at: 'b') isNotNil.
	self assert: (diff diffs at: 'b') left equals: 'B'.
	self assert: (diff diffs at: 'b') right isNil.
	self assert: (diff diffs at: 'c') isNotNil.
	self assert: (diff diffs at: 'c') left isNil.
	self assert: (diff diffs at: 'c') right  equals: 'C'.
	self assert: (diff diffs at: 'd') isNotNil.
	self assert: (diff diffs at: 'd') left isNil.
	self assert: (diff diffs at: 'd') right equals: 'D'.
]

{ #category : #tests }
ODObjectDiffTest >> test_diff_same_class_different_instance [
	| left right diff |
	left := ODDummyObject new.
	left
		a: 'A';
		b: 'B'.
	right := ODDummyObject new.
	right
		a: 'A';
		b: 'C'.
	diff := left odDiff: right.
	self assert: diff identical not.
	self assert: diff matches isNotEmpty.
	self assert: (diff matches at: 'a') equals: 'A'.
	self assert: diff diffs isNotEmpty.
	self assert: (diff diffs at: 'b') isNotNil.
	self assert: (diff diffs at: 'b') left equals: 'B'.
	self assert: (diff diffs at: 'b') right equals: 'C'
]

{ #category : #tests }
ODObjectDiffTest >> test_identical_Objects [
	| value diff |
	value := ODDummyObject new.
	value
		a: 'A';
		b: 'B'.
	diff := value odDiff: value.
	self assert: diff identical
]
