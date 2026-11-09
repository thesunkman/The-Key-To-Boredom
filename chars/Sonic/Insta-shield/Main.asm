; ---------------------------------------------------------------------------
; Object 38 - shield and invincibility stars
; ---------------------------------------------------------------------------

InstaShieldItem:
		moveq	#0,d0
		move.b	obRoutine(a0),d0
		move.w	InstaShi_Index(pc,d0.w),d1
		jmp	InstaShi_Index(pc,d1.w)
; ===========================================================================
InstaShi_Index:	dc.w InstaShi_Main-Shi_Index
		dc.w InstaShi_Shield-Shi_Index
		dc.w Shi_Stars-Shi_Index
; ===========================================================================

InstaShi_Main:	; Routine 0
		addq.b	#2,obRoutine(a0)
		move.l	#Map_InstaShield,obMap(a0)
		move.b	#4,obRender(a0)
		move.b	#1,obPriority(a0)
		move.b	#$10,obActWid(a0)
		move.w	#make_art_tile(Art_InstaShield,0,0),obGfx(a0)	; shield specific code
		rts
; ===========================================================================

InstaShi_Shield:	; Routine 2
		tst.b	(v_invinc).w	; does Sonic have invincibility?
		bne.s	.remove		; if yes, branch
		tst.b	(v_shield).w	; does Sonic have shield?
		beq.s	.delete		; if not, branch
		move.w	(v_player+obX).w,obX(a0)
		move.w	(v_player+obY).w,obY(a0)
		move.b	(v_player+obStatus).w,obStatus(a0)
		lea	(Ani_InstaShield).l,a1
		jsr	(AnimateSprite).l
		jmp	(DisplaySprite).l

.remove:
		rts

.delete:
		jmp	(DeleteObject).l
; ===========================================================================
InstaShi_Start_Delete:	
		jmp	(DeleteObject).l
