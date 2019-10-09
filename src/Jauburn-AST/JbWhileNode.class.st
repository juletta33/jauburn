Class {
	#name : #JbWhileNode,
	#superclass : #Object,
	#instVars : [
		'condition',
		'trueStatements'
	],
	#category : #'Jauburn-AST-Core'
}

{ #category : #accessing }
JbWhileNode >> condition [
	^ condition
]

{ #category : #accessing }
JbWhileNode >> condition: anObject [
	condition := anObject
]

{ #category : #'as yet unclassified' }
JbWhileNode >> executeIn: environment [

	[self condition evaluateIn: environment] whileTrue:[trueStatements do: [ :each | each executeIn: environment ]]
]

{ #category : #accessing }
JbWhileNode >> trueStatements [
	^ trueStatements
]

{ #category : #accessing }
JbWhileNode >> trueStatements: anObject [
	trueStatements := anObject
]
