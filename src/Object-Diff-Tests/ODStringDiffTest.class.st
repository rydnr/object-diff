Class {
	#name : #ODStringDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODStringDiffTest >> test_String_diff_Array [
	| diff left right |
	left := 'a'.
	right := Array with: '1' with: '2'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''a''~=[1:''1'' 2:''2'']'
]

{ #category : #tests }
ODStringDiffTest >> test_String_diff_Dictionary [
	| diff left right |
	left := 'a'.
	right := Dictionary new.
	right at: '1' put: '2'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''a''~=[''1''->''2'']'
]

{ #category : #tests }
ODStringDiffTest >> test_String_diff_Number [
	| diff left right |
	left := 'a'.
	right := 1.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''a''~=1'
]

{ #category : #tests }
ODStringDiffTest >> test_String_diff_OrderedCollection [
	| diff left right |
	left := 'a'.
	right := ODDummyObject new.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''a''~=an ODDummyObject'
]

{ #category : #tests }
ODStringDiffTest >> test_String_diff_String [
	| diff |
	diff := 'a b c' odDiff: 'a b d'.
	self assert: diff isNotNil.
	self assert: diff incompatible
]

{ #category : #tests }
ODStringDiffTest >> test_String_diff_anything_wildcard_disabled [
	| previouslyEnabled |
	previouslyEnabled := ODWildcards enabled.
	ODWildcards disable.
	[ | diff |
	diff := 'a b c' odDiff: '<ANYTHING>'.
	self assert: diff isNotNil.
	self assert: diff incompatible ]
		ensure: [ previouslyEnabled
				ifTrue: [ ODWildcards enable ] ]
]

{ #category : #tests }
ODStringDiffTest >> test_String_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff |
	diff := 'a b c' odDiff: '<ANYTHING>'.
	self assert: diff isNotNil.
	self assert: diff identical ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODStringDiffTest >> test_String_diff_nil [
	| diff |
	diff := 'a b c' odDiff: nil.
	self assert: diff isNotNil.
	self assert: diff startsAt equals: 1.
	self assert: diff match equals: ''.
	self assert: diff leftDiff equals: 'a b c'.
	self assert: diff rightDiff equals: nil
]

{ #category : #tests }
ODStringDiffTest >> test_identical_Strings [
	| diff value |
	value := 'a b c'.
	diff := value odDiff: value.
	self assert: diff isNotNil.
	self assert: diff startsAt isNil.
	self assert: diff leftDiff equals: nil.
	self assert: diff rightDiff equals: nil.
	self assert: diff identical.
	self assert: (value odIdenticalTo: value)
]

{ #category : #tests }
ODStringDiffTest >> test_printOn_String_String [
	| diff left right |
	left := 'aaa'.
	right := 'aab'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''aaa''~=''aab'''
]

{ #category : #tests }
ODStringDiffTest >> test_printOn_completely_different_Strings [
	| diff left right |
	left := 'acc'.
	right := 'xyy'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '''acc''~=''xyy'''
]

{ #category : #tests }
ODStringDiffTest >> test_printOn_identical_Strings [
	| diff value |
	value := 'a'.
	diff := value odDiff: value.
	self assert: diff greaseString equals: ''
]
