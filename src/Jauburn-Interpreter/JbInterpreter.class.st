"
I am an interpreter for programs written in the Jauburn language.  My principle API methods are:

	interpret: anAST -- given an abstract syntax tree, interpret it
	run: aString -- parse and interpret the supplied string
"
Class {
	#name : #JbInterpreter,
	#superclass : #Object,
	#instVars : [
		'environment',
		'transcript',
		'uimanager'
	],
	#category : #'Jauburn-Interpreter-Core'
}

{ #category : #'as yet unclassified' }
JbInterpreter >> absBinding [

  ^#abs -> [ :f | f abs ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> concatBinding [

      ^ #concat -> [ :v :s | v,s ]
]

{ #category : #accessing }
JbInterpreter >> environment [ 

	^environment
]

{ #category : #accessing }
JbInterpreter >> environment: anObject [
	environment := anObject
]

{ #category : #initialization }
JbInterpreter >> initialize [ 

	super initialize.
	environment := JbEnvironment new.
		(self class selectors select: [ :each | each endsWith: 'Binding' ])
		do: [ :s | 
				| binding |
				binding := self perform: s.
				environment at: binding key put: (JbPrimitive new block: binding value) ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> inputBinding [
      ^ #input -> [ :v | self uimanager textEntry: v ]
]

{ #category : #api }
JbInterpreter >> interpret: ast [

	^ast executeIn: environment 
]

{ #category : #'as yet unclassified' }
JbInterpreter >> lengthBinding [

   ^#length -> [ :l | l size]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> modBinding [

  ^#mod -> [ :a :b | a \\ b ]
]

{ #category : #'as yet unclassified' }
JbInterpreter >> notBinding [
	^ #not -> [ :a | a not ]
]

{ #category : #printing }
JbInterpreter >> printBinding [
^#print -> [ :value| Transcript show: value printString]

]

{ #category : #primitives }
JbInterpreter >> printlnBinding [

|result|
  ^ #println -> [ :v | 
	result := v asString.
	v isSymbol ifTrue: [ result := result allButFirst].  
	v isString ifTrue: [result := '"',result,'"'].
	v isArray ifTrue: [ result := result allButFirst].
	result := result,'\n'.
	self transcript show: result 
	 ]
]

{ #category : #api }
JbInterpreter >> run: programString [

	| parser |
	parser := JbParser new.
	self interpret: (parser parse: programString)
]

{ #category : #accessing }
JbInterpreter >> transcript [ 
   ^transcript ifNil: [ ^Transcript  ]
]

{ #category : #accessing }
JbInterpreter >> transcript: anObject [
	transcript := anObject
]

{ #category : #accessing }
JbInterpreter >> uimanager [
	^ uimanager
]

{ #category : #accessing }
JbInterpreter >> uimanager: anObject [
	uimanager := anObject
]
