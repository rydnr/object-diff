Class {
	#name : #ODOrderedCollectionDiff,
	#superclass : #ODCollectionDiff,
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
ODOrderedCollectionDiff class >> left: left right: right [
	| result |
	result := self new.
	result left: left; right: right.
	^ result
]
