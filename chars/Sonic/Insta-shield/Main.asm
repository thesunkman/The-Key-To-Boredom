; ====================================== Instant-Shield Code==============================================

Obj01_InstaShield:
			
		tst.b	#0,(v_character).w	; Is the character Sonic?
		bne.s	InstaShieldReturn	; If not, return.
		
		tst.b	double_jump_flag.w	; Was ability used?
		bne.s	InstaShieldReturn
		
		btst	#1,obStatus(a0)		; is Sonic in the air?
		bne.s 	InstaShieldReturn
		
		move.w	#sfx_Jump,d0
		jsr	(QueueSound2).l	; play jumping sound
		
		



InstaShieldReturn:
		rts