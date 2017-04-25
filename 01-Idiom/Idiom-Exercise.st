!classDefinition: #NotFound category: #'Idiom-Exercise'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!


!classDefinition: #IdiomTest category: #'Idiom-Exercise'!
TestCase subclass: #IdiomTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!IdiomTest methodsFor: 'testing' stamp: 'EF 4/24/2017 13:14:03'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook  new.
	
	self assertThat: [customerBook addCustomerNamed: 'John Lennon'.] runsInLessThanMIllis: 50 
	
! !

!IdiomTest methodsFor: 'testing' stamp: 'EF 4/24/2017 14:29:22'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook  new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	
	self assertThat: [customerBook removeCustomerNamed: paulMcCartney.] runsInLessThanMIllis: 100

! !

!IdiomTest methodsFor: 'testing' stamp: 'EF 4/24/2017 16:50:49'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self mustFail: [ customerBook addCustomerNamed: ''.]  
		 withErrorMessage:  CustomerBook customerCanNotBeEmptyErrorMessage 
		 thenAssert: [customerBook isEmpty] 
		 andAssert: [true].
		! !

!IdiomTest methodsFor: 'testing' stamp: 'EF 4/24/2017 16:46:55'!
test04CanNotRemoveAndInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self mustFail: [customerBook removeCustomerNamed: 'Paul McCartney'.]  
		 withErrorMessage:  nil
		 thenAssert: [customerBook numberOfCustomers = 1] 
		 andAssert: [customerBook includesCustomerNamed: johnLennon].
	
! !


!IdiomTest methodsFor: 'assertions' stamp: 'EF 4/24/2017 22:27:09'!
assertThat: aBlockClosure runsInLessThanMIllis: millis 

	|millisecondsBeforeRunning millisecondsAfterRunning| 

	millisecondsBeforeRunning := Time millisecondClockValue.
	aBlockClosure value.	
	millisecondsAfterRunning := Time millisecondClockValue.

	self assert: (millisecondsAfterRunning - millisecondsBeforeRunning) < millis! !

!IdiomTest methodsFor: 'assertions' stamp: 'EF 4/24/2017 22:27:50'!
mustFail: aBlockClosure withErrorMessage: anErrorMessage thenAssert: aBlockClosureForAssert andAssert: anotherBlockClosureForAssert 
	
	[aBlockClosure value. self fail]
	on: Error
	do: [:anError | self assert: anError messageText =  anErrorMessage].
	self assert: aBlockClosureForAssert value.
	self assert: anotherBlockClosureForAssert value.
	! !


!classDefinition: #CustomerBook category: #'Idiom-Exercise'!
Object subclass: #CustomerBook
	instanceVariableNames: 'customers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Idiom-Exercise'!

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:56'!
includesCustomerNamed: aName

	^customers includes: aName ! !

!CustomerBook methodsFor: 'testing' stamp: 'HernanWilkinson 7/6/2011 17:48'!
isEmpty
	
	^customers isEmpty  ! !


!CustomerBook methodsFor: 'initialization' stamp: 'HernanWilkinson 7/6/2011 17:42'!
initialize

	super initialize.
	customers := OrderedCollection new! !


!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:42'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	(customers includes: aName) ifTrue: [ self signalCustomerAlreadyExists ].
	
	customers add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:56'!
numberOfCustomers
	
	^customers size! !

!CustomerBook methodsFor: 'customer management' stamp: 'HAW 4/14/2017 16:55:43'!
removeCustomerNamed: aName
 
	customers remove: aName ifAbsent: [ NotFound signal ]! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'Idiom-Exercise'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:57'!
customerAlreadyExistsErrorMessage

	^'Customer already exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/6/2011 17:53'!
customerCanNotBeEmptyErrorMessage

	^'Customer name cannot be empty'! !
