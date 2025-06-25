Conectividad Funcional Basada en Semilla
========================================

# Seed-Based Correlation Analysis

En este tutorial aprenderás dos formas de hacer un seed-based correlation analysis (SCA) ya sea a usando AFNI y FSL  o usando R. Como bien sabes el SCA es uno de los métodos más sencillos  de estimar la Conectividad funcional en el cual primero se extrae la serie temporal promedio de una región de interés y luego  se computa un mapa de correlación (pearson) de esa serie de tiempo con la del resto de los voxeles de la imagen funcional. 

**Para seguir este tutorial puedes usar los siguientes archivos:**

- ###### [NIFTI  4D preprocesado](https://drive.google.com/file/d/14Mx4MbFO2GjrMWvq4-CHX3HHbiN_A3jh/view?usp=sharing) (pronto existirá una sección sobre preprocesamiento de datos de  resting state)

  ![](https://github.com/alffajardo/mri_data/blob/master/tutorials/sca/func.gif)

- **[ NIFTI ROI binario](https://github.com/alffajardo/mri_data/blob/master/tutorials/sca/pcc_mask.nii.gz)** (Consulta como hacer un ROI binario [aquí](https://www.youtube.com/watch?v=p70utwa-NkU&t=51s))

  ![](https://github.com/alffajardo/mri_data/blob/master/tutorials/sca/pcc_mask.png)

  

 **Nota importante:** Aunque quizás parezca obvio, no está de más decir que tu NIFTI 4D y tu ROI deben tener las mismas dimensiones x y z y estar en el mismo espacio. En este caso ambas imágenes ya se encuentran en el espacio del atlas MNI152

  
  
## OPCIÓN 1: USANDO FSL Y AFNI  DESDE LA TERMINAL

  para mayores facilidades puedes descargar el script **[rmap_afni.sh](https://github.com/alffajardo/mri_data/blob/master/tutorials/sca/rmap_afni.sh)**. Una vez que le hayas dado permisos de ejecución al archivo simplemente necesitas correrlo de la siguiente manera:

```rmap_afni.sh <archivo NIFTI preprocesado> < ROI binario> <nombre del output> ```
  
  ejemplo: 

  ```./rmap_afni.sh sub-001_bandassed_denoised_warp_FWHM4.nii.gz pcc_mask.nii.gz sub-001_pcc_corrmap```

  **A continuación explicaremos en detalle que es lo que hace este script:**
  
  **1.  Extraer la serie de tiempo promedio de tu funcional usando el ROI:**
  
```fslmeants -i sub-001_bandassed_denoised_warp_FWHM4.nii.gz -m pcc_mask.nii.gz -o pcc.ts```

Si realizaste bien este paso, al intrducir en la terminal el comando `head pcc.ts`  deberías ver lo siguiente:
  
 ``` 
  -3.744489014 
    1.972393204 
    10.74178089 
    14.54784234 
    8.430280266
   -5.448772119 
   -19.30749452 
   -25.47799781 
   -21.67057823 
   -11.75656644
```
**2. Obtener el mapa de correlación con AFNI**

```3dTcorr1D -prefix sub-001_pcc_corrmap.nii.gz sub-001_bandassed_denoised_warp_FWHM4.nii.gz pcc.ts```

Puedes visualizar el mapa de correlación con el visor de tu preferencia. para visualizarlo con fsleyes escribe:

```fsleyes -std sub-001_pcc_corrmap.nii.gz -dr 0.3 0.8   -cm red-yellow```


**Si hiciste todo bien deberías ver algo como en la siguiente imagen:**

![](https://github.com/alffajardo/mri_data/blob/master/tutorials/sca/sub-001_pcc_corrmap.png)

### Como podrás observar hemos obtenido un patrón muy conocido en la literatura. ¡¡Así es!! ¡¡Se trata de la ***Default Mode Network***!! 

***
## OPCIÓN 2: USANDO R

antes de correr el script  asegúrate de tener instalados los paquetes en R:
- oro.nifti
- neurobase
- RNifti

Si no los tienes instalados  simplemente abre una consola de R y escribe:

`install.packages(c("oro.nifti","neurobase","RNifti"))`

Para mayores facilidades puedes descargar el script **[gen_corrmap.R](https://github.com/alffajardo/mri_data/blob/master/tutorials/sca/gen_corrmap.R)**. Este script corre desde la terminal de bash pero llama a R para poder funcionar. En breve explicaremos cómo funciona. Para correrlo simplemente teclea desde bash:

`./gen_corrmap.R < NIFTI 4D > < ROI 3D > < nombre del output > `

**Ejemplo:** `./gen_corrmap.R  sub-001_bandassed_denoised_warp_FWHM4.nii.gz  pcc_mask.nii.gz pcc_map_R`

A continuación se explica lo que hace el script. Nota que se incluye sólo como realizar el análisis en la consola de R y para fines prácticos se excluyeron aquellos comandos necesarios para correr el script desde bash.

**1. Cargar los paquetes necesarios para trabajar**
  ```
library(magrittr)
library(oro.nifti)
library(neurobase)
```
**2. Definir nombre del output:**
 
```output <- "sub-001_pcc_corrmap_R"```

**3. Leer la imagen funcional y el ROI.** Se leen con paquetes diferentes
```
func <- RNifti::readNifti("sub-001_bandassed_denoised_warp_FWHM4.nii.gz")
roi <- readNIfTI("pcc_mask.nii.gz",reorient = FALSE)
```
**4. Obtener las dimensiones de la imagen funcional**

```
d <- dim(func)
```
**4. Crear una máscara para hacer el análisis**

```
func_mask <- niftiarr(img= roi, arr = 0)
func_mask@.Data <- func[,,,1]
func_mask[func_mask !=0] <- 1
```
Si lo deseas puedes visualizar  la máscara utilizando el comando `orthographic(func_mask,crosshairs=F)`

![](https://github.com/alffajardo/mri_data/blob/master/tutorials/sca/func_mask.png)

### **5. Extraer la serie temporal del ROI**

```
ts <- matrix(func[roi!=0],ncol = d[4]) %>%
  colMeans()
```
**6. Aqui se estan haciendo dos pasos. Primero se están extrayendo los datos de la imagen funcional que se encuentran dentro la máscara y transponiendolos a una matriz de dos dimensiones el cual el número de columnas será el número de puntos temporales de la imagen 4d. Una vez vectorizados los datos,cada una de las filas de la matrix (series temporales de cada vóxel en la máscara) se correlaciona con la serie de tiempo obtenida el paso anterior y se almacenan los coeficientes de pearson en un objeto llamado rvalues.**

```
rvalues <- matrix(func[func_mask !=0],ncol=d[4]) %>%
  apply(.,1,cor,ts)
```

**NOTA:** Quizás te preguntes por qué no hicimos directamente las correlaciones con un ciclo for iterando sobre las coordenadas de cada uno de los voxeles de la  imagen funcional. la respuesta es que al realizar literalmente miles de procesos iterativos en un ciclo for, eso haría que tu código fuera asquerosamente lento. Realmente no quieres eso.

**7. Utilizamos la máscara creada previamente para llenarla con los datos recién computados (coeficientes de pearson).**
```
rmap <- func_mask
rmap[rmap !=0] <- rvalues
```
 **8. Escribir el output** 

```
write_nifti(rmap,output)
```
### Si observas con atención notarás que los resultados de ambos scripts son identicos. Así que puedes usar el que te sea más fácil. Si deseas adquirir un nivel mayor de experiencia sobre lo que estás haciendo te recomendamos estudiar el código de R que se ha provisto.Recuerda que para hacer analisis de grupo aún necesitas aplicar la transformada de Fischer a los datos.

![](https://github.com/alffajardo/mri_data/blob/master/tutorials/sca/sub-001_pcc_corrmap_R.png)
