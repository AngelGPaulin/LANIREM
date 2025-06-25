Loops
=====

Iteración de comandos con ``for`` 
-----------------------

**for** es un comando poderoso que permite repetir un comando en varios archivos. La traducción de for sería:

**Definiendo** <mi_variable> **como** <mis_archivos>; **se debe de** <usar_comando> <mi_variable>; terminado

**for** var **in** *.*; **do** <comando> $var; done

<mi_variable> puede ser cualquier letra que se quiera asignar


En el siguiente ejemplo se imprimira en la pantalla todos los archivos dentro de una carpeta escribiendo antes la palabra "hola"

::

   for i in $( ls ); do echo hola: $i; done
  * **echo hola:** es el comando que quiero repetir.


::

   hola archivo1.txt
   hola archivo1.txt
   hola archivo2.txt
   hola archivo3.txt
   hola archivo4.txt
Otro ejemplo de un uso de **for** es el siguiente para subir al cluster la  realización de una mascara binaria con *bet*  en todos los archivos **nii.gz** que comienzan con **t1_** y tienen 4 caracteres más.

::

   for x in $(ls t1_????.nii.gz); do fsl_sub -N $x bet $x $x -m -n -B -f 0.35; done
Leer lineas de un archivo de texto con ``while read`` ##
-----------------------

Si tengo un archivo de texto (txt) y quiero realizar una acción con cada linea puedo usar:

::

   while read linea; do
   echo $linea; 
   done < miTexto.txt
lo anterior imprimira el contenido de cada linea: 

::

   3 GCC Genu of corpus callosum
   4 BCC Body of corpus callosum
   5 SCC Splenium of corpus callosum
Crear condicionales con ``break`` y ``continue`` ##
-----------------------

Si bien el ``for`` nos hace la vida más fácil al ejecutar una gran cantidad de tareas, puede tambien quedarse atorado en un loop "infinito", es asi que ``break`` resulta bastante útil. Aquí es una sintaxis de vainilla:

::

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


Ahora, si cambiamos el ``break`` por el ``continue``, hará que las iteraciones sigan corriendo aunque haya encontrado la variable:
::

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






