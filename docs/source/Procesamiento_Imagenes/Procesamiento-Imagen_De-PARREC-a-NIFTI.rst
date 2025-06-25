PARREC a NIFTI
===============

De PARREC a NIFTI ##
-----------------------
Usar en la terminal el siguiente comando: **PARconv_v1.12.sh**

Debe escribirse en el siguiente orden:
* Comando
* Espacio
* Archivo a convertir (debe escribirse toda la ruta, o bien puede arrastrarse el archivo)
* Espacio
* Nombre final del archivo y agregar: **.nii.gz**

Ejemplo:
::

   PARconv_v1.12.sh 'miarchivoT1' nombrefinaldelarchivo.nii.gz
Este comando **NO** permite reorientar la imagen de manera directa, por lo que es necesario usar en la terminal otro comando el cual es: **fslreorient2std**

Debe escribirse en el siguiente orden:
* Comando
* Espacio
* Archivo a reorientar (debe escribirse toda la ruta, o bien puede arrastrarse el archivo)
* Espacio
* Nombre final del archivo

Ejemplo:
::

   fslreorient2std 'archivoareorientar.nii.gz' nombrefinaldelarchivo.nii.gz
En caso de las imágenes **pseudoflair** hay que utilizar el siguiente comando en lugar de PARconv_v1.12.sh. sin la extensión .PAR o .REC, solo el nombre: ej. ID_pseudoFLAIR.PAR
::

    dcm2nii -o . -v N ID_pseuFLAIR
