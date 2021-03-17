Class {
	#name : #ODWildcards,
	#superclass : #Object,
	#classInstVars : [
		'Matches'
	],
	#category : #'Object-Diff'
}

{ #category : #accessing }
ODWildcards class >> compareWith: anObject [
	^ self matches at: anObject ifAbsent: [ false ]
]

{ #category : #definition }
ODWildcards class >> defaultMatches [
	| result |
	result := Dictionary new.
	result
		at: '<ANYTHING>' put: true.
	^ result
]

{ #category : #accessing }
ODWildcards class >> matches [
	^ Matches ifNil: [ Matches := self defaultMatches. Matches ]
]
