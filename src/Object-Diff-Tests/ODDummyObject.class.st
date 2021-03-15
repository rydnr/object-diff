Class {
	#name : #ODDummyObject,
	#superclass : #Object,
	#instVars : [
		'a',
		'b'
	],
	#category : #'Object-Diff-Tests'
}

{ #category : #accessing }
ODDummyObject >> a [
	^ a
]

{ #category : #accessing }
ODDummyObject >> a: anObject [
	a := anObject
]

{ #category : #accessing }
ODDummyObject >> b [
	^ b
]

{ #category : #accessing }
ODDummyObject >> b: anObject [
	b := anObject
]
