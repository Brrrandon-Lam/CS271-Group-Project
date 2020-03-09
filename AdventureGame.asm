
TITLE Adventure Story Game     (adventureGame.asm)

; Authors: Coral Pease and Brandon Lam
; Course / Project ID: CS271 / Final Project (Adventure Story Game)    Date: 09/03/20
; Description: Program features a user-driven narrative based on random chance and user input.

INCLUDE Irvine32.inc

; Constants
	; Upper and lower bounds for RandomRange calls.
	UPPER_RANGE = 10
	LOWER_RANGE = 1

.data
; Global String Variables
	startGameText		BYTE	"Hello there! We hope you enjoy this text adventure.", 0
	; Introduction Function Variables (Will be used to print text)
	programTitle		BYTE	"Program Title: Adventure Story Game", 0
	programAuthors		BYTE	"Program by Coral Pease and Brandon Lam", 0
	introText1			BYTE	"You wake up in strange place... you see hella trees.", 0
	introText2			BYTE	"You hear a noise behind you. Not wanting to stick around, you decide it best to move.", 0
	introText3			BYTE	"The noise doesn't seem to be getting further away. You're being followed.", 0
	introText4			BYTE	"You come across a fork in the road see two paths.",0
	introText5			BYTE	"One path presents a building, from the other you can hear rushing water.", 0

	; initialBranch Function Variables
	initialChoice		BYTE	"Will you go towards the building (1) or rushing water (2)?", 0

	; Variables for towards building path.
	buildingBranchText1 BYTE	"On your way towards the building, you notice another path.", 0
	buildingBranchText2	BYTE	"(1) You can continue towards the building, you might find help.", 0
	buildingBranchText3	BYTE	"(2) You can break off towards the path and see where it will lead you.",0
	buildingBranchText4	BYTE	"Your pursuer seems to be picking up the pace...", 0

	; buildingPath Function Variables
	buildingPathText1	BYTE	"The building is a house. Certainly abandoned. The noise draws closer.", 0
	buildingPathText2	BYTE	"With no time to run, you decide to enter the abandoned house", 0
	buildingPathText3	BYTE	"What stands out to you is a bed, a closet and a ladder to an attic.", 0
	buildingPathText4	BYTE	"(1) Hiding under the bed seems like a safe bet, but you aren't sure.", 0
	buildingPathText5	BYTE	"(2) Hiding in the closet might throw your pursuer off.", 0
	buildingPathText6	BYTE	"(3) Hiding in the attic might be your only viable option.", 0
	buildingPathText7	BYTE	"The foosteps come closer, time is running out and you must choose!", 0
	buildingPathArt1	BYTE	"  ____||____", 0
	buildingPathArt2	BYTE	" ///////////\", 0
	buildingPathArt3	BYTE	"///////////  \", 0
	buildingPathArt4	BYTE	"|    _    |  |", 0
	buildingPathArt5	BYTE    "|[] | | []|[]|", 0
	buildingPathArt6	BYTE	"|   | |   |  |", 0

	; House Scenario Outcome Variables
	bedText1			BYTE	"You slide under the bed and keep as still as possible.", 0
	bedText2			BYTE	"However, your pursuer simply checks the bed and finds you underneath.", 0
	closetText1			BYTE	"You hide in the closet, praying that you aren't found.",0
	closetText2			BYTE	"You think you're safe, however, as you open the closet to take a peek...", 0
	closetText3			BYTE	"You pursuer opens the closet for you and knocks you out!", 0
	atticText1			BYTE	"Rushing up to the attic, you try your best to keep still.", 0
	atticText2			BYTE	"However, a pack of rats starts to make noise as they've spotted you!", 0
	atticText3			BYTE	"Your pursuer hears the commotion and rushes upstairs...", 0
	atticText4			BYTE	"The rats scurry off having given you away, but there is no escape for you.", 0

	; pathMerge Function Variables
	pathMergeText1		BYTE	"The path is winding and only grows more confusing... is there even a way out?", 0
	pathMergeText2		BYTE	"You can only hope that you end up anywhere but here.", 0
	pathMergeText3		BYTE	"As your sanity begins to fade, hope rises as an end seems to be in sight!", 0

	; Dead End Function Variables
	deadEndText1		BYTE	"You reach the bottom of a cliff. It's a dead end. You're probably screwed.", 0
	deadEndText2		BYTE	"Your pursuer comes closer and you realize you have to confront him.", 0
	deadEndText3		BYTE	"However, the cliffside appears to be scalable", 0
	deadEndText4		BYTE	"(1) Realizing you are doomed, you can try to fight your pursuer.", 0
	deadEndText5		BYTE	"(2) Knowing that your martial skills are limited, you can try climbing.", 0

	; fightOutcome function variables
	fightText1			BYTE	"Dropping those karate lessons was probably a mistake.", 0
	fightText2			BYTE	"Your pursuer approaches and laughs at your stance.", 0
	fightText3			BYTE	"He insults your lack of martial prowess and proceeds to beat you up.", 0
	fightText4			BYTE	"In less than 5 seconds you are knocked out cold. Nice try I guess.", 0

	; Climbing Scenario Conclusion Fucntion Variables
	climbFailText1		BYTE	"You try your best to climb, but you were never a very good climber.", 0
	climbFailText2		BYTE	"You come close to the top! Your freedom is near!", 0
	climbFailText3		BYTE	"However, you lose your footing and fall to your death.", 0
	climbFailText4		BYTE	"A dull thud echoes out for your pursuer to hear.", 0
	climbSuccessText1	BYTE	"You try your best to scale the cliffside", 0
	climbSuccessText2	BYTE	"Being methodical and careful, you finally reach the top...", 0
	climbSuccessText3	BYTE	"It's a town! You are safe for now...", 0
	climbSuccessText4	BYTE	"Perhaps the townsfolk can give you an idea as to where you are.", 0

	; riverPath Function Variables
	riverPathText1		BYTE	"You reach the river you heard. You notice a bridge.", 0
	riverPathText2		BYTE	"The bridge looks like it might fall apart if you try to cross it.",0
	riverPathText3		BYTE	"(1) Maybe you could swim across? The current looks pretty strong.",0
	riverPathText4		BYTE	"(2) You might be able to make it accross the bridge if you're careful.",0
	riverPathText5		BYTE	"Your chaser is getting closer, what do you do?",0

	; Swim conclusion function variables
	swimText1			BYTE	"The bridge seeming too risky, you jump into the river.",0
	swimText2			BYTE	"Ignoring the freezing temperature you swim as fast as you can.",0
	swimText3			BYTE	"Unfortunately, the current is the water is deep and the current is too strong.",0
	swimText4			BYTE	"You make very little progress before you're grabbed from behind. There is no escape.",0

	; Bridge crossing conclusion function variables
	bridgeSuccessText1	BYTE	"Seeing the quick pace of the river's current, you decide it's better to take your chances with the bridge.",0
	bridgeSuccessText2	BYTE	"You start running accross the bridge and hear a loud 'CRACK'. ",0
	bridgeSuccessText3	BYTE	"You run even faster and leap onto the opposite bank just before the entire bridge collapses.",0
	bridgeSuccessText4	BYTE	"You continue running and your pursuer seems to have fallen behind.",0
	bridgeSuccessText5	Byte	"When you slow down for a moment to catch your breath, you notice what looks like a town up ahead.",0
	bridgeSuccessText6	Byte	"You got away. You're safe. For now..",0
	bridgeFailText1		BYTE	"Not being a strong swimmer you immediately head for the bridge.",0
	bridgeFailText2		BYTE	"The bridge is in really rough shape and as you rush accross, you trip and fall hard.",0
	bridgeFailText3		BYTE	"Part of the bridge crumbles into the water, taking you with it.",0
	bridgeFailText4		BYTE	"You hit your head on the way down. You feel the shock of cold as you land in the water."
	bridgeFailText5		Byte	"You see a dark figure approach and loom over you right before you black out.",0

	; Game loop and farewell
	endArt1				BYTE	" _____ _                           _", 0
	endArt2				BYTE	"|_   _| |                         | |", 0
	endArt3				BYTE	"  | | | |__   ___    ___ _ __   __| |", 0
	endArt4				BYTE	"  | | | '_ \ / _ \  / _ \ '_ \ / _` |", 0
	endArt5				BYTE	"  | | | | | |  __/ |  __/ | | | (_| |", 0
	endArt6				BYTE	"  \_/ |_| |_|\___|  \___|_| |_|\__,_|", 0

	gameLoopText1		BYTE	"This concludes our game.", 0
	gameLoopText2		BYTE	"(1) Play again", 0
	gameLoopText3		BYTE	"(2) Quit", 0
	farewellText		BYTE	"Thanks for playing!", 0



.code

; ---------------------------------------------------------
; Description: 
; Receives:  
; Returns: 
; Preconditions: 
; Registers changed: 
; ---------------------------------------------------------

main PROC
	call Randomize					; for random seed

	; First function call is to the introduction, and will be used to print the program title, authors and first set of text.
	; Using stack frame here to demonstrate understanding of how to use it.

	push OFFSET programTitle			; 32
	push OFFSET programAuthors			; 28
	push OFFSET introText1				; 24	
	push OFFSET introText2				; 20
	push OFFSET introText3				; 16
	push OFFSET introText4				; 12
	push OFFSET introText5				; 8
	call introduction

	; Makes a call to the first point in the game where user input impacts the outcome.
	call initialBranch


	exit	; exit to operating system
main ENDP
; ---------------------------------------------------------
; Description: Simply lets the user know that the game has started
; Receives:  Global string variable called startGameText
; Returns: Text
; Preconditions: Program is run 
; Registers changed: edx
; ---------------------------------------------------------
startFunction PROC
	mov edx, OFFSET startGameText
	call WriteString
	call CrLf
startFunction ENDP

; ---------------------------------------------------------
; Description: Prints introductary text to the program
; Receives:  programTitle programAuthor introText1 introText2, introText3, introText4, and introText5 as global string variables
; Returns: Program title, author and intro text.
; Preconditions: Program must successfully have run.  
; Registers changed: ebp, esp, edx
; ---------------------------------------------------------

introduction PROC

	push ebp			; initialize stack frame.
	mov ebp, esp

	mov edx, [ebp+32]
	call WriteString
	call CrLf
	mov	edx, [ebp+28]  
	call WriteString
	call CrLf
	call CrLf
	mov	edx, [ebp+24]  
	call WriteString
	call CrLf
	mov	edx, [ebp+20]  
	call WriteString
	call CrLf
	mov	edx, [ebp+16]
	call WriteString
	call CrLf
	mov	edx, [ebp+12]
	call WriteString
	call CrLf
	mov	edx, [ebp+8]
	call WriteString
	call CrLf
	pop ebp

introduction ENDP

; ---------------------------------------------------------
; Description: Prints the text for this branch while also getting user input to make their first choice.
;			   Then jumps to function corresponding to their choice (1 or 2)
; Receives:  initialChoice (global string variable)
; Returns:	initialChoice text, more text in another function
; Preconditions: Program must have been initialized, intro text must have resolved and this has been called.
; Registers changed: edx, eax
; ---------------------------------------------------------

initialBranch PROC

	mov edx, OFFSET initialChoice
	call WriteString
	call CrLf
	call ReadInt
	call CrLf
	cmp eax, 1				; Comparison equal to 1 (will go to buildingBranch)
	je buildingBranch
	cmp eax, 2				; Comparison equal to 2 (will go to riverPath)
	je riverPath
	jmp initialBranch		; Loops until the input matches 1 or 2.
	ret

initialBranch ENDP

; ---------------------------------------------------------
; Description: User will choose to either go towards the building or continue on another path. Prints text too
; Receives:  buildingBranchText(1-3) as global string variables
; Returns:	Text and a call to another function
; Preconditions: User must have chosen to go towards the building
; Registers changed: edx, eax
; ---------------------------------------------------------

buildingBranch PROC
	mov edx, OFFSET buildingBranchText1
	call WriteString
	call CrLf
	mov edx, OFFSET buildingBranchText2
	call WriteString
	call CrLf
	mov edx, OFFSET buildingBranchText3
	call WriteString
	call CrLf
	call ReadInt
	call CrLf
	cmp eax, 1
	je buildingPath
	cmp eax, 2
	je pathMerge
	jmp buildingBranch
	ret

buildingBranch ENDP


; ---------------------------------------------------------
; Description: Shows a building
; Receives:  buildingPathArt(1-6) as global string variables
; Returns: A picture in string variable format
; Preconditions: user must have chosen this path
; Registers changed: edx
; ---------------------------------------------------------
displayBuildingArt PROC

	mov edx, OFFSET buildingPathArt1
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathArt2
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathArt3
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathArt4
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathArt5
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathArt6
	call WriteString
	call CrLf
	ret

displayBuildingArt ENDP


; ---------------------------------------------------------
; Description: Prints building path text. Allows user to choose from 1 of 3 options.
; Receives:  buildingPathText(1-7) as global string variables
; Returns: text and jump to another function
; Preconditions: user must have chosen 1 as their option in initialBranch
; Registers changed: edx, eax
; ---------------------------------------------------------

buildingPath PROC

	call displayBuildingArt

	; Displays text and gets user input
	mov edx, OFFSET buildingPathText1
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathText2
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathText3
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathText4
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathText5
	call WriteString
	call CrLf
	mov edx, OFFSET buildingPathText6
	call WriteString
	call CrLf
	call readInt
	call CrLf

	; Runs comparisons to determine which function to go to next
	cmp eax, 1
	je bedOutcome
	cmp eax, 2
	je closetOutcome
	cmp eax, 3
	je atticOutcome
	jmp buildingPath
	ret

buildingPath ENDP

; ---------------------------------------------------------
; Description: Prints text for the outcome of hiding under the bed
; Receives:  all bedTextn global string variables (where n is 1 or 2)
; Returns: Resolution to hiding under the bed
; Preconditions: User must have chosen to go to the house and hide under the bed. (through input)
; Registers changed: edx
; ---------------------------------------------------------

bedOutcome PROC
	; Print text and return to main
	mov edx, OFFSET bedText1
	call WriteString
	call CrLf

	mov edx, OFFSET bedText2
	call WriteString
	call CrLf
	jmp gameLoop

bedOutcome ENDP

; ---------------------------------------------------------
; Description: Prints text for outcome of hiding in the closet
; Receives:  all closetTextn  global string variables (where n is 1-3
; Returns:	 A resolution to hiding in the closet
; Preconditions: User must have chosen to go to the path with the house and chosen to hide in the closet. (through input)
; Registers changed: edx
; ---------------------------------------------------------
closetOutcome PROC
	mov edx, OFFSET closetText1
	call WriteString
	call CrLf
	mov edx, OFFSET closetText2
	call WriteString
	call CrLf
	mov edx, OFFSET closetText3
	call WriteString
	call CrLf
	jmp gameLoop

closetOutcome ENDP

; ---------------------------------------------------------
; Description: Prints text for outcome of hiding in the attic
; Receives:  all atticTextn global string variables (where n is 1-4)
; Returns: A resolution to hiding in the attic
; Preconditions: User must have chosen to go to the house, and hide in the attic. (through input)
; Registers changed: edx
; ---------------------------------------------------------

atticOutcome PROC

	mov edx, OFFSET atticText1
	call WriteString
	call CrLf
	mov edx, OFFSET atticText2
	call WriteString
	call CrLf
	mov edx, OFFSET atticText3
	call WriteString
	call CrLf
	mov edx, OFFSET atticText4
	call WriteString
	call CrLf
	jmp gameLoop

atticOutcome ENDP

; ---------------------------------------------------------
; Description: Runs a random check, if it passes the random check then you merge with the river path. Else continue to a dead end
; Receives:  pathMergeText 1-3 as global string variables
; Returns: A function call depending on the random chance
; Preconditions: User must have chosen to deviate from the path to the house and onto this one
; Registers changed: eax, edx
; ---------------------------------------------------------
pathMerge PROC
	;call Randomize	; Just in case, initialize the seed again.
	; Prints scenario text
	mov edx, OFFSET pathMergeText1
	call WriteString
	call CrLf
	mov edx, OFFSET pathMergeText2
	call WriteString
	call CrLf
	mov edx, OFFSET pathMergeText3
	call WriteString
	call CrLf

	; Calls random range (after setting the bounds)
	mov eax, UPPER_RANGE
	sub eax, LOWER_RANGE
	inc eax
	call RandomRange
	add eax, LOWER_RANGE	; Allows for us to compare from 1-10
	cmp eax, 5				; If less than or equal to 5, go to deadEnd
	jle	deadEnd
	cmp eax, 5				; If greater than 5, go to the riverPath.
	jg	riverPath
	ret

pathMerge ENDP

; ---------------------------------------------------------
; Description: Prints dead end text and gives user options. Will jump to corresponding function
; Receives:  deadEndText1-5 as global string variables
; Returns: A function call depending on input
; Preconditions: Random check from previous function must have been under a certain limit.
; Registers changed: eax, edx
; ---------------------------------------------------------

deadEnd PROC
	mov edx, OFFSET deadEndText1
	call WriteString
	call CrLf
	mov edx, OFFSET deadEndText2
	call WriteString
	call CrLf
	mov edx, OFFSET deadEndText3
	call WriteString
	call CrLf
	mov edx, OFFSET deadEndText4
	call WriteString
	call CrLf
	mov edx, OFFSET deadEndText5
	call WriteString
	call CrLf
	call ReadInt
	call CrLf
	cmp eax, 1
	je fightOutcome
	cmp eax, 2
	je climbCheck
	jmp deadEnd
	ret

deadEnd ENDP

; ---------------------------------------------------------
; Description: Prints resolution text for fight choice.
; Receives:  fightText1-4 
; Returns: Resolution to the game via text, and a function call to the game loop
; Preconditions: User chose this path by input
; Registers changed: edx
; ---------------------------------------------------------

fightOutcome PROC
	mov edx, OFFSET fightText1
	call WriteString
	call CrLf
	mov edx, OFFSET fightText2
	call WriteString
	call CrLf
	mov edx, OFFSET fightText3
	call WriteString
	call CrLf
	mov edx, OFFSET fightText4
	call WriteString
	call CrLf
	jmp gameLoop
	ret

fightOutcome ENDP

; ---------------------------------------------------------
; Description:	Runs RNG check for climbing scenario
; Receives:  none
; Returns: A function call based on the number generated
; Preconditions: user chose to climb rather than fight in previous function.
; Registers changed: eax
; ---------------------------------------------------------

climbCheck PROC
	mov eax, UPPER_RANGE
	sub eax, LOWER_RANGE
	inc eax
	call RandomRange
	add eax, LOWER_RANGE	; Allows for us to compare from 1-10
	cmp eax, 5				; If less than or equal to 5, go to climbFailure
	jle	climbFailure
	cmp eax, 5				; If greater than 5, go to the climbSuccess
	jg	climbSuccess
	ret

climbCheck ENDP

; ---------------------------------------------------------
; Description: Successful resolution to climbing the cliff
; Receives:  climbSuccessText 1-4 as global string variables
; Returns: Text
; Preconditions: Random check generated a number above 5 in the previous function 
; Registers changed: 
; ---------------------------------------------------------

climbSuccess PROC
	mov edx, OFFSET climbSuccessText1
	call WriteString
	call CrLf
	mov edx, OFFSET climbSuccessText2
	call WriteString
	call CrLf
	mov edx, OFFSET climbSuccessText3
	call WriteString
	call CrLf
	mov edx, OFFSET climbSuccessText4
	call WriteString
	call CrLf
	jmp gameLoop
	ret

climbSuccess ENDP

; ---------------------------------------------------------
; Description: Failed to climb the cliff, game over.
; Receives:  climbFailText 1-4 as global string variables
; Returns: Resolution text for failure
; Preconditions: Random check generated a number equal to or below 5 in the previous function 
; Registers changed: edx
; ---------------------------------------------------------

climbFailure PROC
	mov edx, OFFSET climbFailText1
	call WriteString
	call CrLf
	mov edx, OFFSET climbFailText2
	call WriteString
	call CrLf
	mov edx, OFFSET climbFailText3
	call WriteString
	call CrLf
	mov edx, OFFSET climbFailText4
	call WriteString
	call CrLf
	jmp gameLoop
	ret

climbFailure ENDP


; ---------------------------------------------------------
; Description: Chose to go towards river.
; Receives:  riverPathText 1-5 as global string variables
; Returns: A function call depending on input
; Preconditions: User must have chosen to go down path to the river.
; Registers changed: edx, eax
; ---------------------------------------------------------
riverPath PROC
	mov edx, OFFSET riverPathText1
	call WriteString
	call CrLf
	mov edx, OFFSET riverPathText2
	call WriteString
	call CrLf
	mov edx, OFFSET riverPathText3
	call WriteString
	call CrLf
	mov edx, OFFSET riverPathText4
	call WriteString
	call CrLf
	mov edx, OFFSET riverPathText5
	call WriteString
	call CrLf
	call ReadInt
	call CrLf
	cmp eax, 1
	je swimRiver
	cmp eax, 2
	je crossBridge
	jmp riverPath
	ret

riverPath ENDP


; ---------------------------------------------------------
; Description: Failed to swim accross river, game over.
; Receives:  swimText 1-4 as global string variables
; Returns: Resolution text for failure
; Preconditions: User must have chosen to go down path to the river then chose to swim.
; Registers changed: edx
; ---------------------------------------------------------
swimRiver PROC
	mov edx, OFFSET swimText1
	call WriteString
	call CrLf
	mov edx, OFFSET swimText2
	call WriteString
	call CrLf
	mov edx, OFFSET swimText3
	call WriteString
	call CrLf
	mov edx, OFFSET swimText4
	call WriteString
	call CrLf
	jmp gameLoop

swimRiver ENDP


; ---------------------------------------------------------
; Description:	Runs RNG check for bridge crossing scenario
; Receives:  none
; Returns: A function call based on the number generated
; Preconditions: user chose to cross the bridge rather than swim in previous function.
; Registers changed: eax
; ---------------------------------------------------------
crossBridge PROC
	mov eax, UPPER_RANGE
	sub eax, LOWER_RANGE
	inc eax
	call RandomRange
	add eax, LOWER_RANGE	; Allows for us to compare from 1-10
	cmp eax, 5				; If less than or equal to 5, go to bridgeFail
	jle	bridgeFail
	cmp eax, 5				; If greater than 5, go to the bridgeSuccess
	jg	bridgeSuccess
	ret

crossBridge ENDP


; ---------------------------------------------------------
; Description: Failed to cross the bridge, game over.
; Receives:  bridgeFailText 1-5 as global string variables
; Returns: Resolution text for failure
; Preconditions: Random check generated a number equal to or below 5 in the previous function 
; Registers changed: edx
; ---------------------------------------------------------
bridgeFail PROC
	mov edx, OFFSET bridgeFailText1
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeFailText2
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeFailText3
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeFailText4
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeFailText5
	call WriteString
	call CrLf
	jmp gameLoop

bridgeFail ENDP


; ---------------------------------------------------------
; Description: Successfully crossed bridge, game over.
; Receives:  bridgeSuccessText 1-6 as global string variables
; Returns: Resolution text for success
; Preconditions: Random check generated a number greater than 5 in the previous function 
; Registers changed: edx
; ---------------------------------------------------------
bridgeSuccess PROC
	mov edx, OFFSET bridgeSuccessText1
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeSuccessText2
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeSuccessText3
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeSuccessText4
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeSuccessText5
	call WriteString
	call CrLf
	mov edx, OFFSET bridgeSuccessText6
	call WriteString
	call CrLf
	jmp gameLoop

bridgeSuccess ENDP


; ---------------------------------------------------------
; Description: Game has reached an end, prints end options and ascii art
; Receives:  endArt 1-6 and gameText 1-3 global string variables
; Returns: Returns a function call to either end game or start over depending on input
; Preconditions: User must have reached one of our available endings
; Registers changed: edx, eax
; ---------------------------------------------------------
gameLoop PROC
	mov edx, OFFSET endArt1
	call WriteString
	call CrLf
	mov edx, OFFSET endArt2
	call WriteString
	call CrLf
	mov edx, OFFSET endArt3
	call WriteString
	call CrLf
	mov edx, OFFSET endArt4
	call WriteString
	call CrLf
	mov edx, OFFSET endArt5
	call WriteString
	call CrLf
	mov edx, OFFSET endArt6
	call WriteString
	call CrLf
	mov edx, OFFSET gameLoopText1
	call WriteString
	call CrLf
	mov edx, OFFSET gameLoopText2
	call WriteString
	call CrLf
	mov edx, OFFSET gameLoopText3
	call WriteString
	call CrLf
	call ReadInt
	call CrLf
	cmp eax, 1
	jl gameLoop
	je main
	cmp eax, 2
	jg gameLoop
	je farewellMessage
	ret

gameLoop ENDP
; ---------------------------------------------------------
; Description: Prints farewell message
; Receives:  farewell global string var
; Returns: text
; Preconditions: user chose to end game 
; Registers changed: edx
; ---------------------------------------------------------
farewellMessage PROC

	mov edx, OFFSET farewellText
	call WriteString
	call CrLf
	exit

farewellMessage ENDP

end main