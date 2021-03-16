Class {
	#name : #ODReversedDiff,
	#superclass : #Object,
	#traits : 'ODTPrintOn',
	#classTraits : 'ODTPrintOn classTrait',
	#instVars : [
		'wrapped'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
ODReversedDiff class >> for: aDiff [
	| result |
	result := self new.
	result wrapped: aDiff.
	^ result
]

{ #category : #meta }
ODReversedDiff class >> reversed [
	^ true
]

{ #category : #'reflective operations' }
ODReversedDiff >> doesNotUnderstand: aMessage [
	"delegate all not implemented methods to the wrapped diff"

	^ (self wrapped respondsTo: aMessage selector)
		ifTrue: [ self wrapped
				perform: aMessage selector
				withEnoughArguments: aMessage arguments ]
		ifFalse: [ super doesNotUnderstand: aMessage ]
]

{ #category : #accessing }
ODReversedDiff >> left [
	^ self wrapped right
]

{ #category : #'class membership' }
ODReversedDiff >> respondsTo: aName [
	^ self wrapped respondsTo: aName
]

{ #category : #accessing }
ODReversedDiff >> right [
	^ self wrapped left
]

{ #category : #private }
ODReversedDiff >> wrapped [
	^ wrapped
]

{ #category : #private }
ODReversedDiff >> wrapped: anObject [
	wrapped := anObject
]
