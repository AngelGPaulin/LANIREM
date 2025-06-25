Permisos
========

Ajuste de permisos para trabajos en el clúster
-----------------------

Es muy importante entender el tema de los permisos ya que al estar trabajando en el clúster, si no tienes los permisos necesarios, esto puede limitar mucho tu trabajo. 

¿Como saber que permisos tengo? 
-----------------------

Al utilizar ``ls -l`` nosotros podemos ver los detalles de cada directorio y archivo, incluyendo los permisos:

!`image <https://github.com/c13inb/c13inb.github.io/assets/129544525/fdc38680-2baf-4acb-adcd-35ddafe2f937>`_

En el recuadro rojo vemos los permisos donde:

``a``: archive, osea que es un archivo nada más.

``d``: directory, es un directorio.
 
``r``: read permissions, quiere decir que tienes tu como usuario permisos de lectura en el archivo/directorio.

``w``: write permissions, esto significa que como usuario puedes escribir, modificar o incluso elimiar el archivo/directorio.

``x``: execute permissions, esto aplica para poder ejecutar scripts principalmente (más abajo explico como).


Pero vemos que hay una separación con  ``-`` entre permisos, esto se refiere quien y quienes son los que tienen permisos aquí, es decir: 

!`image <https://github.com/c13inb/c13inb.github.io/assets/129544525/0375fb49-773c-4e68-8044-dbdbdd7a102e>`_

* Rectangulo amarillo son tus permisos como usuario (paulinav) 
* Rectangulo azul son los permisos del grupo (fmriuser)
* Rojo son los permisos a "otros", osea todos aquellos que no sean tu como usuario o los que pertenecen al grupo fmriuser. 

Entonces, en otras palabras: si tu como usuario tienes ``rwx`` quiere decir que tienes todos los permisos en dichos archivos/directorio.

Ahora, en la siguiente imágen, el rectangulo amarillo te dice el nombre del usuario (paulinav) y el grupo al que perteneces (fmriuser)

!`image <https://github.com/c13inb/c13inb.github.io/assets/129544525/66fc01c1-6cfe-42c1-b77a-c2852a361918>`_

Modificar permisos con ``chmod``
-----------------------
Ahora que ya sabemos como leer los permisos, podemos utilizar el comando ``chmod`` que es el que nos ayudara a modificar/específicar los permisos a quienes nosotros queramos. 

La sintaxis de ``chmod`` se basa en el "quién", "qué" y "cúal" dar los permisos:

* Quién

``u``: osea el dueño del archivo

``g``: permisos a todos los miembros del grupo

``o``: permisos al resto (otros)

``a``: permisos a todos los de arriba

* Qué

``-``: remueve los permisos

``+``: concede el permiso

* Cúal

``r``; permiso de lectura

``w``: permiso de escritura

``x``: permiso de ejecución

Por ejemplo, si yo creo un nuevo script, no lo voy a poder ejecturar inmediatamente, necesitaré cambiar los permisos de tal manera que pueda ser ejecutado:
::

   chmod a+x mi_script.sh

---

También puedes asignar el grupo ya sea fmriuser o bioinfo a una carpeta, subcarpetas y los archivos que contenga, se puede usar el comando:

::

   chown -R usuario:grupo carpeta/
Y para permitir escritura y lectura al grupo usas:

::

   chmod -R g+rwx carpeta/
Sin embargo, puede ocurrir que no se pueda cambiar el grupo si no somos los dueños de la carpeta en cuestión. Si es necesario ajustar el grupo y por alguna razón no funciona el comando, el administrador del equipo en cuestión puede realizar el cambio.



   


