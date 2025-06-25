Procesamiento Imagen
====================

Las imágenes médicas, en este caso de resonancia magnética, por si solas solamente nos brindan información cualitativa, lo cual si estamos en el ámbito de la investigación pues no resulta altamente informativa. Por eso el procesamiento de estas imágenes viene de gran relevancia, ya que através del procesamiento nosotros vamos a poder extraer y destacar información importante de modo que facilité su posterior análisis. 

El tipo de procesamiento dependerá absolutamente del tipo de imágen que estes trabajando, es decir, no es lo mismo procesar imágenes anatómicas T1w a imágenes pesadas a difusión. Tambíen te encontraras que la comunidad de científicos que desarrollan estas herramientas es _muy_ activa, por lo tanto existen vaaarias opciones. En esta entrada vas a encontrar los softwares que más se utilizan, que son robustos y sobre todo bien documentados.  

***


Herramientas para el procesamiento de imágenes.
-----------------------

Aquí abajo encontraras unos de los software más utilizados en la comunidad científica de "resonólogos" con una breve introducción. Dale clic al nombre del software para ver información más detallada jusnto con manuales que han aportado los usuarios de la wiki. 

+ :doc:`FSL`

FMRIB Software Library es una colección de herramientas muy popular para el procesamiento de imágenes estructurales, funcionales y de difusión. Tmabién cuenta con funciones que incluyen el análisis estadístico de dichas imágenes. FSL es completamente open source y esta bastante bien documentado, en su `wiki <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki>`_ puedes encontrar toda la información necesaria para empezar a procesar tus imágenes. 

+ :doc:`MRtrix3`

Uno de los favoritos es MRtrix3 que cuenta con una larga colección de herramientas para procesar, visualizar y analizar imágenes sensibles a difusión 
(DWI). Si bien esta muuuy enfocado a las DWI, muchas herramientas son útiles para manejar imagenes en general. Mrtrix esta tambíen super bien documentado, aquí puedes checar su `wiki <https://mrtrix.readthedocs.io/en/latest/>`_.

+ :doc:`Grosor-cortical`

Un clásico!, FreeSurfer es de los softwares más utilizados para analizar imágenes de humanos. Dentro de su libreria hay montones de funciones para procesar imágenes estructurales, funcionales y de difusión. Puedes realizar desde registros, hasta  tractografía y mapeo funcional. Aquí te dejo su `wiki <https://surfer.nmr.mgh.harvard.edu/fswiki>`_ para que lo cheques. 

+ :doc:`BIDS`

El Brain Imaging Data Structure es una manera estandarizada de organizar y esrtucturar tus datos de neuroimagen. Es altamente recomendable esta practica, sobre todo ya que facilita el compartir los datos o incluso el análisis. En esta entrada viene información de como utilizar los contenedores en el cluster.   

+ :doc:`ImageJ`

ImageJ/FIJI es un software para analizar, procesar, editar y visualizar imágenes de **microscopia**! Si estas haciendo histología como parte de tu proyecto, este es el software que necesitas. Tiene una cgran antidad de plugins y funciones que te van a permitir hacer una muchos tipos de procesos de manera efectiva. Si bien los comandos de cajon estan muy bien documentados, muchos de los plugins tienen una documentación medio irregular y toca aprender a pura prueba y error. Aquí te dejo el `link <https://imagej.net/ij/>`_ de su pagina web.

Transformación de Datos
-----------------------

+ :doc:`Procesamiento-imagen_Compresion`
+ :doc:`Procesamiento-imagen:-Traslado`
+ Convertir de :doc:`Procesamiento-Imagen_De-DICOM-a-NIFTI`
+ Convertir de :doc:`Procesamiento-Imagen_De-PARREC-a-NIFTI`
