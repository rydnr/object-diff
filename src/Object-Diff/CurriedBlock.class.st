Class {
	#name : #CurriedBlock,
	#superclass : #BlockClosure,
	#type : #variable,
	#instVars : [
		'wrapped',
		'curriedValue'
	],
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
CurriedBlock class >> for: aBlockClosure with: aValue [
	| result |
	result := self new.
	result wrapped: aBlockClosure; curriedValue: aValue.
	^ result
]

{ #category : #accessing }
CurriedBlock >> curriedValue [
	^ curriedValue
]

{ #category : #private }
CurriedBlock >> curriedValue: anObject [
	curriedValue := anObject
]

{ #category : #'class membership' }
CurriedBlock >> doesNotUnderstand: aSelector [
	^ self wrapped doesNotUnderstand: aSelector
]

{ #category : #'class membership' }
CurriedBlock >> respondsTo: aMessage [
	^ self wrapped respondsTo: aMessage
]

{ #category : #private }
CurriedBlock >> value: anObject [
	^ self wrapped value: anObject value: self curriedValue
]

{ #category : #accessing }
CurriedBlock >> wrapped [
	^ wrapped
]

{ #category : #private }
CurriedBlock >> wrapped: anObject [
	wrapped := anObject
]
