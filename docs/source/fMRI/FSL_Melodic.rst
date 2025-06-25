Melodic
=======

Para llevar a cabo un análisis de componentes independientes en Melodic es necesario contar con los archivos del "resting state" en formato NIfTI y las imágenes estructurales deben ser sometidas a la extracción de cerebro utilizando la herramienta `brain extraction tool <https://github.com/rcruces/C-13_wiki_demo/wiki/Brain-extraction-tool-bet>`_.  

*Es altamente recomendado que se utilcen las funciones por defecto con las que se ejecuta Melodic a menos de estar seguro que se deben alterar los parámetros*.

En la pestaña **misc** podemos seleccionar si deseamos ocultar la burbuja de ayuda, así como el reporte de progreso que se ejecuta en el explorador de internet. 

En la pestaña de **Data** se introduce el número de "entradas" y los archivos 4D del resting state. Seleccionamos también la carpeta destino para los resultados de análisis (output directory).
Se debe seleccionar el TR utilizado para la adiquisción de las imágenes.
Y tambien se puede seleccionar el valor para el corte del filtro paso banda para establecer el período temporal más largo que se va a permitir.

Pestaña **Pres-stats**

Podemos desactivar la corrección de movimiento que se lleva a cabo con MCFLIRT por defecto. Así mismo especificar el tipo de adquisición de rebandas (slice timing correction). 
Debido a que las imágenes estructurales utilizadas fueron sometidas a un BET esta opción debe estar activada. 
La normaliazción de la intensidad permite elegir la misma media de intensidad para todos los volúmenes.

Pestaña **Registration**

Para el registro de las imágenes usualmente se selecciona "main structural image" dónde se introducen las imágenes estructurales en el mismo orden que los archvios 4D de la pestaña **Data**. Se pueden cambiar los grados de libertad utilzados en el registro lineal. 
El espacio estándar corresponde al atlas utilizado en los registros. 

Pestaña **stats**. Es importante seleccionar aquí el tipo de ICA que queremos realizar, éste depende del número de sujetos a analizar y las secuencias utilizadas en la adquisición de datos. 

Pestaña **post-stats**. En esta ultima sección es posible indtroducir en las secciones "time series model" y "times contrasts model" los archivos **.mat** y **.con** respectivamente, los cuales fueron creados con la herramienta GUI en la elaboración del diseño experimental. 


[[images/gui.png]]
