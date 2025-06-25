Transformar una máscara
=======================

## Transformar una máscara (espacio estándar-atlas) al espacio del sujeto (fMRI)  

### 1. LLevar la máscara a un espacio nuevo


''arafat@tanner:~/Desktop/$ flirt -in  mascara.nii -ref funcional_sujeto.nii -applyxfm -init standard2example_func.mat -out Mascara_highres.nii''

**-in**       la máscara a utilizar

**-ref**      la referencia o espacio que se toma en cuenta para la transformación

**-applyxfm**  (este no sé qué indica pero va solo)

**-init**     aquí va la matriz de transformación, este archivo termina en .mat; este archivo cambia dependiendo de la referencia (-ref) que se tome, si es un sujeto o un espacio estándar, etc. En este caso es una matriz que se puede obtener de los mismos resultados de un obtenidos en el registro de un sujeto (primer nivel).

**-out**       el nombre de la máscara resultante

### 2. Cambiar el umbral de la nueva máscara y binarizarla  



''arafat@tanner:~/Desktop/$ fslmaths Mascara_highres.nii -thr 0.9 -bin Mascara_highres.nii''

**-thr**   es el umbral seleccionado,(las opciones van desde 0.9 que es muy conservador, hasta 0.5 que es más laxo)

**-bin** opción binarizar. Nota: entre cada opción se utiliza el nombre de la imagen que se va a modificar

* más detalles de las opciones en http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FLIRT/FAQ)
