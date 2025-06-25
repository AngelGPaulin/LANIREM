FEAT alto nivel 
===============

## FEATs DE ALTO NIVEL

Los análisis de alto nivel se dividen en dos tipos: segundo y tercer nivel. Los análisis de segundo nivel incluyen, por ejemplo, contrastes en un mismo sujeto (utilizando sus diferentes COPES), mientras que los análisis de tercer nivel constituyen el promedio de un grupo de sujetos en una condición o contraste particular (directorios FEAT).

## Segundo nivel 

1. En la pestaña de Data se selecciona la opción: **inputs are 3D images from FEAT directories**, en input se seleccionan los COPES a utilizar (pertenecientes a un mismo sujeto). En el recuadro de **Output directory** se indica la ruta a la carpeta dónde se quiere guardar el archivo (si no se indica la ruta el default es la carpeta de dónde se están obteniendo los archivos FEAT ) y el nombre del análisis.

`Ejemplo: /datos/maquina/usuario/carpeta/subcarpeta/NOMBRE_DEL_ANALISIS` 

2. En la pestaña de **Stats** se elige entre **fixed effects** o **mixed effects** ; si son diferentes sesiones del sujeto se considera la opción de **Mixed effects**, pero si es una misma sesión se elige **fixed effects**. Dependiendo de cómo se realizó el primer nivel (condiciones A-B-A-B ) se elige **Model setup wizard** donde se permite elegir un promedio para un solo grupo así como opciones para dos grupos. La opción de **Full model setup** permite modelar el análisis e incluir contrastes entre los COPES utilizados como inputs. Dependiendo del número de inputs (COPES) aparecerán cierto número de EVs, sin embargo se pueden añadir más EVs y crear otras categorías (ej. la suma de dos EVs ). Además en esta opción (**Full model setup**) se pueden realizar contrastes o comparaciones entre las EVs:

[[images/full_model_setup.png]]

3.**Post-stats** aquí se puede seleccionar una máscara para delimitar posteriormente la región de interés y reducir de esta forma el número de comparaciones entre voxeles. Aquí se indica si se quiere, o no,  hacer corrección y de qué tipo, el valor de Z y el valor de la P. Además existen otras opciones para desplegar los resultados con una imagen de fondo que corresponde a un sujeto (sea su anatómica o su funcional) o al promedio de todos. Otras opciones permiten homogeneizar los valores de la Z, o bien, hacer transparentes los blobs para poder apreciar la imagen de fondo.
*Se puede elegir que aparezcan en nuestros resultados las gráficas con el curso temporal de la señal  (**time series plots**). 

## Tercer nivel

1. **Data** aquí se selecciona la opción: **inputs are lower-level FEAT directories**. En el recuadro de **number of inputs** se indica el número de FEATs que vamos a incluir, después se seleccionan sus directorios: COPES en particular ''(/datos/maquina/usuario/carpeta/subcarpeta/ejemplo.gfeat/cope1.feat)'',  o bien,  seleccionar todo el directorio ''(/datos/maquina/usuario/carpeta/subcarpeta/ejemplo.gfeat)'' y se corren todos los COPES simultáneamente. El recuadro de **output** es igual que en el segundo nivel.

2. En la pestaña de **Stats** se presentan varias opciones de **mixed effects** para modelar los datos, el comunmente usado porque es rápido y preciso es **FLAME 1** (para más información sostener el cursor sobre el recuadro o visitar http://fsl.fmrib.ox.ac.uk/fsl/fsl4.0/feat5/detail.html). Las opciones de ajuste del modelo son iguales a las de segundo nivel. 
En la opción de **Full model setup** tendremos una EV , si tenemos un solo grupo esa columna nos generará la media de todos los inputs que hayamos incluido (se incluyen poniendo un 1 en cada casilla); si tenemos alguna otra variable (ej. edad, respuestas correctas) que nos interese ingresar al modelo se pueden agregar más EVs y en cada input se van colocando sus valores. Si tenemos dos o más grupos, lo indicamos en la columna de **Group** numerando los inputs según el grupo (ej. 1,1,1,1,1,2,2,2,2,2,), además añadimos una EV por cada grupo (separarlos como variables explicativas nos permite hacer contrastes entre ellas, separar las medias, sacar medias considerando la influencia de cada una, etc.). Abajo de los rótulos de EV1, EV2.... hay una casilla para indicar su nombre. 
En la pestaña de **Contrasts & F-tests**  podemos especificar de qué EV queremos una promedio, ejemplo:   EV1 música , EV2  habla.

[[images/full_model_setup_3level.png]]

3. En **Post-stat**s se siguen las mismas indicaciones que para el segundo nivel.
