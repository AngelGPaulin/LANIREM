fMRI en roedores
================

**Paradigma de tarea en fMRI en ratas**
-----------------------

Si vas a trabajar con resonancia funcional en ratas hay varias consideraciones que se deben tener. Ten en cuenta que dependiendo del análisis que vayas a hacer necesitas elegir el preprocesamiento adecuado para tus imágenes. En el caso de secuencias de resting state considera siempre revisar la literatura científica, ya que el preprocesamiento de estas imágenes requiere varios pasos adicionales  que son impresidibles con respecto a los paradigmas de tarea en fMRI.  

Este caso analizaremos un tarea con diseño por bloques después de haber lesionado el nervio óptico derecho de la rata. En este experimento las ratas fueron escaneadas después de la lesión y se realizó la tarea por bloques de 20s de estimulación lumínica en el ojo derecho, 20 s sin estimulación y 20 s de estimulación lumínica del lado izquierdo.

Estos son los pasos que debes realizar previo a poder correr un GLM de primer nivel con FEAT. considera que se requiere de algunos comando de FSL y mrtrix.

<u>Preparar imágenes para el analísis</u>
-----------------------



**Paso 1**. Copiar la carpeta de /misc/brucker al directorio de trabajo

::

   cp -r /misc/bruker_pvDatasets3/nmrsu/20190827_112430_INB_C13_melatonina_ct03_7d_1_1/ $PWD
**Paso 2**. En entrar en la carpeta del primer sujeto y buscar la secuencia funcional y la estructural. En este caso la carpetas 5 y 6 corresponden las secuencias de interés.

::

   /misc/purcell/alfonso/prueba_frmri_rata/20190827_112430_INB_C13_melatonina_ct03_7d_1_1/5/pdata/1
**Paso 3.** Correr el comando ``inb_bruker_recursive_convert_mih.sh`` dandole como argumentos la carpeta a convertir y el nombre prefijo a guardar. Esto convierte todas las imágenes a formato .mih

ejemplos:Preparar imágenes para el analísis

::

   inb_bruker_recursive_convert_mih.sh 5 5;
    inb_bruker_recursive_convert_mih.sh 6 6
**Paso 4.** converter los mih a nifti con el comando ``mrconvert`` de mrtrix3

estructural:

::

   mrconvert 5_005_T2_TurboRARE_E5.mih T2.nii.gz
funcional:

::

   mrconvert 6_006_T2star_FID_EPI_rsfMRI_20s_uniE6_E6.mih fmri.nii.gz
Es normal que aparezca esta advertencia:

::

   mrconvert: [WARNING] transform matrix contains invalid entries - resetting to sane defaults
   mrconvert: [100%] copying from "5_005_T2_TurboRARE_E5.mih" to "T2.nii.gz"
   mrconvert: [100%] compressing image "T2.nii.gz"
**Paso 5** abrir las imagenes con el visor de tu elección y revisar que hayan sido correctamente transformadas

::

   fsleyes fmri.nii.gz T2.nii.gz
!` <https://github.com/c13inb/c13inb.github.io/blob/master/images/rat_t2_fmri.png>`_


**Paso 6.** Crear una carpeta para el analisis y moverse a ella y también mover las imagenes a esta carpeta

**Paso 7.** Para poder aplicar ``BET`` es necesario cambiar las dimensiones del header del archivo a unas que el programa pueda leer. esto implica cambiar de micras a milímetros y es necesario hacerlo para ambas imágenes. las nuevas dimenciones 1x1x12mm para la T2 y 4.5x4.5x12mm.  este procedimiento quitará las etiquetas lo cual nos resulta conveniente.

***Nota imporante***: para que transforme todos los volúmenes de la fMRI tiene que agregarse un 1 adicional en el comando*

::

   ## convetir la T2
   fslchpixdim T2.nii.gz 1 1 12
   ## convertir la fMRI
   fslchpixdim fmri.nii.gz 4.5 4.5 12 1
**Paso 8.**  Voltear el eje  x ambas imagenes con el comando ``fslswapdim``

::

   # T2
   T2.nii.gz -x y z T2_oriented.nii.gz
   # fMRI
   T2.nii.gz -x y z T2_oriented.nii.gz
**Paso 9.** Correr  ``BET`` para quitar cráneo y meninges de la T2. puede hacerse con ``bet`` o con ``rbet`` si tienes la fortuna de lograr instalarlo.

con  ``bet``:

::

   # T2
   bet T2_oriented.nii.gz  T2_oriented_bet.nii.gz  -f 0.68 -g 0 -m
Posteriormente tendrás que hacer correcciones manuales

con ``rbet``: primero neceistas estimar a ojo de buen cubero las coordenadas del centro de masa y el readio del cerebro de cada una de las secuencias. Puedes usar mrview o fsleyes para hacerlo. Una vez hecho esto escribes en la terminal: ``rbet <input> <output>   -r  < radio en mm> -c <cordenadas (voxel) centro de masa>``

Ejemplo:

::

   ## T2
   rbet T2_oriented.nii.gz T2_oriented_rbet.nii.gz -r 65 -c 126 150 11 -m
**IMPRESIONANTI!!!**
-----------------------

!` <https://github.com/c13inb/c13inb.github.io/blob/master/images/T2_rbet.png>`_



**Paso 10.**  Hacer la corrección de movimiento de la imagen funcional.

::

   ## para ver más opciones teclear mcflirt sin argumentos
   mcflirt -in fmri_oriented.nii.gz -out mri_oriented_mocorr.nii.gz -mats -plots -report
**Paso 11**. Hacer el Bet para la imagen funcional

Con ``bet``

::

   bet fmri_oriented_mocorr.nii.gz bet fmri_oriented_mocorr_bet.nii.gz   -f 0.68 -g 0 -m
Con ``rbet``

::

   rbet  fmri_oriented_mocorr.nii.gz bet fmri_oriented_mocorr_bet -r 65 -c 32 38 11 -m
**Nota:** en el caso de la funcional solo trasformara un volumen, por lo cual después debes multiplicar la mascara por tu imagen funcional ya corrigida por el movimiento


**Paso 12.** multiplicar la imagen funcional por la mascara generada en el bet y sobreescribir la ya existente

::

   fslmaths mri_oriented_mocorr.nii.gz -mul fmri_oriented_mocorr_bet_mask.nii.gz fmri_oriented_mocorr_bet.nii.gz
**MARAVILLOSA JUGADA!!!**
-----------------------

!` <https://github.com/c13inb/c13inb.github.io/blob/master/images/fmri_bet.png>`_



**Todo está listo para correr primer nivel en FEAT. No olvides desactivar el BET y la corrección de movimiento. SI deseas incluir como regresores los parámetros de movimiento puedes hacerlo importando el archivo con estos parámetros**
