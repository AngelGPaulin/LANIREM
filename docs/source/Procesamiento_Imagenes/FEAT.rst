FEAT
====


Tutorial básico
-----------------------
💁 Para un tutorial paso a paso para el análisis de un diseño de bloques, pulsa :doc:`FSL-tutorialFeat`.


Para iniciar el uso de FEAT 
-----------------------

1.- Convertir archivos al formato adecuado 

Los archivos T1 y Funcional pueden estar en formato DICOM o en formato PARREC y ambos deben ser convertidos a formato NIFTI.

Para realizar dichas conversiones revise las siguientes ligas:
+ :doc:`Procesamiento-Imagen:-De-DICOM-a-NIFTI`
+ :doc:`Procesamiento-Imagen:-De-PARREC-a-NIFTI`

2.-  Utilizar BET (Brain extraction tool) 

Para poder utilizar la imagen estructural en FEAT, esta no debe tener tejido ajeno al encéfalo como lo las meninges o el cráneo. Para quitar estas estructuras de la imagen se usa en la terminal el comando :doc:`FSL_-Brain-extraction-tool-BET`.

3.- Abriendo FEAT 

Para abrir la herramienta, escribir en la terminal:**Feat** (¡No olvidar la mayúscula!)

Tips para uso de FEAT
-----------------------
+ ¿Qué datos ingresar en :doc:`cada pestaña <FEAT-Datos-en-pestañas>`
+ :doc:`FEAT:-Análisis-de-alto-nivel` (segundo y tercer nivel): En esta sección se describe cómo hacer un **análisis de alto nivel** con sus diferentes opciones.
+ :doc:`FEAT:-render-highres`: En este apartado podrás aprender a **fusionar una imagen funcional o anatómica** base con un mapa estadístico.
+ :doc:`FEAT:-FEATQuery`: Con esta herramienta puedes analizar el **flujo de cambio de la señal BOLD** en una región específica y obtener su porcentaje de cambio en relación a una condición experimental en particular. 
+ :doc:`FEAT_-Intersección`: Este análisis te permite encontrar las **regiones en común** entre dos categorías o contrastes de interés (ej.  A > B  +  C > B = intersección AC > B).
+ Dual Regression: Este análisis es utilizado para identificar de manera individual en los sujetos los mapas espaciales y cursos temporales asociados (componenetes), que fueron generados con un análisis ICA para multiples sujetos.

+ :doc:`FEAT:-Modificar-sin-GUI` Aquí aprenderás a **engañar a FEAT** para modificar el modelo sin la GUI.

¿Qué hay dentro de la carpeta FEAT?
-----------------------
Descripción breve de los archivos dentro de una :doc:`FEAT_-Archivos-carpeta-FEAT`.
