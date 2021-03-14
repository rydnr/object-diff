Class {
	#name : #OrderedCollectionDiff,
	#superclass : #CollectionDiff,
	#category : #'Object-Diff'
}

{ #category : #'instance creation' }
OrderedCollectionDiff class >> left: left right: right [
	| result |
	result := self new.
	result left: left; right: right.
	^ result
]
