!classDefinition: #TestMarsRover category: 'Mars Rover'!
TestCase subclass: #TestMarsRover
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!TestMarsRover methodsFor: 'testing' stamp: 'fdp 11/3/2022 20:32:05'!
test01RoverDoesntMoveWithEmptyCommand
	| rover |
	rover := MarsRover at: 1@1 pointing: 'N'.
	rover move: ''.
	self assert: (rover position = (1@1)).
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'fdp 11/3/2022 20:33:38'!
test02RoverMovesBackWhilePointingNorth
	| rover |
	rover := MarsRover at: 1@1 pointing: 'N'.
	rover move: 'b'.
	self assert: (rover position = (1@2)).
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'fdp 11/3/2022 20:34:43'!
test03RoverRotatesRightFromNorth
	| rover |
	rover := MarsRover at: 2@2 pointing: 'N'.
	rover move: 'r'.
	self assert: (rover pointingTo = 'E').
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'fdp 11/3/2022 20:35:11'!
test04RoverRotatesLeftFromNorth
	| rover |
	rover := MarsRover at: 2@2 pointing: 'N'.
	rover move: 'l'.
	self assert: (rover pointingTo = 'O').
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'fdp 11/3/2022 20:35:26'!
test05RoverRotatesLeftFromSouth
	| rover |
	rover := MarsRover at: 2@2 pointing: 'S'.
	rover move: 'l'.
	self assert: (rover pointingTo = 'E').
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'fdp 11/3/2022 20:35:48'!
test06RoverMovesForwardWhilePointingWest
	| rover |
	rover := MarsRover at: 2@2 pointing: 'O'.
	rover move: 'f'.
	self assert: (rover position = (1@2)).
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'fdp 11/3/2022 20:36:06'!
test07RoverMovesBackWhilePointingEast
	| rover |
	rover := MarsRover at: 2@2 pointing: 'E'.
	rover move: 'b'.
	self assert: (rover position = (1@2)).
	! !

!TestMarsRover methodsFor: 'testing' stamp: 'FDP 11/4/2022 14:25:34'!
test08RoverMovesWithSeveralCommands
	| rover |
	rover := MarsRover at: 2@2 pointing: 'N'.
	rover move: 'brf'.
	self assert: (rover position = (3@3)).! !

!TestMarsRover methodsFor: 'testing' stamp: 'FDP 11/4/2022 14:26:43'!
test09RoverDoesntUnderstandInvalidInput
	| rover |
	rover := MarsRover at: 2@2 pointing: 'N'.
	self should: [rover move: 'x']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = MarsRover commandNotUnderstood].! !

!TestMarsRover methodsFor: 'testing' stamp: 'FDP 11/4/2022 14:27:40'!
test10RoverMovesBeforeInvalidInput
	| rover |
	rover := MarsRover at: 2@2 pointing: 'N'.
	self should: [rover move: 'bñ']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [:anError | 
			self assert: anError messageText = MarsRover commandNotUnderstood].
	self assert: (rover position = (2@3))! !


!classDefinition: #MarsRover category: 'Mars Rover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!MarsRover methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:26:28'!
move: aCommandString
	aCommandString do: [: char | ('bfrl' includes: char) ifFalse: [^MarsRover error: MarsRover commandNotUnderstood ]. 
							direction move: char TheRover: self].
! !


!MarsRover methodsFor: 'initialization' stamp: 'fdp 11/3/2022 20:28:53'!
initializeAt: aPoint PointingTo: aCardinalDirection
	position := aPoint.
	direction := RoverCardinalDirection with: aCardinalDirection.
	! !


!MarsRover methodsFor: 'accessing' stamp: 'fdp 11/3/2022 20:21:43'!
direction: aNewCardinalDirection
	direction := aNewCardinalDirection.! !

!MarsRover methodsFor: 'accessing' stamp: 'fdp 11/3/2022 20:22:55'!
pointingTo
	^direction sign.! !

!MarsRover methodsFor: 'accessing' stamp: 'fdp 11/3/2022 18:55:08'!
position
	^position.! !

!MarsRover methodsFor: 'accessing' stamp: 'fdp 11/3/2022 20:09:47'!
position: aNewPosition
	position := aNewPosition.! !


!MarsRover methodsFor: 'private - DD' stamp: 'FDP 11/4/2022 14:32:33'!
movePositionXBy: anInteger
	self position: ((position x + anInteger)@(position y)).! !

!MarsRover methodsFor: 'private - DD' stamp: 'FDP 11/4/2022 14:33:30'!
movePositionYBy: anInteger
	self position: ((position x)@(position y + anInteger)).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'Mars Rover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'class initialization' stamp: 'fdp 11/3/2022 19:51:02'!
at: aPoint pointing: aCardinalDirection
	^self new initializeAt: aPoint PointingTo: aCardinalDirection. 
	! !


!MarsRover class methodsFor: 'error messages' stamp: 'fdp 11/3/2022 21:13:45'!
commandNotUnderstood
	^'CommandString has invalid character'.! !


!classDefinition: #RoverCardinalDirection category: 'Mars Rover'!
Object subclass: #RoverCardinalDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!RoverCardinalDirection methodsFor: 'accessing' stamp: 'fdp 11/3/2022 20:23:27'!
sign
	self subclassResponsibility.! !


!RoverCardinalDirection methodsFor: 'movement' stamp: 'fdp 11/3/2022 20:39:41'!
move: aCommand TheRover: aRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverCardinalDirection class' category: 'Mars Rover'!
RoverCardinalDirection class
	instanceVariableNames: ''!

!RoverCardinalDirection class methodsFor: 'class initialization' stamp: 'FDP 11/4/2022 14:07:29'!
isDirection: aCardinalDirectionSign
	self subclassResponsibility.! !

!RoverCardinalDirection class methodsFor: 'class initialization' stamp: 'FDP 11/4/2022 14:06:52'!
with: aCardinalDirection
	
	
	^(RoverCardinalDirection subclasses detect: [:subclass | subclass isDirection: aCardinalDirection]) new.
		
	! !


!classDefinition: #EastDirection category: 'Mars Rover'!
RoverCardinalDirection subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!EastDirection methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:48:10'!
move: aCommand TheRover: aRover
	(RoverMovement with: aCommand) moveEastPointingRover: aRover. 
! !


!EastDirection methodsFor: 'accessing' stamp: 'fdp 11/3/2022 20:23:48'!
sign
	^'E'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EastDirection class' category: 'Mars Rover'!
EastDirection class
	instanceVariableNames: ''!

!EastDirection class methodsFor: 'class initialization' stamp: 'FDP 11/4/2022 14:08:07'!
isDirection: aCardinalDirectionSign
	^aCardinalDirectionSign = 'E'.! !


!classDefinition: #NorthDirection category: 'Mars Rover'!
RoverCardinalDirection subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!NorthDirection methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:41:42'!
move: aCommand TheRover: aRover

		(RoverMovement with: aCommand) moveNorthPointingRover: aRover. 
		! !


!NorthDirection methodsFor: 'accessing' stamp: 'fdp 11/3/2022 20:23:55'!
sign
	^'N'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NorthDirection class' category: 'Mars Rover'!
NorthDirection class
	instanceVariableNames: ''!

!NorthDirection class methodsFor: 'class initialization' stamp: 'FDP 11/4/2022 14:08:17'!
isDirection: aCardinalDirectionSign
	^aCardinalDirectionSign = 'N'.! !


!classDefinition: #SouthDirection category: 'Mars Rover'!
RoverCardinalDirection subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!SouthDirection methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:48:39'!
move: aCommand TheRover: aRover
	(RoverMovement with: aCommand) moveSouthPointingRover: aRover. 
! !


!SouthDirection methodsFor: 'accessing' stamp: 'fdp 11/3/2022 20:24:06'!
sign
	^'S'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SouthDirection class' category: 'Mars Rover'!
SouthDirection class
	instanceVariableNames: ''!

!SouthDirection class methodsFor: 'class initialization' stamp: 'FDP 11/4/2022 14:08:23'!
isDirection: aCardinalDirectionSign
	^aCardinalDirectionSign = 'S'.! !


!classDefinition: #WestDirection category: 'Mars Rover'!
RoverCardinalDirection subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!WestDirection methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:52:13'!
move: aCommand TheRover: aRover
	(RoverMovement with: aCommand) moveWestPointingRover: aRover. 
! !


!WestDirection methodsFor: 'accessing' stamp: 'fdp 11/3/2022 20:24:12'!
sign
	^'O'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WestDirection class' category: 'Mars Rover'!
WestDirection class
	instanceVariableNames: ''!

!WestDirection class methodsFor: 'class initialization' stamp: 'FDP 11/4/2022 14:08:30'!
isDirection: aCardinalDirectionSign
	^aCardinalDirectionSign = 'O'.! !


!classDefinition: #RoverMovement category: 'Mars Rover'!
Object subclass: #RoverMovement
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!RoverMovement methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:46:10'!
moveEastPointingRover: aRover
	self subclassResponsibility.! !

!RoverMovement methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:38:53'!
moveNorthPointingRover: aRover
	self subclassResponsibility.! !

!RoverMovement methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:58:15'!
moveSouthPointingRover: aRover
	self subclassResponsibility.! !

!RoverMovement methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:58:32'!
moveWestPointingRover: aRover
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverMovement class' category: 'Mars Rover'!
RoverMovement class
	instanceVariableNames: ''!

!RoverMovement class methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:10:56'!
isMovement: aMovementSign
	self subclassResponsibility.! !


!RoverMovement class methodsFor: 'class initialization' stamp: 'FDP 11/4/2022 14:12:05'!
with: aMovementSign
	^(RoverMovement subclasses detect: [:subclass | subclass isMovement: aMovementSign]) new.! !


!classDefinition: #RoverBackward category: 'Mars Rover'!
RoverMovement subclass: #RoverBackward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!RoverBackward methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:34:14'!
moveEastPointingRover: aRover
	aRover movePositionXBy: -1! !

!RoverBackward methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:34:50'!
moveNorthPointingRover: aRover
	aRover movePositionYBy: 1! !

!RoverBackward methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:35:05'!
moveSouthPointingRover: aRover
	aRover movePositionYBy: -1! !

!RoverBackward methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:35:21'!
moveWestPointingRover: aRover
	aRover movePositionXBy: 1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverBackward class' category: 'Mars Rover'!
RoverBackward class
	instanceVariableNames: ''!

!RoverBackward class methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:11:26'!
isMovement: aMovementSign
	^aMovementSign = $b.! !


!classDefinition: #RoverForward category: 'Mars Rover'!
RoverMovement subclass: #RoverForward
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!RoverForward methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:35:31'!
moveEastPointingRover: aRover
	aRover movePositionXBy: 1! !

!RoverForward methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:35:45'!
moveNorthPointingRover: aRover
	aRover movePositionYBy: -1! !

!RoverForward methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:35:57'!
moveSouthPointingRover: aRover
	aRover movePositionYBy: 1! !

!RoverForward methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:36:03'!
moveWestPointingRover: aRover
	aRover movePositionXBy: -1! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverForward class' category: 'Mars Rover'!
RoverForward class
	instanceVariableNames: ''!

!RoverForward class methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:11:35'!
isMovement: aMovementSign
	^aMovementSign = $f.! !


!classDefinition: #RoverLeft category: 'Mars Rover'!
RoverMovement subclass: #RoverLeft
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!RoverLeft methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:47:35'!
moveEastPointingRover: aRover
	aRover direction: (RoverCardinalDirection with: 'N').! !

!RoverLeft methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:41:12'!
moveNorthPointingRover: aRover
	aRover direction: (RoverCardinalDirection with: 'O').! !

!RoverLeft methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:54:39'!
moveSouthPointingRover: aRover
	 aRover direction: (RoverCardinalDirection with: 'E').! !

!RoverLeft methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:55:43'!
moveWestPointingRover: aRover
	aRover direction: (RoverCardinalDirection with: 'S').! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverLeft class' category: 'Mars Rover'!
RoverLeft class
	instanceVariableNames: ''!

!RoverLeft class methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:11:41'!
isMovement: aMovementSign
	^aMovementSign = $l.! !


!classDefinition: #RoverRight category: 'Mars Rover'!
RoverMovement subclass: #RoverRight
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Mars Rover'!

!RoverRight methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:47:54'!
moveEastPointingRover: aRover
	aRover direction: (RoverCardinalDirection with: 'S').! !

!RoverRight methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:41:05'!
moveNorthPointingRover: aRover
	aRover direction: (RoverCardinalDirection with: 'E')! !

!RoverRight methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:51:04'!
moveSouthPointingRover: aRover
	aRover direction: (RoverCardinalDirection with: 'O').! !

!RoverRight methodsFor: 'movement' stamp: 'FDP 11/4/2022 13:56:22'!
moveWestPointingRover: aRover
	aRover direction: (RoverCardinalDirection with: 'N').! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RoverRight class' category: 'Mars Rover'!
RoverRight class
	instanceVariableNames: ''!

!RoverRight class methodsFor: 'movement' stamp: 'FDP 11/4/2022 14:11:47'!
isMovement: aMovementSign
	^aMovementSign = $r.! !
