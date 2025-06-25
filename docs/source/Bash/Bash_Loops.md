Loops
=====

## Iteración de comandos con `for` 

**for** es un comando poderoso que permite repetir un comando en varios archivos. La traducción de for sería:

**Definiendo** <mi_variable> **como** <mis_archivos>; **se debe de** <usar_comando> <mi_variable>; terminado

**for** var **in** *.*; **do** <comando> $var; done

<mi_variable> puede ser cualquier letra que se quiera asignar


En el siguiente ejemplo se imprimira en la pantalla todos los archivos dentro de una carpeta escribiendo antes la palabra "hola"

``` bash
for i in $( ls ); do echo hola: $i; done
```
  *  **i**: es mi variable que defino y comprende a todos los archivos que se mencionan en `$(ls )`    
  * **echo hola:** es el comando que quiero repetir.


``` bash
hola archivo1.txt
hola archivo1.txt
hola archivo2.txt
hola archivo3.txt
hola archivo4.txt
```

Otro ejemplo de un uso de **for** es el siguiente para subir al cluster la  realización de una mascara binaria con *bet*  en todos los archivos **nii.gz** que comienzan con **t1_** y tienen 4 caracteres más.

``` bash
for x in $(ls t1_????.nii.gz); do fsl_sub -N $x bet $x $x -m -n -B -f 0.35; done
```

## Leer lineas de un archivo de texto con `while read` ##

Si tengo un archivo de texto (txt) y quiero realizar una acción con cada linea puedo usar:

``` bash
while read linea; do
echo $linea; 
done < miTexto.txt
```

lo anterior imprimira el contenido de cada linea: 

```bash
3 GCC Genu of corpus callosum
4 BCC Body of corpus callosum
5 SCC Splenium of corpus callosum
```

## Crear condicionales con `break` y `continue` ##

Si bien el `for` nos hace la vida más fácil al ejecutar una gran cantidad de tareas, puede tambien quedarse atorado en un loop "infinito", es asi que `break` resulta bastante útil. Aquí es una sintaxis de vainilla:

```
bash
nombres=("Maria" "Luisa" "Carla" "Mariana" "Flor")

for n in "${nombres[@]}"; do
   echo "Nombre: $n"

  if [ "$n" == "Mariana" ]; then
      echo "Encontré a Mariana. Para aquí"
      break

  fi

done

## output
Nombre: Maria
Nombre: Luisa
Nombre: Carla
Nombre: Mariana
Encontré a Mariana. Para aquí
```
Donde el script hará la iteraciones necesarias hasta llegar al nombre de Mariana (en este caso) y ahí es donde terminará el loop. 


Ahora, si cambiamos el `break` por el `continue`, hará que las iteraciones sigan corriendo aunque haya encontrado la variable:
```
bash
nombres=("Maria" "Luisa" "Carla" "Mariana" "Flor")

for n in "${nombres[@]}"; do
    echo "Nombre: $n"

    if [ "$n" == "Mariana" ]; then
        echo "Ignora que encontramos a Mariana"
        continue
    fi
done

## output
Nombre: Maria
Nombre: Luisa
Nombre: Carla
Nombre: Mariana
Ignora que encontramos a Mariana
Nombre: Flor
```
Vuelve a hacer la iteración, pero aun que haya encontrado a "Mariana", va a continuar el loop hasta que acabe todas las iteraciones. 






