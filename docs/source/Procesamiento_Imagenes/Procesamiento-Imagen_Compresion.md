Compresión/Descomprensión de imágenes
=====================================

## Compresión de archivo


Comprime las imágenes en formato `.tar` para poder subirlas al cluster, después de la obtención de datos en el resonador:

  - En la máquina de la unidad de resonancia, buscar el nombre del sujeto de estudio (actualmente en la carpeta "dicom2015").
  - Click derecho y poner la opción `7-zip`.
  - Seleccionar la opción `ad to archive`.
  - Seleccionar la opción `Tar`.

## Descomprensión de archivo 
  * Entrar al directorio dónde se encuentran las imagenes:  
```{bash} 
cd datos/purcell/juan/mis_niftis/ 
```  
  * Usar el comando **tar** con la opcion **xvf** para descomprimir. (x-extract, f-file, v-verbose)  
``` {bash} 
tar xfv sujeto_00.nii.gz 
```
  * Si es un archivo **rar** usar el siguiente comando:  
```{bash} 
unrar x archivo.rar 
```  
  
