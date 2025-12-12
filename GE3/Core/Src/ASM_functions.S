/* ################## Guía de Ejercicios 2 ################## */
.text
.syntax unified
.thumb

/* Exportar funciones*/
.global asm_potencia
.global asm_medDif
.global asm_eco

.global asm_potencia_DSP
.global asm_medDif_DSP
.global asm_eco_DSP

.global asm_eco_DSP2


/* Ejercicio 1 */
// Prototipo en archivo functions.h:
// uint32_t asm_potencia (int16_t *vecIn, uint32_t longitud);

// Parámetros recibidos
//	r0: dirección vector de entrada
//	r1: longitud
// Valor de retorno:
//	r2: potencia

.thumb_func
	asm_potencia:
		cbz r0, _exit1
		cbz r1, _exit1
		mov r2, #0     // Cargo 0 en porencia
		push {r4} 
		mov r4, r1     // Copio longitud en r4 para usarla en la division final

	_loop1:
		sub r1, #1 				// longitud -= 1
		ldrsh r3, [r0, r1, lsl #1]	// cargo el siguiente valor del vector (int16_t)
		mla r2, r3, r3, r2		// potencia += valor * valor
		cbz r1, _exit1			// si r1 es 0 salgo del loop
		b _loop1

	_exit1:
		udiv r0, r2, r4		// retorno en r0 la potencia dividida la longitud
		pop {r4}
		bx lr


// ASSEMBLY DSP VERSION
.thumb_func
	asm_potencia_DSP:
		cbz r0, _exit2
		cbz r1, _exit2
		mov r2, #0     // Cargo 0 en porencia
		push {r4-r5} 
		mov r4, r1     // Copio longitud en r4 para usarla en la division final

	_loop2:
		sub r1, #2			// longitud -= 2
		ldr r3, [r0, r1, lsl #1]	// cargo el siguiente valor del vector (2 x int16_t)
		smlad r2, r3, r3, r2		// potencia += valor1 * valor1 + valor2 * valor2

		cbz r1, _exit2			// si r1 es 0 salgo del loop
		b _loop2

	_exit2:
		udiv r0, r2, r4		// retorno en r0 la potencia dividida la longitud
		pop {r4}
		bx lr



/* Ejercicio 2 */
// Prototipo en archivo functions.h:
// void medDif(int8_t *e, int8_t *x, int8_t *y, uint16_t longitud);

// Parámetros recibidos
//	r0: dirección vector e
//	r1: dirección vector x
//	r2: dirección vector y
//	r3: longitud
// Valor de retorno:
//	ninguno

// r4 - valor temporal x
// r5 - valor temporal y
.thumb_func
	asm_medDif:
		cbz r0, _exit3
		cbz r1, _exit3
		cbz r2, _exit3
		cbz r3, _exit3 
		push {r4, r5}

	_loop3:
		sub r3, #1                 // longitud -= 1
		ldrsb r4, [r1, r3]         // cargo siguiente valor de x (int8_t)
		ldrsb r5, [r2, r3]         // cargo siguiente valor de y (int8_t)
		sub r4, r4, r5             // resto x - y
		asr r4, r4, #1             // divido por 2 (media)
		strb r4, [r0, r3]          // almaceno en e
		cbz r3, _exit3             // si r4 es 0 salgo del loop
		b _loop3
	_exit3:
		pop {r4, r5}
		bx lr


// ASSEMBLY DSP VERSION

.thumb_func
	asm_medDif_DSP:
		cbz r0, _exit4
		cbz r1, _exit4
		cbz r2, _exit4
		cbz r3, _exit4 
		push {r4, r5}

	_loop4:
		sub r3, #4                 // longitud -= 1
		ldr r4, [r1, r3]         // cargo siguiente valor de x (int8_t)
		ldr r5, [r2, r3]         // cargo siguiente valor de y (int8_t)
		shsub8 r4, r4, r5           // resto x - y (unsigned halfword subtract)
		str r4, [r0, r3]          // almaceno en e
		cbz r3, _exit4             // si r4 es 0 salgo del loop
		b _loop4
	_exit4:
		pop {r4, r5}
		bx lr



/* Ejercicio 3 */
// Prototipo en archivo functions.h:
// void asm_eco (int16_t *signal, int16_t *sig_eco, uint32_t lon);
// Parámetros recibidos
//	r0: dirección vector signal
//	r1: dirección vector sig_eco
//	r2: longitud
// Valor de retorno:
//	ninguno

.thumb_func
	asm_eco:
		cbz r0, _exit5
		cbz r1, _exit5
		cbz r2, _exit5 
		push {r4 - r5}

		mov r5, #5         // cargo el valor

	_loop5:
		sub r2, #1                 // longitud -= 1
		ldrsh r4, [r0, r2, lsl #1] // cargo siguiente valor de signal (int16_t)
		cmp r2, r5
		ittt ge 
			subge r3, r2, r5
			ldrshge r3, [r0, r3, lsl #1] // cargo valor retrasado signal[n - 5]
			addge r4, r4, r3, asr #1     // eco = signal + signal[n - 5]

		strh r4, [r1, r2, lsl #1]  // almaceno en sig_eco
		cbz r2, _exit5             // si r2 es 0 salgo del loop
		b _loop5
	_exit5:
		pop {r4 - r5}
		bx lr



// ASSEMBLY DSP VERSION
.thumb_func
	asm_eco_DSP:
		cbz r0, _exit6
		cbz r1, _exit6
		cbz r2, _exit6 
		push {r4 - r6}

		mov r5, #5         // cargo el valor
		mov r6, #0         

	_loop6:
		sub r2, #2                 	// longitud -= 2
		ldr r4, [r0, r2, lsl #1] 	// cargo siguiente valor de signal (2 x int16_t)
		cmp r2, r5
		itttt ge 
			subge r3, r2, r5
			ldrge r3, [r0, r3, lsl #1]
			shadd16ge r3, r3, r6		
			qadd16ge r4, r3, r4       	

		str r4, [r1, r2, lsl #1]  	
		cbz r2, _exit6 
		b _loop6
	_exit6:
		pop {r4 - r6}
		bx lr


.thumb_func
	asm_eco_DSP2:
	    push    {r4-r8, lr}
	    movw    r4, #5
	    movs    r3, #0
	    cmp     r2, #0
	    beq     _end_eco_dsp
	    cmp     r2, r4
	    bhi     _copy_up_to_n
	    mov     r5, r2
	    b       _copy_only_finish

	_copy_up_to_n:
	    mov     r5, r4

	_copy_only_finish:
	    lsrs    r6, r5, #1
	    beq     _copy_only_remain

	_copy_only_pairs:
	    ldr     r7, [r0], #4
	    str     r7, [r1], #4
	    subs    r6, r6, #1
	    bne     _copy_only_pairs

	_copy_only_remain:
	    ands    r8, r5, #1
	    beq     _maybe_start_echo
	    ldrsh   r7, [r0], #2
	    strh    r7, [r1], #2
	    adds    r3, r3, #1
	    subs    r5, r5, #1
	    subs    r2, r2, #1
	    beq     _end_eco_dsp

	    adds    r3, r3, r4
	    b       _start_echo

	_start_echo:
	   b       _end_eco_dsp

	_maybe_start_echo:
	    b       _start_echo

	_end_eco_dsp:
	    pop     {r4-r8, pc}