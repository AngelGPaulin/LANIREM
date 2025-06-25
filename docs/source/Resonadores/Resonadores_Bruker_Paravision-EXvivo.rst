Resonadores:Bruker: Paravision EXvivo
=====================================

Operación del programa Paravision para la adquisición de imágenes ex-vivo

1.- Para crear un nuevo estudio, se da clic en File de la barra de herramientas. Aparece una ventana y se selecciona la opción de new file.

2.- Entonces, aparecerá una ventana que requerirá llenar los datos del sujeto y del estudio. Se ingresa esta información e igualmente en esta ventana, se confirma si se ha reconocido la antena con la que se trabajará, que en este caso será la antena CRYO (RF CP P2300), y se selecciona la opción TxSuc.

3.- Se arrastra un localizador al área de trabajo, para habilitar la opción de plataforma de ajustes e iniciar el Wobble.

4.- El Wobble se realiza dando clic en el icono de plataforma de ajustes. Entonces, aparece un listado de opciones y se da doble clic a la primera o Wobble. A continuación, se elige el elemento 1, se da clic sobre la opción setup y se abre la pestaña de Acq/Rec display.  En caso, de que la onda deflexión negativa no se encuentre centralizada y con mayor amplitud negativa, se ajustarán estos parámetros al girar los tornillos dorados del arreglo para la sintonización de la antena.

5.- En este momento ya se puede correr el localizador y se ajusta la posición de la muestra y la geometría en la zona de interés, si es necesario.

6.- Ahora, se requiere crear un Pre-Scan o secuencia corta, para habilitar la plataforma de ajustes y realizar el reference power y el mapa de B0, en caso de que nuestra secuencia principal vaya a ser sensible a difusión.

7.- La utilidad del Pre-Scan es obtener una imagen preliminar con sólo ciertas características de la imagen principal y un periodo corto de tiempo. Para ello, es ideal que el Pre-Scan sólo tenga una dirección, con un único valor de B y 1 valor de B0. Igualmente, para este Pre-Scan es necesario realizar el shimming, eligiendo la opción map-shim, auto shim volumen y elipsoide.

8.- Si la imagen preliminar, con el ajuste elegido de FOV y bandas de saturación cumple con las expectativas. Ahora, se puede proceder a realizar la secuencia de difusión completa, duplicando el Pre-Scan, cambiando los parámetros de difusión por los originales y utilizando el shimming anterior, con la opción de current shim.

9.- Para iniciar la secuencia, se da clic en apply y posteriormente, en continue.

10.- Si queremos supervisar a distancia el progreso de la adquisición, esto se puede realizar con la aplicación de teamviewer o similar (rust-desktop está bueno). Llamando a un terminal Ctrl + Alt + T y escribiendo en esta teamviewer. Lo que nos habilitará una ventana con un id y un password para ingresar en otro dispositivo.
