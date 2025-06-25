## Anatomically constrained tractography (ACT) ##
Para poder realizar ACT necesitamos una imagen en donde se segmente los tejidos de acuerdo a 

(1) s. gris cortical, 

(2) s. gris subcortical,

(3) s. blanca, 

(4) LCR  

(5) tejido patológico. A esta convención mrtrix3 la llama un archivo 5TT (5-tissue type) y es necesario para correr ACT y SIFT. Lo ideal sería tener imágenes DWI corregidas mediante obtención reversa de fase, y co-registrar imágenes T1 de las cuales podemos derivar este archivo 5TT, pero en caso de no tenerlo, podemos usar un script que trabaja únicamente en espacio DWI:

``` inb_mrtrix3_create_5TT_from_DWI.sh <fa[.gz]> <adc[.gz]> <output5TT.nii[.gz]> ```

Como no tenemos aún los archivos de FA ni ADC, podemos usar ``` inb_mrtrix_proc.sh ``` con el switch ``` -noCSD ``` para generarlos.

