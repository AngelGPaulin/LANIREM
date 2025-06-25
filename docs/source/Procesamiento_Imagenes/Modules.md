módulos
========

# Módulos
Los [módulos](https://modules.readthedocs.io/en/latest/) son una herramienta que permite personalizar el software disponible al usuario en una sesión de su terminal mediante archivos de módulos. 

Los archivos de módulo contienen rutas de carpetas y variables de entorno que se agregan al PATH cuando se manda a llamar dicho módulo. Esto permite tener un buen control de las librerías activas en una sesión para evitar conflictos entre las paqueterías de software en una misma sesión.

## Uso básico

Hay dos comandos principales para utilizar módulos:

- `module avail` : Muestra la lista de software/módules disponibles.

- `module load <module>`: Activa el modulo en el ambiente actual.


Por ejemplo, en una terminal nueva escribir el comando `module avail` nos arroja la lista de módulos de don clusterio:

[[images/module_avail.png]]

Como ejemplo activaremos el módulo de mrtrix con `module load mrtrix`. Enlistando los módulos vemos ahora está activo:

[[images/module_load_mrtrix.png]]

Podemos activar varios módulos en una misma línea. Por ejemplo para agregar fsl y brkraw a nuestra sesión actual podríamos escribir `module load fsl brkraw`.

[[images/module_load_fsl_brkraw.png]]

Si escribimos solo el nombre del módulo se carga la última versión disponible. Podemos especificar la versión a cargar del algún módulo escribiendo su nombre/versión. Por ejemplo, para cargar una versión antigua de AFNIpodriamos utilizar `module load afni/22.2.04`. 

[[images/module_load_afni.png]]

Tip: El autocompletar con tabulador funciona en los módulos!

## Otros comandos
- `module list`: Enlista los módulos actualmente activos en la sesión.
- `module unload <module>`: Desactiva un módulo de la sesión actual.
- `module purge`: Desactiva todos los módulos de la sesión actual.

- `ml`: Alias corto para module load. Podemos cargar modulos mediante `ml <module>`.
- `module av`: Alias de module avail.
- `module add`: Alias de modulo load.
- `module rm`: Alias de modulo unload.

## Cargando módulos en todas las sesiones.
Si hay algún modulo que utilizas seguido (y no conflictúa mucho con otros módulos) puedes cargarlo de manera persistente en todas tus sesiones sin necesidad de cargarlo una vez por sesión. 

Para esto sólo requires modificar el archivo `.bashrc` que se encuentra oculto en tu carpeta HOME agregando al final del mismo la línea con la cual cargas tu modulo (i.e. module load <módulo>).

Puedes modificar este archivo con alguno de los editores de texto de Don Clusterio (e.g. micro, nano, vim, gedit) abriendo una terminal nueva y escribiendo (ejemplo con micro) `micro .bashrc` y agregando los módulos que quieras al final (o al menos asegúrate que sea después del source de configuración de Don Clusterio) y guardando el archivo (para el caso de micro es con `CTRL + S`).

## NOTAS
- El módulo inb_tools contiene una serie de joyitas programadas por el Dr. Concha (en su mayoría en bash) a lo largo de los años de Don Clusterio. Este módulo se activa por default para los usuarios. Puedes ver los scripts en su github (https://github.com/lconcha/inb_tools). Te invitamos a contribuior si sale una idea cool para el cluster!
- El módulo de dipy utiliza ambientes de python. Van a generar conflicto con  ambientes locales de conda si los activas a la par. Cabe decir que estamos experimentando ver si vale la pena mantener módulos de ambientes de python de estar forma.
