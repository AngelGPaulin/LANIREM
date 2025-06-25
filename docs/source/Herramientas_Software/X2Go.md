X2Go
====


* [ssh]: secure Shell

* [VNC]: Virtual Network Computing 

# Acceso remoto por X2Go

## Opciones de Acceso

Accesar de manera gráfica a los equipos del cluster es sencillo con el uso del programa X2Goclient. Si bien el acceso se puede realizar también mediante **ssh**, este involucra el uso de la terminal o en el caso de usar la opción **-X** se tendrá un entorno gráfico que dependiendo del algoritmo de encriptación puede ser lento. Existen soluciones como **VNC** que requieren de la implementación de un servicio complejo en cada equipo a accesar.

## X2Go

**X2Go** Trabaja sobre ssh así que la seguridad es inherente al programa. Además usa algoritmos de compresión de imágenes que permiten una conexión dinámica con el equipo, que además se adapta modificando la compresión del flujo de imágenes provenientes del servidor con respecto al tipo/calidad de conexión a internet.

### Requerimientos

El software corre en **WINDOWS**, **MAC** y **Linux**. El servidor y el cliente ya se encuentra instalado en todos los equipos del cluster.

Para otros equipos necesitas descargar **X2GoClient** para tu sistema operativo:

* [Linux](http://wiki.x2go.org/doku.php/wiki:repositories:start) *Todas las versiones*
* [Mac](http://code.x2go.org/releases/X2GoClient_latest_macosx_10_9.dmg) *10.9+*
* [Windows](http://code.x2go.org/releases/X2GoClient_latest_mswin32-setup.exe)

> Windows requiere permisos de administrador para su instalación. Si no cuentas con permisos la instalación varía un poco, para más detalles visita el [X2Go wiki](http://wiki.x2go.org/doku.php/doc:installation:x2goclient)


> Mac requiere tener instalado [Xquartz](http://www.xquartz.org/), aunque si ya funciona freesurfer o FSL en tu equipo es probable que ya esté instalado.

En el caso de **Ubuntu** la instalación requiere:

    sudo add-apt-repository ppa:x2go/stable
    sudo apt-get update
    sudo apt-get install x2goclient

## Configuración

### IP de acceso al cluster

El acceso a los equipos del cluster depende de la red en la que nos encontramos trabajando. 

[[images/x2go_cluster.png]]

Como se muestra en la figura, dependiendo de la conexión será la IP que usaremo. Si nos encontramos en ethernet o mediante la red **RII** la conexión a la máquina se hace mediante una IP del tipo `172.24.80.70` *( Ejemplo: Jasper)*. Mientras que de la **RIU** o de **Internet** la conexión se hace a través `132.248.142.55` *PENFIELD exterior*. Afortunadamente, ya está homologado el nombre de penfield en cualquiera de las dos redes, así que lo recomendable es usar el nombre completo: **`penfield.inb.unam.mx`**.

### Acceso externo (penfield.inb.unam.mx o IP:132.248.142.55)

#### Crear nueva sesión

Para el acceso externo es importante recordar la configuración de redes de la figura anterior. Ya que la puerta de acceso al cluster es **PENFIELD** que tiene la IP `132.248.142.55`. Podemos escribir simplemente `penfield.inb.unam.mx`
Con esto en mente, presionamos el botón con una estrella amarilla como se muestra en la figura:

[[images/x2go_crearconexion.png]]

Al hacer click se abre la ventana con las opciones de conexión. En ella se configuran tres parámetros:

* **Host** dónde colocaremos la dirección  de **PENFIELD** `132.248.142.55`, o `penfield.inb.unam.mx`
* **Usuario** es el usuario que usamos al acceder al clúster. 
* :warning: Es muy importante que en la sección *Tipo de sesión*, seleccionemos el gestor **LXDE**. Ya que es el más liviano de los gestores disponibles, además de que **Unity** el típico gestor de **Ubuntu** no está disponible para este servicio.

Es importante que el **nombre de la sesión sea descriptivo** y haga referencia al servidor y a la conexión que se realiza.

[[images/x2go_configuracionPenfield1.png]]

Una opción recomendable es el uso de claves `RSA/DSA`, esto brinda mayor seguridad al acceder al clúster y con esto ya no es necesario introducir el password. De lo contrario cada vez que hagamos *login* nos pedirá el password de nuestra cuenta, de la misma forma que cuando se inicia sesión en los equipos del clúster.

#### Conexión

La pestaña conexión permite cambiar la compresión de las imagenes que se envían del servidor al cliente. Si nuestra conexión es lenta podemos mover el nivel a la opción de **MODEM**, sin embargo esto va en detrimento de la calidad de la imagen.

[[images/x2go_configuracionPenfield2.png]]

#### Propiedades

En esta ventana se puede modificar la resolución de inicio, tanto el ancho y el alto de la ventana dónde interactuaremos con el servidor, hasta los DPI de la misma. Sin embargo si se abre la ventana como en el ejemplo `800x600` al maximizar la ventana se adapta a la resolución de la pantalla.

![[images/x2go_configuracionPenfield3.png]]

#### Carpetas compartidas

Una opción muy interesante en **X2Go** es la posibilidad de compartir una carpeta local con el equipo remoto. Logrando así transferir datos de forma sencilla entre los equipos. 

Primero seleccionamos la ruta del directorio **LOCAL** y presionamos **Añadir**.

![[images/x2go_configuracionPenfield4.png]]

Esto agrega la ruta en el panel mayor donde tenemos la opción de **Automontar** la cual podemos seleccionar para que el directorio se monte inmediatamente despues de que accedemos al equipo.

![[images/x2go_configuracionPenfield5.png]]

Una vez configurada la sesión damos **OK** y se guardará. Para abrir la misma sólo será necesario dar click sobre alguna de ellas.

![[images/x2go_variasconexiones.png]]

### Acceso Interno (IP: 172.24.80.X)

Para crear una nueva conexión interna, debemos estar conectados a la red del **INB** ya sea por cable `ETHERNET` o mediante la red **RII**. El procedimiento es el mismo que el que describimos en la sección anterior. El único aspecto que cambia es la **IP** que se coloca en el **Host** siendo `172.24.142.80.X` dónde **X** es un número que cambia dependiendo del servidor al que se conecte. También podemos usar los nombres de las máquinas, como por ejemplo `hahn.inb.unam.mx` , o `fourier.inb.unam.mx`.

> Nota: En el **INB** también se puede abrir una sesión desde un equipo de bajo rendimiento como Arwen a el resto de los equipos de la red. Dejando el poder de procesamiento al equipo remoto. Tambíen una alternativa para acceder a algún software en la máquina remota.

> En algunos casos habrá que probar el acceso en redes dentro del **INB**, por ejemplo desde las aulas de posgrado el acceso es directo. Pero desde el CAC el acceso es externo.

### Acceso a otros equipos en el cluster (bunny hop)

La conexión externa a **PENFIELD** es de mucha utilidad para la interacción con el ambiente gráfico. Pero esto genera mucha carga al equipo, ya que la conexión de cinco usuarios consumiría muchos de los recursos del sistema. Con esto en mente es recomendable realizar conexiones al resto de los equipos del clúster para realizar un balance de la carga sobre este equipo.
Para ello usaremos una modificación de la configuración de sesión que permitira usar a **PENFIELD** como un proxy y conectarnos al resto de los equipos en el clúster.

Cambios:

* La **IP** del **Host** debe ser la asignada internamente al equipo, esta en general esta en el rango `172.24.80.X`, con una variación en el ultimo número. También podemos usar su nombre completo, como por ejemplo `hahn.inb.unam.mx`.
* Además seleccionamos la opción **Usar servidor Proxy para la conexión SSH**.
* Seleccionamos **Mismos datos de inicio de sesión que en el servidor X2GO**
* Seleccionamos el tipo de servidor como **SSH**
* En el **Host** del Servidor Proxi usamos la **IP** de **PENFIELD** `132.248.142.55`, o su nombre completo, `penfield.inb.unam.mx`.

Podemos usar una clave **RSA/DSA**, aunque si no se usa de cualquier forma al acceder se nos pedira el password relacionado con el usuario.

![[images/x2go_config_01.png]]

## Cerrar sesión

Al terminar de utilizar el equipo se puede salir de dos formas. Cerrando la sesión en el equipo remoto. Primero usamos el botón para cerrar sesión.

![[images/x2go_cerrarsesion2.png]]

Esto desplegará la ventana de sesión y ahí seleccionaremos el botón **Logout** para cerrar la sesión.

![[images/x2go_cerrarsesion3.png]]

> **CUIDADO:** No debemos apagar, reiniciar, Hibernar o Suspender el equipo. Podría causar un problema al funcionamiento del clúster.
 
También podemos cerrar la ventana de X2Go manteniendo los programas y el espacio de trabajo activos. Esto ya sea cerrando la ventana principal de X2Go o presionando `Ctrl + Alt + T`.

> **Precaución:** Si bien los programas se conservan, existe la posibilidad de que la sesión no se pueda recuperar. No es común y se puede deber a un error del sistema pero es recomendable guardar los archivos en los que trabajamos.

## Problemas con recarga de sesión 

Cuando abandonamos la sesión de trabajo, en ocasiones podemos tener problemas al retomarla nuevamente. Esto puede ser por velocidad de conexión, para lo cual modificamos en preferencias la velocidad de conexión. Pero también puede deberse a que algunos de los salvapantallas entorpecen el incio de sesión. Por lo que es recomendable desactivar los salvapantallas de la sesión lxde.

Se logra abriendo el **Menú de inicio** > **Preferencias** > **Screensarver**. En la ventana simplemente cambiamos el nombre del screensaver, que por default esta en alaeatorio y seleccionamos la opción de **"Disable Screen Saver"**, que también puede ser seleccionada la opción **"Black Screen Only"**. Con esto se puede retomar la sesión con mayor facilidad.

## Evitar screensaver (salvapantallas)
El screensaver está activado por defecto en la PC a la que nos estamos conectando (servidor). Cuando se inicia el screensaver (por inactividad en la sesión), los gráficos se transmiten por internet hacia la máquina cliente. Esto genera mucho tráfico innecesario en la red. Afortunadamente, es fácil desactivar el screensaver en LXDE:

Primero buscamos la aplicación del screensaver:

![](https://github.com/c13inb/c13inb.github.io/blob/master/images/screensaver_paso1.png)

Y lo desabilitamos: 

![](https://github.com/c13inb/c13inb.github.io/blob/master/images/screensaver_paso2.png)
