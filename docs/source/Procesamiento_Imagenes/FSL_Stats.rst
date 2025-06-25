Mapas cuantitativos: fslstats
=============================

Algo que se requiere muy frecuentemente es extraer el valor de algunos voxeles dentro de un volumen de mapas cuantitativos, como por ejemplo un mapa de FA. La herramienta más práctica para ésto es fslstats. Vamos a ver un ejemplo:

Me interesa sacar el valor de FA en una región del cuerpo calloso. Lo primero es hacer una máscara, y en este caso lo voy a hacer con fslview, aunque se puede hacer con mrview, con freeview, itksnap, matlab, o cualquier cosa que me sepa grabar un archivo nifti con las mismísimas dimensiones que el mapa que quiero consultar. Esta es mi máscara (o región de interes, ROI), y se llama miROI.nii.gz:

[[images/roi_fa.png]]

Ahora quiero sacar el valor promedio de FA de los voxeles dentro del ROI, así como su desviación estándar y el número de voxeles y volumen correspondiente del ROI:

  fslstats fa.nii -k miROI.nii -M -s -v

lo cual me arroja:

  0.869577 0.055804 30 240.000000

Los resultados van en el orden en que los pedí: la media de FA es de 0.869, su desviación estándar es de 0.055, hay 30 voxeles en el ROI, y eso da un volumen de 240 mm cúbicos.

No estamos casados con fsl, así que podemos usar mrstats (parte de mrtrix):

::

   mrstats fa.nii -mask miROI.nii 
   channel         mean        std. dev.   min         max         count
   [ ]             0.869577    0.0548657   0.745245    0.980753    30  
   
En general, fslstats tiene más opciones de salida que mrstats.

Ojo, que la máscara que acepta fslstats como ROI debe ser binaria (ceros en todos lados, excepto lo que me interesa). En efecto, todo lo que no valga cero, fslstats lo convierte en uno, así que aguas.

Pero, no es raro tener un volumen que tenga varios ROIs, cada uno identificado con un número (por ejemplo, los archivos cluster_mask_zstat que arroja FEAT después de hacer un análisis de BOLD). Si queremos los valores de adentro de un solo cluster, tendríamos que extraer primero ese cluster y generar una máscara binaria. Por ejemplo, si me interesa el cluster con el índice 3:

  fslmaths cluster_mask_zstat1.nii.gz -thr 3 -uthr 3 -bin miROI.nii.gz
  
Con esto logramos extraer el cluster 3, binarizarlo, y ponerlo en el archivo miROI.nii.gz, que ahora podemos utilizar con fslstats como arriba.

Dado que esta es una operación frecuente, existe un script en el lab para facilitar lo arriba mencionado:

::

   fslstats_rois data.nii.gz rois.nii.gz roi_idx stats
   
     data.nii.gz : The file from which we want stats
   	rois.nii.gz : A file with several ROIs drawn, each one with a different voxel value (ints)
   	roi_idx     : The voxel value of the ROI that we want
   	stats	    : The list of statistics we want, as in fslstats options. 
   		      If using more than one switch, put it between quotes, as in the example.
   
   
    Example :
   	fslstats_rois data.nii.gz rois.nii.gz 4 "-m -s -c"
