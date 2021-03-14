Extension { #name : #TAssertable }

{ #category : #'*Object-Diff' }
TAssertable >> assert: actual equals: expected [
	| diff |
	diff := expected diff: actual.
	^ self
		assert: actual = expected
		description: [ self comparingStringBetween: actual and: expected ]
]
