Sed
===

El comando ``sed`` (**s**tream **ed**itor) es una herramienta muy poderosa y elegante para la manipulación de texto. El comando te permite realizar operaciones de búsqueda, sustitución y manipulación de texto ya sea en archivos o basicamente de cualquier argumento de salida de otros comandos. Veamos un poco más.

Sintaxis basica
-----------------------

::

   sed [OPCIONES] [SCRIPT] [ARCHIVO]

::

   > echo 
   "Pepe Pecas pica papas con un pico, 
   con un pico pica papas Pepe Pecas. 
   Si Pepe Pecas pica papas con un pico, 
   ¿donde esta el pico con que Pepe Pecas pica papas?" 
   >> Pepe_Pecas.txt

::

   sed 's/papas/manzana/g' Pepe_Pecas.txt
> cat Pepe_Pecas.txt

"Pepe Pecas pica manzana con un pico, 
con un pico pica manzana Pepe Pecas. 
Si Pepe Pecas pica manzana con un pico, 
¿donde esta el pico con que Pepe Pecas pica manzana?"
::

   Tambien podemos contar cuantas veces se menciona a Pepe en el texto:
> 4
::

   
   O porque no agregar una linea al final del texto:

> cat Pepe_Pecas.txt

"Pepe Pecas pica papas con un pico, 
con un pico pica papas Pepe Pecas. 
Si Pepe Pecas pica papas con un pico, 
¿donde esta el pico con que Pepe Pecas pica papas?
Definitivamente Pepe perdio el Pico"
::

   
   
   
   [Aquí](https://www.digitalocean.com/community/tutorials/the-basics-of-using-the-sed-stream-editor-to-manipulate-text-in-linux) te dejo un manual para más trucos con `sed`
   
