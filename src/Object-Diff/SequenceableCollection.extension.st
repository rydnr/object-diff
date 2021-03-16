Extension { #name : #SequenceableCollection }

{ #category : #'*Object-Diff' }
SequenceableCollection >> doWithIndex: elementAndIndexBlock separatedBy: separatorBlock [
	1 to: self size do: [ :index | 
		index = 1
			ifFalse: [ separatorBlock value ].
		elementAndIndexBlock value: (self at: index) value: index ]

]
