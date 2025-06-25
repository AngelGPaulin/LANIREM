/misc
=====

En principio en la carpeta __/misc__ , que se encuentra en la raíz de todos los equipos, se encuentran carpetas con los nombres de los equipos y por lo tanto con acceso a cada uno de ellos.

Por ejemplo, la carpeta __/misc/tanner__ se encuentra físicamente en el equipo __tanner__, pero se encuentra disponible desde cualquier equipo que forme parte del clúster.

Dentro de estas carpetas se encuentran directorios que pertenecen a los usuarios designados a usar ese espacio del equipo.

Es muy importante que los usuarios graben sus datos a procesar y sus resultados en alguna carpeta dentro de __/misc__ utilizando la siguiente nomenclatura:

       /misc/__host__/__usuario__

dónde __host__ es el nombre de la máquina que físicamente tiene el disco duro. Se recomienda que sea la que normalmente se usa físicamente. Ejemplos son: tournoux, fourier, tanner, etc. Nombrando la carpeta __usuario__ facilitamos la tarea de saber cuántos datos tiene cada persona en el cluster.

> Por favor, solo se puede utilizar la carpeta ``/misc`` en el equipo que se te ha asignado. Si por alguna razón el disco esta lleno. Es posible usar temporalmente otro equipo, mientras que se reporta el problema al administrador del sistema.



Crear una carpeta
-----------------------

Una vez que cuenten con Usuario/Contraseña podrán crear sólo una carpeta en el equipo asignado si cuentan con los permisos necesarios, el procedimiento es el siguiente:

       mkdir /misc/nombre_del_equipo/tu_usuario

Carpeta nobackup
-----------------------

Si existen archivos muy grandes que no requieran de respaldo, es recomedable crear una carpeta dentro de su carpeta /misc con el nombre *nobackup*. Esta carpeta podrá ser vista por el resto del folder pero no se realizará backup de ella, facilitando la carga de trabajo del clúster en general.

Disponibilidad de datos en el clúster
-----------------------

Ya que el trabajo en el clúster requiere que los datos se encuentre accesibles para cualquier equipo que pueda llevar a cabo la tarea en cuestión. Los datos deben ser colocados en carpetas que se monten en todos los equipos.  

Para saber cuánto espacio libre hay en  los discos, basta con abrir una terminal y escribir:

::

   df -h
Un ememplo de output:

::

   Filesystem      Size  Used Avail Use% Mounted on
   udev             12G     0   12G   0% /dev
   tmpfs           2.4G  2.2M  2.4G   1% /run
   /dev/sda2        46G   39G  4.7G  90% /
   tmpfs            12G   92M   12G   1% /dev/shm
   tmpfs           5.0M  4.0K  5.0M   1% /run/lock
   tmpfs            12G     0   12G   0% /sys/fs/cgroup
   /dev/loop0       18M   18M     0 100% /snap/chromium-ffmpeg/9
   /dev/loop2       15M   15M     0 100% /snap/gnome-logs/43
   /dev/sda1        48M  6.1M   42M  13% /boot/efi
   /dev/sda3        71G   54M   68G   1% /tmp
   /dev/sdb2       1.8T  1.4T  351G  80% /datos/disco2
   /dev/sdc5       3.6T  2.5T 1013G  71% /misc/mansfield
   tmpfs           2.4G   16K  2.4G   1% /run/user/121
   tmpfs           2.4G  236K  2.4G   1% /run/user/1000
   /dev/sdd1       917G  777G   95G  90% /media/lconcha/CONCHA_WD
   /dev/sdh1        30G   17G   12G  58% /media/lconcha/myswap
