!classDefinition: #StackTest category: 'StackPrimeraParte'!
TestCase subclass: #StackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!StackTest methodsFor: 'test' stamp: 'FDP 10/11/2022 19:56:10'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := Stack initializeStack .
	
	self assert: stack isEmpty! !

!StackTest methodsFor: 'test' stamp: 'FDP 10/11/2022 20:31:45'!
test02CanAddElementToStack
	
	| stack anElement |
	
	stack := Stack initializeStack .
	anElement  := 'Juan'.
	stack push: anElement.
	self assert: (stack isEmpty not) .

	
	! !

!StackTest methodsFor: 'test' stamp: 'FDP 10/11/2022 20:37:01'!
test03CanRemoveAnElementFromStack
	
	| stack anElement |
	
	stack := Stack initializeStack .
	anElement := 'Juan'.
	stack push: anElement.

	self assert: (anElement = (stack pop)).! !

!StackTest methodsFor: 'test' stamp: 'FDP 10/11/2022 20:15:46'!
test04RemovedElementIsTheLastAddedInStack
	
	| stack anElement_1 anElement_2 |
	
	stack := Stack initializeStack .
	anElement_1 := 'Juan'.
	anElement_2 := 'Pedro'.
	stack push: anElement_1.
	stack push: anElement_2.
	
	self assert: (anElement_2 = (stack pop)).! !

!StackTest methodsFor: 'test' stamp: 'FDP 10/11/2022 20:38:52'!
test05GetLastElementWithoutRemovingItFromStack
	
	| stack anElement_1 anElement_2 |
	
	stack := Stack initializeStack .
	anElement_1 := 'Juan'.
	anElement_2 := 'Pedro'.
	stack push: anElement_1.
	stack push: anElement_2.
	
	self assert: (anElement_2 = (stack top)).! !

!StackTest methodsFor: 'test' stamp: 'FDP 10/11/2022 20:45:33'!
test06CantRemoveElementFromEmptyStack
	
	| stack |
	
	stack := Stack initializeStack .
	
	self
	should:  [stack pop]
	raise: Error 
	withExceptionDo: [:anError | self assert: Stack cantPopEmptyStack = anError messageText .]
! !

!StackTest methodsFor: 'test' stamp: 'FDP 10/11/2022 20:45:58'!
test07CantGetLastElementFromEmptyStack
	
	| stack |
	
	stack := Stack initializeStack .
	
	self
	should:  [stack top]
	raise: Error 
	withExceptionDo: [:anError | self assert: Stack cantTopEmptyStack = anError messageText .]! !


!classDefinition: #Stack category: 'StackPrimeraParte'!
Object subclass: #Stack
	instanceVariableNames: 'pila'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'StackPrimeraParte'!

!Stack methodsFor: 'accessing' stamp: 'FDP 10/11/2022 19:59:52'!
isEmpty
	^pila isEmpty .! !

!Stack methodsFor: 'accessing' stamp: 'FDP 10/11/2022 20:35:51'!
pop
	(pila isEmpty ) ifTrue: [^self error: Stack cantPopEmptyStack].
	^pila removeLast.
! !

!Stack methodsFor: 'accessing' stamp: 'FDP 10/11/2022 20:31:05'!
push: anElement
	^pila addLast: anElement.
	! !

!Stack methodsFor: 'accessing' stamp: 'FDP 10/11/2022 20:37:43'!
top
	(pila isEmpty) ifTrue: [^self error: Stack cantTopEmptyStack].
	^pila at: (pila size).! !


!Stack methodsFor: 'initialization' stamp: 'FDP 10/11/2022 19:59:23'!
createStack
	pila := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Stack class' category: 'StackPrimeraParte'!
Stack class
	instanceVariableNames: ''!

!Stack class methodsFor: 'error descriptions' stamp: 'FDP 10/11/2022 20:36:36'!
cantPopEmptyStack
	^'No se puede sacar un elemento de un Stack vacio'! !

!Stack class methodsFor: 'error descriptions' stamp: 'FDP 10/11/2022 20:38:28'!
cantTopEmptyStack
	^'No se puede ver el ultimo elemento de un Stack vacio'! !


!Stack class methodsFor: 'initialization' stamp: 'FDP 10/11/2022 19:57:07'!
initializeStack
	^Stack new createStack.! !
