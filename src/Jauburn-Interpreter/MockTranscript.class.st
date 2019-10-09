Class {
	#name : #MockTranscript,
	#superclass : #Object,
	#instVars : [
		'content'
	],
	#category : #'Jauburn-Interpreter'
}

{ #category : #accessing }
MockTranscript >> content [
	^ content
]

{ #category : #accessing }
MockTranscript >> content: anObject [
	content := anObject
]

{ #category : #streaming }
MockTranscript >> show: aString [ 

  self content: aString 
]
