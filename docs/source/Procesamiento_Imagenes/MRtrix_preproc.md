## Pre-procesamiento ##
Para garantizar que la amplitud de las FOD no esté modulada por inhomogeneidades de B1, y para estandarizar las unidades con la que se miden (en lugar de arbitrarias, que sean un porcentaje de las imágenes b=0), tenemos el script ```
 inb_mrtrix3_preproc.sh ``` . A manera de ejemplo:

1. Obtener una máscara. Primero debemos extraer el primer volumen y luego correr bet.

``` fslroi dti_ec.nii.gz b0 0 1 ```

```bet b0.nii.gz b0 -m -n -f 0.25 ```


2. Ahora sí corremos el script de preprocesamiento de mrtrix3

:warning:  Este script ya está viejo (2014). Se recomienda usarlo como guía, pero no usarlo directamente (lconcha, 2021)

``` inb_mrtrix3_preproc.sh dti_ec.nii.gz dti_ec_encoding.b 1000 b0_mask.nii.gz proc ```

Este paso es tardado, suficiente para un café. Una vez concluido, generará los siguientes resultados:

  * ``` proc_mask.nii.gz ```  Una máscara del cerebro que trata de minimizar la periferia ruidosa del cerebro. No es perfecta, pero es mejor que la previa.
  * ``` proc_dwi_biasCorr_ratios.nii.gz ```  Uno de los dos resultados principales. Son las imágenes DWI pero (a) corregidas por inhomogeneidades de B1 y con unidades [0 1].
  * ``` proc_avDWI_ratios.nii.gz ``` El promedio temporal del archivo ```proc_dwi_biasCorr_ratios.nii.gz ```. Util para usar como fondo anatómico en mrview.
  * ``` proc_dwi_bias_field.nii.gz ``` El factor de compensación B1 aplicado a las imágenes DWI originales.
  * ``` proc_response.txt ``` El otro resultado importante. Es la response_function a utilizar para realizar CSD.  Usando ``` cat proc_response.txt ``` podemos ver el contenido. En este ejemplo es ``` 1.759339452 -0.5281734467 0.1055925936 -0.01716192625 0.0004632802156 ```. El script usará ```lmax ``` tan alto como los datos lo soporten, por lo que el número de coeficientes puede variar, pero los rangos de los valores deben ser similares a éstos.
