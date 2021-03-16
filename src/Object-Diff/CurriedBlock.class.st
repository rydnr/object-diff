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
CurriedBlock >> doesNotUnderstand: aMessage [
	"delegate all not implemented methods to the wrapped closure"

	^ (self wrapped respondsTo: aMessage selector)
		ifTrue: [ self wrapped
				perform: aMessage selector
				withEnoughArguments: aMessage arguments ]
		ifFalse: [ super doesNotUnderstand: aMessage ]
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
