Región de Interés: fslroi
=========================


Extraer una Región de Interés con fslroi 
-----------------------

Extrae una región de interés (ROI region of interest) de una imagen.

A) Es posible tomar una ROI de 3 dimensiones (3D) de un conjunto de datos de 3D, o en caso de que sea de 4 dimensiones (4D) la misma ROI se toma de cada punto temporal y se crea un nuevo conjunto de datos de 4D.

B) Extrae solo algunos puntos de un conjunto de 4D.

C) Controla los limites del espacio y tiempo para la ROI. Hay que darse cuenta que los argumentos son index mínimo y tamaño (no máximo index). Así que para extraer los voxeles de 10 al 12 completos se debe especificar 10 y 3 (no 10 y 12).


Utilización:

       fslroi <input> <output> <xmin> <xsize> <ymin> <ysize> <zmin> <zsize> 

  

       fslroi <input> <output> <tmin> <tsize>       

       fslroi <input> <output> <xmin> <xsize> <ymin> <ysize> <zmin> <zsize> <tmin> <tsize>       

  
