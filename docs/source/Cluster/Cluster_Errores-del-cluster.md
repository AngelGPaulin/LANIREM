En esta página se describen los errores clásicos del cluster.

## Cómo saber que hubo un error
Supongamos que acabamos de mandar un job, ya sea con `fsl_sub` o a través de alguna interface gráfica, como por ejemplo Feat. La pregunta es: está corriendo mi job? La respuesta es fácil de encontrar:

  qstat

Nos regresa algo como lo siguiente:

```{bash}
job-ID  prior   name       user         state submit/start at     queue                          slots ja-task-ID
-----------------------------------------------------------------------------------------------------------------
   4008 0.29506 feat5_stop federica     Eqw   08/18/2014 14:22:16                                    1        
   3308 0.00000 feat3_film federica     hqw   08/14/2014 12:17:19
   3973 0.00000 feat5_stop federica       r   08/18/2014 14:16:12                                    1        
```

Revisemos lo que significa: `job-ID` es el *ticket* que tiene nuestro trabajo en la cola. `prior` es la prioridad del trabajo, que la asigna el propio sistema del cluster. `name` es el nombre del trabajo (recuerda que con `fsl_sub -N <nombre>` puedes asignarlo. En caso de interfaces gráficas como Feat, el mismo programa se encarga de darle nombre. `user` es el dueño del job, y al final tenemos `submit/start at`, que nos dice cuando mandamos el job y cuándo empezó a ejecutar. Ahora, el más importante es `state`. En este ejemplo tenemos tres diferentes estados:

  * `Eqw`. Significa que hubo un error. Este job no va a ejecutarse hasta que se solucione el problema que causó el error.
  * `hqw`.  Este job tiene un //hold//, es decir, que no va a correr sino hasta que un job, probablemente un pre-requisito para este job, termine. Por ejemplo, los post-stats de Feat no pueden correr si no ha corrido stats. Este no es un error.
  * `r`. Este job está corriendo.

Para saber qué pasó con un job en estado `Eqw`, podemos ejecutar:

  qstat -j <job-id>

Por ejemplo, el job-id 4008 está en estado de error. Ejecutar `qstat -j 4008` regresa mucho texto, pero lo más importante está al final:

```{bash}
script_file:                /home/inb/lconcha/fmrilab_software/fsl_5.0.6/bin/feat
jid_predecessor_list (req):  4007
error reason    1:          08/18/2014 14:30:39 [1035:32278]: error: can't chdir to /datos/tournoux/federica/detanner/gaze/sujet
scheduling info:            queue instance "all.q@hahn.inb.unam.mx" dropped because it is disabled
                            queue instance "all.q@neurona.inb.unam.mx" dropped because it is disabled
                            queue instance "high.q@hahn.inb.unam.mx" dropped because it is disabled
                            queue instance "high.q@neurona.inb.unam.mx" dropped because it is disabled
                            queue instance "low.q@hahn.inb.unam.mx" dropped because it is disabled
                            queue instance "low.q@neurona.inb.unam.mx" dropped because it is disabled
                            Job is in error state

```

Aquí lo crucial es `error reason 1`, y `can chdir to /datos/tournoux…`. Esto significa que la carpeta donde tiene que escribir el script (en este caso feat), no está accesible. En efecto, este es el error más común, y hay dos razones para ésto.

La primer razón es causada por el usuario, al tratar de escribir en una carpeta no existente o en la que no tiene permisos de escritura. Esto sucede, por ejemplo, si el usuario `usuarioA`, en una terminal, está colocado en la carpeta `/home/inb/__usuarioX__`, en la cual, por defecto, no tiene permisos de escritura, y ahí ejecuta algún `fsl_sub`. Los logs que genera `fsl_sub` no podrán ser escritos en la carpeta actual. La solución es cambiar de carpeta.
`
La segunda razón es culpa del sistema de archivos NFS, que es el que permite que las computadoras compartan sus discos duros en la red de nuestro cluster.


Para diagnosticar este problema, ejecutamos el siguiente escript:

  inb_cluster_NFS_status_simple.sh


Un output de este escript es como:

```{bash}
--> arwen 	.. W ................. W ... W ..........OK
--> austin 	.. W ............... W ... W ... W .......OK
--> bloch 	.. W ............... W ... W ... W .......OK
--> cannabis 	... W ............... W ... W ..........OK
--> carr 	... W .............. W ... W ... W .......OK
--> charcot 	... W ................ W ... W ..........OK
--> claustrum 	... W ................ W ... W ..........OK
--> copula2 	... W .............. W ... W ... W .......OK
--> copula 	... W ............. W ... W ... W .......OK
--> ernst 	... W .............. W ... W ... W .......OK
--> evarts 	... W ................ W ... W ..........OK
--> fourier 	... W .............. W ... W ..........OK
--> giora 	... W .............. W ... W ... W .......OK
--> hahn 	... W .............. W ... W ... W .......OK
--> jasper 	... W ................ W ... W ..........OK
--> mansfield 	... W ............... W .. W ... W .......OK
--> mountcastle 	... W ................. W .. W ..........OK
--> penfield 	... W ................. W .. W ..........OK
--> purcell 	... W ............... W ... W .. W .......OK
--> rabi 	... W ................. W ... W .........OK
--> rhesus 	... W ............... W ... W .. W .......OK
--> sherrington 	... W ............... W ... W ... W .....OK
--> tanner 	... W ............... W ... W ... W .....OK
--> torrey 	... W ................ W ... W ... W .......OK
--> tournoux 	... W ................. W ... W ........OK

  Note: [W] means a whitelisted or disabled mount point (not an error).

    Whitelisted node(s)/mount(s): lauterbur sesamo drobo bruker pruebas

  whitelist file is /home/inb/lconcha/fmrilab_software/tools/inb_cluster_whiteList.txt


```

Vemos cómo el script pasa por todas las computadoras y revisa que cada uno de los sistemas de archivos estén bien montados en /datos. Si todo está bien, la computadora marca `OK`. Todo lo demás indica errores. En este caso, `lauterbur` no tiene montados los `homes`, así que ningún script va a correr en lauterbur. En otros casos este script nos dirá que algún directorio `/misc` está mal montado.  Vemos también que `Rhesus` no está prendida. Afortunadamente, el cluster deshabilita a las computadoras caídas para que no les lleguen jobs, así que esto no debe ser un problema mayor. Si aparece `W` en vez de `.` significa que ese nodo está deshabilitado a propósito por alguna razón, y por lo tanto se puso en la _lista blanca_ (whitelist), y el no encontrarlo no es un error.

En caso de que este script marque errores, *el usuario no puede corregir el problema* así que se recomienda comunicarse con el administrador del sistema (Luis, o Leopoldo, por ahora).
