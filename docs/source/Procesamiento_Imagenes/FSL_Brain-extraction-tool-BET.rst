BET
===

Elimina de las imágenes aquellas estructuras que rodean al cerebro (cráneo y meninges):

  - Se escribe la ruta en donde se encuentra el archivo.
  - Se pone el comando ``bet``
  - Se escribe el nombre del archivo con formato ``.nii.gz``
  - Se pone el nuevo nombre del archivo.
  - Se escribe el grado de extracción que se desea, usualmente funciona con ``-f 0.5``, pero el gradiente va desde 0 a 1, siendo los valores cercanos a 0 los más laxos, y los cercanos a 1 los de mayor extracción.

**Ejemplo**
   
::

      datos/purcell/circe/tesis/imágenes bet s408.nii.gz bet408 –f 0.5
**Otra manera de explicarlo**

Debe escribirse en el siguiente orden:
  Comando
  Espacio
  Archivo con tejido ajeno al encéfalo (debe escribirse toda la ruta, o bien puede arrastrarse el archivo)
  Espacio
  Nombre final del archivo sin tejido ajeno al encéfalo

**Ejemplo**

::

   bet 'archivoconmeninges.nii.gz' nombredelarchivosinmeninges.nii.gz 
Al agregar **-f** al final, se puede regular qué tanto tejido se quita de la imagen. Por default, el comando bet está en 0.5 Este número puede ser modificado escribiendo alguno de 0.1 a 0.9

**Ejemplo:**

::

    bet 'archivoconmeninges.nii.gz' nombredelarchivosinmeninges.nii.gz -f 0.6 
