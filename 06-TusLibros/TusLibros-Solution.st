!classDefinition: #TusLibrosTest category: #'TusLibros-Solution'!
TestCase subclass: #TusLibrosTest
	instanceVariableNames: 'book emptyCatalogue catalogueWithOneBook emptyCart cartWithABook cartWithTwoBooks catalogueWithTwoBook cashierDate expiredDate nonExpiredDate dictionaryWithABookWithBigAmount cartWithBigAmount presentDate pastDate futureDate nonExpiredCreditCard expiredCreditCard merchantProcessorPaying0 merchantProcessorDebit10OK merchantProcessorDebit20OK merchantProcessorForExpiredCard merchantProcessorForStolenCard merchantProcessorForInsufficientBalance sellBook sellsBook merchantProcessorForAmountExceeded merchantProcessorDebitDecimalOK dictionaryWithABookWithDecimalAmount cartWithDecimalAmount market marketWithMPOK timeNow presentDateTime fileDate creditCard creditCardFile cartOldDate presentDateMidnight cartFile'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 18:58:37'!
setUp
	
	|dictionaryWithABook|

	presentDate := Date today.
	pastDate := Date year: presentDate yearNumber - 1 month: presentDate monthIndex day: presentDate dayOfMonth.
	futureDate := Date year: presentDate yearNumber + 1 month: presentDate monthIndex day: presentDate dayOfMonth.
	timeNow := Time now.
	presentDateTime := GregorianDateTime date: presentDate timeOfDay: timeNow.
	fileDate := GregorianDateTime date: (Date year: 2017 month: 5 day: 1) timeOfDay: timeNow.
 	cartOldDate := GregorianDateTime date: presentDate timeOfDay: (Time hour: 11 minute: 29 second: 00).
 	presentDateMidnight := GregorianDateTime date: presentDate timeOfDay: Time midnight.
	
	creditCardFile := CreditCard withNumber: 1234 andOwner: 'owner' andExpirationDate: (Date year: 2017 month: 10 day: 1).
	nonExpiredCreditCard := CreditCard withNumber: 1234 andOwner: 'owner' andExpirationDate: futureDate.
	expiredCreditCard := CreditCard withNumber: 1234 andOwner: 'owner' andExpirationDate: pastDate.

	merchantProcessorPaying0 := MerchantProcessorMock with: [:amount | '1|CanNotPay0'].
	merchantProcessorDebit10OK := MerchantProcessorMock with: [:amount | (amount = 10.00) ifTrue: ['0|OK'] ifFalse: [self error: 'amount should has been 10.00']].
	merchantProcessorDebit20OK := MerchantProcessorMock with: [:amount | (amount = 20.00) ifTrue: ['0|OK'] ifFalse: [self error: 'amount should has been 20.00']].
	merchantProcessorDebitDecimalOK := MerchantProcessorMock with: [:amount | (amount = (10.123 roundTo: 0.01)) ifTrue: ['0|OK'] ifFalse: [self error: 'amount should has been 10.12']].
	merchantProcessorForExpiredCard := MerchantProcessorMock with: [:amount | '1|Expired card'].
	merchantProcessorForStolenCard := MerchantProcessorMock with: [:amount | '1|Stolen card'].
	merchantProcessorForInsufficientBalance := MerchantProcessorMock with: [:amount | '1|Insufficient balance'].
	merchantProcessorForAmountExceeded := MerchantProcessorMock with: [:amount | '1|Amount exceeded'].
		
	sellsBook := Dictionary new.
	
	book := '1234'.
	dictionaryWithABook := Dictionary new.
	dictionaryWithABook at: book hash put: 10.
	catalogueWithOneBook := dictionaryWithABook.
	emptyCart := Cart with: catalogueWithOneBook and: presentDateTime and: 1.
	cartWithABook := Cart with: catalogueWithOneBook and: presentDateTime and: 1. 
	cartWithABook add: book times: 1.
	cartFile := Cart with: catalogueWithOneBook and: fileDate and: 1. 
	cartFile add: book times: 1.
	
	dictionaryWithABookWithBigAmount := Dictionary new.
	dictionaryWithABookWithBigAmount at: book hash put: 1234567890123456.
	cartWithBigAmount := Cart with: dictionaryWithABookWithBigAmount and: presentDateTime and: 1.
	cartWithBigAmount add: book times: 1.

	dictionaryWithABookWithDecimalAmount := Dictionary new.
	dictionaryWithABookWithDecimalAmount at: book hash put: 10.123.
	cartWithDecimalAmount := Cart with: dictionaryWithABookWithDecimalAmount and: presentDateTime and: 1.
	cartWithDecimalAmount add: book times: 1.
	
	cartWithTwoBooks := Cart with: catalogueWithOneBook and: presentDateTime and: 1. 
	cartWithTwoBooks add: book times: 2.

	cashierDate := Date year: 2017 month: 5 day: 1.
	expiredDate := Date year: (cashierDate yearNumber - 1) month: (cashierDate month monthIndex) day: cashierDate dayOfMonth.
	nonExpiredDate := Date year: (cashierDate yearNumber + 1) month: (cashierDate month monthIndex) day: cashierDate dayOfMonth.
	
	catalogueWithOneBook :=  Dictionary new.
	catalogueWithOneBook at: book hash put: 10.
	emptyCart := Cart with: catalogueWithOneBook and: presentDateTime and: 1.
	
	cartWithABook := Cart with: catalogueWithOneBook and: presentDateTime and: 1. 
	cartWithABook add: book times: 1.
	cartWithTwoBooks := Cart with: catalogueWithOneBook and: presentDateTime and: 1. 
	cartWithTwoBooks add: book times: 2.
	
	market := Market with: catalogueWithOneBook and: merchantProcessorDebit10OK.
	marketWithMPOK := Market with: catalogueWithOneBook and: merchantProcessorDebit10OK.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'EF 6/22/2017 15:24:06'!
test01NewCartsAreEmpty

	self assert: emptyCart isEmpty.
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'EF 6/15/2017 20:12:35'!
test02AfterAddingAProductToCartItIsNotEmpty

	self deny: cartWithABook isEmpty.
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:40:32'!
test03TheCartHasWhatWePutInIt

	|cart book catalogue|
	
	book := Object new.
	catalogue := Dictionary new.
	catalogue at: book hash put: 10.
	cart := Cart with: catalogue and: presentDateTime and: 1.
	cart add: book times: 1.
	self assert: (cart includes: book).
	self assert: cart quantity = 1.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:40:47'!
test04AddMoreThanOneEqualBooks

	|cart|
	cart := Cart with: catalogueWithOneBook and: presentDateTime and: 1.
	cart add: book times: 2.
	self assert: (cart includes: book).
	self assert: cart quantity = 2! !

!TusLibrosTest methodsFor: 'testing' stamp: 'EF 6/15/2017 20:19:08'!
test05CantAddANegativeQuantityOfBooks

	self should: [emptyCart add: book times: -1]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText = emptyCart class mustBeAPositiveIntegerQuantityOfBooksErrorMessage.
									self assert: emptyCart quantity = 0]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'EF 6/15/2017 20:21:02'!
test06CantAddZeroBooks

	self should: [emptyCart add: book times: 0]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText = emptyCart class mustBeAPositiveIntegerQuantityOfBooksErrorMessage.
									self assert: emptyCart quantity = 0]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'EF 6/15/2017 20:21:23'!
test07CantAddANonIntegerQuantity

	self should: [emptyCart add: book times: 1/2]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText = emptyCart class mustBeAPositiveIntegerQuantityOfBooksErrorMessage.
									self assert: emptyCart quantity = 0]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'EF 6/15/2017 20:22:24'!
test08CantAddABookThatIsNotFromEditorial
	
	|newBook|
	
	newBook := Object new.
	self should: [emptyCart add: newBook times: 1]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText = emptyCart class canNotAddABooThatIsNotFromEditorial.
									self assert: emptyCart quantity = 0]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:41:40'!
test09CheckoutAnEmptyCartThroughCashier
	
	| cashier |
	
	cashier := Cashier with: sellsBook and: merchantProcessorPaying0.
		
	self should: [cashier checkoutCart: emptyCart with: nonExpiredCreditCard on: presentDateTime]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText = cashier class canNotCheckoutAnEmptyCart.
									  self assert: emptyCart isEmpty.
									  self assert: sellsBook isEmpty.]	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 18:48:53'!
test10CheckoutACartWithOneBookThroughCashier
	
	|cashier sell|
	
	cashier := Cashier with: sellsBook and: merchantProcessorDebit10OK.
	sell := Sell withACart: cartWithABook andDate: presentDateTime andCreditCard: nonExpiredCreditCard.
	
	self assert: (cashier checkoutCart: cartWithABook with: nonExpiredCreditCard on: presentDateTime) equals: '0|OK'.
	self assert: sellsBook size = 1.
	self assert: (sellsBook at: 1) anyOne = sell.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 18:49:28'!
test11CheckoutACartWithMoreThanOneBook
	
	|cashier sell|
	
	cashier := Cashier with: sellsBook and: merchantProcessorDebit20OK.
	sell := Sell withACart: cartWithTwoBooks andDate: presentDateTime andCreditCard: nonExpiredCreditCard.
	
	self assert: (cashier checkoutCart: cartWithTwoBooks with: nonExpiredCreditCard on: presentDateTime) equals: '0|OK'.
	self assert: sellsBook size = 1.
	self assert: (sellsBook at: 1) anyOne = sell
! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 14:32:20'!
test12MustFailWhenUsingAnExpiredCreditCard

	| cashier |

	cashier := Cashier with: sellsBook and: merchantProcessorForExpiredCard.
	
	self should: [cashier checkoutCart: cartWithABook with: expiredCreditCard on: presentDateTime]
	raise: Error 
	withExceptionDo: [ :anError | self assert: anError messageText = cashier class canNotCheckoutExpiredCard.
									  self assert: cartWithABook quantity = 1]! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 14:44:21'!
test13MustFailWhenUsingAnStolenCreditCard

	| cashier |

	cashier := Cashier with: sellsBook and: merchantProcessorForStolenCard.

	self assert: ((cashier checkoutCart: cartWithABook with: nonExpiredCreditCard on: presentDateTime) = '1|Stolen card').
	self assert: (sellsBook isEmpty).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 14:44:31'!
test14MustFailWhenUsingACreditCardWithInsuficientBalance

	| cashier |

	cashier := Cashier with: sellsBook and: merchantProcessorForInsufficientBalance.

	self assert: ((cashier checkoutCart: cartWithABook with: nonExpiredCreditCard on: presentDateTime ) = '1|Insufficient balance').
	self assert: (sellsBook isEmpty).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 14:44:43'!
test15MustNotDoCheckoutWithAmountExceeded

	| cashier |

	cashier := Cashier with: sellsBook and: merchantProcessorForAmountExceeded .
	
	self assert: (cashier checkoutCart: cartWithABook with: nonExpiredCreditCard on: presentDateTime) = '1|Amount exceeded'.
	self assert: (sellsBook isEmpty).! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 18:49:40'!
test16MustDoCheckoutWithAnAmountWithTwoDecimal

	| cashier sell |

	cashier := Cashier with: sellsBook and: merchantProcessorDebitDecimalOK .
	sell := Sell withACart: cartWithDecimalAmount andDate: presentDateTime andCreditCard: nonExpiredCreditCard.
	
	self assert: (cashier checkoutCart: cartWithDecimalAmount with: nonExpiredCreditCard on: presentDateTime) = '0|OK'.
	self assert: sellsBook size = 1.
 	self assert: (sellsBook at: 1) anyOne = sell.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:44:11'!
test17MustSaveInterfaceInputCheckoutFileIfMerchanProcessorIsOutOfLine

	|cashier sellsBook file|

	sellsBook := Set new.
	cashier := Cashier with: sellsBook and: (MerchantProcessorMock with: [:amount|'1|Is not posible to establish conection']).

	file := 'TUSLIBROS_INPUT_2017_5_1.csv' asFileEntry.

	self assert: ((cashier checkoutCart: cartFile with: creditCardFile on: fileDate) = '1|Is not posible to establish conection').
	self assert: file exists.
	self assert: file textContents = ('2,1234,102017,owner', Character cr asString).
	file delete.
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:28:59'!
test18MustFailCreateCartThroughInterfaceWithANonExistingUser

	
	|interface users|
	
	users := Dictionary new.
	interface := TusLibrosInterface withUsers: users andMarket: market.
	
	self assert: (interface createCart: 'idUser' and: 'password' andDate: presentDateTime) = '1|User does not exist'.
	self assert: users keys isEmpty! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:29:23'!
test19MustFailCreateCartThroughInterfaceWithExistingUserButWrongPass

	
	|interface users|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	interface := TusLibrosInterface  withUsers: users andMarket: market.
	
	self assert: (interface createCart: 'idUser1' and: 'password1' andDate: presentDateTime) = '1|Wrong password'.
	self assert: (users at: 'idUser1') = 'password'.
	self assert: users keys size = 1.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:29:34'!
test20CanCreateCartThroughInterfaceWithExistingUserAndCorrectPass

	
	|interface users|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	interface := TusLibrosInterface  withUsers: users andMarket: market.
	
	self assert: (interface createCart: 'idUser1' and: 'password' andDate: presentDateTime ) = '0|1'.
	self assert: (users at: 'idUser1') = 'password'.
	self assert: users keys size = 1.
	self assert: (interface listCart: 1) = '0'.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:29:51'!
test21CreatingMoreThanOneCartMustHaveDifferentIds
	
	|interface users|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	users at: 'idUser2' put: 'password'.

	interface := TusLibrosInterface  withUsers: users andMarket: market.
	
	self assert: (interface createCart: 'idUser1' and: 'password' andDate: presentDateTime) = '0|1'.
	self assert: (interface createCart: 'idUser2' and: 'password' andDate: presentDateTime) = '0|2'.
	
	self assert: (users at: 'idUser1') = 'password'.
	self assert: users keys size = 2.
	self assert: (interface listCart: 1) = '0'.
	self assert: (interface listCart: 2) = '0'.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'EF 6/25/2017 23:39:25'!
test22CantAddABookToANonExistingCart
	
	|interface users|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	
	interface := TusLibrosInterface  withUsers: users andMarket: market.

	self assert: (interface addToCart: 2 bookISBN: book quantity: 1) = '1|Cart does not exist'.
	self assert: (interface listCart: 2) = '1|Cart does not exist'.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:29:59'!
test23CanAddABookToAnExistingCart
	
	|interface users|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	
	interface := TusLibrosInterface  withUsers: users andMarket: market.
	
	self assert: (interface createCart: 'idUser1' and: 'password' andDate: presentDateTime) = '0|1'.
	self assert: (interface addToCart: 1 bookISBN: book quantity: 1) = '0|Ok'.
	self assert: (interface listCart: 1) = '0|1234|1'.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:30:05'!
test24CantAddANonNaturalQuantityOfBooks
	
	|interface users|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	
	interface := TusLibrosInterface  withUsers: users andMarket: market.
	
	self assert: (interface createCart: 'idUser1' and: 'password' andDate: presentDateTime) = '0|1'.
	self assert: (interface addToCart: 1 bookISBN: book quantity: 0) = '1|Must be a positive integer quantity of books'.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:30:37'!
test25CheckoutANonExistingCartMustFail
	
	|interface users myCartId|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	
	interface := TusLibrosInterface  withUsers: users andMarket: market.
	
	myCartId := 1.

	self assert: (interface checkoutCart: 1 ccn: 1234 cced: 052017 cco: 'owner' date: presentDateTime) = '1|Cart does not exist'.
	
	! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:30:53'!
test26CheckoutAnExistingCartMustBeHandledByTheCashier
	
	|interface users myCartId|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	
	interface := TusLibrosInterface  withUsers: users andMarket: market.
	
	myCartId := 1.

	self assert: (interface checkoutCart: myCartId ccn: 1234 cced: 052017 cco: 'owner' date: presentDateTime) = '1|Cart does not exist'.
	
	interface createCart: 'idUser1' and: 'password' andDate: presentDateTime.
	
	self assert: (interface checkoutCart: myCartId ccn: 1234 cced: 052017 cco: 'owner' date: presentDateTime) = ('1|', Cashier canNotCheckoutAnEmptyCart).
! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 15:42:13'!
test27CheckoutAnExistingCartWithAnExpiredCreditCard
	
	|interface users myCartId|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	
	interface := TusLibrosInterface withUsers: users andMarket: market.
	
	interface createCart: 'idUser1' and: 'password' andDate: presentDateTime .
	myCartId := 1.
	interface addToCart: 1 bookISBN: book quantity: 1.
	
	self assert: (interface checkoutCart: myCartId ccn: expiredCreditCard number cced: expiredCreditCard expiration cco: expiredCreditCard owner date: presentDateTime) = ('1|Can not checkout with an expired card').! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 18:42:18'!
test28CheckoutAnExistingCartWithACreditCard
	
	| interface users myCartId |
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	
	interface := TusLibrosInterface withUsers: users andMarket: marketWithMPOK.
	
	interface createCart: 'idUser1' and: 'password' andDate: presentDateTime.
	myCartId := 1.
	interface addToCart: 1 bookISBN: book quantity: 1.
	
	self assert: (interface checkoutCart: myCartId ccn: nonExpiredCreditCard number cced: nonExpiredCreditCard expiration cco: nonExpiredCreditCard owner date: presentDateTime) = ('0|OK').
	self assert: (interface listPurchases: 'idUser1' and: 'password') = '0|1234|1|10'.! !

!TusLibrosTest methodsFor: 'testing' stamp: 'ek 6/27/2017 16:17:28'!
test29CanNotCheckoutAnExistingCartAfter30Minutes
	
	|interface users myCartId|
	
	users := Dictionary new.
	users at: 'idUser1' put: 'password'.
	
	interface := TusLibrosInterface withUsers: users andMarket: market.
	
	interface createCart: 'idUser1' and: 'password' andDate: cartOldDate .
	myCartId := 1.
	interface addToCart: 1 bookISBN: book quantity: 1.
	
	self assert: (interface checkoutCart: myCartId ccn: nonExpiredCreditCard number cced: nonExpiredCreditCard expiration cco: nonExpiredCreditCard owner date: presentDateMidnight) = ('1|Can not checkout a cart after 30 minutes').
! !


!classDefinition: #Cart category: #'TusLibros-Solution'!
Object subclass: #Cart
	instanceVariableNames: 'books catalogue creationDate userId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cart methodsFor: 'accessing' stamp: 'EF 6/15/2017 19:55:47'!
books
	
	^books! !

!Cart methodsFor: 'accessing' stamp: 'EF 6/15/2017 19:55:18'!
catalogue

	^catalogue! !

!Cart methodsFor: 'accessing' stamp: 'ek 6/27/2017 15:46:53'!
creationDate

	^creationDate! !

!Cart methodsFor: 'accessing' stamp: 'EF 6/13/2017 20:01:56'!
includes: aBook

	^books includes: aBook.! !

!Cart methodsFor: 'accessing' stamp: 'EF 6/13/2017 19:55:30'!
isEmpty

	^ books size = 0! !

!Cart methodsFor: 'accessing' stamp: 'EF 6/13/2017 20:03:11'!
quantity

	^books size.! !

!Cart methodsFor: 'accessing' stamp: 'ek 6/24/2017 17:18:41'!
totalAmount
	
	|amount|
	amount := 0.
	books do: [ :aBook | amount := amount + catalogue at: aBook hash. ].
	(amount isKindOf: Integer) ifTrue: [^ amount].
	^amount! !

!Cart methodsFor: 'accessing' stamp: 'ek 6/27/2017 16:34:48'!
userId

	^userId! !


!Cart methodsFor: 'adding' stamp: 'EF 6/15/2017 20:11:42'!
add: aBook times: aQuantity
	(catalogue includesKey: aBook hash) ifFalse: [self error:
										    self class canNotAddABooThatIsNotFromEditorial].
	(aQuantity > 0 & aQuantity isKindOf: Integer) ifTrue: [books add: aBook withOccurrences: aQuantity]
	ifFalse: [self error: self class mustBeAPositiveIntegerQuantityOfBooksErrorMessage]! !


!Cart methodsFor: 'initialization' stamp: 'ek 6/27/2017 16:34:00'!
initializeWith: aCatalogue and: aDateTime and: anUserId

	catalogue := aCatalogue.
	books := Bag new.
	creationDate := aDateTime.
	userId := anUserId.! !


!Cart methodsFor: 'comparing' stamp: 'ek 6/24/2017 14:21:44'!
= aCart

	^ catalogue = aCart catalogue & books = aCart books.! !

!Cart methodsFor: 'comparing' stamp: 'ek 6/27/2017 16:14:09'!
isExpired: aDateTime

	(creationDate date < aDateTime date) ifTrue: [ ^((Time midnight- aDateTime timeOfDay) + creationDate time) totalMinutes > 30].
	
	(creationDate date = aDateTime date) ifTrue: [ ^ ((creationDate timeOfDay - aDateTime timeOfDay) totalMinutes > 30)].
	
	^true! !


!Cart methodsFor: 'printing' stamp: 'EF 6/25/2017 23:35:41'!
printString

	| myBooks |
	myBooks := ''.
	books do: [:book | myBooks := myBooks , '|' ,book , '|' ,(books occurrencesOf: book) printString].
	^myBooks! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'TusLibros-Solution'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'EF 6/15/2017 18:43:30'!
canNotAddABooThatIsNotFromEditorial

	^ 'Can not add a book that is not from editorial'! !

!Cart class methodsFor: 'error messages' stamp: 'EF 6/13/2017 21:02:06'!
mustBeAPositiveIntegerQuantityOfBooksErrorMessage

	^ 'Must be a positive integer quantity of books'! !


!Cart class methodsFor: 'initialization' stamp: 'ek 6/27/2017 16:33:12'!
with: aCatalogue and: aDateTime and: anUserId

	^self new initializeWith: aCatalogue and: aDateTime and: anUserId.! !


!classDefinition: #Cashier category: #'TusLibros-Solution'!
Object subclass: #Cashier
	instanceVariableNames: 'sellsBook merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Cashier methodsFor: 'consulting' stamp: 'ek 6/27/2017 13:51:07'!
isExpiredCreditCard: aCardDate and: cashierDate
	
	(aCardDate yearNumber < cashierDate date yearNumber) ifTrue: [^ true].
	((aCardDate yearNumber = cashierDate date yearNumber) and: [aCardDate monthIndex < cashierDate date monthIndex]) ifTrue: [^true]. 
	 ^false.! !

!Cashier methodsFor: 'consulting' stamp: 'ek 6/27/2017 14:09:19'!
with: aSellsBook and: aMerchantProcessor
	
	sellsBook := aSellsBook.
	merchantProcessor := aMerchantProcessor.! !


!Cashier methodsFor: 'operations' stamp: 'ek 6/27/2017 18:59:02'!
checkoutCart: aCart with: aCreditCard on: cashierDate
	
	| result sell amountRounded |	
	
	(aCart isExpired: cashierDate) ifTrue: [self error: 'Can not checkout a cart after 30 minutes']. 
	
	aCart isEmpty ifTrue: [self error: self class canNotCheckoutAnEmptyCart].
	
	(self isExpiredCreditCard: aCreditCard expiration and: cashierDate) ifTrue: [self error: self class canNotCheckoutExpiredCard].

	(aCart totalAmount >= 100000000000000) ifTrue: [self error: self class canNotCheckoutWithABigAmount].

	amountRounded := ((aCart totalAmount asFloat) roundTo: 0.01).
	result := merchantProcessor debitUsing: aCreditCard number expiration: aCreditCard expiration owner: aCreditCard owner amount: amountRounded.

	sell := Sell withACart: aCart andDate: cashierDate andCreditCard: aCreditCard.

	(result = '0|OK') ifTrue: [(sellsBook at: (aCart userId) ifPresent: [:sells | sells add: sell] ifAbsent: [sellsBook at: (aCart userId) put: (Set with: sell)])].

	(result = '1|Is not posible to establish conection') ifTrue: [ self saveFile: cashierDate and: aCreditCard].
	
	^result! !

!Cashier methodsFor: 'operations' stamp: 'ek 6/27/2017 18:56:15'!
saveFile: cashierDate and: aCreditCard
	
	('TUSLIBROS_INPUT_', cashierDate date yearNumber printString, '_', cashierDate date month monthIndex printString, '_', cashierDate date dayOfMonth printString, '.csv') asFileEntry appendContents: 	('2,', aCreditCard number printString, ',', aCreditCard expiration monthIndex printString, aCreditCard expiration yearNumber printString ,',', aCreditCard owner , (Character cr asString)).
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #'TusLibros-Solution'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'EF 6/15/2017 19:18:21'!
canNotCheckoutAnEmptyCart

	^'Can not checkout an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'EF 6/22/2017 14:40:18'!
canNotCheckoutExpiredCard

	^'Can not checkout with an expired card'! !

!Cashier class methodsFor: 'error messages' stamp: 'ek 6/24/2017 16:27:40'!
canNotCheckoutWithABigAmount

	^'Can not checkout with a big amount'
! !

!Cashier class methodsFor: 'error messages' stamp: 'ek 6/24/2017 12:08:49'!
with: ABookSale and: AMerchantProcessor

	^self new with: ABookSale and: AMerchantProcessor.! !


!classDefinition: #CreditCard category: #'TusLibros-Solution'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiration owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!CreditCard methodsFor: 'initialization' stamp: 'ek 6/24/2017 22:33:52'!
initializeWith: aNumber and: aName and: aDate

	number := aNumber.
	owner := aName.
	expiration := aDate.
! !


!CreditCard methodsFor: 'accessing' stamp: 'ek 6/24/2017 13:35:22'!
expiration

	^ expiration! !

!CreditCard methodsFor: 'accessing' stamp: 'ek 6/24/2017 13:35:13'!
number

	^ number! !

!CreditCard methodsFor: 'accessing' stamp: 'ek 6/24/2017 13:35:29'!
owner

	^ owner! !


!CreditCard methodsFor: 'comparing' stamp: 'ek 6/24/2017 14:22:45'!
= aCreditCard

	^ number = aCreditCard number & expiration = aCreditCard expiration & owner = aCreditCard owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #'TusLibros-Solution'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'initialization' stamp: 'ek 6/24/2017 22:33:20'!
withNumber: aNumber andOwner: aOwner andExpirationDate: aDate

	^ self new initializeWith: aNumber and: aOwner and: aDate.! !


!classDefinition: #Market category: #'TusLibros-Solution'!
Object subclass: #Market
	instanceVariableNames: 'nextCartID cartsById catalogue merchantProcessor sellsBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Market methodsFor: 'initialization' stamp: 'EF 6/25/2017 22:46:10'!
initializeWith: aCatalogue

	catalogue := aCatalogue.
	nextCartID := 1.
	cartsById := Dictionary new.! !

!Market methodsFor: 'initialization' stamp: 'ek 6/27/2017 16:23:27'!
initializeWith: aCatalogue and: aMerchantProcessor

	catalogue := aCatalogue.
	nextCartID := 1.
	cartsById := Dictionary new.
	merchantProcessor := aMerchantProcessor.
	sellsBook := Dictionary new.! !


!Market methodsFor: 'operations' stamp: 'EF 6/25/2017 23:58:24'!
addToCart: cartID bookISBN: bookISBN quantity: quantity
	
	cartsById at: cartID ifPresent:[:cart | cart add: bookISBN times: quantity ]
						ifAbsent:[self error: 'Cart does not exist'].
	^'0|Ok'! !

!Market methodsFor: 'operations' stamp: 'ek 6/27/2017 14:09:37'!
checkoutCart: cartId ccn: creditCardNumber cced: expirationDate owner: owner date: aDateTime
	
	| cashier creditCard |
	
	cashier := Cashier with: sellsBook and: merchantProcessor.
	creditCard := CreditCard withNumber: creditCardNumber andOwner:owner andExpirationDate: expirationDate.
	cartsById at: cartId ifPresent: [:cart | ^cashier checkoutCart: cart with: creditCard on: aDateTime] ifAbsent: [self error: 'Cart does not exist']

! !

!Market methodsFor: 'operations' stamp: 'ek 6/27/2017 16:32:42'!
createCart: anUserId andDate: aDateTime
	
	|currentCartID|

	currentCartID := self nextCartID. 
	cartsById at: currentCartID put: (Cart with: catalogue and: aDateTime and: anUserId).
	^currentCartID printString. ! !

!Market methodsFor: 'operations' stamp: 'EF 6/26/2017 00:12:09'!
listCart: idCart
	| cartsBookListString |
	cartsById at: idCart ifPresent: 
							[:cart | cartsBookListString := cart printString] 
						 ifAbsent:[ self error: 'Cart does not exist'].
						
	^cartsBookListString! !

!Market methodsFor: 'operations' stamp: 'ek 6/27/2017 18:42:09'!
listPurchases: idUser

	| sells totalAmount|
	
	totalAmount := 0.
	sells := sellsBook at: idUser.
	
	^String streamContents: [:stream | sells do: [:sell | totalAmount := totalAmount + sell cart totalAmount. 
															     (sell cart) books do: [:book |  stream nextPut: $|. (book asInteger) printOn: stream. stream nextPut: $|. ((sell cart) books occurrencesOf: book) printOn: stream].
																stream nextPut: $|. totalAmount printOn: stream]]! !


!Market methodsFor: 'private' stamp: 'EF 6/25/2017 23:01:57'!
nextCartID
	
	nextCartID := nextCartID + 1.
	^nextCartID - 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Market class' category: #'TusLibros-Solution'!
Market class
	instanceVariableNames: ''!

!Market class methodsFor: 'initialization' stamp: 'ek 6/27/2017 13:19:58'!
with: aCatalogue and: aMerchantProcessor

	^self new initializeWith: aCatalogue and: aMerchantProcessor! !


!classDefinition: #MerchantProcessor category: #'TusLibros-Solution'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessor methodsFor: 'initialization' stamp: 'ek 6/24/2017 12:47:53'!
debitUsing: aCreditCardNumber expiration: expirationDate owner: owner amount: amount

	^ self subclassResponsibility.! !


!classDefinition: #MerchantProcessorInterfaz category: #'TusLibros-Solution'!
MerchantProcessor subclass: #MerchantProcessorInterfaz
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!


!classDefinition: #MerchantProcessorMock category: #'TusLibros-Solution'!
MerchantProcessor subclass: #MerchantProcessorMock
	instanceVariableNames: 'message'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!MerchantProcessorMock methodsFor: 'initialization' stamp: 'ek 6/24/2017 23:07:13'!
debitUsing: aCreditCardNumber expiration: expirationDate owner: owner amount: amount

	^ message value: amount.! !

!MerchantProcessorMock methodsFor: 'initialization' stamp: 'ek 6/24/2017 12:52:30'!
initializeWith: AdebitBehaviourClosure

	message := AdebitBehaviourClosure.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorMock class' category: #'TusLibros-Solution'!
MerchantProcessorMock class
	instanceVariableNames: ''!

!MerchantProcessorMock class methodsFor: 'as yet unclassified' stamp: 'ek 6/24/2017 12:51:27'!
with: AdebitBehaviourClosure

	^self new initializeWith: AdebitBehaviourClosure.! !


!classDefinition: #Sell category: #'TusLibros-Solution'!
Object subclass: #Sell
	instanceVariableNames: 'cart date creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!Sell methodsFor: 'accessing' stamp: 'ek 6/24/2017 14:13:00'!
cart

	^ cart! !

!Sell methodsFor: 'accessing' stamp: 'ek 6/24/2017 14:13:17'!
creditCard

	^creditCard! !

!Sell methodsFor: 'accessing' stamp: 'ek 6/24/2017 14:13:08'!
date

	^date! !


!Sell methodsFor: 'comparing' stamp: 'ek 6/24/2017 14:13:57'!
= aSell

	
	^ cart = aSell cart & date = aSell date & creditCard = aSell creditCard! !


!Sell methodsFor: 'initialization' stamp: 'ek 6/24/2017 13:24:02'!
with: ACart and: ADate and: ACreditCard

	cart := ACart .
	date :=  ADate .
	creditCard := ACreditCard.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sell class' category: #'TusLibros-Solution'!
Sell class
	instanceVariableNames: ''!

!Sell class methodsFor: 'as yet unclassified' stamp: 'ek 6/27/2017 18:26:44'!
withACart: ACart andDate: ADate andCreditCard: ACreditCard

	^self new with: ACart and: ADate and: ACreditCard.! !


!classDefinition: #TusLibrosInterface category: #'TusLibros-Solution'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'users market'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Solution'!

!TusLibrosInterface methodsFor: 'operations' stamp: 'EF 6/25/2017 23:59:47'!
addToCart: cartID bookISBN: bookISBN quantity: quantity
	|message|
	message := '0|Ok'.
	[market addToCart: cartID bookISBN: bookISBN quantity: quantity] 
											on: Error do: [:error| message:= '1|', error messageText].
	^message! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'ek 6/27/2017 13:45:16'!
checkoutCart: cartId ccn: creditCardNumber cced: mmYYYY cco: owner date: aDateTime
	
	[^market checkoutCart: cartId ccn: creditCardNumber cced: mmYYYY owner: owner date: aDateTime] on: Error do: [:error | ^ '1|', error messageText].! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'ek 6/27/2017 16:32:17'!
createCart: anUserId and: aPassword andDate: aDateTime
	
	|message|
	
	users at: anUserId ifPresent: 
							[:pass | (pass = aPassword) ifFalse: [message := '1|Wrong password'] ifTrue: [message :=  '0|', (market createCart: anUserId andDate: aDateTime)]] 
						 ifAbsent:[message := '1|User does not exist'].
	
	^message! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'EF 6/26/2017 00:09:28'!
listCart: idCart
	|message cartIBooks|
	
	[cartIBooks := (market listCart: idCart) .message := '0',cartIBooks ] on: Error do: [:error | message := '1|', error messageText].
	^message! !

!TusLibrosInterface methodsFor: 'operations' stamp: 'ek 6/27/2017 18:47:22'!
listPurchases: userId and: password

	|message listPurchases|
	
	users at: userId ifPresent: [:pass | (pass = password) ifFalse: [message := '1|Wrong password'] 
														  		 ifTrue: [[ listPurchases := (market listPurchases: userId) . message := '0', listPurchases ] on: Error do: [:error | message := '1|', error messageText]]]
					    ifAbsent:[message := '1|User does not exist'].
	
	^message
	
	
	! !


!TusLibrosInterface methodsFor: 'initialization' stamp: 'EF 6/25/2017 22:48:20'!
initializeWith: userPasswordDictionary and: aMarket
	
	market := aMarket.
	users := userPasswordDictionary! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosInterface class' category: #'TusLibros-Solution'!
TusLibrosInterface class
	instanceVariableNames: ''!

!TusLibrosInterface class methodsFor: 'initialization' stamp: 'EF 6/25/2017 22:48:41'!
withUsers: userPasswordDictionary andMarket: aMarket

	^self new initializeWith: userPasswordDictionary and: aMarket.
	! !
