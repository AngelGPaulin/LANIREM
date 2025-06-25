FEATQuery
=========

1.Abrir FEATQuery desde la terminal:   ''arafat@tanner:~$ Featquery'' o abrirlo desde la interfaz de FSL (**Misc**)


2. Ingresa el número y la ruta de los directorios FEATs (promedios o contrastes) en el recuadro de **Number of FEAT directorie**s.  Se puede elegir un sólo sujeto o un promedio de varios los sujetos, la diferencia será que en la lista final, en el primer caso, cada línea será un punto temporal en el que se evalúa la respuesta hemodinámica (en el mismo sujeto), mientras que para el análisis de un grupo cada linea en la lista es un sujeto. 

3. La segunda opción es seleccionar la región de interés ya sea definida anatómicamente o funcionalmente: 

  a) seleccionar una máscara de los atlas ya disponibles en FATQuery  con la opción de **Use atlas**; 

  b) seleccionar una máscara de otros atlas que no estén ahí (ej. FSLview) cargando el archivo;
 
  c) seleccionar una máscara de una región de interés (ROI) definida funcionalmente (de algún resultado FEAT). En esta última podemos considerar la opción de darle las coordenadas específicas de un voxel, o bien, analizar una región más grande usando una máscara de algún cluster.

4. **Output options** , en esta sección se especifican los datos que queremos que se desplieguen como resultado del análisis. La primera opción (**use atlas**) nos permite utilizar el pico máximo de activación y buscar en el atlas que elijamos la estructura que se superponga con nuestro voxel. Las siguientes opciones permiten  :

  a) **Convert PE/COPE values to %** , transformar los valores de nuestros parámetros en porcentajes, está opción es casi obligatoria.

  b) **Do not binarise mask**  respeta y mantiene los valores de cada voxel de la máscara (funcional), como resultado del FEAT.

  c) **Change post-interpolation thresholding of mask**, esta opción permite interpolar la máscara de un espacio estándar o de alta resolución a un espacio de baja resolución (imagen funcional).

  d) **Threshold stats images as well as masking**, esta opción se selecciona si se desea considerar unicamente los voxeles (de la máscara) que pasen un determinado umbral estadístico (el valor se debe de especificar en el recuadro).

  e) Las opciones de **Create timeseries plots** y **popup results in the web browser** son seleccionadas por default y son similares a las que se obtienen en los análisis FEAT.

  f) **Featquery output directory name**, si no se especifica nada (ni nombre ni ruta) el resultado se guarda en una carpeta denominada featquery dentro del archivo que contiene el FEAT que se está utilizando. 

5. Simplemente  **GO**
