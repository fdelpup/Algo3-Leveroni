!classDefinition: #AccountReportTest category: 'ServiciosFinancieros2'!
TestCase subclass: #AccountReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountReportTest methodsFor: 'ReportTransferNet Test' stamp: 'fdp 11/18/2022 14:40:55'!
test07TransferNetOfEmptyAccountIsZero
	| anAccount aTransferNetReport |
	
	anAccount := ReceptiveAccount new.
	aTransferNetReport := TransferNet from: anAccount.
	
	self assert: (aTransferNetReport printReport = ('El neto de transferencias es 0 * pesos')).
	! !

!AccountReportTest methodsFor: 'ReportTransferNet Test' stamp: 'fdp 11/18/2022 14:36:47'!
test08TransferNetReportConveysTheExtractionValueOfTransfer
	| originAccount destinationAccount aTransferNetReport |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer  amount: (10 * peso) from: originAccount  to: destinationAccount .

	aTransferNetReport := TransferNet from: originAccount.
	
	self assert: (aTransferNetReport printReport = ('El neto de transferencias es -10 * pesos')).
	! !

!AccountReportTest methodsFor: 'ReportTransferNet Test' stamp: 'fdp 11/18/2022 14:36:54'!
test09TransferNetReportConveysTheDepositValueOfTransfer
	| originAccount destinationAccount aTransferNetReport |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer  amount: (10 * peso) from: originAccount  to: destinationAccount .

	aTransferNetReport := TransferNet from: destinationAccount.
	
	self assert: (aTransferNetReport printReport = ('El neto de transferencias es 10 * pesos')).
	! !


!AccountReportTest methodsFor: 'ReportSummary Test' stamp: 'fdp 11/18/2022 14:27:39'!
test01SummaryReportHasAnAccountWithEmptyBalance
	| anAccount aSummaryReport expectedReport|
	
	anAccount := ReceptiveAccount new.
	aSummaryReport := Summary from: anAccount.
	
	expectedReport := OrderedCollection new.
	expectedReport add: 'Balance = 0 * pesos'.
	self assert: (aSummaryReport printReport = expectedReport).
	! !

!AccountReportTest methodsFor: 'ReportSummary Test' stamp: 'fdp 11/18/2022 14:30:54'!
test02SummaryReportShowsAccountDeposit
	| anAccount aSummaryReport expectedReport|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: anAccount.
	aSummaryReport := Summary from: anAccount.
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Depósito por 10 * pesos').
	expectedReport add: ('Balance = 10 * pesos').
	
	self assert: (aSummaryReport printReport = expectedReport).
	! !

!AccountReportTest methodsFor: 'ReportSummary Test' stamp: 'fdp 11/18/2022 14:31:10'!
test03SummaryReportShowsAccountWithdraw
	| anAccount aSummaryReport expectedReport|
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 10 * peso on: anAccount.
	aSummaryReport := Summary from: anAccount.
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Extracción por 10 * pesos').
	expectedReport add: ('Balance = -10 * pesos').
	
	self assert: (aSummaryReport printReport = expectedReport).
	! !

!AccountReportTest methodsFor: 'ReportSummary Test' stamp: 'fdp 11/18/2022 14:32:15'!
test04SummaryReportShowsExtractionFromTransfer
	| originAccount destinationAccount aSummaryReport expectedReport |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer  amount: (10 * peso) from: originAccount  to: destinationAccount .
	aSummaryReport := Summary from: originAccount.
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Salida por transferencia de 10 * pesos').
	expectedReport add: ('Balance = -10 * pesos').
	
	self assert: (aSummaryReport printReport = expectedReport).
	! !

!AccountReportTest methodsFor: 'ReportSummary Test' stamp: 'fdp 11/18/2022 14:32:36'!
test05SummaryReportShowsDepositFromTransfer
	| originAccount destinationAccount aSummaryReport expectedReport |
	
	originAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Transfer  amount: (10 * peso) from: originAccount  to: destinationAccount .
	aSummaryReport := Summary from: destinationAccount.
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Entrada por transferencia de 10 * pesos').
	expectedReport add: ('Balance = 10 * pesos').
	
	self assert: (aSummaryReport printReport = expectedReport).
	! !

!AccountReportTest methodsFor: 'ReportSummary Test' stamp: 'fdp 11/18/2022 14:33:35'!
test06SummaryReportShowsAllTheTransactionsFromAnAccount
	| auxAccount accountForReport aSummaryReport expectedReport |
	
	auxAccount := ReceptiveAccount new.
	accountForReport := ReceptiveAccount new.
	Deposit register: 50 * peso on: accountForReport.
	Withdraw register: 50 * peso on: accountForReport.
	Transfer  amount: (50 * peso) from: accountForReport  to: auxAccount .
	Transfer  amount: (50 * peso) from: auxAccount  to: accountForReport .

	aSummaryReport := Summary from: accountForReport.

	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Depósito por 50 * pesos').
	expectedReport add: ('Extracción por 50 * pesos').
	expectedReport add: ('Salida por transferencia de 50 * pesos').
	expectedReport add: ('Entrada por transferencia de 50 * pesos').
	expectedReport add: ('Balance = 0 * pesos').
	
	self assert: (aSummaryReport printReport = expectedReport).
	! !


!AccountReportTest methodsFor: 'ReportPortfolioTreePrinter Test' stamp: 'fdp 11/18/2022 14:37:33'!
test10TreePrinterDisplaysTheEmptyPortfolioName
	|  emptyPortfolio reportTreePrinter expectedReport |
	emptyPortfolio := Portfolio named: 'Portfolio de nadie'. 
	reportTreePrinter := PortfolioTreePrinter from: emptyPortfolio. 
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de nadie').
	
	self assert: (reportTreePrinter printReport = expectedReport).
	
	! !

!AccountReportTest methodsFor: 'ReportPortfolioTreePrinter Test' stamp: 'fdp 11/18/2022 14:38:05'!
test11TreePrinterDisplaysTheAccountOfThePortfolio
	|  pepePortfolio pepeAccount reportTreePrinter expectedReport |
	pepeAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	pepePortfolio := Portfolio named: 'Portfolio de pepe' with: pepeAccount . 
	reportTreePrinter := PortfolioTreePrinter from: pepePortfolio. 
	
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de pepe').
	expectedReport add: ('   Cuenta de pepe').	
	
	self assert: (reportTreePrinter printReport = expectedReport).
	
	! !

!AccountReportTest methodsFor: 'ReportPortfolioTreePrinter Test' stamp: 'fdp 11/18/2022 14:38:17'!
test12TreePrinterDisplaysTheAccountsOfThePortfolio
	|  amigosPortfolio juanAccount pepeAccount reportTreePrinter expectedReport |
	
	pepeAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	juanAccount := ReceptiveAccount named: 'Cuenta de juan'.
	
	amigosPortfolio := Portfolio named: 'Portfolio de amigos' with: pepeAccount with: juanAccount . 
	reportTreePrinter := PortfolioTreePrinter from: amigosPortfolio. 
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de amigos').
	expectedReport add: ('   Cuenta de pepe').	
	expectedReport add: ('   Cuenta de juan').	
	
	self assert: (reportTreePrinter printReport = expectedReport).
	
	! !

!AccountReportTest methodsFor: 'ReportPortfolioTreePrinter Test' stamp: 'fdp 11/18/2022 14:38:52'!
test13TreePrinterDisplaysThePortfolioInsideOfTheMainPortfolio
	|  portfolioDePortfolio pepeAccount reportTreePrinter expectedReport pepePortfolio |
	
	pepeAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	pepePortfolio := Portfolio named: 'Portfolio de pepe' with: pepeAccount. 

	portfolioDePortfolio := Portfolio named: 'Portfolio de portfolio' with: pepePortfolio. 
	reportTreePrinter := PortfolioTreePrinter from: portfolioDePortfolio. 
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de portfolio').
	expectedReport add: ('   Portfolio de pepe').	
	expectedReport add: ('      Cuenta de pepe').	
	
	self assert: (reportTreePrinter printReport = expectedReport).
	
	! !

!AccountReportTest methodsFor: 'ReportPortfolioTreePrinter Test' stamp: 'fdp 11/18/2022 14:39:28'!
test14TreePrinterDisplaysAllThePortfolioAccounts
	|  portfolioDePortfolio pepeAccount reportTreePrinter expectedReport amigosPortfolio juanAccount|
	
	pepeAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	juanAccount := ReceptiveAccount named: 'Cuenta de juan'.

	amigosPortfolio := Portfolio named: 'Portfolio de amigos' with: pepeAccount with: juanAccount. 

	portfolioDePortfolio := Portfolio named: 'Portfolio de portfolio' with: amigosPortfolio with: pepeAccount. 
	reportTreePrinter := PortfolioTreePrinter from: portfolioDePortfolio. 
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de portfolio').
	expectedReport add: ('   Portfolio de amigos').	
	expectedReport add: ('      Cuenta de pepe').	
	expectedReport add: ('      Cuenta de juan').	
	expectedReport add: ('   Cuenta de pepe').	
	
	self assert: (reportTreePrinter printReport = expectedReport).
	
	! !


!AccountReportTest methodsFor: 'ReportPortfolioDetailedTreePrinter Test' stamp: 'fdp 11/18/2022 14:40:47'!
test15DetailedTreeOfEmptyPortfolioHasBalanceOfZero
	|  emptyPortfolio reportTreePrinter expectedReport |
	emptyPortfolio := Portfolio named: 'Portfolio de nadie'. 
	reportTreePrinter := PortfolioDetailedTreePrinter from: emptyPortfolio. 
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de nadie').
	expectedReport add: ('   Balance = 0 * pesos').

	
	self assert: (reportTreePrinter printReport = expectedReport).
	! !

!AccountReportTest methodsFor: 'ReportPortfolioDetailedTreePrinter Test' stamp: 'fdp 11/18/2022 14:41:33'!
test16DetailedTreeWithEmptyAccountHasBalanceOfZero
	|  pepePortfolio pepeAccount reportTreePrinter expectedReport |
	pepeAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	pepePortfolio := Portfolio named: 'Portfolio de pepe' with: pepeAccount . 
	reportTreePrinter := PortfolioDetailedTreePrinter from: pepePortfolio. 
	
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de pepe').
	expectedReport add: ('   Cuenta de pepe').	
	expectedReport add: ('      Balance = 0 * pesos').	
	expectedReport add: ('   Balance = 0 * pesos').	
	
	self assert: (reportTreePrinter printReport = expectedReport).
	! !

!AccountReportTest methodsFor: 'ReportPortfolioDetailedTreePrinter Test' stamp: 'fdp 11/18/2022 14:42:37'!
test17DetailedTreeDisplaysTheCorrectDepositOfPortfolio
	|  pepePortfolio pepeAccount reportTreePrinter expectedReport |
	pepeAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	 Deposit register: 10 * peso on: pepeAccount.
	
	pepePortfolio := Portfolio named: 'Portfolio de pepe' with: pepeAccount . 
	reportTreePrinter := PortfolioDetailedTreePrinter from: pepePortfolio. 
	
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de pepe').
	expectedReport add: ('   Cuenta de pepe').	
	expectedReport add: ('      Depósito por 10 * pesos').	
	expectedReport add: ('      Balance = 10 * pesos').	
	expectedReport add: ('   Balance = 10 * pesos').
	
	self assert: (reportTreePrinter printReport = expectedReport).
	
	
	! !

!AccountReportTest methodsFor: 'ReportPortfolioDetailedTreePrinter Test' stamp: 'fdp 11/18/2022 14:43:03'!
test18DetailedTreeDisplaysTheCorrectWithdrawOfPortfolio
	|  pepePortfolio pepeAccount reportTreePrinter expectedReport |
	pepeAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	 Withdraw register: 10 * peso on: pepeAccount.
	
	pepePortfolio := Portfolio named: 'Portfolio de pepe' with: pepeAccount . 
	reportTreePrinter := PortfolioDetailedTreePrinter from: pepePortfolio. 
	
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de pepe').
	expectedReport add: ('   Cuenta de pepe').	
	expectedReport add: ('      Extracción por 10 * pesos').	
	expectedReport add: ('      Balance = -10 * pesos').	
	expectedReport add: ('   Balance = -10 * pesos').
	
	self assert: (reportTreePrinter printReport = expectedReport).
	
	
	! !

!AccountReportTest methodsFor: 'ReportPortfolioDetailedTreePrinter Test' stamp: 'fdp 11/18/2022 14:43:26'!
test19DetailedTreePrinterDisplaysTheCorrectTransferOfPortfolio
	|  pepeAccount reportTreePrinter expectedReport amigosPortfolio juanAccount|
	
	pepeAccount := ReceptiveAccount named: 'Cuenta de pepe'.
	juanAccount := ReceptiveAccount named: 'Cuenta de juan'
	.
	Transfer amount: (10 * peso) from: pepeAccount to: juanAccount.
	
	amigosPortfolio := Portfolio named: 'Portfolio de amigos' with: pepeAccount with: juanAccount. 
	reportTreePrinter := PortfolioDetailedTreePrinter from: amigosPortfolio. 
	
	expectedReport := OrderedCollection new.
	expectedReport add: ('Portfolio de amigos').
	expectedReport add: ('   Cuenta de pepe').	
	expectedReport add: ('      Salida por transferencia de 10 * pesos').	
	expectedReport add: ('      Balance = -10 * pesos').	
	expectedReport add: ('   Cuenta de juan').	
	expectedReport add: ('      Entrada por transferencia de 10 * pesos').	
	expectedReport add: ('      Balance = 10 * pesos').	
	expectedReport add: ('   Balance = 0 * pesos').	

	
	self assert: (reportTreePrinter printReport = expectedReport).
	
	! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros2'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros2'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

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


!classDefinition: #TransferTest category: 'ServiciosFinancieros2'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'tests' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros2'!
Object subclass: #Account
	instanceVariableNames: 'accountName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'fdp 11/17/2022 19:08:48'!
withName: aName
	accountName := aName.! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!Account methodsFor: 'accessing' stamp: 'fdp 11/17/2022 20:15:41'!
name
	^accountName.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros2'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Portfolio methodsFor: 'initialization' stamp: 'LL 7/1/2021 03:21:03'!
initialize

	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'fdp 11/16/2022 20:14:53'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ ^(0 * peso)]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'LL 7/1/2021 03:21:12'!
add: accountToAdd
	
	accounts add: accountToAdd.
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


!Portfolio methodsFor: 'visitor' stamp: 'fdp 11/17/2022 21:48:47'!
accept: aClass
	^(aClass visitPortfolio: self).! !


!Portfolio methodsFor: 'accessing' stamp: 'fdp 11/17/2022 19:15:52'!
accounts
	^ accounts copy! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros2'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'fdp 11/17/2022 19:07:43'!
named: aName 
	^self new withName: aName.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'fdp 11/17/2022 19:07:25'!
named: aName with: anAccount 
	^(self with: anAccount) withName: aName.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'fdp 11/17/2022 19:06:39'!
named: aName with: aFirstAccount with: aSecondAccount
	^(self with: aFirstAccount with: aSecondAccount) withName: aName.! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros2'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'fdp 11/16/2022 19:14:29'!
initialize
	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'fdp 11/16/2022 20:14:22'!
balance
	| aBalance |
	aBalance := (0 * peso).
	transactions do: [:aTransaction |
		aBalance := aTransaction affectBalance: aBalance.
		].
	^aBalance ! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!ReceptiveAccount methodsFor: 'visitor' stamp: 'fdp 11/17/2022 21:49:19'!
accept: aClass
	^(aClass visitReceptiveAccount: self).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'ServiciosFinancieros2'!
ReceptiveAccount class
	instanceVariableNames: 'accountName'!

!ReceptiveAccount class methodsFor: 'instance creation' stamp: 'fdp 11/17/2022 19:08:16'!
named: aName
	^self new withName: aName.! !


!classDefinition: #AccountReport category: 'ServiciosFinancieros2'!
Object subclass: #AccountReport
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountReport methodsFor: 'accessing' stamp: 'fdp 11/17/2022 18:18:57'!
printReport
	self subclassResponsibility.! !


!AccountReport methodsFor: 'initialization' stamp: 'fdp 11/17/2022 18:18:37'!
initializeWith: anAccount
	account := anAccount.! !


!classDefinition: #PortfolioTreePrinter category: 'ServiciosFinancieros2'!
AccountReport subclass: #PortfolioTreePrinter
	instanceVariableNames: 'tabsString'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioTreePrinter methodsFor: 'visitor' stamp: 'fdp 11/17/2022 21:48:47'!
visitPortfolio: aPortfolio

	| names originalTabString |
	names := OrderedCollection new.
	originalTabString := tabsString.
	names add: (tabsString, aPortfolio name).
	tabsString := tabsString appendToString: '   '.
	aPortfolio accounts do: [:anAccount | names addAllLast: (anAccount accept: self)].
	tabsString := originalTabString.
	^names.
	! !

!PortfolioTreePrinter methodsFor: 'visitor' stamp: 'fdp 11/17/2022 21:49:19'!
visitReceptiveAccount: aReceptiveAccount
	| name |
	name := OrderedCollection new.
	name add: (tabsString, aReceptiveAccount name).
	^name.! !


!PortfolioTreePrinter methodsFor: 'accessing' stamp: 'fdp 11/17/2022 21:47:25'!
printReport
	| aReport |
	aReport := OrderedCollection new.
	tabsString := ''.
	aReport addAllLast: (account accept: self).
	^aReport.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: 'ServiciosFinancieros2'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'fdp 11/17/2022 19:04:03'!
from: aPortfolio 
	^self new initializeWith: aPortfolio.! !


!classDefinition: #PortfolioDetailedTreePrinter category: 'ServiciosFinancieros2'!
PortfolioTreePrinter subclass: #PortfolioDetailedTreePrinter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!PortfolioDetailedTreePrinter methodsFor: 'visitor' stamp: 'fdp 11/17/2022 21:49:19'!
visitReceptiveAccount: aReceptiveAccount
	| name summaryOfAccount |
	name := OrderedCollection new.
	name add: (tabsString, aReceptiveAccount name).
	summaryOfAccount := (Summary from: aReceptiveAccount) printReport.
	name addAllLast: (summaryOfAccount collect: [:aTransaction | tabsString, '   ', aTransaction]).
	^name.! !


!PortfolioDetailedTreePrinter methodsFor: 'accessing' stamp: 'fdp 11/17/2022 21:47:25'!
printReport
	| aReport |
	aReport := OrderedCollection new.
	tabsString := ''.
	aReport addAllLast: (account accept: self).
	aReport add: ('   Balance = ', account balance asString).
	^aReport.
	! !


!classDefinition: #Summary category: 'ServiciosFinancieros2'!
AccountReport subclass: #Summary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Summary methodsFor: 'accessing' stamp: 'fdp 11/17/2022 21:01:22'!
printReport
	| aReport |
	aReport := OrderedCollection new.
	
	account transactions do: [:aTransaction |
		aReport add: aTransaction reportOfTransaction.
		].
	aReport add: ('Balance = ', account balance asString).
	^aReport.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Summary class' category: 'ServiciosFinancieros2'!
Summary class
	instanceVariableNames: ''!

!Summary class methodsFor: 'instance creation' stamp: 'fdp 11/16/2022 19:32:25'!
from: anAccount 
	^self new initializeWith: anAccount.! !


!classDefinition: #TransferNet category: 'ServiciosFinancieros2'!
AccountReport subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferNet methodsFor: 'accessing' stamp: 'fdp 11/16/2022 21:27:14'!
printReport
	| transferNet | 
	transferNet := (account transactions 
		inject: (0 * peso)
		into: [ :currentBalance :transaction  | 
			(transaction isKindOf: TransferLeg) ifTrue: [transaction affectBalance: currentBalance].
		]).
	^('El neto de transferencias es ', transferNet asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'ServiciosFinancieros2'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'instance creation' stamp: 'fdp 11/16/2022 21:17:25'!
from: aReceptiveAccount 
	^self new initializeWith: aReceptiveAccount.! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros2'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros2'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'accessing' stamp: 'fdp 11/16/2022 20:53:26'!
reportOfTransaction
	^('Depósito por ', self value asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros2'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'LL 9/20/2020 22:28:14'!
initializeWith: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros2'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 22:45:01'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeWith: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros2'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'fdp 11/16/2022 20:53:22'!
reportOfTransaction
	^('Entrada por transferencia de ', self value asString).! !

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros2'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'fdp 11/16/2022 20:53:19'!
reportOfTransaction
	^('Salida por transferencia de ', self value asString).! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros2'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'accessing' stamp: 'fdp 11/16/2022 20:53:15'!
reportOfTransaction
	^('Extracción por ', self value asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros2'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Transfer category: 'ServiciosFinancieros2'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros2'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros2'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
