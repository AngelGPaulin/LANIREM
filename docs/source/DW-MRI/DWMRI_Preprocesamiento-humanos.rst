Preprocesamiento en imágenes de humanos.
========================================

Antes de empezar, algunos detalles:

* Visita `Andy's brain book <https://andysbrainbook.readthedocs.io/en/latest/MRtrix/MRtrix_Course/MRtrix_04_Preprocessing.html>`_ para más información (y más actualizada).
* `Lista de herramientas para preprocesamiento <https://hackmd.io/@c13lab/preproc>`_ compilada por Ricardo Ríos.


Conversion de datos 
-----------------------

+ Convertir de :doc:`Procesamiento-Imagen:-De-DICOM-a-NIFTI`
+ Convertir de :doc:`Procesamiento-Imagen:-De-PARREC-a-NIFTI`


Corrección de inhomogeneidades del campo magnético
-----------------------
Lo que conviene ahora es corregir los errores de movimiento y los artefactos inducidos por `corrientes eddy <http://es.wikipedia.org/wiki/Corriente_de_Foucault>`_. Existen dos versiones, la clásica es con:
::

   
   Este método es anticuado y sub-óptimo, pero lo único que se puede hacer en caso de no contar con imágenes con adquisición reversa de fase. En caso de contar con ellas, entonces utilizar la opción **Eddy correct revpe**. Por el momento no se ha utilizado completamente esta herramienta, pero en esta [página](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup) se encuentra toda la información necesaria.
   
   ## Reacomodo de la tabla de gradientes para la compatibilidad de mrtrix
   
   Si queremos usar mrtrix debemos cambiar el formato de la tabla de gradientes a como le gusta a mrtrix. Para ello usamos: 
   
::

   
::

   
