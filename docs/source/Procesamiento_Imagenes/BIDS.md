BIDS
====

[BIDS](https://bids.neuroimaging.io/) es un estándar de almacenamiento de datos, que mediante una jerarquía de carpetas y nomenclatura específica de archivos, permite la utilización transparente (y supuestamente sencilla) de complicados [*pipelines*](http://bids-apps.neuroimaging.io/) de procesamiento de imágenes reunidos en *contenedores* tipo [Docker](https://www.docker.com/) y/o [Singularity](http://singularity.lbl.gov/) que facilitan la reproducibilidad de los resultados. Puede usarse para analizar fMRI, DWI, e imágenes anatómicas.


No es la intención de esta página el repetir lo que ya está dicho de cómo se organizan los datos en BIDS, pues para ésto hay tutorales. [Aquí están los tutoriales oficiales](https://github.com/bids-standard/bids-starter-kit/wiki/Tutorials), pero una búsqueda en Google revelará muchos más.

Una vez que organices tus datos, revisa que hayas hecho un buen trabajo, validando tu fólder bids mediante el [bids validator](http://bids-standard.github.io/bids-validator/).


Listo para correr un contenedor? Tenemos instalado [Singularity](http://singularity.lbl.gov/) en el cluster del laboratorio! De igual forma, está instalado en el LAVIS!

Como ejemplo, veamos cómo correr [fmriprep](https://fmriprep.readthedocs.io/en/stable/).  [Sigue esta liga para un corto tutorial.](./fmriprep)

***

## PPMI
Para notas sobre cómo bajar datos de [PPMI](https://www.ppmi-info.org/) y convertirlos a BIDS, visita [aquí](./ppmi_bids).


***

## Convertir tus imágenes pre-clínicas en formato BIDS

Para mayor control y estandarización en la organización de tus imágenes, se recomienda el uso de BIDS. Y también tiene la ventaja de que es muchísimo mas rápido convertir todas tus imágenes que están en el Bruker en formato nifti. 

En este tutorial te digo como hacer la conversion utilizando las herramientas de `BIDS converter` ya englobadas en un script que hará todo el proceso de conversion por ti. Sin embargo hay solo un preparativo previo: tienes que pasar a un directorio todos las carpetas del bruker que desees convertir. 

Accede a la ruta del bruker:
```
ls /misc/bruker7/data02/user/...
```

Una vez que identificas las imágenes de tu experimento, las moveremos a tu directorio de trabajo (`/misc/../..`):

`cp -r /misc/bruker7/data02/user/mi_usuario/mis_imagenes* /mi/directorio/de/trabajo/`
> Usa las rutas de acuerdo a tu usuario y el directorio donde almacenas tu información.

Ahora si usaremos el script de abajo que ya engloba las dos funciones de bruker para realizar la conversion `bids_helper` que generará el archivo `.csv` de la descripción de tu dataset y `bids_convert` que hará toda la conversión. 

Abre `micro` o `nano` en la terminal y haz _copy & paste_ lo siguiente:

```bash

#!/bin/bash


module load brkraw/0.3.11


raw_dir=$1

mkdir ${raw_dir}/BIDS
bids_dir=${raw_dir}/BIDS
csv_filename=dataset_description

brkraw bids_helper $raw_dir ${raw_dir}/${csv_filename} -j 


brkraw bids_convert $raw_dir ${raw_dir}/${csv_filename}.csv -o $bids_dir

```

Ahora cierra el editor, nombra el script como bruker2bids.sh y luego escribe en la terminal: `chmod a+x bruker2bids.sh`

Listo, ahora usaremos el código de la siguiente manera:

```
bruker2bids /la/ruta/de/mis/imagenes/crudas/
```

> Modifica la ruta del directorio por la ruta donde tienes guardadas las imágenes crudas que pasaste del bruker.

La organización quedará de la siguiente manera:

```bash

raw_dir
   \- bruker_raw_folder                               
   \- bruker_raw_folder
   \- bruker_raw_folder
   .
   .
   .
   .
   \- dataset_description.csv
   \- dataset_description.json
   \- BIDS
       \- README
       \- dataset_description.json
       \- participants.json
       \- participants.csv
       \- sub-001
            \-anat
                \- nii.gz
            \-dwi
                \- .bval
                \- .bvec
                \- nii.gz
            \-fmap
                \- nii.gz
            \-func
                \- nii.gz

       \- sub-002
            .
            .
            .

```
