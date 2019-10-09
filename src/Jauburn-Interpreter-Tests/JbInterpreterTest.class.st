Class {
	#name : #JbInterpreterTest,
	#superclass : #TestCase,
	#instVars : [
		'interpreter',
		'parser'
	],
	#category : #'Jauburn-Interpreter-Tests'
}

{ #category : #utilities }
JbInterpreterTest >> interpret: aString [

	| ast |
	ast :=  parser parse: aString.
	^interpreter interpret: ast.
	
]

{ #category : #running }
JbInterpreterTest >> setUp [ 

	parser := JbParser new.
	interpreter := JbInterpreter new
]

{ #category : #tests }
JbInterpreterTest >> testAbs [ 
    interpreter run: 'var x = abs(-3);'.
    self assert: (interpreter environment at: 'x') equals: 3.
]

{ #category : #tests }
JbInterpreterTest >> testConcat [ 

   interpreter run: 'var x = concat("hello", "Professor");'.
   self assert: (interpreter environment at: 'x') equals: 'helloProfessor'.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationBindsVariableToExpressionValue [

	self interpret: 'var x = 3 + 2 * 8;'.
	self assert: (interpreter environment at: 'x') equals: 19.
	
	self interpret: 'var x = 6;var y = 2*x;'.
	self assert: (interpreter environment at: 'y') equals: 12.
	
self interpret: 'var x = 6;var y = 2-x;'.
	self assert: (interpreter environment at: 'y') equals: -4.
	
self interpret: 'var x = 6;var y = x/2;'.
	self assert: (interpreter environment at: 'y') equals: 3.
]

{ #category : #running }
JbInterpreterTest >> testDeclarationCreatesVariable [

	self interpret: 'var x = 99;'.
	self assert: (interpreter environment includesKey: 'x')
]

{ #category : #tests }
JbInterpreterTest >> testInput [ 
  |mui|
mui := MockUIManager new.
interpreter uimanager: mui.
interpreter run: 'var x = input("this is a test");'.
self assert: (interpreter environment at: 'x') equals: 'foo bar'.
]

{ #category : #tests }
JbInterpreterTest >> testJbArity1OperatorNode [
	
	
	self interpret: 'var x = 3; var y = -x;'.
	self assert: (interpreter environment at: 'y') equals: -3.
]

{ #category : #tests }
JbInterpreterTest >> testJbArity2Operator [
 self interpret: 'var a=1; var b=1; if (a==b) { var x = 1; } else { var x = 2;}'.
	self assert: (interpreter environment at: 'x')equals: 1.
	
 self interpret: 'a=2; b=3; if (a != b) { var x = 3; } else { var x = 4;}'.
	self assert: (interpreter environment at: 'x')equals: 3.
		
 self interpret: 'a=2; b=3; if (a < b) { var x = 5; } else { var x = 6;}'.
	self assert: (interpreter environment at: 'x')equals: 5.
	
 self interpret: 'a=2; b=3; if (a > b) { var x = 6; } else { var x = 7;}'.
	self assert: (interpreter environment at: 'x')equals: 7.
]

{ #category : #tests }
JbInterpreterTest >> testLength [

   interpreter run: 'var x = length("hello");'.
   self assert: (interpreter environment at: 'x') equals: 5.
]

{ #category : #tests }
JbInterpreterTest >> testMod [
   interpreter run: 'var x = mod(10,2);'.
   self assert: (interpreter environment at: 'x') equals: 0.
]

{ #category : #tests }
JbInterpreterTest >> testNot [ 

   interpreter run: 'var x = not(true);'.
   self assert: (interpreter environment at: 'x') equals: false.
]

{ #category : #tests }
JbInterpreterTest >> testPrintlnBinding [
|mt|
mt := MockTranscript new.
interpreter transcript: mt.
interpreter run: 'var x = println ("hello");'.

  self assert: mt content equals: '"hello"\n'.
]

{ #category : #tests }
JbInterpreterTest >> testWhile [ 

   interpreter run: 'var x = 1; var y = 0; while(x <= 10) {y = y + x; x = x + 1;}'.
   self assert: (interpreter environment at: 'y') equals: 55.
]
