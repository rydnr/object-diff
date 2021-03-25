Class {
	#name : #ODArrayDiffTest,
	#superclass : #TestCase,
	#category : #'Object-Diff-Tests'
}

{ #category : #tests }
ODArrayDiffTest >> test_Array_diff_Dictionary [
	| diff left right |
	left := Array with: 'c'.
	right := Dictionary new.
	right at: 'firstKey' put: 'a'.
	right at: 'secondKey' put: 'b'.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff matches isEmpty.
	self assert: diff incompatible.
	self
		assert: diff greaseString
		equals: '[1:''c'']~=[''firstKey''->''a'' ''secondKey''->''b'']'
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_diff_Number [
	| diff left right |
	left := #('a').
	right := 1.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff left equals: left.
	self assert: diff right equals: right.
	self assert: diff greaseString equals: '[1:''a'']~=1'
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_diff_Object [
	| diff left right |
	left := #('a').
	right := ODDummyObject new.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff left equals: left.
	self assert: diff right equals: right.
	self assert: diff greaseString equals: '[1:''a'']~=an ODDummyObject'
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_diff_OrderedCollection [
	| diff left right |
	left := Array with: '1' with: '2'.
	right := OrderedCollection with: '3' with: '4'.
	diff := left odDiff: right.
	self
		assert: diff greaseString
		equals: '[1:''1''~=''3'' 2:''2''~=''4'']'
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_diff_String [
	| diff left right |
	left := #('a').
	right := '1'.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff left equals: left.
	self assert: diff right equals: right.
	self assert: diff greaseString equals: '[1:''a'']~=''1'''
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_diff_anything_wildcard_disabled [
	| previouslyEnabled |
	previouslyEnabled := ODWildcards enabled.
	ODWildcards disable.
	[ | diff left right |
	left := #('a').
	right := '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff incompatible ]
		ensure: [ previouslyEnabled
				ifTrue: [ ODWildcards enable ] ]
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_diff_anything_wildcard_enabled [
	| previouslyDisabled |
	previouslyDisabled := ODWildcards disabled.
	ODWildcards enable.
	[ | diff left right |
	left := #('a').
	right := '<ANYTHING>'.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff identical ]
		ensure: [ previouslyDisabled
				ifTrue: [ ODWildcards disable ] ]
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_diff_nil [
	| diff left |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	left atWrap: 2 put: 'b'.
	diff := left odDiff: nil.
	self assert: diff isNotNil.
	self assert: diff matches isEmpty
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_with_Dictionary_diff_Array_with_String [
	| diff left right |
	left := Array with: (Dictionary with: 'd' -> 'D' with: 'e' -> 'E').
	right := #('x').
	diff := left odDiff: right.
	"[1:['d'->'D' 'e'->'E']]"
	"[1:'x']"
	self
		assert: diff greaseString
		equals: '[1:[''d''->''D'' ''e''->''E'']~=''x'']'
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_with_Dictionary_diff_Array_with_String_2 [
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
	diff := left odDiff: right.
	"[1:'a' 2:[1:'1' 2:['d'->'D' 'e'->'E']]]"
	"[1:'a' 2:[1:'x' 2:'2']]"
	self
		assert: diff greaseString
		equals: '[2:[1:''1''~=''x'' 2:[''d''->''D'' ''e''->''E'']~=''2'']]'
]

{ #category : #tests }
ODArrayDiffTest >> test_Array_with_nested_Dictionary_diff_Array_with_nested_Array [
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
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 1.
	self assert: (diff matches at: 1) equals: 'a'.
	self assert: diff diffs isNotEmpty.
	self assert: diff diffs size equals: 1.
	self assert: (diff diffs at: 2) equals: (nestedLeft odDiff: nestedRight).
	self assert: (diff diffs at: 2) left equals: nestedLeft.
	self assert: (diff diffs at: 2) right equals: nestedRight
]

{ #category : #tests }
ODArrayDiffTest >> test_diff_partially_matching_Arrays [
	| diff left right |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	left atWrap: 2 put: 'b'.
	right := Array new: 2.
	right atWrap: 1 put: 'a'.
	right atWrap: 2 put: 'c'.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 1.
	self assert: (diff matches at: 1) equals: 'a'.
	self assert: diff diffs isNotEmpty.
	self assert: diff diffs size equals: 1.
	self assert: (diff diffs at: 2) equals: ('b' odDiff: 'c')
]

{ #category : #tests }
ODArrayDiffTest >> test_diff_with_nested_Arrays [
	| diff left right nestedLeft nestedRight |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	nestedLeft := #('1' '2').
	left atWrap: 2 put: nestedLeft.
	right := Array new: 2.
	right atWrap: 1 put: 'a'.
	nestedRight := #('x' '2').
	right atWrap: 2 put: nestedRight.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 1.
	self assert: (diff matches at: 1) equals: 'a'.
	self assert: diff diffs isNotEmpty.
	self assert: diff diffs size equals: 1.
	self assert: (diff diffs at: 2) equals: (nestedLeft odDiff: nestedRight)
]

{ #category : #tests }
ODArrayDiffTest >> test_identical_Arrays [
	| diff left right |
	left := Array new: 2.
	left atWrap: 1 put: 'a'.
	left atWrap: 2 put: 'b'.
	right := Array new: 2.
	right atWrap: 1 put: 'a'.
	right atWrap: 2 put: 'b'.
	diff := left odDiff: right.
	self assert: diff isNotNil.
	self assert: diff matches isNotEmpty.
	self assert: diff matches size equals: 2.
	self assert: (diff matches at: 1) equals: 'a'.
	self assert: (diff matches at: 2) equals: 'b'.
	self assert: diff diffs isEmpty.
	self assert: diff identical
]

{ #category : #tests }
ODArrayDiffTest >> test_printOn_different_Arrays [
	| diff left right |
	left := #('a').
	right := #('b').
	diff := left odDiff: right.
	self assert: diff greaseString equals: '[1:''a''~=''b'']'
]

{ #category : #tests }
ODArrayDiffTest >> test_printOn_identical_Arrays [
	| diff value |
	value := #('a' 'b').
	diff := value odDiff: value.
	self assert: diff isNotNil.
	self assert: diff greaseString equals: ''
]
