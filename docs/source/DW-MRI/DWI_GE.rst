Resonador GE
============

El resonador GE Discovery MR750 recientemente recibió una actualización de software a versión 29.1 (2022), lo que incluyó importantes mejoras para DWI.

Una de las principales mejoras es la capacidad de incorporar protocolos DWI multi-shell sin necesidad de realizar cada shell como una adquisición independiente. La otra buenísima es la posibilidad de adquirir múltiples rebanadas de forma simultánea (SMS; Hyperband), con lo que el tiempo de adquisición se reduce de manera lineal en función del número de rebanadas simultáneas.

Para adquirir DWI multi-shell, se debe seleccionar la opción ``Tensor``, y escribir el número de direcciones _totales_ (la suma de todas las direcciones en todos los shells), y como ``bvalue`` escribir el máximo valor de _b_ en nuestras shells. 

!` <https://github.com/c13inb/c13inb.github.io/blob/master/images/q-space-sampling_diffusion-setup.png>`_


El sistema incluye algunos protocolos famosos pre-cargados. Para utilizarlos, vamos a la pestaña ``Advanced`` y en ``Tensor filename`` ponemos el número entero que corresponde a un archivo llamado ``Tensor????.dat`` que está grabado en la carpeta ``/usr/g/bin`` del resonador. 

!` <https://github.com/c13inb/c13inb.github.io/blob/master/images/q-space-sampling_advanced-setup.png>`_


En caso de querer colocar nuestros propios archivos de protocolos multishell, los pondremos en esa ruta, con la ayuda del físico médico de la URM. Los archivos pueden consultarse `aquí <https://drive.google.com/drive/folders/1l8ZdOjHbMcL4t4z_8ALl78SQya3ZYP_G?usp=share_link>`_ y se resumen a continuación:

|protocolo       | archivo        | nDirs en consola | bval en consola | nb0 | b1   | dirs1 | b2   | dirs2 | b3   | dirs3 | b4   | dirs4 | Notas                                       |
| -------------- | -------------- | ---------------- | --------------- | --- | ---- | ----- | ---- | ----- | ---- | ----- | ---- | ----- | ------------------------------------------- |
|HCP             | tensor1090.dat | 90               | 2000            | 0   | 1000 | 45    | 2000 | 45    |      |       |      |       | Especificar nb0 en consola                  |
|ADNI-3          | tensor1127.dat | 126              | 2000            | 6   | 500  | 6     | 1000 | 48    | 2000 | 60    |      |       | Recomendado para gradientes >70 mT/m        |
|ADNI-3          | tensor1127.dat | 100              | 2000            | 9   | 500  | 6     | 1000 | 38    | 2000 | 47    |      |       | Recomendado para gradientes menos poderosos |
|ABCD            | tensor4321.dat | 102              | 3000            | 6   | 500  | 6     | 1000 | 15    | 2000 | 15    | 3000 | 60    |                                             |
|ABCD            | tensor4321.dat | 96               | 3000            | 0   | 500  | 6     | 1000 | 15    | 2000 | 15    | 3000 | 60    | Especificar nb0 en consola                  |
|UK Biobank      | tensor521.dat  | 104              | 2000            | 4   | 1000 | 50    | 2000 | 50    |      |       |      |       |                                             |
|UK Biobank      | tensor521.dat  | 6                | 2000            | 3   | 2000 | 3     |      |       |      |       |      |       | Para revpe                                  |
|Desconocido     | tensor8313.dat | 296              | 3000            | 26  | 1000 | 90    | 2000 | 90    | 3000 | 90    |      |       |                                             |
|Desconocido     | tensor8313.dat | 270              | 3000            | 0   | 1000 | 90    | 2000 | 90    | 3000 | 90    |      |       | Especificar nb0 en consola                  |


El manual de usuario del software del resonador GE está disponible `aquí <https://drive.google.com/file/d/1NfvfB3EoYON41HucbuNLgt9Rq6X1Yo9i/view?usp=sharing>`_. Se recomienda revisar página 1807.

Hay más explicaciones y scripts para generar nuestros propios archivos ``tensor????.dat`` en `este fabuloso link <https://github.com/naveau/qspacesampling2GE>`_.


User CVs
-----------------------
Para evitar que se interpolen las imágenes en el plano (no bueno para dwidenoise), usar CV ``rhmethod=1``.
Para cambiar la polaridad del _phase encoding_ para poder usar `eddy y topup <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup>`_, usar ``revpe``.
