Class {
	#name : #ODWildcards,
	#superclass : #Object,
	#classInstVars : [
		'matches',
		'disabled'
	],
	#category : #'Object-Diff'
}

{ #category : #api }
ODWildcards class >> compareWith: anObject [
	| result |
	result := false.
	(disabled isNil or: [ disabled not ])
		ifTrue: [ result := self matches at: anObject ifAbsent: [ false ] ].
		^ result
]

{ #category : #definition }
ODWildcards class >> defaultMatches [
	| result |
	result := Dictionary new.
	result
		at: '<ANYTHING>' put: true.
	^ result
]

{ #category : #api }
ODWildcards class >> disable [
	disabled := true
]

{ #category : #accessing }
ODWildcards class >> disabled [
	^ disabled ifNil: [ false ]
]

{ #category : #api }
ODWildcards class >> enable [
	disabled := false
]

{ #category : #accessing }
ODWildcards class >> enabled [
	^ self disabled not
]

{ #category : #accessing }
ODWildcards class >> matches [
	^ matches ifNil: [ matches := self defaultMatches. matches ]
]
