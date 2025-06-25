Reorientar imágenes
=============================

## Para visualizar de manera "normal" las imágenes (tanto funcionales como estructurales) 

Hay veces en las que al abrir una imagene en FslView se observa con una orientación diferente a la que estamos acostumbrados. En la mayoría de los casos sólo es la visualización la que no está bien, lo cual no interfiere con los análisis que se realicen con las imágenes. 

Lo primero que hay que hacer es verificar si las etiquetas que pone FslView son correctas. Es decir, aunque la imagen esté rotada, ver si ésta conserve sus etiquetas corrrectas (e.g., lo superior lo marca como superior aunque se observe en la parte izquierda). Para evitar esta "incomodidad" se recomienda agregar -reorientar al final del comando para transformar a nifti las imágenes.

inb_dcm2nii.sh Input Output **reorientar**

Si no se soluciona el problema, puede intentarse con el comando fslreorient2std. Este comando asume que la imagen tiene información válida sobre la orientación (que las etiquetas son correctas). Esta no es una herramienta de registro, solamente rota la imagen para mostrarla similar a la imagen estándar.

fslreorient2std Input Output 

Si tu imagen no tiene las etiquetas correctas se considera un problema grave; en la mayoría de los casos relacionados con el header. Para solucionar ese tipo de problemas más específicos, aquí hay información: http://fsl.fmrib.ox.ac.uk/fsl/fslwiki/Orientation%20Explained
