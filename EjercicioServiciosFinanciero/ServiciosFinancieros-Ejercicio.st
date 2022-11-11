!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 20:03:45'!
test01EmptyPortfolioBalanceIsCero
	| portfolio |
	portfolio := Portfolio new.
	self assert: (portfolio balance = (0  * peso))! !

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 19:58:35'!
test02PortfolioHasBalanceAfterAccountHasBeenAdded
	| portfolio account |
	account := ReceptiveAccount new.
	account deposit: (100 * peso).
	portfolio := Portfolio new.
	portfolio add: account.
	self assert: (portfolio balance = (100  * peso)).! !

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 19:59:10'!
test03PortfolioReuturnsTotalBalanceOfAccounts
	| portfolio accountWithPositiveBalance accountWithNegativeBalance |
	
	accountWithPositiveBalance := ReceptiveAccount new.
	accountWithNegativeBalance := ReceptiveAccount new.
	
	accountWithPositiveBalance deposit: (400 * peso).
	accountWithNegativeBalance withdraw: (100 * peso).
	
	portfolio := Portfolio new.
	portfolio add: accountWithPositiveBalance.
	portfolio add: accountWithNegativeBalance.
	self assert: (portfolio balance = (300  * peso)).! !

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 19:59:53'!
test04AnEmptyPortfolioHasNoTransactionsRegistered
	| portfolio account |
	
	account := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self deny: (portfolio transactionsWereRegistered).! !

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 20:04:15'!
test05PortfolioHasTransactionsRegistered
	| portfolio account |
	
	account := ReceptiveAccount new.
	account deposit: (1000 * peso).
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self assert: (portfolio transactionsWereRegistered).! !

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 20:07:56'!
test06PortfolioHasEmptyTransactionsWithInactiveAccount
	| portfolio account emptyTransactions|
	
	account := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	emptyTransactions := OrderedCollection new.
	
	self assert: ((portfolio transactionsOf: account) = emptyTransactions).! !

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 20:09:15'!
test07PortfolioWithAPortfolioReturnsTheCorrectBalance
	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	account deposit: (100 * peso).
	
	portfolio2 add: account.
	portfolio1 add: portfolio2.
	
	self assert: ((portfolio1 balance) = (100 * peso)).! !

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 20:02:08'!
test08PortfolioWithAnEmptyPortfolioHasNoTransactionsRegistrered
	| portfolio1 portfolio2 |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	portfolio1 add: portfolio2.
	
	self deny: (portfolio1 transactionsWereRegistered).! !

!PortfolioTest methodsFor: 'test' stamp: 'fdp 11/10/2022 20:09:48'!
test09PortfolioWithAPortfolioHasTransactionsRRegistered
	| portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.
	account deposit: (100 * peso).
	
	portfolio1 add: account.
	portfolio1 add: portfolio2.
	
	self assert: (portfolio1 transactionsWereRegistered).! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransactionTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransactionTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransactionTest methodsFor: 'tests' stamp: 'fdp 11/10/2022 20:12:44'!
test01TransactionExtractsFromOneAccountAndDepositsInAnotherOne
	| extractionAccount depositAccount  |
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	Transfer anAmount: (100 * peso)  from: extractionAccount to: depositAccount.
	
	self assert: (extractionAccount balance = (-100 * peso)).
	self assert: (depositAccount balance = (100 * peso))	.! !

!TransactionTest methodsFor: 'tests' stamp: 'fdp 11/10/2022 20:12:24'!
test02TransactionAmountOfCeroCannotBeTransfer
	| extractionAccount depositAccount  |
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	self should: [	Transfer anAmount: (0 * peso)  from: extractionAccount to: depositAccount.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = ReceptiveAccount invalidTransferAmount].	
! !

!TransactionTest methodsFor: 'tests' stamp: 'fdp 11/10/2022 20:12:35'!
test03ANegativeTransactionAmountCannotBeTransfer
	| extractionAccount depositAccount  |
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	self should: [	Transfer anAmount: (-100 * peso)  from: extractionAccount to: depositAccount.]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = ReceptiveAccount invalidTransferAmount].	
		
	self assert: (extractionAccount balance = (0 * peso)).
	self assert: (depositAccount balance = (0 * peso))	
		
! !

!TransactionTest methodsFor: 'tests' stamp: 'fdp 11/10/2022 20:13:20'!
test04TransferHasItsValue
	| extractionAccount depositAccount  transfer |
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	transfer := Transfer anAmount: (100 * peso)  from: extractionAccount to: depositAccount.
	
	self assert: (transfer value = (100 * peso)).
	
	
	! !

!TransactionTest methodsFor: 'tests' stamp: 'fdp 11/10/2022 20:13:38'!
test05TransferKnowsTheExtractionAccount
	| extractionAccount depositAccount  transfer |
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	transfer := Transfer anAmount: (100 * peso)  from: extractionAccount to: depositAccount.
	
	self assert: (transfer extractionComponent == (extractionAccount)).
	
	
	! !

!TransactionTest methodsFor: 'tests' stamp: 'fdp 11/10/2022 20:14:03'!
test06TransferKnowsTheDepositAccount
	| extractionAccount depositAccount  transfer |
	extractionAccount := ReceptiveAccount new.
	depositAccount := ReceptiveAccount new.
	
	transfer := Transfer anAmount: (100 * peso)  from: extractionAccount to: depositAccount.
	
	self assert: (transfer depositComponent == (depositAccount )).
	
	
	! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'fdp 11/8/2022 20:43:07'!
value 
	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'fdp 11/4/2022 19:31:59'!
newBalanceValue: anOldBalance
	^anOldBalance + value.! !

!Deposit methodsFor: 'value' stamp: 'fdp 11/8/2022 20:42:00'!
value
	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'fdp 11/4/2022 19:30:19'!
newBalanceValue: anOldBalance
	^anOldBalance - value.! !

!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'accessing' stamp: 'fdp 11/10/2022 18:48:07'!
add: anAccount
	accounts add: anAccount.
	! !

!Portfolio methodsFor: 'accessing' stamp: 'fdp 11/10/2022 19:01:18'!
balance
	| aBalance |
	aBalance := 0.
	accounts do: [:account | 
		aBalance := aBalance + (account balance).
		].
	^aBalance. ! !

!Portfolio methodsFor: 'accessing' stamp: 'fdp 11/10/2022 19:24:17'!
transactionsOf: anAccount 
	^anAccount transactions.! !

!Portfolio methodsFor: 'accessing' stamp: 'fdp 11/10/2022 19:45:21'!
transactionsWereRegistered
	(accounts select: [:account | account transactionsWereRegistered.]) ifEmpty: [^false.].
	^true.! !


!Portfolio methodsFor: 'initialization' stamp: 'fdp 11/8/2022 20:35:43'!
initialize
	accounts := OrderedCollection new.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Ejercicio'!
Portfolio class
	instanceVariableNames: 'account'!


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fdp 11/4/2022 19:32:14'!
balance
	| aBalance |
	aBalance := 0.
	transactions do: [:aTransaction |
		aBalance := aTransaction newBalanceValue: aBalance.
		].
	^aBalance. ! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fdp 11/8/2022 20:24:35'!
deposit: aDepositAmount 
	Deposit register: aDepositAmount on: self.! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fdp 11/10/2022 19:03:20'!
register: aTransaction
	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fdp 11/10/2022 19:02:29'!
transactions 
	^ transactions copy! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fdp 11/10/2022 19:48:23'!
transfer: anAmount to: anAccount
	(anAmount <= 0) ifTrue: [self error: self class invalidTransferAmount].
	
	self withdraw: anAmount.
	anAccount deposit: anAmount.

	! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fdp 11/10/2022 19:48:38'!
withdraw: anAmount
	Withdraw register: anAmount on: self.
! !


!ReceptiveAccount methodsFor: 'private' stamp: 'fdp 11/10/2022 19:50:42'!
transactionsWereRegistered
	^(transactions isEmpty not).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'error' stamp: 'fdp 11/4/2022 20:17:50'!
invalidTransferAmount
	'The amount inputed is not valid for a transfer'.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'extractionAccount depositAccount transferValue'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'initialization' stamp: 'fdp 11/8/2022 21:31:24'!
initializeWith: anAmount from: anExtractionAccount to: aDepositAccount 
	transferValue := anAmount.
	extractionAccount := anExtractionAccount.
	depositAccount := aDepositAccount.
	anExtractionAccount transfer: anAmount to: aDepositAccount .! !


!Transfer methodsFor: 'accessing' stamp: 'fdp 11/8/2022 21:43:28'!
depositComponent
	^depositAccount 
	
	! !

!Transfer methodsFor: 'accessing' stamp: 'fdp 11/8/2022 21:41:40'!
extractionComponent
	^extractionAccount 
	! !

!Transfer methodsFor: 'accessing' stamp: 'fdp 11/8/2022 21:36:36'!
value
	^transferValue .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'fdp 11/8/2022 21:36:10'!
anAmount: anAmount from: anExtractionAccount to: aDepositAccount
	^(Transfer new initializeWith: anAmount from: anExtractionAccount to: aDepositAccount).
! !
