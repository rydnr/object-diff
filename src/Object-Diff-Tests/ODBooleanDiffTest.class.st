Class {
	#name : #ODBooleanDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODBooleanDiffTest >> test_false_identicalTo_false [
	self assert: (false odIdenticalTo: false).
]

{ #category : #tests }
ODBooleanDiffTest >> test_false_notIdenticalTo_true [
	self assert: (false odIdenticalTo: true) not
]

{ #category : #tests }
ODBooleanDiffTest >> test_true_identicalTo_true [
	self assert: (true odIdenticalTo: true)
]

{ #category : #tests }
ODBooleanDiffTest >> test_true_notIdenticalTo_false [
	self assert: (true odIdenticalTo: false) not
]
