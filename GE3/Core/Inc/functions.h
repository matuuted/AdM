#ifndef INC_FUNCTIONS_H_
#define INC_FUNCTIONS_H_

#include "inttypes.h"


/* ---------- Funciones en C --------- */
/* Ejercicio 1 */
uint32_t potencia (int16_t *vecIn, uint32_t longitud);

/* Ejercicio 2 */
void medDif(int8_t *e, int8_t *x, int8_t *y, uint16_t longitud);

/* Ejercicio 3 */
void eco (int16_t *signal, int16_t *sig_eco, uint32_t lon);

/* ---------- Funciones en Assembly --------- */
/* Ejercicio 1 */
uint32_t asm_potencia (int16_t *vecIn, uint32_t longitud);

// /* Ejercicio 2 */
void asm_medDif(int8_t *e, int8_t *x, int8_t *y, uint16_t longitud);

// /* Ejercicio 3 */
void asm_eco(int16_t *signal, int16_t *sig_eco, uint32_t lon);


/* ---------- Funciones en Assembly DSP--------- */
/* Ejercicio 1 */
uint32_t asm_potencia_DSP (int16_t *vecIn, uint32_t longitud);

// /* Ejercicio 2 */
void asm_medDif_DSP(int8_t *e, int8_t *x, int8_t *y, uint16_t longitud);

// /* Ejercicio 3 */
void asm_eco_DSP (int16_t *signal, int16_t *sig_eco, uint32_t lon);


void asm_eco_DSP2 (int16_t *signal, int16_t *sig_eco, uint32_t lon);
#endif /* INC_FUNCTIONS_H_ */
