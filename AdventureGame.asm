
TITLE Adventure Story Game     (AdventureGame.asm)

; Authors: Coral Pease and Brandon Lam
; Course / Project ID                 Date: 3/4/20
; Description: Choose your own adventure style story game

INCLUDE Irvine32.inc

; (insert constant definitions here)

.data

; (insert variable definitions here)

	info1			BYTE	"Program Title: Adventure Story Game",0
	info2			BYTE	"Program by Coral Pease and Brandon Lam",0
	intro			BYTE	"You wake up in strange place...(add to later)",0
	intro2			BYTE	"noise behind you, something chasing",0
	firstOptnDes	BYTE	"you reach a fork, there looks like a building up ahead on one path, hear water from other",0
	firstChoice		BYTE	"building(1) or river(2)?",0
	riverDes		BYTE	"You reach a river, there is a broken bridge",0
	riverChoice		BYTE	"Swim(1) or cross bridge(2)",0
	swimOptn		BYTE	"too deep, too slow, you're caught, The End!",0
	bridgeEndG		Byte	"barely make across before bridge breaks, you escape to a town. The End!",0
	bridgeEndB		BYTE	"Bridge breaks, you drown. The End!",0
	buildDes		BYTE	"you come across seemingly abandoned shack, you could maybe hide there",0
	buildChoice		BYTE	"try to hide(1), or keep going on path(2)?",0
	hideDes			BYTE	"find/describe some hiding spots",0
	hideChoice		BYTE	"Under bed(1), in closet(2), or in attic(3)?",0
	hideEnd			BYTE	"You were found and caught. The End!",0
	deadEndDes		BYTE	"come to dead end, cliff wall, maybe you can climb it?",0
	deadEndChoice	BYTE	"try to climb(1), or stay and fight(2) whatever is chasing?",0
	fightEnd		BYTE	"lore describing fight. The End!",0
	climbEndG		BYTE	"You successfully climb out just in time and escape to town. The End!",0
	clumbEndB		BYTE	"You lose your grip and fall to your death. The End!",0
	restart			BYTE	"Would you like to play again? Yes(1) or no(2)?",0
	;uchoice			DWORD	?

.code
main PROC

; (insert executable instructions here)

	;project info
	mov edx, OFFSET info1
	call WriteString
	call Crlf

	mov edx, OFFSET info2
	call WriteString
	call Crlf

	call Crlf
	call Crlf

	call Randomize		;seed randomization


	GameStart:					;intro to game
	mov edx, OFFSET intro
	call WriteString
	call Crlf

	mov edx, OFFSET intro2
	call WriteString
	call Crlf
	call Crlf

	mov edx, OFFSET firstOptnDes	;reach first split
	call WriteString
	call Crlf

	FirstSplit:					;ask for choice and jump to selected path
	mov edx, OFFSET firstChoice
	call WriteString
	call Crlf
	call ReadInt
	call Crlf

	cmp eax, 1						;if 1 is entered, go to building
	je BuildPath
	cmp eax, 2						;if 2 selected, go to river
	je RiverPath
	jmp FirstSplit					;if other entered, repeat prompt


	RiverPath:					;reach river
	mov edx, OFFSET riverDes
	call WriteString
	call Crlf

	RiverSplit:				;ask for choice and jump to selected path
	mov edx, OFFSET riverChoice
	call WriteString
	call Crlf
	call ReadInt

	cmp eax, 1						;if 1 is entered, go to swim ending
	je SwimEnd
	cmp eax, 2						;if 2 selected, cross bridge
	je Bridge
	jmp RiverSplit					;if other entered, repeat prompt


	SwimEnd:				;Swim choice leads to game ending
	mov edx, OFFSET swimOptn
	call WriteString
	call Crlf
	jmp EndGame

	
	Bridge:					;Tries to cross bridge
	mov eax, 2			
	call RandomRange				;Get random number between 1 and 2
	add eax, 1
	cmp eax, 1						;if 1 is entered, go to good bridge ending
	je BridgeEndingG
	cmp eax, 2						;if 2 selected, go to bad bridge ending
	je BridgeEndingB


	BridgeEndingG:				;sucessfully cross bridge, game ends
	mov edx, OFFSET BridgeEndG
	call WriteString
	call Crlf
	jmp EndGame


	BridgeEndingB:				;bridge breaks, game ends
	mov edx, OFFSET BridgeEndB
	call WriteString
	call Crlf
	jmp EndGame


	BuildPath:
	jmp EndGame						;until rest is added

	EndGame:				;asks if user wants play again
	mov edx, OFFSET restart
	call WriteString
	call Crlf
	call ReadInt

	cmp eax, 1						;if 1 is entered, go to start of game
	je GameStart
	cmp eax, 2						;if not 1 or 2, repeat prompt
	jne EndGame				

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
