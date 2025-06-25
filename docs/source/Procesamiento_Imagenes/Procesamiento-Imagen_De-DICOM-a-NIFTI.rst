DICOM a NIFTI
=============

De DICOM a NIFTI 
-----------------------

Usar en la terminal el siguiente comando: **inb_dcm2nii.sh**

Debe escribirse en el siguiente orden:
	
* Comando
* Espacio
* Archivo a convertir (debe escribirse toda la ruta, o bien puede arrastrarse el archivo)
* Espacio
* Nombre final del archivo y agregar: **.nii.gz**

Ejemplo:

::

   inb_dcm2nii.sh 'miarchivoT1' nombrefinaldelarchivo.nii.gz
Si al final de la línea se agrega **-reorientar** esta función hará que la imagen sea orientada de forma convencional.

Ejemplo:

::

   inb_dcm2nii.sh 'miarchivoT1' nombrefinaldelarchivo.nii.gz -reorientar
