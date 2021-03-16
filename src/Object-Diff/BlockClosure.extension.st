Extension { #name : #BlockClosure }

{ #category : #'*Object-Diff' }
BlockClosure >> curry: aValue [
	^ CurriedBlock for: self with: aValue
]
