terminar un proceso
===================

## ¿Cómo matar un proceso?

En ocasiones ocurre que por alguna razón, los procesos en los que trabajamos,
necesitan ser terminados:

- Porque ocupan muchos recursos,
- Porque se quedaron trabados,
- Porque sus procesos _"padre"_ murieron pero ellos no
- O porque no permiten la ejecución de otros programas.

En cualquiera de los casos es importante saber cómo matar los procesos.

### ps y kill

La opción clásica para matar un proceso es usando dos comandos en la terminal.

    ps -a

Permite ver una lista de los procesos en ejecución que nos pertenecen.

    ps -A

Nos muestra una lista completa de todos los procesos activos.  En ambos casos
se puede usar grep para buscar en la lista un programa en particular.

    ps -A | grep programa

Cuando lo utilizamos, nos muestra una salida como esta:

    PID TTY          TIME CMD
    1841 pts/9    00:00:00 dbus-launch
    3622 tty2     00:00:00 bash
    5411 pts/7    00:00:00 ps

Dónde lo importante es el número __PID__, pues este número es el que
utilizaremos en el comando _kill_.

    kill 5411

Si se necesita que el proceso acabe inmediatamente, se puede usar una
prioridad __9__ que lo vuelve obligatorio.

    kill -9 5411


### htop

Htop es una manera muy cómoda para terminar un proceso. Basta seleccionar el proceso y presionar __F9__, esta acción 
contiene varias opciones, sin embargo, es suficiente con la opción por default. Al presionar enter el proceso termina.

En cuaquier caso para salir de una selección se presiona __ESC__. Y para salir del programa se usa la tecla __q__.

[[images/htop.gif]]

### Interfaz gráfica

Si se quiere hacer gráficamente, se abre la aplicación __system monitor__ o
desde la consola `gnome-system-monitor` ahí en la pestaña de procesos se ubica
el programa y al presionar el segundo botón sobre el proceso aparece la opción
__kill process__. Un ejemplo:  

[[images/killgrafico.gif]]  

## Matar todo lo que puede morir (de tu sesión)

En un caso extremo dónde se haya trabado todo y no veas nada incluída la interfaz gráfica, primero se debe de ingresar al **TTY** (terminales físicas sin entorno gráfico) por medio de las teclas **Crtl+Alt+F1-F6**, son seis las que se pueden seleccionar, de F1 a F6.

Una vez ahí se debe dar login con tu **usuario** y **contraseña**.

Entonces se escribe:

    kill -9 -1

Parecerá que se reinicia la sesión gráfica y tendrás que entrar de nuevo. Asegúrate de entrar nuevanebte al TTY y cerrar la sesión.
