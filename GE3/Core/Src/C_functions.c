/* ################## Guía de Ejercicios 2 ################## */

#include "functions.h"


/* Ejercicio 1 */
uint32_t asm_potencia (int16_t *vecIn, uint32_t longitud){
    uint64_t potencia = 0;
    for (uint32_t i = 0; i < longitud; i++){
        potencia += vecIn[i] * vecIn[i];
    }
    return (uint32_t)(potencia / longitud);
}

/* Ejercicio 2 */
void asm_medDif(int8_t *e, int8_t *x, int8_t *y, uint16_t longitud)
{
    for (uint16_t i = 0; i < longitud; i++){
        e[i] = (x[i] - y[i]) / 2;
    }
}

/* Ejercicio 3 */
void asm_eco (int16_t *signal, int16_t *sig_eco, uint32_t lon){
    uint32_t retardo = 882; // 20ms * 44100 samples/s -> 44100 * 0.02f -> = 882 muestras
}
