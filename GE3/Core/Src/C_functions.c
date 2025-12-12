/* ################## Guía de Ejercicios 2 ################## */

#include "functions.h"

/* Ejercicio 1 */
uint32_t potencia (int16_t *vecIn, uint32_t longitud){
    uint32_t potencia = 0;
    for (uint32_t i = 0; i < longitud; i++){
        potencia += vecIn[i] * vecIn[i];
    }
    return (uint32_t)(potencia / longitud);
}

/* Ejercicio 2 */
void medDif(int8_t *e, int8_t *x, int8_t *y, uint16_t longitud)
{
    for (uint16_t i = 0; i < longitud; i++){
        e[i] = (x[i] - y[i]) / 2;
    }
}

// /* Ejercicio 3 */
void eco (int16_t *signal, int16_t *sig_eco, uint32_t lon){
    int16_t retardo = 5; // 20ms * 44100 samples/s -> 44100 * 0.02f -> = 882 muestras

    for(uint32_t elemento = 0; elemento < lon; elemento++){
    
        // Empezamos con la señal original
        int16_t sample = signal[elemento];

        // Si pasamos el tiempo de retardo, sumamos el eco
        if(elemento >= retardo){
            sample += (signal[elemento - retardo] / 2);
        }

        sig_eco[elemento] = sample;

    }

}
