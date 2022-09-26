!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'FDP 9/24/2022 19:03:04'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds
	|customerBook|
	customerBook := CustomerBook new.
	self assert: (self addOrRemoveCustomer: [customerBook addCustomerNamed: 'John Lennon'] inMaxTime: 50).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FDP 9/24/2022 19:03:01'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds
	|customerBook|
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: 'Paul McCartney'.
	self assert: (self addOrRemoveCustomer: [customerBook removeCustomerNamed: 'Paul McCartney'] inMaxTime: 100).

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HernanWilkinson 5/9/2012 18:12'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.

	[ customerBook addCustomerNamed: ''.
	self fail ]
		on: Error 
		do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]! !

!CustomerBookTest methodsFor: 'testing' stamp: 'HAW 8/28/2017 08:57:25'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	[ customerBook removeCustomerNamed: 'Paul McCartney'.
	self fail ]
		on: NotFound 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon) ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FDP 9/24/2022 19:27:37'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addSuspendedCustomerNamed: paulMcCartney in: customerBook.
	
	self correctNumberOfCustomersIn: customerBook withActiveCustomers: 0 AndSuspendedCustomers: 1.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FDP 9/24/2022 19:28:15'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	self addSuspendedCustomerNamed: paulMcCartney in: customerBook.
	
	customerBook removeCustomerNamed: paulMcCartney.
	
	self correctNumberOfCustomersIn: customerBook withActiveCustomers: 0 AndSuspendedCustomers: 0.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).



	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FDP 9/26/2022 18:59:28'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self cantSuspendCustomerNamed: 'Ringo Starr' in: customerBook withRemainingCustomer: johnLennon.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'FDP 9/26/2022 18:59:58'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	self addSuspendedCustomerNamed: johnLennon in: customerBook.

	self cantSuspendCustomerNamed: johnLennon in: customerBook withRemainingCustomer: johnLennon.
! !


!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'FDP 9/24/2022 18:55:29'!
addOrRemoveCustomer: aClosure inMaxTime: aNumber
	| millisecondsBeforeRunning millisecondsAfterRunning |

	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aClosure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	^(millisecondsAfterRunning-millisecondsBeforeRunning) < (aNumber * millisecond)
	! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'FDP 9/24/2022 19:27:14'!
addSuspendedCustomerNamed: aCustomer in: customerBook 
	customerBook addCustomerNamed: aCustomer.
	customerBook suspendCustomerNamed: aCustomer.! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'FDP 9/26/2022 18:58:30'!
cantSuspendCustomerNamed: aName in: customerBook withRemainingCustomer: aCustomer
	[ customerBook suspendCustomerNamed: aName .
	self fail ]
		on: CantSuspend 
		do: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: aCustomer) ]! !

!CustomerBookTest methodsFor: 'as yet unclassified' stamp: 'FDP 9/24/2022 19:21:37'!
correctNumberOfCustomersIn: aCustomerBook withActiveCustomers: numberOfActiveCustomers AndSuspendedCustomers: numberOfSuspendedCustomers
	
	self assert: numberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: numberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: numberOfActiveCustomers + numberOfSuspendedCustomers equals: aCustomerBook numberOfCustomers.
	! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'FDP 9/26/2022 19:08:44'!
removeCustomerNamed: aName 
 

	(self removeCustomer: aName From: active) ifTrue: [^aName].
 	(self removeCustomer: aName From: suspended ) ifTrue: [^aName].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !


!CustomerBook methodsFor: 'as yet unclassified' stamp: 'FDP 9/26/2022 19:08:07'!
removeCustomer: aName From: aList 

	1 to: aList size do: 	
	[ :index |
		aName = (aList at: index)
			ifTrue: [
				aList removeAt: index.
				^ true.
			] 
	].
	^false.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:18'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/30/2020 09:05:25'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
