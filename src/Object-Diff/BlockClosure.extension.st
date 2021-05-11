Extension { #name : #BlockClosure }

{ #category : #'*Object-Diff' }
BlockClosure >> curry: aValue [
	^ CurriedBlock for: self with: aValue
]

{ #category : #'*Object-Diff' }
BlockClosure >> odIdenticalTo: anObject [
	^ anObject odIdenticalToBlockClosure: self
]

{ #category : #'*Object-Diff' }
BlockClosure >> odIdenticalToBlockClosure: anObject [
	^ anObject asText = self asText
]
