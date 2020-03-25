;*******************************
;*                             *
;* LARGE CLI                   *
;* Vergrößert das CLI Fenster  *
;* auf 640 * 256 Bildpunkte    *
;* von Lutz Großhennig         *
;*                             *
;*******************************

; Library Offsets EXEC

OpenLibrary    = -408
CloseLibrary   = -414

; Library Offsets INTUITION

WindowSize     = -288

; Konstante

ExecBase       = 4

;------------------------------

Start:

  Move.l  ExecBase,a6       ; Intuition öffnen
  Move.b  530(a1),d1        ; Testen ob PAL oder NTCS
  Cmp.b   #60,d1            ; NTSC ? ( 60 = NTSC, 50 = PAL )
  Beq     Ende              ; JA, ENDE

Large1:

  Lea     Intname,a1
  Jsr     OpenLibrary(a6)
  Move.l  d0,Intbase

  Move.l  Intbase,a0        ; Window Adresse finden
  Move.l  $34(a0),a0

  Move.l  Intbase,a6
  Move.l  #0,d0             ; X +  0 Punkte
  Move.l  #56,d1            ; Y + 56 Punkte
  Jsr     WindowSize(a6)    ; Größe verändern

  Move.l  Execbase,a6       ; Intuition schließen
  Move.l  Intbase,a1
  Jsr     CloseLibrary(a6)

Ende:

  RTS                       ; Ende

Intbase:  dc.l 0                       ; Variable
Intname:  dc.b "intuition.library"     ; Lib Name

  END

