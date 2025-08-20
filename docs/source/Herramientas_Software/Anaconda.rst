Anaconda
========

`Anaconda <https://www.anaconda.com/>`_ es un manejador de paquetes y ambientes de Python de código abierto. Anaconda se encarga de instalar, correr y actualizar paquetes de Python y sus dependencias, así como también de crear ambientes de python de manera muy sencilla.

En esta entrada de la wiki encontrarás algunos comandos básicos para su uso e información sobre como configurar Anaconda para que funcione adecuadamente en tu cuenta del clúster. Si quieres aprender más sobre su uso avanzado te recomendamos la `wiki oficial de Anaconda <https://docs.conda.io/projects/conda/en/latest/index.html>`_.

.. warning::
   Si ya tenías una instalación local previa de Anaconda y planeas crear nuevos ambientes, es necesario realizar una configuración inicial para no saturar los discos del clúster. Más de esto en esta wiki.

Instalando Anaconda (miniconda) en el clúster
----------------------------------------------

.. important::
   Lo más relevante de esta sección es asegurarse de que conda se instale **fuera de tu carpeta home**. Instalar conda dentro de ``/home`` infringe las normativas del clúster con respecto al uso de espacio de discos duros.

La instalación de Anaconda trae por defecto mucha paquetería científica de Python y esto puede generar mucha redundancia y uso de datos en los discos duros del clúster. Por ello recomendamos instalar `miniconda <https://docs.conda.io/en/latest/miniconda.html>`_, que es una versión mínima de Anaconda que sólo trae Python. Las librerías que vayas a requerir las puedes ir agregando en los diferentes ambientes que vayas creando.

Para comenzar, puedes descargar la versión más reciente de miniconda desde este `link <https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh>`_. Si requieres una versión distinta, puedes revisar las diferentes opciones en la `documentación oficial <https://docs.conda.io/en/latest/miniconda.html>`_.

Después, en una terminal (suponiendo que estás en la misma carpeta donde guardaste el archivo) ejecutamos el script que descargamos:

.. code-block:: bash

   bash Miniconda3-latest-Linux-x86_64.sh

Primero, nos va a solicitar leer y aceptar los términos y condiciones de la licencia, los cuales podemos revisar dando ``Enter``, luego ``q`` para salir del lector, y finalmente escribiendo ``yes`` para aceptar.

.. danger::
   ¡El siguiente paso es súper importante!

Ahora nos va a solicitar la ubicación donde se instalará Miniconda. Por defecto, será dentro de tu carpeta ``/home``, **lo cual no está permitido en el clúster**. Es vital que cambies la ruta de instalación a alguna carpeta dentro de tu usuario en ``/misc``, por ejemplo:

.. code-block:: text

   /misc/computadora/usuario/miniconda

Donde hay que cambiar ``computadora`` y ``usuario`` por tu computadora preferente en ``/misc`` y tu nombre de usuario. Después de esto, está bien aceptar los valores por defecto para finalizar la instalación.

Ambientes de Anaconda
---------------------
Un ambiente de Anaconda es un directorio que contiene una instalación aislada de Python y paquetes puestos por el usuario. De esta forma, puedes tener varios ambientes con diferentes versiones de Python y/o paquetes, de tal forma que no haya interferencia o conflicto entre ellos.

Una de las cosas más útiles de Anaconda es que puedas crear tus propios ambientes de Python y puedas instalar los paquetes que requieras. Con Anaconda puedes hacer todo esto sin necesidad de los permisos de superusuario, que normalmente impiden la instalación de software en el clúster.

Tu ambiente por defecto, llamado **(base)**, será un Python "vanilla". Si hay paquetes que necesitas, ha llegado la hora de que crees tus propios ambientes y les instales lo que requieras.

Configuración para crear ambientes fuera de la carpeta de instalación
---------------------------------------------------------------------
Por defecto, Anaconda crea los ambientes en el mismo lugar donde lo instalaste. Si instalaste correctamente Anaconda en alguna ruta de ``/misc``, puedes saltarte estas instrucciones. Este paso es opcional si requieres que tus ambientes estén en otro lugar fuera de la ruta de instalación principal.

Para cambiar esto, necesitamos hacer una configuración sencilla en tu cuenta. Primero, es necesario que crees una nueva carpeta donde quieras almacenar tus ambientes. Las reglas del clúster indican que sea una carpeta dentro de ``/misc`` y, de preferencia, dentro de una subcarpeta con el nombre ``nobackup``.

En una terminal nueva (que empiece en tu home) abrimos el archivo de configuración de conda:

.. code-block:: bash

   gedit ~/.condarc

Dentro del archivo, pega el siguiente contenido, ajustando la ruta a tu carpeta:

.. code-block:: yaml

   envs_dirs:
     - /misc/ruta/a/tu/folder/de/ambientes

   env_prompt: ({name})

.. note::
   Si algún día borras Anaconda, no olvides eliminar también estos ambientes de dicho lugar.

Crear y eliminar ambientes
--------------------------
Para crear un ambiente nuevo de Anaconda, escribimos en la terminal:

.. code-block:: bash

   # Crear un ambiente con la última versión de Python
   conda create -n myenv python

   # Crear un ambiente con una versión específica de Python
   conda create -n myenvPython2 python=2.7

Para eliminar un ambiente por completo, ejecutamos:

.. code-block:: bash

   conda remove --name myenv --all

Navegando tus ambientes
-----------------------
Por defecto, tu miniconda siempre arranca en el ambiente **(base)**.

Para ver tus ambientes disponibles, los puedes enlistar en la terminal con:

.. code-block:: bash

   conda env list

Para activar un ambiente diferente, requieres ejecutar en la terminal:

.. code-block:: bash

   conda activate nombre_del_ambiente_a_activar

Puedes moverte con el comando ``activate`` entre tus diferentes ambientes.

Manejo de paquetes
------------------

Para ver qué paquetes de Python están en tu ambiente activo, basta con escribir:

.. code-block:: bash

   conda list

Para instalar un paquete:

.. code-block:: bash

   conda install paquete

Si por alguna razón el paquete que vas a instalar no se encuentra en el repositorio por defecto de Anaconda (y por lo tanto falló el comando anterior), te recomendamos intentar buscarlo en el canal alternativo **conda-forge**:

.. code-block:: bash

   conda install paquete -c conda-forge

El canal *conda-forge* es un repositorio mantenido por la comunidad donde encontrarás la mayoría de los paquetes que requieras. Si de plano tampoco se encuentra allí, aún puedes instalarlo usando el clásico **pip**:

.. code-block:: bash

   pip install paquete_raro