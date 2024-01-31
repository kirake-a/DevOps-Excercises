#!/bin/bash

# No se han recibido parametros de la terminal
# $# --> Numero de argumentos pasados al script o funcion
# -eq --> Operador de igualdad en Bash
if [[ $# -eq 0 ]];
then 
    echo "No sabemos que pokemon buscar..."
    exit 1
fi

pokemon_name=$1

url="https://pokeapi.co/api/v2/pokemon/${pokemon_name}"
response=$(curl -s "$url")

# Verificar que se haya traido informacion de manera exitosa
# Se verifica la existencia del "pokemon" dado
# $? --> codigo de salida del ultima comando ejectudo
# 0 representa una ejecucion exitosa
if [[ $? -ne 0 || "$(echo "$response" | jq -r '.detail')" != "null" ]];
then
    echo "Error al obtener información del Pokemon..."
    exit 1
fi

# Ingresando a variables la informacion del JSON
poke_name=$(echo "$response" | jq -r '.name')
poke_id=$(echo "$response" | jq -r '.id')
poke_weight=$(echo "$response" | jq -r '.weight')
poke_height=$(echo "$response" | jq -r '.height')
poke_order=$(echo "$response" | jq -r '.order')

# Imprimir en consola
echo "$poke_name (No. $poke_id)
Id = $poke_order
Weight: $poke_weight
Height: $poke_height"