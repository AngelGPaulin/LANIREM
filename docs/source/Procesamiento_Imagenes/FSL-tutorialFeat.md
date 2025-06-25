# Tutorial FEAT
Luis Concha
Instituto de Neurobiología, UNAM Campus Juriquilla
lconcha@unam.mx

En este tutorial usaremos las computadoras del Lanirem. En caso de querer instalar fsl en su computadora, [sigue éstas instrucciones]
(https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/FslInstallation).

Una vez que entremos con nuestras credenciales, abrimos una terminal.



## Conversión de formato
Ahora vamos a convertir nuestros archivos desde formato DICOM hacia formato NIFTI (nii). Para ello usaremos el programa [`dcm2niix`](https://github.com/rordenlab/dcm2niix), pero primero debemos navegar hacia nuestra carpeta. Para fines de este tutorial, todos los archivos estarán grabados en la ruta `/misc/hahn2/nobackup/fMRI2021`

Por lo tanto, en la terminal tecleamos:
```bash=
cd /misc/hahn2/nobackup/fMRI2021
```

Si queremos ver el contenido de la carpeta, usamos el comando:
```bash=
ls
```

Y veremos que existe una carpeta llamada `datos`. Ahí están los Dicoms. Podemos ver el contenido:
```bash=
ls datos
```
Vemos que tiene dos carpetas, una para los datos anatómicos `1401_T1W_3D_SENSE` y otra para los datos funcionales `1101_fMRI_SMA`. Adentro de cada una de esas carpetas hay muchos, muchos archivos con extensión `.dcm` (uno para cada rebanada).

Los archivos dicom serán compartidos por todos en el tutorial, pero cada quien requiere su carpeta para todos sus resultados. Necesitamos hacer una carpeta personal, a la que llamaremos de acuerdo a nuestro nombre de usuario (en este tutorial, es `fMRI_test`) y la haremos dentro de este mismo directorio, así que es fácil:

```bash=
mkdir fMRI_test
```

:warning: **No escribas `fMRI_test`, sino tu nombre de usuario.** Tu nombre de usuario se puede ver en la terminal, justo antes de la `@`. Y también puedes conocerlo tecleando el comando `whoami`.


Para convertir los datos de DICOM a NIFTI, el programa `dcm2niix` espera una ENTRADA (carpeta donde están los dicoms), y opcionalmente una SALIDA (carpeta donde queremos grabar los niftis, `-o`; el default es la carpeta de entrada, pero no es recomendable mezclar ambos tipos de archivos). Por lo tanto, para convertir los datos anatómicos el comando queda como:

```bash=
dcm2niix -o fMRI_test datos/1401_T1W_3D_SENSE/
```

Igualmente, convertimos los datos funcionales:
```bash=
dcm2niix -o fMRI_test datos/1101_fMRI_SMA/
```

Si vemos el contenido de nuestra carpeta personal, encontraremos archivos nifti:
![](https://i.imgur.com/KLIdKOL.png)


:information_source: Los nombres de los archivos se generan a través de los meta-datos de los archivos DICOM, que por default son la fecha de adquisición y tipo de imagen. Por lo tanto, los nombres de los archivos quedan muy largos.  El comportamiento de dcm2niigui se puede modificar en Help-Preferences, pero por ahora dejaremos los valores por defecto.


Ahora que tenemos nuestros datos, podemos procesarlos.

# FEAT

En la terminal, escribimos `fsl`. Se abrirá el menú de fsl. Seleccionamos el quinto, `FEAT FMRI analysis`.
![](https://i.imgur.com/tSlUA52.png)

En la parte superior, dejaremos puesto `First-level analysis` y `Full analysis`. Si quisiéramos hacer análisis de grupo, cambiaríamos esa opción a `Higher-level analysis`, y si quisieramos brincarnos algunos pasos del análisis, quitaríamos `full analysis` y seleccionaríamos alguna de las otras opciones.

Primero, indicamos nuestro archivo con las imágenes funcionales. Para ello, presionamos el botón que está en la pestaña *Data*, que dice `Select 4D Data`. Usamos el ícono del folder para navegar a donde está nuestro archivo, que es en la carpeta `/misc/hahn2/nobackup/fMRI2021/USUARIO` (eecuerda cambiar `USUARIO` por tu login). El archivo se llama `1101_fMRI_SMA_fMRI_SMA_SENSE_20121004193706_1101.nii`. Seleccionamos `OK`, y nuevamente `OK` en la ventanita de `Select Input Data`.

Aprovechamos y ponemos la ruta del `Output directory`, que en este tutorial será en `/misc/hahn2/nobackup/fMRI2021/USUARIO/miprueba` (eecuerda cambiar `USUARIO` por tu login). Para ello podemos escribirlo directamente en el recuadro de texto, o utilizar el ícono del fólder y navegar a la carpeta /home/vagrant/cursofmri y ahí escribir `miprueba`. 

:information_source: El programa FEAT siempre agregará el sufijo `.feat` a la carpeta output que nosotros indiquemos. Sin embargo, esto no lo muestra en la caja de texto de `Ouptut directory`. Así, el resultado quedará en la ruta: `/misc/hahn2/nobackup/fMRI2021/USUARIO/miprueba.feat` 

:information_source: los nombres de archivos en linux son sensibles a mayúsculas/minúsculas, y no deben contener espacios.

![](https://i.imgur.com/keRoP3W.png)

Saldrá una advertencia:
![](https://i.imgur.com/jVO9s1g.png)

Esto nos está diciendo que el default del programa es hacer extracción de cerebro en las imágenes anatómicas, así que debemos poner imágenes anatómicas también con extracción de cerebro (ver adelante). Ahora, decimos `OK`. Podemos ver que en la pestaña *Data*, el software ya reconoció que nuestro archivo tiene 110 volúmenes, y que el TR es de 2 segundos. Si no lo hubiera reconocido, tenemos la opción de escribirlo (este dato lo sabríamos de acuerdo a nuestra adquisición). Dejamos las otras opciones intactas, pues no necesitamos eliminar volúmenes, y el filtro pasa-altas está en 100s (de forma predeterminada aparece 60, o 100), que es un buen valor por default.

Vamos a la pestaña *Pre-stats*. Lo único que cambiaremos es `Slice Timing correction`, a `Interleaved`. Este parámetro depende de cada tipo de adquisición. Podríamos cambiar el nivel de suavizado de la imagen mediante FWHM, pero el valor 5 mm por ahora es bueno (normalmente se utilizan FWHM con valores de 1.5 a 2 veces la dimensión del voxel).

![](https://i.imgur.com/jZXBNw6.png)


Pasamos a la pestaña *Registration*.

Activamos el botón `Main Structural image`. Aquí vamos a poner una imagen anatómica de nuestro sujeto, pero primero debemos hacerle extracción de cerebro. 



### Extracción de cerebro

Regresemos a la ventana principal FSL y presionemos el primer botón, `BET brain extraction`.

En `Input Image`, usemos el botón del fólder para ir a buscar nuestra imagen anatómica, que se llama `1401_T1W_3D_SENSE_T1W_3D_SENSE_20121004193706_1401.nii`. La salida se pone automáticamente, con el mismo nombre del archivo de entrada, pero con un `_brain` agregado.

![](https://i.imgur.com/Cm0mjFi.png)


**Regresamos a la ventana FEAT**, pestaña *Registration*. Usemos el botón de fólder para incluir una `Main Structural Image`, y seleccionamos nuestra nueva imagen (poner la que termina con `_brain`), presionamos `OK`.

![](https://i.imgur.com/wMhNYiE.png)


Vamos a la pestaña *Stats*. 

Dejamos activado `Use FILM prewhitening`. En el primer botón, apretamos el botón `Don’t Add Motion Parameters`, y en el menú que se abrirá, seleccionamos `Standard Motion Parameters`. Y ahora presionamos `Model setup wizard`.

![](https://i.imgur.com/Axsct70.png)


Nuestro paradigma fue de movimiento de mano, 30 seg sí, 30 seg no, iniciando con reposo. Por lo tanto, seleccionamos el modelo `rArA...`, y dejamos en 30 los periodos `rest` y `A`.

![](https://i.imgur.com/bDZGf9n.png)

Presionamos `Process`. Veremos el paradigma, con la línea de tiempo en la vertical. Hay tres columnas, la primera es el tiempo, con barras blancas cada 20 segundos. La segunda columna es nuestro paradigma experimental (reposo-actividad), pero convolucionado con la respuesta hemodinámica. La tercer columna es la derivada de la primer columna, y se calcula automáticamente.

![](https://i.imgur.com/2pBpqiC.png)


Por ahora no haremos nada en la pestaña *Post-stats*.

![](https://i.imgur.com/h1xMD2U.png)


**Estamos listos!** Presionamos `GO`. El proceso tardará 10 a 15 minutos. Se abrirá una página web (local) en el navegador de internet, donde veremos el progreso. En caso de que cerremos la ventana, o que ésta no se haya abierto por default, podemos encontrar el archivo `.html` en la siguiente ruta:
`/misc/hahn2/nobackup/fMRI2021/fMRI_test/miprueba.feat/report.html`

![](https://i.imgur.com/Sb9K4F7.png)


## Revisando resultados.

Esta página tiene 5 pestañas. *Registration* mostrará los resultados del registro de las imágenes funcionales con las T1, y éstas con el atlas. *Pre-stats* nos mostrará resultados de la corrección de movimiento y otros pre-procesos. *Stats* nos indica el modelo estadístico que estamos probando. *Post-stats* nos muestra el resultado de la evaluación estadística por voxel, después de haber hecho las correcciones pertinentes por comparaciones múltiples (Random-field theory, en nuestro caso). Finalmente, *Log* es una bitácora de los procesos que hizo el programa, y es útil para revisarlo en caso de que algo haya fallado.

En la pestaña *post-stats* podemos ver que nuestro modelo muestra un muy buen ajuste con la señal BOLD en la región motora izquierda, correspondiente al paradigma experimental (mover la mano derecha).

![](https://i.imgur.com/lg0tGH1.png)

Si damos clic en el mapa de resultados, nos aparecerá una tabla que indica los clústers encontrados, su volumen, sus coordenadas,  y su significancia estadística.


Regresando a la página de *post-stats*, más abajo, podemos ver la señal temporal BOLD en el voxel que mayor significancia estadística tuvo de todo el cerebro. En rojo la señal BOLD de nuestro sujeto, y en azul y verde el modelo experimental (es decir, el diseño de bloques convolucionado con la respuesta hemodinámica canónica).

![](https://i.imgur.com/jB5T4wE.png)

Si damos clic en la serie temporal, veremos más información relevante. En el caso de modelos de bloques, es fácil ver la respuesta hemodinámica asociada al bloque, si se alinean todos los eventos para iniciar en t=0.

![](https://i.imgur.com/LPl2O85.png)



## Visualización interactiva de resultados

Usaremos el programa `fsleyes`, dándole como argumento (entrada), la carpeta `.feat` que se hizo como resultado de nuestro análisis.

```bash=
fsleyes -s feat fMRI_test/miprueba.feat
```

:information_desk_person: La opción `-s feat` le dice a `fsleyes` que vamos a querer ver los resultados de un análisis de FEAT, así que automáticamente abre varias sub-ventanas para hacernos la vida fácil.

Agregaremos nuestro mapa estadístico, en `File->Add from file->`, y navegamos hacia dentro de nuestra carpeta de resultados `.feat`, a buscar el archivo `thresh_zstat1.nii.gz`.

![](https://i.imgur.com/3aES11o.png)

Teniendo seleccionada la imagen `thresh_zstat1` en la sub-ventana *Overlay list*, vamos a la parte superior derecha, donde vemos los diferentes mapas de color.  Seleccionamos el segundo (`Red-Yellow`), o algún otro que nos agrade.

![](https://i.imgur.com/VGk29uj.png)

Y cambiemos el rango de intensidades. Dado que lo que vemos en color es el valor *z* del ajuste estadístico para cada voxel, y habíamos elegido en el software que para ser considerado parte de un cluster, el voxel tendría que tener *z*>3.1, pongamos dicho valor como mínimo. El máximo depende de los valores resultantes de nuestro mapa, y el elegido automáticamente fue el valor máximo encontrado. Podemos cambiarlo, si queremos.

![](https://i.imgur.com/c52M0gh.png)


Ahora podemos navegar por el volumen, y ver en tres planos el resultado, de manera interactiva. Podemos dibujar un recuadro con el botón derecho del mouse, y se hará un zoom automáticamente a esa zona. Para restablecer el zoom, podemos poner 100 en el factor zoom, o usar el botón de la lupa que tiene una flecha.


Podemos usar la tabla de los clústers que habíamos visto en la página html, pero ahora interactiva. Para ir a ver cada cluster, podemos dar clic en el ícono de la flecha que apunta a la derecha, y nos llevará al centro del clúster (técnicamente, al voxel con *z* más alto).

![](https://i.imgur.com/i7GEznP.png)

