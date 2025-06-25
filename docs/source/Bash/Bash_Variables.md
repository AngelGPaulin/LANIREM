Variables
=========

En el contexto de la programación, una variable funciona como un "contenedor" que almacena un valor que puede ir cambiando a lo largo del tiempo durante la ejecución de un programa. Cuando se declara una variable, este se reserva en un espacio en la memoria donde almacena su valor, normalmente tu como usuario decides que nombre le das a tu variable, el cual tiene que ser un nombre unico de preferencia, para que puedas hacer referencia a ella en el código. 
Las variables tienen la ventaja de que pueden contener cualquier tipo de informacion, ya sea numérica, texto, directorios, etc.

### Asignación de variables 

En este primer ejemplo la variable contiene la frase Hola mundo, la cual puedes imprimirla en la terminal usando `echo`. Donde el signo `=` lo utilizo para **asignar** mi variable y el signo de `$` para mandarlo a llamar. 

```bash
> mi_variable = "Hola mundo"

> echo $mi_variable 

> Hola mundo
```

Hagamos otros ejemplos:

```bash
> export PATH=/misc/nyquist/paulinav

> echo $PATH

> /misc/nyquist/paulinav
```

```bash
> edad = 30

if [ $edad -ge 18 ]
 then
    categoria="Adulto"
else
    categoria="Menor"
fi

> categoria=Adulto
```

```bash
> input=/misc/nyquist/usuario/mis_imagenes
> output=/misc/carr2/usuario/analisis

for f in ${input}
   do
      cp -r $f ${output}

done

```

Existen mil maneras mas de utilizar las variables. Al final del día, las variables te facilitaran muchisimo el manejo de la terminal, y tambien brindarán estabilidad en tus scripts. 



