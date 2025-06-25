mni2surf
========

Proyectar un resultado de grupo de FEAT a la superficie de fsaverage
-----------------------

Para esta acción se utilizarán las herramientas del grupo de Yeo, disponibles `aquí <https://github.com/ThomasYeoLab/CBIG/tree/master/stable_projects/registration/Wu2017_RegistrationFusion>`_.


Requisitos
-----------------------

1. Nuestro resultado está en formato NIFTI, y normalizado en un espacio MNI152.
1. Tenemos freesurfer instalado y nuestra variable ``$FREESURFER_HOME`` es válida.
1. Tenemos el script ``CBIG_RF_projectMNI2fsaverage.sh`` en nuestro PATH (está colocado en ``$FMRILAB_SOFTARE/tools``), así que no es necesario hacer nada, sólo checar.
1. Tener matlab. En estos momentos en el laboratorio, está instalado en ``/home/inb/soporte/fmrilab_software/MatlabR2018a/bin``



Ejemplo
-----------------------

* Mi carpeta ``feat`` de nivel de grupo es ``/misc/mansfield/lconcha/arafat/scirep/groupResults/cope1.feat``, y me interesa ``zstat5``
* Mi carpeta para los outputs será ``misc/mansfield/lconcha/TMP/proj2surf``
* El comando principal es ``CBIG_RF_projectMNI2fsaverage.sh``, y recibirá de argumentos ``-s`` el archivo nifti con los resultados que queremos ver en la superficie, ``-o`` la carpeta dónde se grabarán los outputs, y ``-m`` para la ruta de Matlab. En el fmrilab, la ruta de matlab es ``/home/inb/soporte/fmrilab_software/MatlabR2018a/bin``. Por lo tanto, nuestro comando queda:
::

    CBIG_RF_projectMNI2fsaverage.sh \
      -s  /misc/mansfield/lconcha/arafat/scirep/groupResults.gfeat/cope1.feat/thresh_zstat5.nii.gz  \
      -o /misc/mansfield/lconcha/TMP/proj2surf \
      -m /home/inb/soporte/fmrilab_software/MatlabR2018a/bin
Al correrlo, quedarán los siguientes outputs:
::

   lh.thresh_zstat5.allSub_RF_ANTs_MNI152_orig_to_fsaverage.nii.gz
   rh.thresh_zstat5.allSub_RF_ANTs_MNI152_orig_to_fsaverage.nii.gz
Para visualizarlo, utilizamos ``freeview``

::

   freeview \
    -v $SUBJECTS_DIR/fsaverage/mri/brain.mgz \
    -f $SUBJECTS_DIR/fsaverage/surf/lh.white:overlay=lh.thresh_zstat5.allSub_RF_ANTs_MNI152_orig_to_fsaverage.nii.gz \
    $SUBJECTS_DIR/fsaverage/surf/rh.white:overlay=rh.thresh_zstat5.allSub_RF_ANTs_MNI152_orig_to_fsaverage.nii.gz
[[images/freeview_mni2surf.png|alt=mni2surf]]
