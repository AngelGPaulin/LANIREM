Quitar volúmenes de un archivo niffti
=====================================

Quitar volúmenes de un archivo niffti
-----------------------


Cuando hay exceso de movimiento durante una corrida de funcional (puede verse en el apartado Pre-stats del reporte) es posible eliminar los volúmenes donde se registró mayor movimiento.

Opción 1. Utilizar fslsplit
-----------------------

Separamos los volúmenes.
-----------------------

    fslsplit Input Output_Base -t

Ejemplo:

    fslsplit '/home/inb/lauveri/Desktop/Fun0.nii.gz' Im_1 -t


Detalles: I) El nombre del output debe tener el guión bajo. II) -t se refiere a que va a separar por tiempo, También es posible separar por los tres ejes, aunque no sé en qué circunstancias sería necesario. III) Considera que las imágenes que vas a tener son tantas como volúmenes tiene el input.

Borrar los volúmenes deseados.
-----------------------
No hay limitaciones del orden o número de volúmenes que se pueden borrar. Tampoco es necesario renombrar los archivos conservados.

Utilizar el comando fslmerge
-----------------------

    fslmerge -t output inputs

En los que he hecho, disminuye mucho el desplazamiento absoluto, pero no el relativo.
**No olvides modificar los vectores de tu matriz de diseño FEAT.**

Es importante mencionar que fslmerge sirve también para concatenar imágenes en las otras dimensiones (x, y, z). Basta cambiar -t por x, y ó z.


Opción 2: fslroi
-----------------------
fslroi es capaz de hacer un ''crop'' a nuestros datos, ya sea en espacio 3D o en el tiempo. En nuestro caso, queremos eliminar algunos volúmenes dentro de un set 4D. Supongamos que tenemos 100 volúmenes, y queremos quitar del 50 al 60, que nuestro sujeto se movió. Recordemos que fslroi cuenta a partir de 0, así que los primeros volúmenes son del 0 al 49 y los últimos son del 59 al 99. Tendremos que hacerlo en tres pasos:

    fslroi archivoOriginal.nii primeraParte.nii 0 49
    fslroi archivoOriginal.nii segundaParte.nii 59 41
    fslmerge -t archivoFinal.nii primeraParte.nii segundaParte.nii

En el caso de la primera línea de código, el 0 representa el índice del volúmen inicial, pero el 49 no representa el índice del volumen final, sino la cantidad de volúmenes que quiero tener. Es decir, aquí le estamos diciendo a FSL que comience a contar con el volúmen índice 0 (o el primero de la serie de volúmenes) y tome 49 en total. En la segunda línea de código le estamos diciendo a FSL que comience desde el índice 59 (o el volúmen número 60) y tome 41 volúmenes.

Opción 3: mrconvert
-----------------------
Si de plano lo queremos hacer en un solo paso, la opción es usar ''mrconvert'', que es parte de ''mrtrix''. mrconvert es capaz de extraer volúmenes indicandolos como secuencias numéricas. Hay mucha información en `esta liga <http://www.brain.org.au/software/mrtrix/general/cmdline.html>`_

    mrconvert -coord 3 0:49,59:99 archivoOriginal.nii archivoFinal.nii
