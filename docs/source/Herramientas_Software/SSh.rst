SSH
===

* [ssh]:Secure Shell

El protocolo __ssh__ o _Secure SHell_ por sus siglas, permite el acceso remoto
a un equipo en red con un manejo total de este. Este interprete de comandos
puede incluso redirigir las X (interfaz gráfica) y tráfico de red. Es un
protocolo relativamente seguro ya que el tráfico de datos viaja de manera
encriptada entre los equipos.

En linux y mac ssh está instalado y listo para usarse. En windows puedes usar `mobaxterm <https://mobaxterm.mobatek.net/>`_
o `putty <https://www.putty.org/>`_.

En particular el uso de este protocolo  permite acceder a los diferentes
equipos en el clúster.  Esto es recomendable, por ejemplo, para organizar datos
que se encuentren en determinado equipo, desde el equipo en cuestión. Por lo
que mover archivos y cambiar permisos se vuelve una tarea local y por lo tanto
el ancho de banda queda libre de estos procedimientos.

El comando a ejecutar tiene un arreglo básico:

     ssh usuario@equipo

Este comando se puede modificar en el caso de que se quiera usar la interfaz gráfica a travez de la red. Una vez realizada la conexión es necesario usar [comandos de bash](?id=basicos) para interactuar con el equipo.

    ssh -X usuario@equipo

>  __Nota:__   
 Este comando permite el uso de programas en modo gráfico. Sin embargo la velocidad de conexión entre los equipos debe ser rapida. De lo contrario la interfaz es muy lenta. Incluso puede ejecutarse fuera de la red interna pero nuevamente sera muy lenta la interacción si la conexión es de baja velocidad.

Si se desea crear un tunnel se usa el comando

    ssh -D ##### usuario@equipo

Donde se sustituye el ##### por el número de puerto a usar.

Este comando permite generar un tunel al que se puede redirigir el tráfico del
navegador local para poder acceder a internet a traves de la red del instituto
e interactuar con el clúster.


Por ultimo, como ya se ha mencionado la conexión puede hacerse de manera externa al instituto. El usuario y contraseña son los que se usan en sesiones normales. Para conectarse de manera externa al instituto se requiere la dirección para realizar la conexión.

Transferir archivos
-----------------------

Es posible transferir archivos de manera sencilla entre los equipos, tan solo poniendo el contenido en la carpeta de datos que nos corresponde.

Sin embargo es puede transferir archivos entre computadoras usando como base el protocolo ssh.

El comando básico de transferencia es ``scp``, este comando transfiere datos de manera segura a cualquier zona del equipo objetivo donde tengamos permisos de escritura. Permite enviar algún archivo o directorio , así como descargar un archivo o directorio.

Envio de archivo
-----------------------

    scp archivo usuario@equipo:/carpetadestino/

Descarga de archivo
-----------------------

    scp usuario@equipo:/carpetaorigen/ /carpetadestino/archivo

Sin embargo este comando no permite resumir una descarga interrumpida y es básicamente una copia segura. En caso de querer resumir una descarga o poder hacer un copia que seleccione los archivos nuevos, es mejor el uso del comando ``rsync``. Rsync permite la copia de un archivo a traves de conexiones seguras, así como de conexiones sin encriptación.

En el caso de una conexión sin encriptación solo se usa el comando que no declara el protocolo.

Para copiar un archivo a la carpeta destino
-----------------------

    rsync -auvzh /carpetaorigen/archivo /carpetadestino/

Si se quiere copiar todo el directorio
-----------------------

    rsync -auvzh /carpetaorigen /carpetadestino/

Esto copiaría la ``carpetaorigen`` completa en la carpeta destino.
Para hacer las transferencias a traves de ssh:

Para copiar un archivo a la maquina remota
-----------------------

    rsync -e 'ssh' /carpetaorigen/archivo usuario@equipo:/carpetadestino/

Para copiar la carpeta completa a la maquina remota
-----------------------

    rsync -e 'ssh' /carpetaorigen usuario@equipo:/carpetadestino/

Para copiar un archivo del equipo remoto a la carpeta local
-----------------------

    rsync -e 'ssh' usuario@equipo:/carpetaorigen/archivo /carpetadestino/

Para copiar la carpeta completa del equipo remoto a la carpeta local
-----------------------

    rsync -e 'ssh' usuario@equipo:/carpetaorigen /carpetadestino/



ssh-keygen
-----------------------
Es un utilidad que permite generar, administrar y convertir llaveros de autentificación para el protocolo ssh.
[Revisa este link ](ssh-keygen)
