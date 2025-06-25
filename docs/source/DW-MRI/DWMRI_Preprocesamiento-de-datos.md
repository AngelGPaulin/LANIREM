

Antes de empezar, algunos detalles:

* Para un ejercicio más extenso, usando datos de roedor, visita [esta entrada](./dwipreproc-rat).
* Visita [Andy's brain book](https://andysbrainbook.readthedocs.io/en/latest/MRtrix/MRtrix_Course/MRtrix_04_Preprocessing.html) para más información (y más actualizada).
* [Lista de herramientas para preprocesamiento](https://hackmd.io/@c13lab/preproc) compilada por Ricardo Ríos.


## Conversion de datos 
+ Convertir de [DICOM a NIFTI](./Procesamiento-Imagen:-De-DICOM-a-NIFTI)
+ Convertir de [PARREC a NIFTI](./Procesamiento-Imagen:-De-PARREC-a-NIFTI)


## Corrección de inhomogeneidades del campo magnético
Lo que conviene ahora es corregir los errores de movimiento y los artefactos inducidos por [corrientes eddy](http://es.wikipedia.org/wiki/Corriente_de_Foucault). Existen dos versiones, la clásica es con:
``` eddy_correct_rotbvecs.sh ```

Este método es anticuado y sub-óptimo, pero lo único que se puede hacer en caso de no contar con imágenes con adquisición reversa de fase. En caso de contar con ellas, entonces utilizar la opción **Eddy correct revpe**. Por el momento no se ha utilizado completamente esta herramienta, pero en esta [página](http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup) se encuentra toda la información necesaria.

## Reacomodo de la tabla de gradientes para la compatibilidad de mrtrix
Si queremos usar mrtrix debemos cambiar el formato de la tabla de gradientes a como le gusta a mrtrix. Para ello usamos: 

``` inb_mrtrix_nii2mif.sh ```

El formato preferido de mrtrix es ``` .mif ```, pero es perfectamente feliz leyendo  ``` .nii ``` y ```.nii.gz ```, así que por comodidad utilizamos estos últimos. Esto quiere decir que no vamos a generar ningún archivo ``` .mif ```, pero sí nuestra tabla de gradientes. Entonces vamos a engañar un poco al script para que no genere el archivo ``` . mif ```, utilizando la opción ``` -onlyGrads ```. Por ejemplo:

``` inb_mrtrix_nii2mif.sh dwi_ec.nii.gz dwi_ec.mif dwi.bvec dwi.bval -flip_y -flip_z -onlyGrads ```

Esto generará el archivo ``` dwi_ec_encoding.b ``` en el cual el sentido de los componentes  ``` y ``` y  ``` z ``` de los gradientes están invertidos. Esto se requiere por el cambio de formato, y es dependiente de cada protocolo de imagen. Para saber qué componentes hay que invertir se hace por ensayo y error.

