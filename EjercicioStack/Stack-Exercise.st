!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:02'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:57'!
test02PushAddElementsToTheStack

	| stack |
	stack := OOStack new.
	
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:50'!
test03PopRemovesElementsFromTheStack

	| stack |
	stack := OOStack new.
	stack push: 'something'.
	
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:43'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack pop! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:56:59'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'first'.
	secondPushedObject := 'second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: secondPushedObject equals: stack pop.
	self assert: firstPushedObject equals: stack pop.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 18:00:26'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: pushedObject equals: stack top.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:27'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: 1 equals: stack size.
	stack top.
	self assert: 1 equals: stack size.
	! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:44'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:58:56'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'JMB 10/8/2022 17:59:07'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: OOStack stackEmptyErrorDescription equals: anError messageText ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FDP 10/13/2022 22:48:16'!
test01FindsWordWithGivenPrefix
	| Pila Coleccion |
	
	Pila := OOStack new.
	Pila push: 'Hola como va'.
	Pila push: 'Chau hasta luego'.
	
	Coleccion := OrderedCollection new.
	Coleccion add: 'Hola como va'.
	
	Finder := SentenceFinderByPrefix with: Pila.

	self assert: ( Coleccion = (Finder find: 'Hola')).
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FDP 10/13/2022 22:47:38'!
test02FinderIsCaseSensitive
	| Pila Coleccion |
	
	Pila := OOStack new.
	Pila push: 'hola como va'.
	Pila push: 'chau hasta luego'.
	
	Coleccion := OrderedCollection new.
	
	Finder := SentenceFinderByPrefix with: Pila.

	self assert: ( Coleccion = (Finder find: 'Hola')).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FDP 10/13/2022 22:56:59'!
test03StackStaysTheSame
	| Pila |
	
	Pila := OOStack new.
	Pila push: 'Hola como va'.
	Pila push: 'Chau hasta luego'.
	
	Finder := SentenceFinderByPrefix with: Pila.
	Finder find: 'Hola'.
	
	self assert: ( Pila pop = 'Chau hasta luego').
	self assert: ( Pila pop = 'Hola como va').
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FDP 10/13/2022 23:15:20'!
test04FinderOmitsEmptySpaces
	
	| Pila Coleccion_1 Coleccion_2 |
	
	Pila := OOStack new.
	Pila push: 1.
	Pila push: 'Hola como va'.

	
	Coleccion_1 := OrderedCollection new.
	Coleccion_1 add: 'Hola como va'.
	
	Finder := SentenceFinderByPrefix with: Pila.

	self assert: ( Coleccion_1 = (Finder find: 'Hola')).
	
	Coleccion_2 := OrderedCollection new.
	
	Coleccion_2 add: nil.
	
	self deny: (Coleccion_2 = (Finder find: nil)).
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FDP 10/13/2022 23:22:39'!
test05FinderOnlyWorksIfTheWordIsAtTheBeginning
	| Pila Coleccion |
	
	Pila := OOStack new.
	Pila push: 'Juan hola como va'.
	Pila push: 'Pepe dijo hola'.
	Pila push: 'chau hasta luego'.
	Pila push: 'hola es una palabra'.
	
	Coleccion := OrderedCollection new.
	Coleccion add: 'hola es una palabra'.
	
	Finder := SentenceFinderByPrefix with: Pila.

	self assert: ( Coleccion = (Finder find: 'hola')).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FDP 10/13/2022 23:27:51'!
test06FindsManyWordsWithGivenPrefix
	| Pila Coleccion | 
	
	Pila := OOStack new.
	Pila push: 'Hola como va'.
	Pila push: 'Hola Juan'.
	Pila push: 'Hola que tal'.
	Pila push: 'Chau hasta luego'.
	
	Coleccion := OrderedCollection new.
	Coleccion add: 'Hola que tal'.
	Coleccion add: 'Hola Juan'.
	Coleccion add: 'Hola como va'.
	
	Finder := SentenceFinderByPrefix with: Pila.

	self assert: ( Coleccion = (Finder find: 'Hola')).
	! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'FDP 10/13/2022 23:30:45'!
test07SamePrefixWorksWithDifferentWords
	| Pila Coleccion | 
	
	Pila := OOStack new.
	Pila push: 'Horrible Cuis'.
	Pila push: 'Hola como va'.
	Pila push: 'Hoho feliz navidad'.
	Pila push: 'Chau hasta luego'.
	
	Coleccion := OrderedCollection new.
	Coleccion add: 'Hoho feliz navidad'.
	Coleccion add: 'Hola como va'.
	Coleccion add: 'Horrible Cuis'.
	
	Finder := SentenceFinderByPrefix with: Pila.

	self assert: ( Coleccion = (Finder find: 'Ho')).
	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'tamanio tope'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'accessing' stamp: 'b 10/14/2022 15:24:05'!
isEmpty
	^tope isBase.! !

!OOStack methodsFor: 'accessing' stamp: 'b 10/14/2022 15:40:07'!
pop
	| dato |
	dato := tope dato.
	tope := tope anterior.
	tamanio := tamanio - 1.
	^dato! !

!OOStack methodsFor: 'accessing' stamp: 'b 10/14/2022 15:25:33'!
push: anElement
	| nuevo_tope |
	nuevo_tope := OOStackElement with: anElement.
	nuevo_tope anterior: tope.
	tope := nuevo_tope.
	tamanio := tamanio + 1.
	! !

!OOStack methodsFor: 'accessing' stamp: 'b 10/14/2022 15:25:14'!
size
	^tamanio.! !

!OOStack methodsFor: 'accessing' stamp: 'b 10/14/2022 15:38:34'!
top
	^tope dato.! !


!OOStack methodsFor: 'initialize' stamp: 'b 10/14/2022 15:35:35'!
initializeStack
	tope := OOStackBase crearBase.
	tamanio := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!OOStack class methodsFor: 'initialization' stamp: 'FDP 10/12/2022 19:21:46'!
new
	^ self basicNew initialize initializeStack.! !


!classDefinition: #OOStackTope category: 'Stack-Exercise'!
OOStack subclass: #OOStackTope
	instanceVariableNames: 'dato anterior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTope methodsFor: 'accessing private' stamp: 'b 10/14/2022 15:28:06'!
anterior
	^anterior.! !

!OOStackTope methodsFor: 'accessing private' stamp: 'b 10/14/2022 15:28:17'!
anterior: aTop
	anterior := aTop.! !

!OOStackTope methodsFor: 'accessing private' stamp: 'b 10/14/2022 15:38:59'!
dato
	^self subclassResponsibility.! !


!classDefinition: #OOStackBase category: 'Stack-Exercise'!
OOStackTope subclass: #OOStackBase
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackBase methodsFor: 'accessing private' stamp: 'b 10/14/2022 15:39:37'!
dato
	^OOStack error: OOStack stackEmptyErrorDescription.! !

!OOStackBase methodsFor: 'accessing private' stamp: 'b 10/14/2022 15:28:47'!
isBase
	^true.! !


!OOStackBase methodsFor: 'initialize' stamp: 'b 10/14/2022 15:28:40'!
initializeBase
	dato := nil.
	anterior := nil.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackBase class' category: 'Stack-Exercise'!
OOStackBase class
	instanceVariableNames: ''!

!OOStackBase class methodsFor: 'initialization' stamp: 'b 10/14/2022 15:30:34'!
crearBase
	^self basicNew initialize initializeBase.
	! !


!classDefinition: #OOStackElement category: 'Stack-Exercise'!
OOStackTope subclass: #OOStackElement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackElement methodsFor: 'initialize' stamp: 'b 10/14/2022 15:29:20'!
createElement: anElement
	dato := anElement.
	anterior := tope.
	! !


!OOStackElement methodsFor: 'accessing private' stamp: 'b 10/14/2022 15:40:37'!
dato
	^dato.! !

!OOStackElement methodsFor: 'accessing private' stamp: 'b 10/14/2022 15:29:28'!
isBase
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackElement class' category: 'Stack-Exercise'!
OOStackElement class
	instanceVariableNames: ''!

!OOStackElement class methodsFor: 'initialization' stamp: 'b 10/14/2022 15:30:46'!
with: anElement
	^self basicNew initialize createElement: anElement .! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'finder' stamp: 'FDP 10/13/2022 23:10:24'!
find: aPrefix
	| AuxStack CollectionOfWords |
	AuxStack := OOStack new.
	CollectionOfWords := OrderedCollection new.
	
	[ stack isEmpty ] whileFalse: [ | aString | aString := (stack pop).
		
		( aPrefix isString and: (aString isString) ) ifTrue: [
			(aString beginsWith: aPrefix) ifTrue: [CollectionOfWords add: aString].
		].
		AuxStack push: aString
	].
	
	[AuxStack isEmpty] whileFalse: [
		stack push: (AuxStack pop)
	].
	
	^CollectionOfWords.

	! !


!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'FDP 10/13/2022 20:00:43'!
initializeWith: aStack
	stack := aStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'initialization' stamp: 'FDP 10/13/2022 19:59:55'!
with: aStack
	^self new initializeWith: aStack ! !
