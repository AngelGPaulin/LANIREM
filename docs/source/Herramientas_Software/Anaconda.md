Anaconda
========

[Anaconda](https://www.anaconda.com/) es un manejador de paquetes y ambientes de Python de código abierto.
Anaconda se encarga de instalar, correr y actualizar paquetes de Python y sus depependencias, así como también para crear ambientes de python de manera muy sencilla.

En esta entrada de la wiki encontrarás algunos comandos básicos para su uso e informacion sobre como configurar Anaconda para que funcione adecuademente en tu cuenta del cluster. Si quieres aprender mas sobre su uso avanzado te recomendamos la [wiki oficial de Anaconda](https://docs.conda.io/projects/conda/en/latest/index.html).



>  :warning: Si ya tenias una instalación local previa de Anaconda y planeas crear nuevos ambientes es necesario realizar una configuracion inicial para no saturar los discos del cluster. Mas de esto en esta wiki.


## Instalando anaconda (miniconda) en el cluster

>  :warning: Lo más relevante de esta sección es asegurarse de que que conda se instale fuera de tu carpeta home. Instalar conda dentro de home inflinge las normativas del cluster con respecto al uso de espacio de discos duros.

La instalación de Anaconda trae por default mucha paquetería científica de python y esto puede generar mucha redundancia y uso de datos en los discos duros del cluster. Por ello recomendamos instalar [miniconda](https://docs.conda.io/en/latest/miniconda.html), que es una versión mínima de Anaconda que sólo trae python. Las librerias que vayan a requerir las pueden ir agregando en los diferentes ambientes que vayan creando.

Para comenzar pueden descargar la versión más reciente de miniconda de este [link](https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh). Si requieren una versión distinta pueden revisar las diferenes opciones en la [documentación oficial](https://docs.conda.io/en/latest/miniconda.html).

Después en una terminal (suponiendo están en la misma carpeta donde guardaron el archivo) ejecutamos el scrip que descargamos:
```
bash Miniconda3-latest-Linux-x86_64.sh
```

Primero nos va a solicitar leer y aceptar los términos de condiciones de licencia los cuales podemos leer detenidamente dando `enter` luego `q` y finalmente escribiendo `yes`.

>  :warning: El siguiente paso es super importante!

Ahora nos va a solicitar en que ubicación instalará Miniconda. Por default será dentro de tu carpeta home lo cual no es permitido en el cluster (Más información de por que en este link). Es vital que cambien el path de instalación a algun folder dentro de su usuario en misc, como ejemplo

```
/misc/computadora/usuario/miniconda
```

donde hay que cambiar `computadora` y `usuario` por su computadora preferente en misc y su usuario.

Después de esto está bien darle a los defaults de la instalación para una instalación general.



## Ambientes de Anaconda
Un ambiente de Anaconda es un directorio que contiene una instalacion aislada de Python y paquetes puestos por el usuario. De esta forma puedes tener varios ambientes con diferentes versiones de python y/o paquetes de tal forma que no haya interferencia o conflicto entre ellos.

Una de las cosas mas utiles de Anaconda es que puedas crear tus propios ambientes de Python y puedas instalar los paquetes que requieras. Con anaconda puedes hacer todo esto sin necesidad de los permisos de superusuario que normalmente impide la instalacion de software en el cluster.


Tu ambiente *(base)* de Anaconda será un python vanilla. Si hay paquetes que necesitas que quisieras tener, ha llegado la hora de que crees tus propios ambientes y les instales lo que requieras.


### Configuracion para crear ambiente fuera de la carpeta de instalacion
Por default Anaconda crea los ambientes en el mismo lugar donde instalaste Anaconda en el paso de instalación. Si instalaste correctamente anaconda en algun lugar de /misc puedes brincarte estas instrucciones. Este paso es opcional si requieres a tus ambientes en otro lugr fuera de la ruta de instalación.

Para cambiar esto necesitamos hacer una configuracion sencilla en tu cuenta. Primero es necesario crees un nuevo folder donde quieras almacenar tus ambientes. La reglas del cluster indican que sea un folder de la carpeta /misc y de preferencia dentro de una carpeta con titulo nobackup. 

En una terminal nueva (que empiece en tu home) escribimos:
```
gedit .condarc
```
la cual abrira gedit con un nuevo archiuvo .condrac vacio. Continuacion pegaremos las siguientes lineas (cambiando "/misc/ruta/a/tu/folder/de/ambientes"  a la ruta del folder que acabas de crear) y le daremos Save
```
envs_dirs:
 - /misc/ruta/a/tu/folder/de/ambientes

env_prompt: ({name})
```
Con esto tendremos Anaconda listo para crear ambientes nuevos.

Nota: Sí algún día borras anaconda no olvides eliminar estos ambientes de dicho lugar.

### Crear/eliminar ambientes nuevos
Para crear un ambiente nuevo de Anaconda escribimos en la terminal:
```
conda create -n myenv python
```
Sustituyendo "myenv" por el nombre que le queremos dar al ambiente. Este comando ba a crear un ambiente con python 3. Podemos especificar la version de python a instalar, como por ejemplo:
```
conda create -n myenvPython2 python=2.7
```
Crearia un nuevo ambiente *myenvPython2* con Python 2.7 instalado.


Para eliminar un ambiente ejecutamos
```
conda remove --name myenv --all
```
sustituyendo *myenv* con el nombre del ambiente a eliminar.

### Navegando tus ambientes
Por default tu miniconda siempre arracna en el ambiente *(base)*

Para ver tus ambientes disponibles los puedes enlistar en la terminal con:
```
conda env list
```
Para una instalación nueva de anaconda sólo tendrá enlistado el ambiente *(base)*, mientras vayas agregando ambientes apareceran aquí.

Para activar un ambiente diferente al *(base)* requieres ejecutar en terminal el comnado:
```
conda activate nombre_del_ambiente_a_activar
```
donde cambias "nombre_del_ambiente_a_activar" por el ambiente a activar.

Puedes moverte con el comando activate entre tus ambientes.


## Manejo de paquetes

Para ver que paquetes de python están en tu ambiente activo basta con escribir
```
conda list
```
Para instalar paquetes nuevos en el ambiente actual lo mas recomendado es hacerlo mediante los paquetes propios comandos de anaconda, loc cuales se van a encargar de instalar todas las dependecias requeridas por este paquete. Esto lo podemos hacer con el comando:
```
conda install paquete
```
Cambiendo *paquete*, por el que vas a instalar.

Si por alguna razón el paquete que vas a instalar no se encuentra en el respositorio default de Anaconda (y por lo tanto falló el comando anterior), te recomendamos intentar buscarlo en el canal repositorio alternativo de *conda-forge*:
```
conda install paquete -c conda-forge
```

El canal *conda-forge* es un repositorio alternativo mantenido por la comunidad pythonera donde vas a encontrar la mayoría de paquetes que requieras. Si de plano tampoco se encuentra en *conda-forge*, aún puedes instalarlo usando el clásico pip:
```
pip install paquete_raro
```
Sin embargo no es recomendado pues anaconda no siempre podrá manejar adecuademente las dependencias de dicho paquete. Usalo sólo en caso de que tu paquete no se encuentre en *conda-forge*.


