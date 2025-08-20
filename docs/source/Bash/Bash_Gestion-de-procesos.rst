Gestión de procesos
===================

top
-----------------------

Muestra los procesos que se están ejecutando y permite matarlos.

htop
-----------------------

**htop** es una versión más avanzada de **top**, la cual permite observar los procesos activos.

El comando ``htop`` inicia esta interfaz en la cual nos desplazamos con las flechas arriba y abajo. El comando tiene más opciones de control. Sin embargo nos pueden interesar dos: F6 permite seleccionar el orden en el que se presentan los procesos, y F9 terminar los procesos.

Son de especial interes el arreglo por **"" __USER__, __CPU%__ y __MEM%__"**.

Matar procesos
-----------------------

Bash tiene diversas formas para terminar comandos y procesos en ejecución, revise la entrada para 
:doc:`Bash-kill`

s
-----------------------

Muestra la lista de procesos del usuario.

Este comando es útil en varias cuestiones, por ejemplo, nos puede mostrar los procesos en nuestro sistema, el estado del mismo, los datos sobre el tamaño de algún proceso, los usuarios a los que pertenecen algunos procesos, el tiempo del CPU, el tiempo del reloj y muchos más.

Parámetros:

.. tabs::

   .. tab:: Opciones Comunes

      .. admonition:: Banderas (flags) más usadas
         :class: tip

         Estas opciones modifican el comportamiento de muchos comandos, como ``ps`` (para ver procesos).

         **-a**
            Muestra **a**ll (todos) los procesos, no solo los del usuario actual.

         **-r**
            Muestra solo los procesos en ejecución (**r**unning).

         **-x**
            Muestra procesos que no están asociados a una terminal.

         **-u**
            Filtra los procesos por **u**suario.

         **-l**
            Presenta la salida en formato de lista **l**arga y detallada.

         **-w**
            Muestra la salida en formato ancho (**w**ide), evitando que se corte.


   .. tab:: Comandos de Diagnóstico

      .. rubric:: Comandos esenciales para monitorear el sistema

      |

      .. container:: command-box

         **free -h**

         Muestra el estado de la memoria RAM del sistema de forma legible para **h**umanos. Te dice cuánta memoria está libre, en uso y en caché.

      .. container:: command-box

         **df -h**

         Reporta el espacio libre en los **d**iscos duros (**f**ilesystems). La opción ``-h`` muestra los tamaños en GB, MB, etc.

         .. code-block:: bash

            df -h

      .. container:: command-box

         **ping**

         Verifica la conectividad de red con otro equipo (servidor). Envía un pequeño paquete y espera una respuesta.

         .. code-block:: bash

            ping mansfield