MRtrix3
=======

**MRtrix3** es un software bastante popular para procesar, analizar y visualizar imágenes, especialmente las pesadas a difusión. El software fue lanzado allá por el 2019 por Donald Tournier y ha sido actualizado constantemente. Entre los análisis que MRtrix te ofrece esta la estimación de los FODs, tractografía mediante distintos algoritmos, análisis de conectividad cerebral, entre otros. Si estas trabajando con sustancia blanca, MRtrix te podría convenir. Ahora, no toooodo es enfocado en DWI, MRtrix tiene su visualizador `mrview` bastante comodo, tambien tiene muchos comandos que pueden ser muy útiles para el manejo de imágenes de resonancia en general, como por ejemplo `mrconvert`, `mrinfo`, `mrregister`, `mrtransform`, entre otros.

Por último, muy importante resaltar es que MRtrix esta bastante bien documentado y su uso es relativamente sencillo (una vez que le agarras la onda a la sintaxis) en este [link](https://mrtrix.readthedocs.io/en/latest/) te dejo su wiki donde podrás encontrar como instalarlo, conceptos claves, manuales de uso de los comandos y mucho más.  

***

## Configuración de Mrtrix

Hasta el día de hoy (abril 2024) existen dos versiones de `mrtrix` en el clúster:
```
module avail mrtrix

mrtrix/3.0.3
mrtrix/3.0.4
```
Carga la versión que deseas con `module load mrtrix/...`. Ten en cuenta que todos los comandos de mrtrix se ejecutan en la terminal. 


***

## Algunos procesos comunes con MRtrix:

+ [Pre-procesamiento](./MRtrix:-preproc)

+ [Deconvolución esférica de la señal DWI](./MRtrix:-DE)

+ [Anatomically constrained tractography (ACT)](./MRtrix:-ACT)

+ [Sacar AFD de un tracto](https://hackmd.io/@lconcha/ry2S2Fun0)
