Class {
	#name : #ODObjectDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODObjectDiffTest >> test_Object_diff_Array [
	| diff left right |
	left := ODDummyObject new.
	right := Array with: '1' with: '2'.
	diff := left odDiff: right.
	self
		assert: diff greaseString
		equals: 'an ODDummyObject~=[1:''1'' 2:''2'']'
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_diff_Dictionary [
	| diff left right |
	left := ODDummyObject new.
	right := Dictionary new.
	right at: '1' put: '2'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: 'an ODDummyObject~=[''1''->''2'']'
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_diff_Number [
	| diff left right |
	left := ODDummyObject new.
	right := 3.
	diff := left odDiff: right.
	self assert: diff greaseString equals: 'an ODDummyObject~=3'
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_diff_OrderedCollection [
	| diff left right |
	left := ODDummyObject new.
	right := OrderedCollection with: '1' with: '2'.
	diff := left odDiff: right.
	self
		assert: diff greaseString
		equals: 'an ODDummyObject~=[1:''1'' 2:''2'']'
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_diff_String [
	| diff left right |
	left := ODDummyObject new.
	right := 'a'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: 'an ODDummyObject~=''a'''
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_diff_anything_wildcard_disabled [
	| previouslyEnabled |
	previouslyEnabled := ODWildcards enabled.
	ODWildcards disable.
	[ | diff left right |
	left := ODDummyObject new.
	right := '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff incompatible ]
		ensure: [ previouslyEnabled
				ifTrue: [ ODWildcards enable ] ]
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := ODDummyObject new.
	right := '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff identical ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_with_Number_attribute_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := ODDummyObject new.
	left a: 33.
	right := ODDummyObject new.
	right a: '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff identical ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_with_OrderedCollection_attribute_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := ODDummyObject new.
	left a: (OrderedCollection with: 'a' with: 1).
	right := ODDummyObject new.
	right a: '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff identical ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_with_String_attribute_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := ODDummyObject new.
	left a: 'whatever'.
	right := ODDummyObject new.
	right a: '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff identical ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODObjectDiffTest >> test_Object_with_attributes_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := ODDummyObject new.
	left a: 'whatever'.
	left b: 33.
	right := ODDummyObject new.
	right a: '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff identical not ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

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

{ #category : #tests }
ODObjectDiffTest >> test_printOn_Object_with_String_and_Number_attributes_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := ODDummyObject new.
	left a: 'whatever'.
	left b: 3.
	right := ODDummyObject new.
	right a: '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '[#b:3~=]' ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODObjectDiffTest >> test_printOn_Object_with_String_attribute_diff_anything_wildcard_disabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards disable.
	[ | diff left right |
	left := ODDummyObject new.
	left a: 'whatever'.
	right := ODDummyObject new.
	right a: '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '[#a:''whatever''~=''<ANYTHING>'']' ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODObjectDiffTest >> test_printOn_Object_with_String_attribute_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := ODDummyObject new.
	left a: 'whatever'.
	right := ODDummyObject new.
	right a: '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff greaseString equals: '' ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]
