# Archivos dentro de una carpeta FEAT 

## Carpetas 

### Custom_timing_files 
En esta carpeta se encuentran tus archivos .times, con el nombre ev#.tx. El número se relaciona con el orden en que fueron ingresados.

### logs 
Aquí se encuentran archivos que indican qué hizo fsl para realizar el analisis FEAT.

### mc (motion correction) 
Aquí se encuentran los archivos referentes al análisis mcflirt de corrección de movimiento.

### reg 
Aquí se encuentran los archivos relacionados con el registro de la imagen funcional a la anatómica. 

### reg_standar 
Aquí están los archivos sobre el registro hacia la imagen standar.

### stats 
Aquí estan los archivos relacionados al análisis estadístico. Estos archivos muestran los mapas estadísticos en la imagen funcional, desde archivos pe, cope, varcope e incluso los zstats. 

### tsplot 
Aquí tienes archivos relacionados a tu señal BOLD y como se ajusta a tus diferentes variables. 

## cluster_mask_zstat#.nii.gz 
Estos archivos son máscaras de los clusters de cada uno de tus contrastes. Al abrirlos en fslview, verás cada cluster con intensidades diferentes. El que tiene mayor intensidad tinene mayor número de voxeles, y así sucesivamente. 

## cluster_zstat#.txt/.html 
Estos archivos te muestran los cluster que pasaron el umbral estadístico en espacio del sujeto, es decir, las coordenadas están en voxeles.

## cluster_zstat#_std.txt/.html 
Al igual que el archivo anterior, éstos te muestran los clusters que pasaron el umbral estadístico pero en el espacio estándar, por lo tanto las coordenadas estarán en milímetros (mm).

## lmax_zstat#.txt 
Estos archivos te muestran los voxeles con mayor valor estadístico de cada uno de los clusters.

## rendered_thresh_zstat#.nii.gz 
Ente archivo lo puedes abrir con fslview. Muestra los clusters que pasaron el umbrar estadístico sobre la imagen funcional del sujeto, en una escala de color rojo. 

## thresh_zstat#.nii.gz 
Te muestra los clusters que pasaron el umbral estadístico. Es en este archivo en donde puedes especificar el color de la escala y los valores mínimos/máximos de brillo en fslview.

"" desing.con/.mat/.frf/.fsf/.min 
Estos archivos tienen que ver con el diseño de tu modelo. Principalmente el archivo [[enganar|desing.fsf]],  el cual es la receta que sigue fsl para realizar todos los análisis que usualmente especificas con la GUI de FEAT. 
