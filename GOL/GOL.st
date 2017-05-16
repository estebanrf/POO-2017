!classDefinition: #GOLTest category: #GOL!
TestCase subclass: #GOLTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:07'!
test01AliveCellWithLessThanTwoAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1 }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:14'!
test02AliveCellWithTwoAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:19'!
test03AliveCellWithThreeAliveNeighStaysAlive

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. }  withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:14:25'!
test04AliveCellWithMoreThanThreeAliveNeighDies

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 1@1. 2@0. 1@0. 1@2. 0@1 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self assert: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:01:13'!
test05DeadCellWithThreeAliveNeighResurects

	|gameOfLife |
	
	gameOfLife := GameOfLife withLiveCells: { 2@0. 1@0. 0@0 } withSize: 3@3.
	gameOfLife nextGeneration.
	
	self deny: (gameOfLife isDeadAt: 1@1) ! !

!GOLTest methodsFor: 'as yet unclassified' stamp: 'EF 5/15/2017 21:34:31'!
test06CanNotCreateCellOutsideBounds

	self 
		should: [ GameOfLife withLiveCells: { 2@0. 1@0. 1@4 } withSize: 3@3 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: 'celda fuera de rango' ]! !


!classDefinition: #GameOfLife category: #GOL!
Object subclass: #GameOfLife
	instanceVariableNames: 'aliveCells size'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'GOL'!

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'EF 5/15/2017 14:01:47'!
aliveCellsThatSurvive

	^(aliveCells select: [ :aCell | self hasToSurvive: aCell ])! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'EF 5/15/2017 12:28:11'!
boardContains: aCell
	
	^((aCell x between: 0 and: size x) and: [ aCell y between: 0 and: size y])! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/12/2017 09:10:31'!
deadCells
	
	| deadCells |
	
	deadCells _ OrderedCollection new.
	0 to: size x do: [ :x |
		0 to: size y do: [ :y |
			(aliveCells includes: x@y) not ifTrue: [ deadCells add: x@y]]].
	^deadCells ! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'EF 5/15/2017 14:02:08'!
deadCellsThatResurrect

	^(self deadCells select: [ :aDeadCell | self hasToResurrect: aDeadCell ])! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 21:11:17'!
hasToResurrect: aCell

	^(self numberOfAliveNeighboursOf: aCell) = 3! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 19:57:05'!
hasToSurvive: aCell
	
	| numberOfAliveNeighbours|
	
	numberOfAliveNeighbours := self numberOfAliveNeighboursOf: aCell.
	
	^numberOfAliveNeighbours = 2 or:  [numberOfAliveNeighbours = 3]! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'EF 5/15/2017 12:28:02'!
initializeWith: aCollectionOfAliveCells withSize: aSize

	size := aSize.
	aliveCells := aCollectionOfAliveCells.
	(aliveCells allSatisfy: [:aCell |
		self boardContains: aCell]) ifFalse: [ self error: 'celda fuera de rango' ]! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:28:24'!
isDeadAt: aCell

	^(aliveCells includes: aCell) not! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'EF 5/15/2017 14:02:33'!
nextGeneration
	
	aliveCells := self aliveCellsThatSurvive union:
		self deadCellsThatResurrect! !

!GameOfLife methodsFor: 'as yet unclassified' stamp: 'HAW 5/10/2017 10:29:35'!
numberOfAliveNeighboursOf: aCell

	^(aCell eightNeighbors intersection: aliveCells) size! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'GameOfLife class' category: #GOL!
GameOfLife class
	instanceVariableNames: ''!

!GameOfLife class methodsFor: 'as yet unclassified' stamp: 'HAW 5/11/2017 20:38:14'!
withLiveCells: aCollectionOfAliveCells withSize: aPoint 
	
	^self new initializeWith: aCollectionOfAliveCells withSize: aPoint ! !
