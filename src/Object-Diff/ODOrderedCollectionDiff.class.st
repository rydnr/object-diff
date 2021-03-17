Class {
	#name : #ODOrderedCollectionDiff,
	#superclass : #ODAbstractDiff,
	#category : #'Object-Diff'
}

{ #category : #accessing }
ODOrderedCollectionDiff >> gtViewDiffsOn: aView [

	<gtView>
	
	(self diffs isEmpty) ifTrue: [^ aView empty].
	^ aView columnedTree
		title: 'Differences' translated;
		items: [self diffs];
		column: 'Left' item: [:each | 
			each left];
		column: 'Right' item: [:each |
			each right]
]
