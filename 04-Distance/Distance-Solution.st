!classDefinition: #DistanceTest category: #'Distance-Solution'!
TestCase subclass: #DistanceTest
	instanceVariableNames: 'oneMeter hundredCentimeters twoMeters threeMeters oneHundredOneCentimeters oneCentimeter twoCentimeters twoHundredCentimeters threeHundredCentimeters halfMeter oneMeterAndAHalf twoMetersAndAHalf threeMetersAndAHalf fourMeters fourMetersAndAHalf fiveMeters'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/30/2017 17:50:04'!
setUp
	
	oneMeter := Meter withAmount: 1.
	twoMeters := Meter withAmount: 2.
	threeMeters := Meter withAmount: 3.
	
	oneCentimeter := Centimeter withAmount: 1.
	twoCentimeters := Centimeter withAmount: 2.
	hundredCentimeters := Centimeter withAmount: 100.
	oneHundredOneCentimeters := Centimeter withAmount: 101.
	twoHundredCentimeters := Centimeter withAmount: 200.
	threeHundredCentimeters := Centimeter withAmount: 300.
	oneMeterAndAHalf := Meter withAmount: 1.5.
	twoMetersAndAHalf := Meter withAmount: 2.5.
	threeMetersAndAHalf := Meter withAmount: 3.5.
	fourMeters := Meter withAmount: 4.
	fourMetersAndAHalf := Meter withAmount:4.5.
	fiveMeters := Meter withAmount:5.
	! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:18:05'!
test01CanCreateAMetre

	self assert: oneMeter amount = 1.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:18:15'!
test02MetresWithSameAmountMustBeEquals
	
	|anotherOneMetre|
	
	anotherOneMetre := Meter withAmount: 1.
	
	self assert: oneMeter = anotherOneMetre.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:18:26'!
test03MetresWithDifferentAmountMustNotBeEquals

	
	self deny: oneMeter = twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:18:40'!
test04SumBetweenMetres
	
	self assert: oneMeter + oneMeter = twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 20:03:19'!
test05AMetreIsEqualsToItsEquivalentDistanceInCentimeters

	self assert: oneMeter = hundredCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:18:55'!
test06AMetreIsNotEqualToANotEquivalentDistanceInCentimeters

	self deny: oneMeter = oneHundredOneCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/27/2017 12:17:45'!
test07CentimeterWithSameAmountMustBeEquals
	
	|anotherOneCentimeter|
	
	anotherOneCentimeter := Centimeter withAmount: 1.
	
	self assert: oneCentimeter = anotherOneCentimeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/27/2017 12:17:55'!
test08SumBetweenCentimeters
	
	self assert: oneCentimeter + oneCentimeter = twoCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:19:14'!
test09ACentimeterIsEqualsToItsEquivalentDistanceInMetres
	
	self assert: hundredCentimeters = oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:19:20'!
test10ACentimeterIsNotEqualToItsNotEquivalentDistanceInMetres
	
	self deny: oneHundredOneCentimeters = oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:19:29'!
test11MultiplicationBetweenMetreAndScalar
	
	self assert: oneMeter * 2 = twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:19:41'!
test12SubtractionBetweenMetres
	
	self assert: threeMeters - oneMeter = twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:19:50'!
test13MultiplicationBetweenScalarAndMetre
	
	self assert: 2 * oneMeter = twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:19:57'!
test14DivAMetreByScalarResultMustBeComparableWithHalfMetres
	
	|aHalfMeter|
	
	aHalfMeter := Meter withAmount: (1/2).
	
	self assert: oneMeter / 2 = aHalfMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 18:40:46'!
test15MultiplicationBetweenCentimeterAndScalar
	
	self assert: oneCentimeter * 2 = twoCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 18:43:58'!
test16SubtractionBetweenCentimeters
	
	self assert: twoCentimeters - oneCentimeter = oneCentimeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 18:45:59'!
test17MultiplicationBetweenScalarAndCentimeter
	
	self assert: 2 * oneCentimeter = twoCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 18:48:26'!
test18DivACentimeterByScalarResultACentimeter
	
	|aHalfCentimeter|
	
	aHalfCentimeter := Centimeter withAmount: (1/2).
	
	self assert: oneCentimeter / 2 = aHalfCentimeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:20:10'!
test19SumAMeterAndACentimeter
	
	self assert: oneMeter + hundredCentimeters = twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:20:25'!
test20SumACentimeterAndAMeter
	
	self assert: hundredCentimeters + oneMeter = twoHundredCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:20:34'!
test21SubtractionBetweenAMeterAndACentimeter
	
	self assert: twoMeters - hundredCentimeters = oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'ek 5/28/2017 19:21:35'!
test22SubtractionBetweenACentimeterAndAMeter
	
	self assert: twoHundredCentimeters - oneMeter = hundredCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/29/2017 20:08:24'!
test23CentimeterLessThanCentimeter
	
	self assert: oneCentimeter < twoCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/29/2017 20:07:47'!
test24MetreGreaterThanMetre
	
	self assert: twoMeters > oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/29/2017 20:11:59'!
test25MetreLessThanMetre
	
	self assert: oneMeter < twoMeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/29/2017 20:16:33'!
test26CentimeterGreaterThanCentimeter
	
	self assert: twoCentimeters > oneCentimeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/29/2017 20:19:57'!
test27MetreLessThanCentimeter
	
	self assert: oneMeter < oneHundredOneCentimeters.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/29/2017 20:21:38'!
test28MetreGreaterThanCentimeter
	
	self assert: oneMeter > oneCentimeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/29/2017 20:36:31'!
test29CentimeterGreaterThanMeter
	
	self deny: twoCentimeters > oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/29/2017 20:49:19'!
test30CentimeterLessThanMeter
	
	self assert: twoCentimeters < oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/30/2017 17:03:13'!
test31DistanceLessEqualsThanDistance
	
	self assert: hundredCentimeters <= oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/30/2017 17:04:59'!
test32DistanceGreaterEqualsThanDistance
	
	self assert: hundredCentimeters >= oneMeter.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/30/2017 17:29:57'!
test33IntervalFromADistanceToAnotherDistance
	
	|intervalFromOneMeterToThree|
	
	intervalFromOneMeterToThree := OrderedCollection with: oneMeter with: twoMeters with: threeMeters.
	
	self assert: (oneMeter to: threeHundredCentimeters) equals: intervalFromOneMeterToThree.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/30/2017 17:25:58'!
test34IntervalFromADistanceToAMinorDistance
	
	self should: [ oneMeter to: oneCentimeter ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Distance canNotCreateAnIntervalToAMinorDistance].
	! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/30/2017 17:40:53'!
test35IntervalFromADistanceToAnotherDistanceByADistance
	
	|intervalFromOneMeterToThreeHundCentim byStep|
	
	byStep := Centimeter withAmount: 50.
	intervalFromOneMeterToThreeHundCentim := OrderedCollection with: oneMeter with: oneMeterAndAHalf with: twoMeters with: twoMetersAndAHalf with: threeMeters.
	
	self assert: (oneMeter to: threeHundredCentimeters by: byStep) equals: intervalFromOneMeterToThreeHundCentim.! !

!DistanceTest methodsFor: 'testing' stamp: 'EF 5/30/2017 17:48:36'!
test36IntervalDo
	
	|intervalFromOneMeterToThreeHundCentim byStep|
	
	byStep := Centimeter withAmount: 50.
	intervalFromOneMeterToThreeHundCentim := OrderedCollection with: threeMeters with: threeMetersAndAHalf with: fourMeters with: fourMetersAndAHalf with: fiveMeters.
	
	self assert: (oneMeter to: threeHundredCentimeters by: byStep do: [:elem | elem + (Meter withAmount: 2)]) equals: intervalFromOneMeterToThreeHundCentim.! !


!classDefinition: #Distance category: #'Distance-Solution'!
Object subclass: #Distance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Distance methodsFor: 'operations' stamp: 'ek 5/30/2017 00:39:22'!
* aScalar

	^ self class withAmount: self amount * aScalar.! !

!Distance methodsFor: 'operations' stamp: 'EF 5/30/2017 18:15:32'!
+ aDistance

	^self calculateDistanceWithOperator: #+ andDistance: aDistance
! !

!Distance methodsFor: 'operations' stamp: 'EF 5/30/2017 18:16:35'!
- aDistance

	^self calculateDistanceWithOperator: #- andDistance: aDistance
! !

!Distance methodsFor: 'operations' stamp: 'ek 5/30/2017 00:41:53'!
/ aScalar

	^ self class withAmount: self amount / aScalar.! !

!Distance methodsFor: 'operations' stamp: 'EF 5/30/2017 18:27:53'!
calculateDistanceWithOperator: anOperator andDistance: anotherDistance
		
	^self class withAmount: (self normalizeAmount perform: anOperator with: anotherDistance normalizeAmount) / self factor
! !


!Distance methodsFor: 'comparing' stamp: 'EF 5/30/2017 18:19:25'!
< aDistance

	^self normalizeAmount < aDistance normalizeAmount! !

!Distance methodsFor: 'comparing' stamp: 'EF 5/30/2017 18:19:19'!
<= aDistance 
	
	^self normalizeAmount <= aDistance normalizeAmount! !

!Distance methodsFor: 'comparing' stamp: 'EF 5/30/2017 18:19:43'!
= aDistance

	^self normalizeAmount = aDistance normalizeAmount! !

!Distance methodsFor: 'comparing' stamp: 'EF 5/30/2017 18:19:56'!
> aDistance

	^self normalizeAmount > aDistance normalizeAmount! !

!Distance methodsFor: 'comparing' stamp: 'EF 5/30/2017 18:20:12'!
>= aDistance 
	
	^self normalizeAmount >= aDistance normalizeAmount! !


!Distance methodsFor: 'acessing' stamp: 'EF 5/30/2017 15:19:12'!
amount 
	
	self subclassResponsibility! !

!Distance methodsFor: 'acessing' stamp: 'EF 5/30/2017 15:19:50'!
factor

	self subclassResponsibility! !


!Distance methodsFor: 'intervals' stamp: 'EF 5/30/2017 17:43:36'!
to: aDistance 
	
	^self to: aDistance by: (Meter withAmount:1)! !

!Distance methodsFor: 'intervals' stamp: 'EF 5/30/2017 17:55:14'!
to: aDistance by: stepDistance
 
	^self to: aDistance by: stepDistance do: [:elem | elem]! !

!Distance methodsFor: 'intervals' stamp: 'EF 5/30/2017 18:06:26'!
to: aDistance by: stepDistance do: aBlockClosure 
	
	|interval current|
	
	(self > aDistance) ifTrue: [self error: self class canNotCreateAnIntervalToAMinorDistance].
	interval := OrderedCollection new.
	current := self.
	[current <= aDistance] whileTrue: [interval add: (aBlockClosure value: current). current := current + stepDistance].
	^interval! !


!Distance methodsFor: 'as yet unclassified' stamp: 'EF 5/30/2017 17:56:18'!
adaptToInteger: aScalar andSend: aSelector

	^ self perform: aSelector with: aScalar! !


!Distance methodsFor: 'normalization' stamp: 'EF 5/30/2017 18:17:58'!
normalizeAmount

	^self amount * self factor.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Distance class' category: #'Distance-Solution'!
Distance class
	instanceVariableNames: ''!

!Distance class methodsFor: 'error message' stamp: 'EF 5/30/2017 17:27:19'!
canNotCreateAnIntervalToAMinorDistance

	^'Can not create an Interval to a minor distance'.! !


!classDefinition: #Centimeter category: #'Distance-Solution'!
Distance subclass: #Centimeter
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Centimeter methodsFor: 'initialization' stamp: 'EF 5/23/2017 20:03:07'!
initializeWith: anAmountOfCentimeters

	amount := anAmountOfCentimeters! !


!Centimeter methodsFor: 'accessing' stamp: 'EF 5/23/2017 20:03:38'!
amount
	
	^amount! !

!Centimeter methodsFor: 'accessing' stamp: 'EF 5/30/2017 14:50:24'!
factor

	^self class factor! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Centimeter class' category: #'Distance-Solution'!
Centimeter class
	instanceVariableNames: 'factor'!

!Centimeter class methodsFor: 'initialization' stamp: 'EF 5/30/2017 14:45:55'!
initialize
	
	super initialize.
	self initializeFactor.! !

!Centimeter class methodsFor: 'initialization' stamp: 'EF 5/30/2017 15:07:32'!
initializeFactor

	factor := 1/100! !

!Centimeter class methodsFor: 'initialization' stamp: 'EF 5/23/2017 20:02:34'!
withAmount: anAmountOfCentimeters

	^self new initializeWith: anAmountOfCentimeters! !


!Centimeter class methodsFor: 'accessing' stamp: 'EF 5/30/2017 14:51:07'!
factor

	^factor! !


!classDefinition: #Meter category: #'Distance-Solution'!
Distance subclass: #Meter
	instanceVariableNames: 'amount'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!Meter methodsFor: 'initialization' stamp: 'EF 5/23/2017 19:26:34'!
initializeWith: anAmountOfMetres

	amount := anAmountOfMetres.! !



!Meter methodsFor: 'accessing' stamp: 'EF 5/23/2017 19:27:10'!
amount

	^amount! !

!Meter methodsFor: 'accessing' stamp: 'EF 5/30/2017 14:50:06'!
factor

	^self class factor! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Meter class' category: #'Distance-Solution'!
Meter class
	instanceVariableNames: 'factor'!

!Meter class methodsFor: 'initialization' stamp: 'EF 5/30/2017 14:44:55'!
initialize 

	super initialize.
	self initializeFactor! !

!Meter class methodsFor: 'initialization' stamp: 'EF 5/30/2017 14:45:16'!
initializeFactor

	factor := 1! !

!Meter class methodsFor: 'initialization' stamp: 'EF 5/23/2017 19:26:07'!
withAmount: anAmountOfMetres

	^self new initializeWith: anAmountOfMetres.! !


!Meter class methodsFor: 'accessing' stamp: 'EF 5/30/2017 14:51:20'!
factor

	^factor! !


!classDefinition: #DistanceFactory category: #'Distance-Solution'!
Object subclass: #DistanceFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Distance-Solution'!

!DistanceFactory methodsFor: 'factory' stamp: 'EF 5/30/2017 15:35:41'!
minusOneMeter

	^Meter withAmount: -1! !

!DistanceFactory methodsFor: 'factory' stamp: 'EF 5/30/2017 15:35:20'!
oneHundredCentimeters

	^Centimeter withAmount: 100! !

!DistanceFactory methodsFor: 'factory' stamp: 'EF 5/30/2017 15:34:56'!
oneMeter

	^Meter withAmount: 1! !

!DistanceFactory methodsFor: 'factory' stamp: 'EF 5/30/2017 15:34:48'!
twoHundredCentimeters

	^Centimeter withAmount: 200! !

!DistanceFactory methodsFor: 'factory' stamp: 'EF 5/30/2017 15:34:35'!
twoMeters

	^Meter withAmount: 2.! !

!DistanceFactory methodsFor: 'factory' stamp: 'EF 5/30/2017 15:34:16'!
zeroMeters
	
	^Meter withAmount: 0.! !

Centimeter initialize!
Meter initialize!