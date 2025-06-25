## ¿Qué datos ingresar en cada pestaña?

### Data
Pulsar el botón **Select 4D** data para seleccionar el archivo en formato NIFTI ya reorientado con las imágenes funcionales.

**Output directory:** seleccionar la carpeta de destino.

Colocar el **TR** usado durante la adquisición.


### Pre-stats
**Slice timing correction:** 

       Pulsar el botón y elegir el modo en que fueron adquiridas las imágenes.
	   
### Stats
Activar opción **Add motion parameters to model**

Pulsar el botón **Full model setup**
 
  **EVs**

       En la opción Number of original Evs colocar el número de bloques.
       En la opción EV name colocar el nombre designado a cada bloque.
       En la opción Basic shape: elegir Custom (3 column format). Se desplegará la opción para elegir el archivo .times convertido de eprime.

   **Contrasts & F-tests**

	Elegir el número de contrastes deseado
	Pulsar el botón Done y aparecerá una ventana con el modelo
	
### Registration
Activar la opción **Main structural image**. Elegir el archivo de la imagen anatómica en formato NIFTI y reorientado.

Después de esto se generará una carpeta con la extensión FEAT que es el resultado final.
