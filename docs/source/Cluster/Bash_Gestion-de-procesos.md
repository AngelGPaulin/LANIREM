Gestión de procesos
===================


## top
Muestra los procesos que se están ejecutando y permite matarlos.

## htop

**htop** es una versión más avanzada de **top**, la cual permite observar los procesos activos.

El comando `htop` inicia esta interfaz en la cual nos desplazamos con las flechas arriba y abajo. El comando tiene más opciones de control. Sin embargo nos pueden interesar dos: F6 permite seleccionar el orden en el que se presentan los procesos, y F9 terminar los procesos.

Son de especial interes el arreglo por __USER__, __CPU%__ y __MEM%__.

## Matar procesos ##

Bash tiene diversas formas para terminar comandos y procesos en ejecución, revise la entrada para [terminar un proceso](./Bash:-kill).

##ps

Muestra la lista de procesos del usuario.

Este comando es útil en varias cuestiones, por ejemplo, nos puede mostrar los procesos en nuestro sistema, el estado del mismo, los datos sobre el tamaño de algún proceso, los usuarios a los que pertenecen algunos procesos, el tiempo del CPU, el tiempo del reloj y muchos más.

Parámetros:

```
     -a Muestra todos los procesos con un control, este comando no sólo muestra datos del usario actual.
     -r Muestra sólo los procesos que están en ejecución
     -x Muestra procesos, de los cuáles la terminal no tiene control.
     -u Muestra los procesos del propio usuario (owner process)
     -l Muestra los datos en formato de una lista larga
     -w Muestra procesos de la línea de comandos.
```

## free -h

Muestra el estado de la memoria del CPU actual.

## df

Muestra el espacio libre de los discos/dispositivos. Legible a humanos (-h)

```
      df -h
```

## ping

Indica si hay respuesta por parte del servidor

```
      ping mansfield
```
