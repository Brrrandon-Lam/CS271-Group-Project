
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
	firstOptnDes	BYTE	"you reach a fork, there looks like a building up ahead on one path, hear water from other"
	firstChoice		BYTE	"building(1) or river(2)?",0
	riverDes		BYTE	"You reach a river, there is a broken bridge",0
	riverChoice		BYTE	"Swim(1) or cross bridge(2)",0
	swimOptn		BYTE	"too deep, too slow, you're caught, The End!",0
	bridgeEndG		Byte	"barely make across before bridge breaks, you escape to a town. The End!"
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
	uchoice			DWORD	?

.code
main PROC

; (insert executable instructions here)

	exit	; exit to operating system
main ENDP

; (insert additional procedures here)

END main
