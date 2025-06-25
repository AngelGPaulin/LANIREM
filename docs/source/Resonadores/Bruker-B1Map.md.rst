Generar Mapas de B1 en Bruker
-----------------------


Paravision 7 incluye una secuencia para generar mapas de B1 basado en el método DREAM `(Nehrke y Börnet, 2012) <https://onlinelibrary.wiley.com/doi/10.1002/mrm.24158>`_.





En el foro de discusión de preclinical imaging de Bruker, dan una solución sencilla `(link, se requiere registrarse gratis) <https://pci-community.com/t/b1-mapping/900/11>`_:



Generar Mapas de B1 con QUIT
-----------------------

[QUIT](https://quit.readthedocs.io/en/latest/) es un programa que incluye diversas rutinas para imagen cuantitativa. Es bastante útil para relaxometría, transferencia de magnetización, etc. Afortunadamente, incluye una rutina para calcular el mapa de B1 a partir de las imágenes crudas del método DREA` <https://quit.readthedocs.io/en/latest/>`_ es un programa que incluye diversas rutinas para imagen cuantitativa. Es bastante útil para relaxometría, transferencia de magnetización, etc. Afortunadamente, incluye una rutina para calcular el mapa de B1 a partir de las imágenes crudas del método DREAM.














::

   ln -s 250224_mt_r2g1c_s2_3_4_3_b1map-_e4_-01.nii.gz STE.nii.gz
   ln -s 250224_mt_r2g1c_s2_3_4_3_b1map-_e4_-02.nii.gz fid.nii.gz

::

   mrcat -axis 3 fid.nii.gz ste.nii.gz dream_file.nii.gz




::

   qi dream dream_file.nii.gz --out=prefixdream --order=f -a 15

