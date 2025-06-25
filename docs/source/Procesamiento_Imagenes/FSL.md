
FSL
===

# FMRIB Software Library - FSL

FSL es una libreria _open access_ de herramientas para el análisis de imagenes de resonancia magnética, desarrollada por investigadores de la Universidad de Oxford. Al día de hoy cuenta con una colección extensa para el análisis y procesamiento de imágenes estructurales, pesadas a difusión (DWI) y funcionales (fMRI). La librería FSL no le hace el feo a nadie y la puedes descargar en cualquier sistema operativo Linux, macOS o Windows (bueno, poquito a windows, hay que hacerlo mediante WSL). En este [link](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation) te dicen como paso a paso.

## Herramientas
En esta sección estan las herramientas más utilizadas de FSL y una breve introducción de qué hace. 

### Imágenes estructurales

+ [fsl_anat](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/fsl_anat) : si lo que buscas es una manera directa de procesar tus imágenes T1w, esta es una opción. El pipeline tiene la ventaja de que envuelve todas las herramientas de abajo.  
+ [BET](./FSL_Brain-extraction-tool-BET) : esta herramienta elimina todo lo que no sea tejido de cerebro en la imágen, así como las superficies del cráneo. 
+ [FAST](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FAST) : realiza una segmentación de los diferentes tejidos del cerbero, ya sea sustancia gris, blanca, liquido cefaloraquídeo, etc. 
+ [FIRST](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FIRST/UserGuide) : por otro lado, esta herramienta segmenta areas subcorticales. 
+ [FLIRT](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FLIRT) : es una herramienta robusta para registrar imágenes de manera lineal y no lineal con [FNIRT](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FNIRT).

### Imágenes funcionales

+ [FEAT](./FEAT) : herramienta bastante extensa y robusta para procesar y analizar datos funcionales. 
+ [MELODIC](./FSL_Melodic) : sirve para realizar un análisis de componentes independientes. 

### Imágenes difusión

+ [FDT](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FDT) : es una herramienta para el análisis de las DWI y lo puedes correr desde una interfaz gráfica o desde la terminal. Este pipeline incluye eddy, ajuste de tensores y tractografía. 
+ [TBSS](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/TBSS) : esta herramienta proyecta todos los mapas de FA de todos los sujetos de estudio (a partir de un registro no-lineal) en un "esqueleto" de FA promedio. 
+ [EDDY](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy) : forma parte fundamental del preprocesamiento, ya que corrige tanto el moviemiento del sujetoo como las distorsiones generadas por los cambios en los gradientes de difusion. 
+ [TOPUP](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup) : a la par de eddy, esta herramienta esta diseñada para corregir las distorsiones causadas por las inhomogeneidades del campo magnético. Por ejemplo, si adquirimos las imágenes en una dirección postero-anterior, la imágen resultante tendrá la distorsión notoria en la parte mas anterior (donde parece que la cabeza tiene un chipote gigante). 


⭐ Recuerda que si eres miembro de la wiki y usas algunas de estas herramientas puedes colaborar generando nuevas entradas con tus mejores tips!


***

## Manejo de versión de FSL

Gracias a los [módulos](./Modules) ya no tendrás conflicto entre versiones. Hasta el momento (Abril 2024) hay dos versiones en el Cluster:

```
module avail fsl

fsl/6.0.7.1
fsl/6.0.7.4
```

Lo unico que tienes que hacer es elegir la version con la que quieras trabajar y mandarla a llamar con `module load`. Como sugerencia, realiza tus análisis siempre con una misma versión. 


## Algunos tips del uso de FSL

+ [Región de Interés: fslroi](./FSL_ROI): Extrae una región de interés (ROI region of interest) de una imagen.
+ [Mapas cuantitativos: fslstats](./FSL_Stats): Extraer valores de un mapa cuantitativo.
+ [Reorientar imágenes](./FSL_Reorientar-imagenes): Para visualizar las imágenes de forma habitual.
+ [Quitar volúmenes de un archivo niffti](./FSL_Quitar-volumen-NIFFTI)
+ [Transformar una máscara](./FSL_Transformar-mascara) (espacio estándar-atlas) al espacio del sujeto (fMRI).
