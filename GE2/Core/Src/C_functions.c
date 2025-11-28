/* ################## Guía de Ejercicios 2 ################## */

#include "functions.h"

/* Ejercicio 1 */
void pack32to16 (int32_t * vectorIn, int16_t *vectorOut, uint32_t longitud){
    for (uint32_t i = longitud; i > 0; i --){
        vectorOut[i-1] = (vectorIn[i-1] >> 16); // Se copian los 16 bits menos significativos
    }
}

/* Ejercicio 2 */
uint32_t max (int32_t * vectorIn, uint32_t longitud){

    int32_t maximo = vectorIn[0]; // Se asume que el primer valor es el máximo
    uint32_t indice = 0;

    for (uint32_t i = longitud; i > 0; i --){
        if (vectorIn[i-1] > maximo){
            maximo = vectorIn[i-1]; // Se actualiza el máximo
            indice = i-1;          // Se guarda el índice del máximo
        }
    }   
    return indice; // Se devuelve el índice del máximo
}   

/*Ejercicio 3 */
void downSample (int32_t * vectorIn, int32_t * vectorOut, uint32_t longitud, uint32_t N){
    uint32_t indice = 0;
    for (uint32_t i = 0; i < longitud; i ++){
        if (((i + 1) % N) == 0) continue;

		vectorOut[indice] = vectorIn[i];
		indice++;
    }
}
/* Ejercicio 4 */
void invertir (uint16_t * vector, uint32_t longitud){
    uint16_t aux;
    for (uint32_t i = longitud - 1; i >= longitud / 2; i--) {
        
        uint32_t j = longitud - 1 - i; // Índice correspondiente desde el inicio

        aux = vector[i];
        vector[i] = vector[j];
        vector[j] = aux;
    }
}
