!classDefinition: #MeasureInterval category: #'Measure-Solution'!
Interval subclass: #MeasureInterval
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureInterval methodsFor: 'accessing' stamp: 'ek 6/2/2017 22:39:50'!
by

	^ ((self last - self first) / (self size - 1)) convertTo: self first unit.! !

!MeasureInterval methodsFor: 'accessing' stamp: 'ek 6/2/2017 00:44:01'!
from

	^self first! !

!MeasureInterval methodsFor: 'accessing' stamp: 'ek 6/2/2017 00:44:15'!
to

	^self last! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureInterval class' category: #'Measure-Solution'!
MeasureInterval class
	instanceVariableNames: ''!

!MeasureInterval class methodsFor: 'exceptions' stamp: 'EF 6/6/2017 23:26:48'!
canNotCreateAnIntervalToAMinorMeasure

	^'Can not create an interval to a minor measure'.! !


!MeasureInterval class methodsFor: 'initialization' stamp: 'EF 6/6/2017 19:47:33'!
from: start to: stop
	
	|step|
	
	step := Measure withAmount: 1 andUnit: start unit.
	^self from: start to: stop by: step.! !

!MeasureInterval class methodsFor: 'initialization' stamp: 'ek 6/2/2017 22:27:28'!
from: start to: stop by: step
	
	| count end |	
			
	count _ ((stop - start) normalizeAmount / step normalizeAmount) + 1.
	(count closeTo: count rounded)
		ifTrue: [
			count _ count rounded.
			end _ stop ]
		ifFalse: [
			count _ count truncated.
			end _ count-1 * step + start.].
	
	^self from: start to: end count: count.! !


!classDefinition: #MeasureTest category: #'Measure-Solution'!
TestCase subclass: #MeasureTest
	instanceVariableNames: 'oneMeter oneKilo meter kilo twoMeters oneDolar dolar zeroMeters zeroKilo zeroKelvin kelvin zeroCelcius celcius second centimeter oneSquareMeter twoSquareMeter'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureTest methodsFor: 'testing' stamp: 'EF 6/8/2017 15:26:31'!
setUp
	
	centimeter := SingleUnit withName: 'centimeter' andFactor: 1/100 andType: 'distance'.
	meter := SingleUnit withName: 'meter' andFactor: 1 andType: 'distance'.
	oneMeter := Measure withAmount: 1 andUnit: meter. 
	twoMeters := Measure withAmount: 2 andUnit: meter. 
	zeroMeters := Measure withAmount: 0 andUnit: meter. 
	kilo := SingleUnit withName: 'kilo' andFactor: 1 andType: 'weight'.
	oneKilo := Measure withAmount: 1 andUnit: kilo.
	zeroKilo := Measure withAmount: 0 andUnit: kilo.

	dolar := SingleUnit withName: 'dolar' andFactor: 1 andType: 'dolar'.
	oneDolar := Measure withAmount: 1 andUnit: dolar.

	kelvin := SingleUnit withName: 'kelvin' andFactor: -273  andType: 'temperature'.
	zeroKelvin := Measure withAmount: 0 andUnit: kelvin. 
	
	celcius := SingleUnit withName: 'celcius' andFactor: 0  andType: 'temperature'.
	zeroCelcius := Measure withAmount: 0 andUnit: celcius. 
	
	second := SingleUnit withName: 'second' andFactor: 1  andType: 'time'.
	
	oneSquareMeter :=  1*meter*meter.
	twoSquareMeter :=  2*meter*meter.! !

!MeasureTest methodsFor: 'testing' stamp: 'EF 6/6/2017 21:07:07'!
test01aDistancesIsNotEqualToAWeight

	self deny: oneMeter = oneKilo.! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/4/2017 15:17:34'!
test02aWeightIsNotEqualToADistance

	self deny: oneKilo  = oneMeter.! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:57:45'!
test03AddADistanceAndAWeight

	self assert: oneMeter + oneKilo = (MeasureSumatory with: oneMeter with: oneKilo).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/4/2017 15:20:08'!
test04AddADistanceAndAWeightIsEqualToAddAWeightAndADistance

	self assert: oneMeter + oneKilo = (oneKilo + oneMeter).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:58:03'!
test05AddADistanceAndAWeightandADistance

	self assert: oneMeter + oneKilo + oneMeter = (MeasureSumatory with: twoMeters with: oneKilo).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:57:56'!
test06AddADistanceAndAWeightandADolar

	self assert: oneMeter + oneKilo + oneDolar = (MeasureSumatory with: oneMeter with: oneKilo with: oneDolar).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:58:10'!
test07SubstractADistanceAndAWeight

	self assert: oneMeter - oneKilo = (MeasureSumatory with: oneMeter with: oneKilo negated).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:57:49'!
test08SubtractDistanceAndAWeightIsEqualToNegatedOfSubtractAWeightAndADistance

	self assert: oneKilo- oneMeter = (MeasureSumatory with: oneKilo with: oneMeter negated).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:57:59'!
test09SubtractADistanceAndAWeightandADistance

	self assert: oneMeter + oneKilo - oneMeter = (MeasureSumatory with: zeroMeters with: oneKilo).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:58:14'!
test10SubtractADistanceAndAWeightandADolar

	self assert: oneMeter - oneKilo - oneDolar = (MeasureSumatory with: oneMeter with: oneKilo negated with: oneDolar negated).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/7/2017 22:44:48'!
test11CanNotConvertDifferentMeasure

	self
		should: [ oneMeter convertTo: kilo ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Measure canNotConvertToUnitErrorMessage]! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/7/2017 22:45:25'!
test12CanNotConvertDifferentMeasure

	self
		should: [ oneKilo convertTo: meter ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | self assert: anError messageText equals: Measure canNotConvertToUnitErrorMessage]! !

!MeasureTest methodsFor: 'testing' stamp: 'EF 6/4/2017 23:27:32'!
test13NothingEqualsToNothingDistanceAndWeight

	self assert: zeroMeters = zeroKilo ! !

!MeasureTest methodsFor: 'testing' stamp: 'EF 6/4/2017 23:36:19'!
test14NothingEqualsToNothingWeightAndDistance

	self assert: zeroKilo = zeroMeters ! !

!MeasureTest methodsFor: 'testing' stamp: 'EF 6/5/2017 00:06:54'!
test15NothingEqualsToNothingTemperatureAndWeight

	self assert: zeroKelvin = zeroKilo ! !

!MeasureTest methodsFor: 'testing' stamp: 'EF 6/5/2017 00:19:51'!
test16ZerosInTemperaturesAreDistinct

	self deny: zeroKelvin = zeroCelcius! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 00:48:40'!
test17CanCreateMeasureUsingUnit

	self assert: 1*meter = oneMeter.! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:34:54'!
test18CanCreateMeasureWithCompoundUnitUsingUnits

	self assert: oneSquareMeter = (1 * (meter * meter)).
	self assert: (oneSquareMeter unit isKindOf: CompoundUnit).
	self assert: oneSquareMeter unit numeratorUnits = (Bag with: meter with: meter).	
	self assert: oneSquareMeter unit denominatorUnits = (Bag new).
	self assert: oneSquareMeter amount = 1.! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 01:05:13'!
test19CanCreateMeasureUsingUnit

	self deny: 1*kilo*kilo = (1 * (meter * meter))! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 02:17:26'!
test20MeasurePorCompound

	self assert: (1*kilo)*(kilo * kilo) = (1 * kilo * kilo * kilo)! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:53:20'!
test21MultiplyingMeasuresMustCompoundTheirUnits
	
	|newMeasure|
	
	newMeasure := 1 * meter * (1 * centimeter).
	self assert: newMeasure amount = (1/100).
	self assert: (newMeasure unit isKindOf: CompoundUnit).
	self assert: newMeasure unit numeratorUnits = (Bag with: meter with: meter).	
	self assert: newMeasure unit denominatorUnits = (Bag new).
! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:53:27'!
test225DividedMeasuresMustCompoundTheirUnits
	
	|newMeasure|
	
	newMeasure := (1 * meter) / (1 * kilo).
	self assert: newMeasure amount = 1.
	self assert: (newMeasure unit isKindOf: CompoundUnit).
	self assert: newMeasure unit numeratorUnits = (Bag with: meter).	
	self assert: newMeasure unit denominatorUnits = (Bag with: kilo).
! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:53:34'!
test23DividedMeasuresWithTheSameCategoryUnitBeCancel
	
	|newMeasure|
	
	newMeasure := (1 * meter) / (1 * meter).
	self assert: newMeasure = 1.! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:53:42'!
test24MultiplyTwoMeasuresWithCompundUnits

	|newMeasure|
	
	newMeasure := (1 * meter * meter * meter) / (1 * meter).
	self assert: newMeasure amount = 1.
	self assert: (newMeasure unit isKindOf: CompoundUnit).
	self assert: newMeasure unit numeratorUnits = (Bag with: meter with: meter).
	self assert: newMeasure unit denominatorUnits = (Bag new).! !

!MeasureTest methodsFor: 'testing' stamp: 'ek 6/8/2017 18:53:49'!
test25MultiplyTwoMeasureAndHaveAMeasureWithSingleUnit

	|newMeasure|
	
	newMeasure := (1 * meter * meter) / (1 * meter).
	self assert: newMeasure amount = 1.
	self assert: (newMeasure unit isKindOf: SingleUnit).
	self assert: newMeasure unit = meter.! !


!classDefinition: #Measure category: #'Measure-Solution'!
Object subclass: #Measure
	instanceVariableNames: 'amount unit'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Measure methodsFor: 'operations' stamp: 'EF 6/8/2017 14:15:41'!
* aMultiplicator

	^(OOMeasureState stateFor: self) * aMultiplicator! !

!Measure methodsFor: 'operations' stamp: 'ek 6/8/2017 18:58:19'!
+ aMeasure

	(aMeasure unit type = self unit type) ifFalse: [^MeasureSumatory with: self with: aMeasure].
	^self calculateDistanceWithOperator: #+ andDistance: aMeasure
! !

!Measure methodsFor: 'operations' stamp: 'ek 6/8/2017 18:58:24'!
- aDistance

	(aDistance unit type = self unit type) ifFalse: [^ MeasureSumatory with: self with: aDistance negated].
	^self calculateDistanceWithOperator: #- andDistance: aDistance
! !

!Measure methodsFor: 'operations' stamp: 'EF 6/8/2017 14:16:01'!
/ aDivider

	^(OOMeasureState stateFor: self) / aDivider! !

!Measure methodsFor: 'operations' stamp: 'EF 6/1/2017 19:41:29'!
calculateDistanceWithOperator: anOperator andDistance: anotherDistance
		
	^self class withAmount: (self normalizeAmount perform: anOperator with: anotherDistance normalizeAmount) / self unit factor andUnit: self unit.
 ! !

!Measure methodsFor: 'operations' stamp: 'ek 6/8/2017 18:27:55'!
divideWhenHasCompoundUnit: aDivisor
	
	(aDivisor isKindOf: Unit) ifTrue: [^Measure withAmount: amount andUnit: (unit / aDivisor)].
	(aDivisor isKindOf: Integer) ifTrue: [^Measure withAmount: (self amount / aDivisor) andUnit: self unit].
	(self unit numeratorUnits) detect: [:current | current type = aDivisor unit type.] 
								   ifFound: [:elem | self unit numeratorUnits remove: elem.
													  ((self unit numeratorUnits size = 1) and: [self unit denominatorUnits size = 0]) 
													  ifTrue: [ ^Measure withAmount: amount/((aDivisor convertTo: elem) amount) andUnit: self unit numeratorUnits anyOne] 
													  ifFalse: [^Measure withAmount: amount/((aDivisor convertTo: elem) amount) andUnit: self unit]] 
								   ifNone: [^Measure withAmount: (amount / aDivisor amount) andUnit: unit / aDivisor unit].! !

!Measure methodsFor: 'operations' stamp: 'EF 6/8/2017 13:45:46'!
divideWhenHasSingleUnit: aDivisor

	(aDivisor isKindOf: Unit) ifTrue: [^Measure withAmount: amount andUnit: (unit / aDivisor)].
	(aDivisor isKindOf: Integer) ifTrue: [^Measure withAmount: (self amount / aDivisor) andUnit: self unit].	
	(self unit type = aDivisor unit type) ifTrue: [^ (self amount / (aDivisor convertTo: self unit) amount)].
	^ self class withAmount: (self amount / aDivisor amount) andUnit: (self unit / aDivisor unit)! !

!Measure methodsFor: 'operations' stamp: 'ek 6/4/2017 17:48:31'!
increase: aDistance

	amount := (self + aDistance) amount.
! !

!Measure methodsFor: 'operations' stamp: 'EF 6/8/2017 13:36:28'!
multiplyWhenHasCompoundUnit: aMultiplier
	
	| newAmount |
	
	(aMultiplier isKindOf: Unit) ifTrue: [^Measure withAmount: amount andUnit: ( unit * aMultiplier)].
	(aMultiplier isKindOf: Integer) ifTrue: [^Measure withAmount: (self amount * aMultiplier) andUnit: self unit].
	(aMultiplier unit isKindOf: CompoundUnit) ifTrue: [
		newAmount := (self normalizeAmount * aMultiplier normalizeAmount).

		^Measure withAmount: (amount * aMultiplier) andUnit: self unit].
	
	(unit type = aMultiplier unit type) ifTrue: [^Measure withAmount: ((aMultiplier convertTo: (self unit)) amount * amount) andUnit: (unit * unit)].
	^Measure withAmount: (amount * aMultiplier amount) andUnit: (unit * aMultiplier).! !

!Measure methodsFor: 'operations' stamp: 'EF 6/8/2017 13:47:08'!
multiplyWhenHasSingleUnit: aMultiplier
	
	(aMultiplier isKindOf: Unit) ifTrue: [^Measure withAmount: amount andUnit: (unit * aMultiplier)].
	(aMultiplier isKindOf: Integer) ifTrue: [^Measure withAmount: (self amount * aMultiplier) andUnit: self unit].
	
	(self unit type = aMultiplier unit type) ifTrue: [^Measure withAmount: ((aMultiplier convertTo: (self unit)) amount * self amount) andUnit: (self unit * self unit)].
	^Measure withAmount: (amount * aMultiplier amount) andUnit: (unit * aMultiplier).! !

!Measure methodsFor: 'operations' stamp: 'EF 6/6/2017 19:50:45'!
negated

	^Measure withAmount: (self amount * -1) andUnit: self unit.! !


!Measure methodsFor: 'comparing' stamp: 'ek 6/4/2017 14:58:08'!
< aDistance

	^self normalizeAmount < aDistance normalizeAmount.! !

!Measure methodsFor: 'comparing' stamp: 'ek 6/4/2017 14:58:23'!
<= aDistance 
	
	^self normalizeAmount <= aDistance normalizeAmount.! !

!Measure methodsFor: 'comparing' stamp: 'EF 6/8/2017 14:16:25'!
= aMeasure

	^(OOMeasureState stateFor: self) = aMeasure! !

!Measure methodsFor: 'comparing' stamp: 'EF 5/30/2017 18:19:56'!
> aDistance

	^self normalizeAmount > aDistance normalizeAmount! !

!Measure methodsFor: 'comparing' stamp: 'EF 5/30/2017 18:20:12'!
>= aDistance 
	
	^self normalizeAmount >= aDistance normalizeAmount! !

!Measure methodsFor: 'comparing' stamp: 'ek 6/2/2017 22:44:17'!
between: aDistance and: anotherDistance 
	
	^ (self >= aDistance  & self <= anotherDistance)! !

!Measure methodsFor: 'comparing' stamp: 'EF 6/8/2017 14:21:11'!
equalsWhenHasCompoundUnit: aMeasure

	(self canConvertTo: aMeasure unit) ifTrue: [ ^(self normalizeAmount = aMeasure normalizeAmount)]
											ifFalse: [ ^(aMeasure amount = 0 and: [amount = 0])]! !

!Measure methodsFor: 'comparing' stamp: 'EF 6/8/2017 14:12:24'!
equalsWhenHasSingleUnit: aMeasure

	(aMeasure unit type = self unit type) ifTrue: [^self normalizeAmount = aMeasure normalizeAmount].
	^(aMeasure amount = 0 and: [amount = 0]).
	! !

!Measure methodsFor: 'comparing' stamp: 'EF 6/1/2017 21:58:39'!
hash

	^self normalizeAmount hash! !

!Measure methodsFor: 'comparing' stamp: 'ek 6/2/2017 22:44:27'!
max: aDistance 
	
	 self >= aDistance ifTrue: [^self].
	^aDistance! !

!Measure methodsFor: 'comparing' stamp: 'ek 6/2/2017 22:44:37'!
min: aDistance 
	
	 self <= aDistance ifTrue: [^self].
	^aDistance! !


!Measure methodsFor: 'acessing' stamp: 'EF 6/1/2017 19:34:47'!
amount 
	
	^amount! !

!Measure methodsFor: 'acessing' stamp: 'EF 6/1/2017 21:37:27'!
printString
	
	(amount = 1) ifTrue: [^amount printString , ' ', unit name].
	^amount printString , ' ', unit name, 's'. ! !

!Measure methodsFor: 'acessing' stamp: 'EF 6/1/2017 19:35:00'!
unit

	^unit! !


!Measure methodsFor: 'intervals' stamp: 'EF 6/6/2017 19:51:06'!
to: aDistance 
	
	^self to: aDistance by: (Measure withAmount: 1 andUnit: self unit)! !

!Measure methodsFor: 'intervals' stamp: 'EF 6/6/2017 19:53:01'!
to: aDistance by: stepDistance
 
	^MeasureInterval from: self to: aDistance by: stepDistance. ! !

!Measure methodsFor: 'intervals' stamp: 'EF 6/6/2017 19:52:57'!
to: aDistance by: stepDistance do: aBlockClosure 
	
	|distanceInterval|
	
	distanceInterval := MeasureInterval from: self to: aDistance by: stepDistance.
	
	^distanceInterval do: aBlockClosure.
	
	! !


!Measure methodsFor: 'normalization' stamp: 'EF 6/8/2017 15:13:48'!
normalizeAmount

	^(OOMeasureState stateFor: self) normalizeAmount! !

!Measure methodsFor: 'normalization' stamp: 'EF 6/8/2017 15:13:10'!
normalizeAmountWhenHasCompoundUnit

	| newAmount |
	
	newAmount := 1.
		
	unit numeratorUnits do:[:elem | newAmount := newAmount * (elem factor)].
	unit denominatorUnits do:[:elem | newAmount := newAmount / (elem factor)].
	^ amount * newAmount! !

!Measure methodsFor: 'normalization' stamp: 'EF 6/8/2017 15:13:24'!
normalizeAmountWhenHasSingleUnit

	(self unit type = 'temperature') ifTrue: [^ amount + self unit factor].
	^self amount * self unit factor.! !


!Measure methodsFor: 'initialization' stamp: 'EF 6/1/2017 19:32:32'!
initializeWith: anAmount and: anUnit

	amount := anAmount.
	unit := anUnit.! !


!Measure methodsFor: 'conversion' stamp: 'EF 5/30/2017 17:56:18'!
adaptToInteger: aScalar andSend: aSelector

	^ self perform: aSelector with: aScalar! !

!Measure methodsFor: 'conversion' stamp: 'EF 6/8/2017 14:32:27'!
canConvertTo: anUnit
	
	^(OOMeasureState stateFor: self) canConvertTo: anUnit! !

!Measure methodsFor: 'conversion' stamp: 'ek 6/8/2017 18:55:56'!
canConvertToUnitWhenHasCompUnit: anUnit
		
	| newUnit |
	
	newUnit := (self unit) copy.
	newUnit := newUnit /(anUnit copy).
	^((Measure withAmount: 1 andUnit: newUnit) cancelUnits) isKindOf: Integer.
! !

!Measure methodsFor: 'conversion' stamp: 'ek 6/8/2017 17:34:04'!
canConvertToUnitWhenHasSingleUnit: anUnit
		
	^(self unit type = anUnit type)
! !

!Measure methodsFor: 'conversion' stamp: 'ek 6/8/2017 18:10:38'!
cancelUnits

	| newAmount newUnit |
	
	newAmount := 1.
	unit numeratorUnits do: [:elem | unit denominatorUnits detect: [:aUnit | elem type = aUnit type] 
																     ifFound: [:aUnit | newAmount := newAmount * (elem factor / aUnit factor).
																					    unit numeratorUnits remove: elem.
																			   		    unit denominatorUnits remove: aUnit.] 
																	ifNone: []].
																															
	(unit denominatorUnits size = 0 and: [ unit numeratorUnits size = 0]) ifTrue: [^(amount * newAmount)].
	(unit denominatorUnits size = 0 and: [ unit numeratorUnits size = 1]) ifTrue: [ newUnit := SingleUnit withName: (unit numeratorUnits) anyOne name andFactor: (unit numeratorUnits) anyOne factor]
																			    ifFalse: [newUnit := unit].
																			
	^Measure withAmount: amount * newAmount andUnit: newUnit.! !

!Measure methodsFor: 'conversion' stamp: 'EF 6/6/2017 19:50:57'!
convertTo: anUnit
		
	(self unit type = anUnit type) ifFalse: [^self error: Measure canNotConvertToUnitErrorMessage].
	^Measure withAmount: ( self normalizeAmount / anUnit factor) andUnit: anUnit.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Measure class' category: #'Measure-Solution'!
Measure class
	instanceVariableNames: ''!

!Measure class methodsFor: 'initialization' stamp: 'EF 6/1/2017 19:38:31'!
withAmount: anAmount andUnit: anUnit

	^self new initializeWith: anAmount and: anUnit.! !


!Measure class methodsFor: 'as yet unclassified' stamp: 'EF 6/4/2017 22:55:32'!
canNotConvertToUnitErrorMessage
	
	^'Can not convert to this unit'! !


!classDefinition: #MeasureFactory category: #'Measure-Solution'!
Object subclass: #MeasureFactory
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureFactory class' category: #'Measure-Solution'!
MeasureFactory class
	instanceVariableNames: ''!

!MeasureFactory class methodsFor: 'distance units' stamp: 'EF 6/8/2017 15:31:52'!
centimeter

	^SingleUnit withName: 'centimeter' andFactor: 1/100 andType: 'distance'.
! !

!MeasureFactory class methodsFor: 'distance units' stamp: 'EF 6/8/2017 15:32:16'!
decameter

	^SingleUnit withName: 'decameter' andFactor: 1/10 andType: 'distance'.
! !

!MeasureFactory class methodsFor: 'distance units' stamp: 'EF 6/8/2017 15:32:56'!
hectometer

	^SingleUnit withName: 'hectometer' andFactor: 100 andType: 'distance'.
! !

!MeasureFactory class methodsFor: 'distance units' stamp: 'EF 6/8/2017 15:34:34'!
kilometer

	^SingleUnit withName: 'kilometer' andFactor: 1000 andType: 'distance'.
! !

!MeasureFactory class methodsFor: 'distance units' stamp: 'EF 6/8/2017 15:34:47'!
meter

	^SingleUnit withName: 'meter' andFactor: 1 andType: 'distance'.
! !

!MeasureFactory class methodsFor: 'distance units' stamp: 'EF 6/8/2017 15:34:59'!
millimeter

	^SingleUnit withName: 'millimeter' andFactor: 1/1000 andType: 'distance'.
! !


!MeasureFactory class methodsFor: 'distance measures' stamp: 'EF 6/8/2017 15:40:21'!
minusOneMeter

	^ Measure withAmount: -1 andUnit: (MeasureFactory meter). ! !

!MeasureFactory class methodsFor: 'distance measures' stamp: 'EF 6/8/2017 15:40:36'!
oneCentimeter

	^ Measure withAmount: 1 andUnit: (MeasureFactory centimeter). ! !

!MeasureFactory class methodsFor: 'distance measures' stamp: 'EF 6/8/2017 15:40:50'!
oneHundredCentimeters

	^ Measure withAmount: 100 andUnit: (MeasureFactory centimeter). ! !

!MeasureFactory class methodsFor: 'distance measures' stamp: 'EF 6/8/2017 15:40:57'!
oneMeter

	^ Measure withAmount: 1 andUnit: (MeasureFactory meter). ! !

!MeasureFactory class methodsFor: 'distance measures' stamp: 'EF 6/8/2017 15:41:09'!
twoHundredCentimeters

	^ Measure withAmount: 200 andUnit: (MeasureFactory centimeter). ! !

!MeasureFactory class methodsFor: 'distance measures' stamp: 'EF 6/8/2017 15:41:18'!
twoMeters

	^ Measure withAmount: 2 andUnit: (MeasureFactory meter). ! !

!MeasureFactory class methodsFor: 'distance measures' stamp: 'EF 6/8/2017 15:41:28'!
zeroMeters

	^ Measure withAmount: 0 andUnit: (MeasureFactory meter). ! !


!MeasureFactory class methodsFor: 'temperature units' stamp: 'EF 6/8/2017 15:27:21'!
celsius

	^SingleUnit withName: 'celcius' andFactor: 0 andType: 'temperature'.
! !

!MeasureFactory class methodsFor: 'temperature units' stamp: 'EF 6/8/2017 15:27:36'!
fahrenheit

	^SingleUnit withName: 'fahrenheit' andFactor: -32 andType: 'temperature'.
! !

!MeasureFactory class methodsFor: 'temperature units' stamp: 'EF 6/8/2017 15:27:48'!
kelvin

	^SingleUnit withName: 'kelvin' andFactor: -273 andType: 'temperature'.
! !


!MeasureFactory class methodsFor: 'temperature measures' stamp: 'EF 6/8/2017 15:42:01'!
oneCelsius

	^ Measure withAmount: 1 andUnit: (MeasureFactory celsius). ! !

!MeasureFactory class methodsFor: 'temperature measures' stamp: 'EF 6/8/2017 15:42:13'!
thirtyTwoFahrenheits

	^ Measure withAmount: 32 andUnit: (MeasureFactory fahrenheit). ! !

!MeasureFactory class methodsFor: 'temperature measures' stamp: 'EF 6/8/2017 15:42:19'!
twoCelsius

	^ Measure withAmount: 2 andUnit: (MeasureFactory celsius). ! !

!MeasureFactory class methodsFor: 'temperature measures' stamp: 'EF 6/8/2017 15:42:24'!
zeroCelsius

	^ Measure withAmount: 0 andUnit: (MeasureFactory celsius). ! !

!MeasureFactory class methodsFor: 'temperature measures' stamp: 'EF 6/8/2017 15:42:31'!
zeroKelvin

	^ Measure withAmount: 0 andUnit: (MeasureFactory kelvin). ! !


!MeasureFactory class methodsFor: 'time units' stamp: 'EF 6/8/2017 15:36:16'!
day

	^SingleUnit withName: 'day' andFactor: 24 andType: 'time'.
! !

!MeasureFactory class methodsFor: 'time units' stamp: 'EF 6/8/2017 15:36:33'!
hour

	^SingleUnit withName: 'hour' andFactor: 1 andType: 'time'.
! !

!MeasureFactory class methodsFor: 'time units' stamp: 'EF 6/8/2017 15:36:52'!
minute

	^SingleUnit withName: 'minute' andFactor: 1/60 andType: 'time'.
! !

!MeasureFactory class methodsFor: 'time units' stamp: 'EF 6/8/2017 15:37:49'!
second

	^SingleUnit withName: 'second' andFactor: 1/3600 andType: 'time'.
! !


!MeasureFactory class methodsFor: 'formula' stamp: 'EF 6/8/2017 02:21:07'!
finalSpeedStartingAt: initialVel accelerating: acceleration during: time

	^initialVel + (acceleration * time)! !


!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:42:47'!
oneDay

	^ Measure withAmount: 1 andUnit: (MeasureFactory day). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:42:56'!
oneHour

	^ Measure withAmount: 1 andUnit: (MeasureFactory hour). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:43:02'!
oneMinute

	^ Measure withAmount: 1 andUnit: (MeasureFactory minute). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:43:08'!
oneSecond

	^ Measure withAmount: 1 andUnit: (MeasureFactory second). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:43:20'!
sixtyMinutes

	^ Measure withAmount: 1 andUnit: (MeasureFactory minute). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:43:57'!
sixtyOneSeconds

	^ Measure withAmount: 61 andUnit: (MeasureFactory second). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:44:09'!
sixtySeconds

	^ Measure withAmount: 60 andUnit: (MeasureFactory second). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:44:19'!
twentyFourHours

	^ Measure withAmount: 24 andUnit: (MeasureFactory hour). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:44:24'!
twoSeconds

	^ Measure withAmount: 2 andUnit: (MeasureFactory second). ! !

!MeasureFactory class methodsFor: 'time measures' stamp: 'EF 6/8/2017 15:44:32'!
zeroSeconds

	^ Measure withAmount: 0 andUnit: (MeasureFactory second). ! !


!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:48:59'!
eightCubicMeters
	
	|meterUnit|
	
	meterUnit := MeasureFactory meter.
	^ Measure withAmount: 8 andUnit: meterUnit*meterUnit*meterUnit. 
	! !

!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:49:42'!
fourSquaredMeters

	|meterUnit|
	
	meterUnit := MeasureFactory meter.
	^ Measure withAmount: 4 andUnit: meterUnit*meterUnit.! !

!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:50:26'!
oneHundredTwentyMetersPerSecond

	|meterUnit secondUnit|
	
	meterUnit := MeasureFactory meter.
	secondUnit := MeasureFactory second.
	^ Measure withAmount: 120 andUnit: meterUnit*secondUnit.! !

!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:50:55'!
oneMeterPerSecond

	|meterUnit secondUnit|
	
	meterUnit := MeasureFactory meter.
	secondUnit := MeasureFactory second.
	^ Measure withAmount: 1 andUnit: meterUnit*secondUnit.! !

!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:51:45'!
oneSquaredMeter

	|meterUnit|
	
	meterUnit := MeasureFactory meter.
	^ Measure withAmount: 1 andUnit: meterUnit*meterUnit.! !

!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:52:10'!
oneSquaredSecond

	|secondUnit|
	
	secondUnit := MeasureFactory second.
	^ Measure withAmount: 1 andUnit: secondUnit*secondUnit.! !

!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:52:46'!
twoMetersBySecond
	
	|meterUnit secondUnit|
	
	meterUnit := MeasureFactory meter.
	secondUnit := MeasureFactory second.
	^ Measure withAmount: 2 andUnit: meterUnit/secondUnit.! !

!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:53:25'!
twoMetersPerSquaredSecond

	|meterUnit secondUnit|
	
	meterUnit := MeasureFactory meter.
	secondUnit := MeasureFactory second.
	^ Measure withAmount: 2 andUnit: meterUnit/ secondUnit * secondUnit.! !

!MeasureFactory class methodsFor: 'compound measures' stamp: 'EF 6/8/2017 15:56:02'!
twoMetersTimesSecond

	|meterUnit secondUnit|
	
	meterUnit := MeasureFactory meter.
	secondUnit := MeasureFactory second.
	^ (Measure withAmount: 2 andUnit: meterUnit) * secondUnit.! !


!classDefinition: #MeasureSumatory category: #'Measure-Solution'!
Object subclass: #MeasureSumatory
	instanceVariableNames: 'measures'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!MeasureSumatory methodsFor: 'operations' stamp: 'EF 6/6/2017 20:15:10'!
+ aMeasure

	measures detect: [:current | current unit type = aMeasure unit type] ifFound: [:elem | measures add: (elem + aMeasure). measures remove: elem.] ifNone:[measures add: aMeasure.].! !

!MeasureSumatory methodsFor: 'operations' stamp: 'EF 6/6/2017 20:14:57'!
- aMeasure

	measures detect: [:current | current unit type = aMeasure unit type] ifFound: [:elem | measures add: (elem - aMeasure). measures remove: elem.] ifNone:[measures add: aMeasure negated].
! !


!MeasureSumatory methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:32:47'!
initialize

	measures := Set new.! !

!MeasureSumatory methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:42:27'!
initializeWith: aMeasure

	measures := Set with: aMeasure.! !

!MeasureSumatory methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:42:38'!
initializeWith: aMeasure with: anotherMeasure

	measures := Set with: aMeasure with: anotherMeasure.! !

!MeasureSumatory methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:42:55'!
initializeWith: aMeasure with: anotherMeasure with: otherMeasure

	measures := Set with: aMeasure with: anotherMeasure with: otherMeasure.! !


!MeasureSumatory methodsFor: 'comparing' stamp: 'EF 6/6/2017 20:27:15'!
= anotherMeasureSet
	
	^measures = anotherMeasureSet measures! !


!MeasureSumatory methodsFor: 'accessing' stamp: 'EF 6/6/2017 20:27:34'!
measures

	^measures! !


!MeasureSumatory methodsFor: 'adding' stamp: 'EF 6/6/2017 20:36:16'!
add: aMeasure

	measures detect: [:current | current unit type = aMeasure unit type] ifFound: [:elem | measures add: (elem + aMeasure). measures remove: elem.] ifNone:[measures add: aMeasure.].
	^self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MeasureSumatory class' category: #'Measure-Solution'!
MeasureSumatory class
	instanceVariableNames: ''!

!MeasureSumatory class methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:42:06'!
with: aMeasure 

	^self new initializeWith: aMeasure! !

!MeasureSumatory class methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:43:37'!
with: aMeasure with: anotherMeasure 

	^self new initializeWith: aMeasure with: anotherMeasure! !

!MeasureSumatory class methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:43:33'!
with: aMeasure with: anotherMeasure with: otherMeasure

	^self new initializeWith: aMeasure with: anotherMeasure with: otherMeasure ! !


!classDefinition: #OOMeasureState category: #'Measure-Solution'!
Object subclass: #OOMeasureState
	instanceVariableNames: 'measure'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!OOMeasureState methodsFor: 'initialization' stamp: 'EF 6/8/2017 12:53:52'!
initializeFor: aMeasure

	measure := aMeasure! !


!OOMeasureState methodsFor: 'measure operations' stamp: 'EF 6/8/2017 13:06:51'!
* aMultiplier

	self subclassResponsibility ! !

!OOMeasureState methodsFor: 'measure operations' stamp: 'EF 6/8/2017 13:06:45'!
/ aDivisor

	self subclassResponsibility ! !


!OOMeasureState methodsFor: 'measure normalization' stamp: 'EF 6/8/2017 15:14:32'!
normalizeAmount

	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOMeasureState class' category: #'Measure-Solution'!
OOMeasureState class
	instanceVariableNames: ''!

!OOMeasureState class methodsFor: 'state selection' stamp: 'EF 6/8/2017 12:51:17'!
canHandle: aMeasure

	self subclassResponsibility ! !

!OOMeasureState class methodsFor: 'state selection' stamp: 'EF 6/8/2017 12:50:45'!
stateFor: aMeasure

	^(self subclasses detect: [:aMeasureStateClass | aMeasureStateClass canHandle: aMeasure ]) for: aMeasure! !


!OOMeasureState class methodsFor: 'instance creation' stamp: 'EF 6/8/2017 12:51:05'!
for: aMeasure

	^self new initializeFor: aMeasure! !


!classDefinition: #OOWithCompoundUnitMeasureState category: #'Measure-Solution'!
OOMeasureState subclass: #OOWithCompoundUnitMeasureState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!OOWithCompoundUnitMeasureState methodsFor: 'measure operations' stamp: 'EF 6/8/2017 14:17:58'!
* aMultiplier

	^measure multiplyWhenHasCompoundUnit: aMultiplier.! !

!OOWithCompoundUnitMeasureState methodsFor: 'measure operations' stamp: 'EF 6/8/2017 14:17:55'!
/ aDivisor
	
	^measure divideWhenHasCompoundUnit: aDivisor.
	! !


!OOWithCompoundUnitMeasureState methodsFor: 'measure comparing' stamp: 'EF 6/8/2017 14:17:51'!
= anotherMeasure

	^measure equalsWhenHasCompoundUnit: anotherMeasure! !


!OOWithCompoundUnitMeasureState methodsFor: 'measure convertion' stamp: 'EF 6/8/2017 14:26:11'!
canConvertTo: anUnit

	^measure canConvertToUnitWhenHasCompUnit: anUnit! !


!OOWithCompoundUnitMeasureState methodsFor: 'measure normalization' stamp: 'EF 6/8/2017 15:16:02'!
normalizeAmount

	^measure normalizeAmountWhenHasCompoundUnit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOWithCompoundUnitMeasureState class' category: #'Measure-Solution'!
OOWithCompoundUnitMeasureState class
	instanceVariableNames: ''!

!OOWithCompoundUnitMeasureState class methodsFor: 'state selection' stamp: 'EF 6/8/2017 13:06:16'!
canHandle: aMeasure

	^aMeasure unit isKindOf: CompoundUnit! !


!classDefinition: #OOWithSingleUnitMeasureState category: #'Measure-Solution'!
OOMeasureState subclass: #OOWithSingleUnitMeasureState
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!OOWithSingleUnitMeasureState methodsFor: 'measure operations' stamp: 'EF 6/8/2017 13:46:40'!
* aMultiplier
	
	^measure multiplyWhenHasSingleUnit: aMultiplier! !

!OOWithSingleUnitMeasureState methodsFor: 'measure operations' stamp: 'EF 6/8/2017 13:45:09'!
/ aDivisor
	
	^measure divideWhenHasSingleUnit: aDivisor.
	
	! !


!OOWithSingleUnitMeasureState methodsFor: 'measure comparing' stamp: 'EF 6/8/2017 14:09:19'!
= anotherMeasure

	^measure equalsWhenHasSingleUnit: anotherMeasure.! !


!OOWithSingleUnitMeasureState methodsFor: 'measure convertion' stamp: 'EF 6/8/2017 14:26:32'!
canConvertTo: anUnit

	^measure canConvertToUnitWhenHasSingleUnit: anUnit! !


!OOWithSingleUnitMeasureState methodsFor: 'measure normalization' stamp: 'EF 6/8/2017 15:16:21'!
normalizeAmount

	^measure normalizeAmountWhenHasSingleUnit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOWithSingleUnitMeasureState class' category: #'Measure-Solution'!
OOWithSingleUnitMeasureState class
	instanceVariableNames: ''!

!OOWithSingleUnitMeasureState class methodsFor: 'state selection' stamp: 'EF 6/8/2017 13:05:58'!
canHandle: aMeasure

	^aMeasure unit isKindOf: SingleUnit! !


!classDefinition: #Unit category: #'Measure-Solution'!
Object subclass: #Unit
	instanceVariableNames: 'name type'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!Unit methodsFor: 'accessing' stamp: 'EF 6/6/2017 21:03:35'!
factor 
	
	^ self subclassResponsibility! !

!Unit methodsFor: 'accessing' stamp: 'EF 6/1/2017 21:33:54'!
printString
	
	^name! !

!Unit methodsFor: 'accessing' stamp: 'EF 6/6/2017 23:00:07'!
type
	
	^ self subclassResponsibility! !


!Unit methodsFor: 'comparing' stamp: 'EF 6/6/2017 21:02:33'!
= anUnit

	^ self subclassResponsibility! !


!Unit methodsFor: 'converting' stamp: 'EF 6/6/2017 21:02:15'!
* anUnit 
	
	^ self subclassResponsibility! !

!Unit methodsFor: 'converting' stamp: 'EF 6/6/2017 21:02:24'!
/ anUnit 
	
	^ self subclassResponsibility! !

!Unit methodsFor: 'converting' stamp: 'EF 6/6/2017 21:02:50'!
adaptToNumber: aScalar andSend: aSelector 
	
	^ self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Unit class' category: #'Measure-Solution'!
Unit class
	instanceVariableNames: ''!

!Unit class methodsFor: 'initialization' stamp: 'EF 6/1/2017 19:38:22'!
withName: aName andFactor: aFactor
	
	^self new initializeWith: aName and: aFactor.
	! !

!Unit class methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:12:28'!
withName: aName andFactor: aFactor andType: aType
	
	^self new initializeWith: aName and: aFactor and: aType.
	! !


!classDefinition: #CompoundUnit category: #'Measure-Solution'!
Unit subclass: #CompoundUnit
	instanceVariableNames: 'numeratorUnits denominatorUnits'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!CompoundUnit methodsFor: 'initialization' stamp: 'EF 6/6/2017 21:21:25'!
initializeWith: aName andNumeratorUnits: someUnits andDenominatorUnits: otherUnits
	
	name := aName.
	numeratorUnits := someUnits.
	denominatorUnits := otherUnits.! !


!CompoundUnit methodsFor: 'accessing' stamp: 'EF 6/6/2017 21:13:56'!
denominatorUnits
	
	^denominatorUnits.! !

!CompoundUnit methodsFor: 'accessing' stamp: 'EF 6/6/2017 21:13:45'!
numeratorUnits
	
	^numeratorUnits.! !

!CompoundUnit methodsFor: 'accessing' stamp: 'ek 6/8/2017 18:52:38'!
postCopy
	
	name := name copy.
	numeratorUnits := numeratorUnits copy.
	denominatorUnits := denominatorUnits copy.
	type := type copy.! !

!CompoundUnit methodsFor: 'accessing' stamp: 'EF 6/6/2017 21:01:06'!
printString
	
	^name! !

!CompoundUnit methodsFor: 'accessing' stamp: 'EF 6/6/2017 21:01:06'!
type
	
	^type.! !


!CompoundUnit methodsFor: 'comparing' stamp: 'EF 6/6/2017 23:29:13'!
= anotherCompoundUnit
	
	^numeratorUnits = anotherCompoundUnit numeratorUnits and: [denominatorUnits = anotherCompoundUnit denominatorUnits]! !


!CompoundUnit methodsFor: 'converting' stamp: 'ek 6/7/2017 23:10:21'!
* anUnit 

	(anUnit isKindOf: CompoundUnit) ifTrue: [numeratorUnits addAll: anUnit numeratorUnits. denominatorUnits addAll: anUnit denominatorUnits.] ifFalse: [numeratorUnits add: anUnit].
	^ CompoundUnit withName: (name , '*' , anUnit name) andNumeratorUnits: numeratorUnits andDenominatorUnits: denominatorUnits.! !

!CompoundUnit methodsFor: 'converting' stamp: 'ek 6/8/2017 18:46:52'!
/ anUnit 
	
	(anUnit isKindOf: CompoundUnit) ifTrue: [ numeratorUnits addAll: anUnit denominatorUnits. denominatorUnits addAll: anUnit numeratorUnits.] ifFalse: [ numeratorUnits add: anUnit].
	^ CompoundUnit withName: (name , '/' , anUnit name) andNumeratorUnits: numeratorUnits andDenominatorUnits: denominatorUnits.! !

!CompoundUnit methodsFor: 'converting' stamp: 'EF 6/6/2017 21:01:06'!
adaptToNumber: aScalar andSend: aSelector 
	
	^Measure withAmount: aScalar andUnit: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CompoundUnit class' category: #'Measure-Solution'!
CompoundUnit class
	instanceVariableNames: ''!

!CompoundUnit class methodsFor: 'initialization' stamp: 'EF 6/6/2017 21:22:42'!
withName: aName andNumeratorUnits: numeratorUnits andDenominatorUnits: denominatorUnits
	
	^self new initializeWith: aName andNumeratorUnits: numeratorUnits andDenominatorUnits: denominatorUnits.
	! !


!classDefinition: #SingleUnit category: #'Measure-Solution'!
Unit subclass: #SingleUnit
	instanceVariableNames: 'factor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Measure-Solution'!

!SingleUnit methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:59:39'!
initializeWith: aName and: aFactor and: aType

	name := aName.
	factor := aFactor.
	type := aType.! !


!SingleUnit methodsFor: 'accessing' stamp: 'EF 6/6/2017 20:59:39'!
factor 
	
	^factor.! !

!SingleUnit methodsFor: 'accessing' stamp: 'ek 6/8/2017 18:51:07'!
postCopy
	
	type := type copy.
	name := name copy.
	factor := factor copy.! !

!SingleUnit methodsFor: 'accessing' stamp: 'EF 6/6/2017 20:59:39'!
printString
	
	^name! !

!SingleUnit methodsFor: 'accessing' stamp: 'EF 6/6/2017 20:59:39'!
type
	
	^type.! !


!SingleUnit methodsFor: 'comparing' stamp: 'EF 6/6/2017 20:59:39'!
= anUnit

	^factor = anUnit factor! !


!SingleUnit methodsFor: 'converting' stamp: 'ek 6/8/2017 17:47:58'!
* anUnit 
		
	(anUnit isKindOf: CompoundUnit) ifTrue: [ anUnit numeratorUnits add: self.
														^CompoundUnit withName: (self name, anUnit name) andNumeratorUnits: anUnit numeratorUnits andDenominatorUnits: anUnit denominatorUnits].
	^CompoundUnit withName: (name , '*' , anUnit name) andNumeratorUnits: (Bag with: self with: anUnit) andDenominatorUnits: Bag new.! !

!SingleUnit methodsFor: 'converting' stamp: 'EF 6/6/2017 23:37:13'!
/ anUnit 
	
	^ CompoundUnit withName: (name , '/' , anUnit name) andNumeratorUnits: (Bag with: self) andDenominatorUnits: (Bag with: anUnit).! !

!SingleUnit methodsFor: 'converting' stamp: 'EF 6/6/2017 20:59:39'!
adaptToNumber: aScalar andSend: aSelector 
	
	^Measure withAmount: aScalar andUnit: self. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SingleUnit class' category: #'Measure-Solution'!
SingleUnit class
	instanceVariableNames: ''!

!SingleUnit class methodsFor: 'initialization' stamp: 'EF 6/6/2017 20:59:39'!
withName: aName andFactor: aFactor andType: aType
	
	^self new initializeWith: aName and: aFactor and: aType.
	! !
