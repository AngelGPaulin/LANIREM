## Deconvolución esférica de la señal DWI ##
Como vemos al final del script en preprocesamiento, obtener los FODs es ahora trivial:

``` dwi2fod -grad dti_ec_encoding.b -mask proc_mask.nii.gz proc_dwi_biasCorr_ratios.nii.gz proc_response.txt proc_FOD.nii.gz ```

