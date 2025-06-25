Bruker Biospec 70/16
====================

Para usar el resonador Bruker es necesario acreditar un proceso de certificación. Para ello es necesario contactar al Dr. Juan Ortiz.


Algunos datos sobre el resonador:

* Bruker Biospec 70/16: 70 porque es un 7 Tesla, y 16 porque su túnel tiene 16 cm de diámetro.
* El resonador tiene un magneto  `Pharmascan <https://www.bruker.com/products/mr/preclinical-mri/pharmascan/overview.html?gclid=EAIaIQobChMIo-bPoJCW4QIVx7jACh3UYAvBEAAYASAAEgIKrfD_BwE>`_, sin embargo toda la electrónica y los gradientes son de un `Biospec <https://www.bruker.com/products/mr/preclinical-mri/biospec/overview.html?gclid=EAIaIQobChMIrY6ZtpCW4QIVhIbACh3L_wZLEAAYASAAEgJdofD_BwE>`_. Por lo tanto, el resonador es _de facto_ un Biospec.


La transferencia de los datos se puede realizar en varios formatos:

* Formato DICOM: En Paravision seleccionar los datasets que requieres, da clic derecho y elige ``convert to Dicom``. Al finalizar te dará la ruta donde se guardaron, que es por default dentro del data set. Ahora tienes dos opciones: Los sacas directamente del resonador usando una USB, o los sacas usando ``/misc`` (ver adelante).
* Formato NIFTI: Obten primero tus datos en DICOM  y posteriormente conviértelos en tu máquina usando `mrconvert <https://mrtrix.readthedocs.io/en/latest/reference/commands/mrconvert.html>`_ de Mrtrix3, o `dcm2niix <https://github.com/rordenlab/dcm2niix>`_.


***

Como exportar mis datos desde el Bruker
---------------------------------------

Los datos que se almacenan en el bruker estan en ruta ``/misc/bruker7/data01/`` o ``/misc/bruker7/data02/`` al cual podemos acceder de la siguiente manera: 

::

   cd /misc/bruker7/data02/user/mi_usuario
   
Lo siguiente es localizar los archivos que deseas convertir. Puedes buscarlos al usar el comando ``ls`` o maás fácil, buscarlo utilizando un ``*`` si sabes el nombre de tu archivo. 

::

   ls *irm150d_rata64A*

``20220104_085643_INB_C13_hluna_irm150d_rata64A_INB_C13_hluna_1_1 ``, y es el que voy a utilizar de ahora en adelante como ejemplo.

Donde ``20220104`` es la fecha de adquisición y ``INB_C13_hluna_irm150d_rata64A_INB_C13_hluna`` el nombre que le das a tu estudio. Si nosotros enlistamos (``ls``) esta carpeta para ver que hay adentro, veremos que hay carpetas enumeradas al inicio, estos corresponden a cada adquisición en el orden en el que fueron tomadas y son las que vamos a ir convirtiendo.

::

   ls 20220104_085643_INB_C13_hluna_irm150d_rata64A_INB_C13_hluna_1_1/
   
   1  2  3  4  5  6  7  8  AdjResult  AdjStatePerStudy  Mapshim  ResultState  ScanProgram.scanProgram  subject
Bien, hasta aqui ya sabemos como acceder a tus imágenes del Bruker, siguiente paso es exportarlas en formato Nifti.

Paso numero uno es cargar el modulo de Bruker (gracias a Ricardo Rios que nos hizo la vida mas facil al crear los modulos, si aun no te familiarizas con ellos, da click `aquí <https://github.com/c13inb/c13inb.github.io/wiki/Modules>`_ y aprende mas a como usarlos.


::

   module load brkraw/0.3.11
Una vez cargado el módulo estas listo para utilizarlo. Si quieres saber la información detallada de cada una de tus adquisiciones, puedes utilizar el comando ``brkraw info`` que nos despliega la siguiente información:

::

   brkraw info 20220104_085643_INB_C13_hluna_irm150d_rata64A_INB_C13_hluna_1_1/
::

   Paravision 7.0.0
   ----------------
   UserAccount:    conchalab 
   Date:           2022-01-04
   Researcher:     rata64A
   Subject ID:     INB_C13_hluna_irm150d_rata64A
   Session ID:     INB_C13_hluna_irm150d_rata64A
   Study ID:       1
   Date of Birth:  07 Aug 2021
   Sex:            male
   Weight:         0.433 kg
   Subject Type:   Quadruped
   Position:       Prone           Entry:  HeadFirst
   
   [ScanID]        Sequence::Protocol::[Parameters]
   [001]   Bruker:FLASH::1_Localizer::1_Localizer (E1)
           [ TR: 100 ms, TE: 2.50 ms, pixelBW: 159.22 Hz, FlipAngle: 30 degree]
       [01] dim: 2D, matrix_size: 256 x 256 x 3, fov_size: 50 x 50 (unit:mm)
            spatial_resol: 0.195 x 0.195 x 2.000 (unit:mm), temporal_resol: 12800.000 (unit:msec)
   [002]   Bruker:FLASH::1_Localizer::1_Localizer (E2)
           [ TR: 100 ms, TE: 2.50 ms, pixelBW: 159.22 Hz, FlipAngle: 30 degree]
       [01] dim: 2D, matrix_size: 256 x 256 x 3, fov_size: 50 x 50 (unit:mm)
            spatial_resol: 0.195 x 0.195 x 2.000 (unit:mm), temporal_resol: 12800.000 (unit:msec)
   [003]   Bruker:FLASH::1_Localizer::1_Localizer (E3)
           [ TR: 100 ms, TE: 2.50 ms, pixelBW: 159.22 Hz, FlipAngle: 30 degree]
       [01] dim: 2D, matrix_size: 256 x 256 x 3, fov_size: 50 x 50 (unit:mm)
            spatial_resol: 0.195 x 0.195 x 2.000 (unit:mm), temporal_resol: 12800.000 (unit:msec)
   [004]   Bruker:FLASH::T1_FLASH::T1_FLASH (E4)
           [ TR: 201.57 ms, TE: 3.50 ms, pixelBW: 98.64 Hz, FlipAngle: 30 degree]
       [01] dim: 2D, matrix_size: 384 x 384 x 13, fov_size: 25.6 x 25.6 (unit:mm)
            spatial_resol: 0.067 x 0.067 x 1.100 (unit:mm), temporal_resol: 309614.466 (unit:msec)
   [005]   Bruker:FieldMap::B0Map-ADJ_B0MAP::T1_FLASH
           [ TR: 20 ms, TE: 0 ms, pixelBW: 1860.12 Hz, FlipAngle: 30 degree]
       [01] dim: 3D, matrix_size: 64 x 64 x 64, fov_size: 45 x 45 x 45 (unit:mm)
            spatial_resol: 0.703 x 0.703 x 0.703 (unit:mm), temporal_resol: 81920.000 (unit:msec)
   [006]   Bruker:DtiEpi::DTI_EPI_30dir::DWIzoom (E6)
           [ TR: 2000 ms, TE: 22.86 ms, pixelBW: 2289.38 Hz, FlipAngle: 90 degree]
       [01] dim: 2D, matrix_size: 126 x 86 x 25 x 285, fov_size: 22 x 15 (unit:mm)
            spatial_resol: 0.175 x 0.174 x 1.250 (unit:mm), temporal_resol: 4000.000 (unit:msec)
       [02] dim: 2D, matrix_size: 126 x 86 x 22 x 25, fov_size: 22 x 15 (unit:mm)
            spatial_resol: 0.175 x 0.174 x 0.006 (unit:mm), temporal_resol: 0.000 (unit:msec)
   [007]   Bruker:DtiEpi::DTI_EPI_30dir::DWI-IVIM-zoom(E11) (E7)
           [ TR: 2000 ms, TE: 22.86 ms, pixelBW: 2289.38 Hz, FlipAngle: 90 degree]
       [01] dim: 2D, matrix_size: 126 x 86 x 25 x 63, fov_size: 22 x 15 (unit:mm)
            spatial_resol: 0.175 x 0.174 x 1.250 (unit:mm), temporal_resol: 4000.000 (unit:msec)
       [02] dim: 2D, matrix_size: 126 x 86 x 22 x 25, fov_size: 22 x 15 (unit:mm)
            spatial_resol: 0.175 x 0.174 x 0.006 (unit:mm), temporal_resol: 0.000 (unit:msec)
   [008]   Bruker:RARE::T2_TurboRARE::T2_TurboRARE (E8)
           [ TR: 4212.78 ms, TE: 33 ms, pixelBW: 140.85 Hz, FlipAngle: 141.72 degree]
       [01] dim: 2D, matrix_size: 256 x 256 x 26, fov_size: 30 x 30 (unit:mm)
            spatial_resol: 0.117 x 0.117 x 1.200 (unit:mm), temporal_resol: 269617.981 (unit:msec)
   
Podría parecer mucha información al inicio, pero al final no es mas que los detalles del usuario y cada adquisición enumerada del ``[001]`` al ``[008]``. Aquí tu puedes decidir que imágen te sirve y cual quieres convertir. Como ejemplo yo voy a convertir una imágen anatómica pesada a T2 que es la número 008:

::

   brkraw tonii 20220104_085643_INB_C13_hluna_irm150d_rata64A_INB_C13_hluna_1_1/ -o /path/64A_dwi -r 1 -s 8

``tonii`` es el comando que convierte de Bruker a Nifti.

``-o`` es el output de como quieres que se llame tu imagen y en donde quieres guardarla, en este caso yo nombro a mi imágen como 64A_T2 ``/path/`` la ruta donde las quiero guardar.

``-r`` es la reconstruccion que queremos, en este caso es la primera y por eso ponemos 1

``-s`` es la imagen que queremos convertir, en este caso es la numero 8 


Para ver que tus imagenes se convirtieron exitosamente en formato Nifti, vamos a visualizarlas utilizando ``mrview`` del software ``mrtrix``. Para esto, no olvides cargar tu modulo: ``module load mrtrix/3.0.4``

::

   mrview 64A_T2.nii.gz
Y el resultado es esto:

!`image <https://github.com/c13inb/c13inb.github.io/assets/129544525/fe8d393b-9b6f-4df3-9af3-02aadabf23f1>`_

Una vez que conviertes tus imágenes, estas listo para el siguiente paso que es procesarlas de acuerdo al tipo de estudio. Aprende más acerca de como procesar tus imágenes en esta `entrada <https://github.com/c13inb/c13inb.github.io/wiki/Procesamiento-Imagen>`_. 


***

Tutoriales para el uso del resonador
-----------------------

Las siguientes páginas de la wiki incluyen algunos tutoriales para el uso básico del resonador.

* :doc:`Resonadores_Bruker_Conexion-Cryo`
* :doc:`Resonadores_Bruker_Paravision-EXvivo`
* :doc:`Resonadores_Bruker_Wobble-Superficie`
+ :doc:`Bruker-B1Map.md`

Checklists para uso del resonador
-----------------------

Las siguientes ligas contienen algunos google docs con checklist útiles para el cambio de antenas y uso del resonador.

* `Preparación antena Cryo <https://docs.google.com/document/d/1S850dGVnyL1k5UMD0Cf-ebfKXblKklNMRuPto7Vl66M/edit?usp=sharing>`_
* `Preparación antena de volumen <https://docs.google.com/document/d/1pCrKejx-Q31kqw07g8t0ZBscDQr9n007i6fegMNHtMA/edit?usp=sharing>`_
* `Checklist inicio Paravision <https://docs.google.com/document/d/1hwDM7ySkY2xqzBnHkGzsFiiu1vH7U6Af9pxxcvGMHR4/edit?usp=sharing>`_
