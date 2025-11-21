#ifndef INC_FUNCTIONS_H_
#define INC_FUNCTIONS_H_

#include "inttypes.h"


/* ---------- Funciones en C --------- */
/* Ejercicio 1 */
void productoEscalar32(uint32_t *vectorIn, uint32_t *vectorOut, uint32_t longitud, uint16_t escalar);

/* Ejercicio 2 */
void productoEscalar12(uint16_t *vectorIn, uint16_t *vectorOut, uint32_t longitud, uint16_t escalar);

/* Ejercicio 3 */
uint32_t bitfield_clear(uint32_t dato, uint32_t ancho, uint32_t inicio);

/* Ejercicio 4 */
uint32_t bitfield_toggle (uint32_t dato, uint32_t ancho, uint32_t inicio);


/* ---------- Funciones en Assembly --------- */
/* Ejercicio 1 */
void asm_productoEscalar32(uint32_t *vectorIn, uint32_t *vectorOut, uint32_t longitud, uint16_t escalar);

/* Ejercicio 2 */
void asm_productoEscalar12(uint16_t *vectorIn, uint16_t *vectorOut, uint32_t longitud, uint16_t escalar);

/* Ejercicio 3 */
uint32_t asm_bitfield_clear(uint32_t dato, uint32_t ancho, uint32_t inicio);

/* Ejercicio 4 */
uint32_t asm_bitfield_toggle (uint32_t dato, uint32_t ancho, uint32_t inicio);

#endif /* INC_FUNCTIONS_H_ */
