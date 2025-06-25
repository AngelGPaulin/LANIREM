Compresión/Descomprensión de imágenes
=====================================

Compresión de archivo
-----------------------


Comprime las imágenes en formato ``.tar`` para poder subirlas al cluster, después de la obtención de datos en el resonador:

  - En la máquina de la unidad de resonancia, buscar el nombre del sujeto de estudio (actualmente en la carpeta "dicom2015").
  - Click derecho y poner la opción ``7-zip``.
  - Seleccionar la opción ``ad to archive``.
  - Seleccionar la opción ``Tar``.

Descomprensión de archivo 
-----------------------
  * Entrar al directorio dónde se encuentran las imagenes:  
::

   cd datos/purcell/juan/mis_niftis/ 
::

   tar xfv sujeto_00.nii.gz 
::

   unrar x archivo.rar 
