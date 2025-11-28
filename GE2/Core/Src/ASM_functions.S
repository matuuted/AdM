/* ################## Guía de Ejercicios 2 ################## */
.text
.syntax unified
.thumb

/* Exportar funciones*/
.global asm_pack32to16
.global asm_max
.global asm_downSample
.global asm_invertir

/* Ejercicio 1 */
// Prototipo en archivo functions.h:
// void asm_pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud);

// Parámetros recibidos
//	r0: dirección vector de entrada
//	r1: dirección vector de salida
//	r2: longitud de ambos vectores

//  r3: variable de apoyo

// Valor de retorno: void
.thumb_func
	asm_pack32to16:
		cbz r0, _exit1
		cbz r1, _exit1

	_loop1:
		sub r2, #1 // longitud -= 1
		ldr r3, [r0, r2, LSL #2]
		asr r3, r3, #16
		strh r3, [r1, r2, LSL #1]
		cbz r2, _exit1
		b _loop1

	_exit1:
		bx lr

/* Ejercicio 2 */
// Prototipo en archivo functions.h:
// uint32_t asm_max (int32_t * vectorIn, uint32_t longitud);
// Parámetros recibidos
//	r0: dirección vector de entrada
//	r1: longitud

//  r2 maximo
//  r3 indice del maximo
//  r4 valor actual a comparar

// Valor de retorno:
//  r0 indice del primer maximo encontrado
.thumb_func
	asm_max:
		push {r4}

		mov r3, #0     // Cargo 0 en indice del maximo

		cbz r0, _exit2  //Salir si vectorIn es 0
		cbz r1, _exit2  //Salir si longitud es 0

		ldr r2, [r0]    // Primer maximo es indice 0
	_loop2:
		sub r1, #1 				// longitud -= 1
		cbz r1, _exit2			// si r1 es 0 salgo del loop
		ldr r4, [r0, r1, LSL #2] // cargo en r4 el valor del indice r1 (r1 != 0)
		cmp r4, r2				// comparo valor cargado con maximo
		ble _loop2				// si es menor o igual sigo el loop
		mov r2, r4				// si es mayor, cargo nuevo maximo
		mov r3, r1				// si es mayor, cargo indice del nuevo maximo
		b _loop2

	_exit2:
		pop {r4}
		mov r0, r3
		bx lr

/* Ejercicio 3 */
// Prototipo en archivo functions.h:
// void asm_downSample (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N);

// Parámetros recibidos:
//	r0: direccion del vector de entrada
//	r1: direccion del vector de salida
//	r2: longitud
//  r3: N

//  r4: indice
//  r5: i

// Valor de retorno: void

.thumb_func
	asm_downSample:
		push {r4 - r7}

		cbz r0, _exit3
		cbz r1, _exit3
		cbz r2, _exit3

		mov r4, #0			// indice
		mov r5, #0			// i

	_loop3:
		cmp r5, r2	// Comparo i con longitud
		bge _exit3   // salgo para i >= longitud

		add r6, r5, #1				// i+1
		udiv r7, r6, r3				// (i+1) / N (r7 -> cociente)
		mls  r7, r7, r3, r6 		// (i+1) - (r7*N) (r7 -> resto)
		cbnz r7, _add_val   		// Si resto es != 0 cargo
		add r5, #1					// incrementamos i
		b _loop3						// volvemos al bucle

	_add_val:
		ldr r6, [r0, r5, LSL #2]    // cargo en r6 valor del vectorin en i
		str r6, [r1, r4, LSL #2]    // guardo valor en vectorout posicion indice
		add r4, #1					// incremento indice
		add r5, #1					// incremento i
		b _loop3

	_exit3:
		pop {r4 - r7}
		bx lr

/* Ejercicio 4 */
// Prototipo en archivo functions.h:
// void asm_invertir (uint16_t * vector, uint32_t longitud);
// Parámetros recibidos:
//	r0: direccion del vector a procesar
//	r1: longitud

// Valor de retorno: void

.thumb_func
	asm_invertir:
		push {r4 - r5}

		cbz r0, _exit4
		cbz r1, _exit4

		sub r2, r1, #1  // i = longitud - 1 Final
		mov r3, #0		// J = 0			Principio

	_loop4:
		cmp r3, r2		// comparo j con i
		bge _exit4		// si j >= i salgo

		ldrh r4, [r0, r2, LSL #1]	// Guardo valor superior
		ldrh r5, [r0, r3, LSL #1]   // Guardo valor inferior

		strh r4, [r0, r3, LSL #1]   // Cargo valor inferior
		strh r5, [r0, r2, LSL #1]   // Cargo valor superior

		add r3, #1
		sub r2, #1

		b _loop4

	_exit4:
		pop {r4 - r5}
		bx lr




