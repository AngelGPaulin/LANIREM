## Selección de elementos, filas y columnas ##
Supongamos que hay un archivo con la siguiente información dentro de un archivo de valores separados por comas llamado **datos.csv**. 

Al utilizar el valor **$0** se imprimen todos los valores contenidos en el archivo.

``` bash
 $ awk -F "\"*,\"*" '{print $0}' datos.csv

type,ID,WM.cm3,WM.%,GM.cm3,GM.%
no_incl,job932,381.3076,34.6114,537.8429,48.8202
no_incl,job933,599.6653,35.8897,798.9063,47.8141
no_incl,job945,523.3554,42.194,610.4963,49.2194
no_incl,job957,483.2968,35.1759,646.6898,47.0682
```
Si quisieras imprimir la 3ra columna completa se escribe de la siguiente manera, donde el $3 equivale a la tercera columna, $2 a la segunda, $1 a la primera, etc.:

```bash 
$ awk -F "\"*,\"*" '{print $3}' datos.csv

WM.cm3
381.3076
599.6653
523.3554
483.2968
```

Con NR==# se puede escoger una fila en particular, en este caso escogemos la 3er fila:

``` bash
$ awk -F "\"*,\"*" 'NR==3' datos.csv

no_incl,job933,599.6653,35.8897,798.9063,47.8141
```

Y utilizando una combinación de ambos se puede seleccionar un elemento en particular, aquí escogimos el elemento de  la 4a fila y 6a columna:
``` bash
$ awk 'NR==4 {print $6}' tmp.csv

49.2194
```

Finalmente se pueden seleccionar multiples elementos de una fila o columnas. A continuación escogimos en el primer ejemplo la fila 3, columnas 2, 3 y 4.
Y en el segundo ejemplo se escogieron de la fila 2 a la 4, columnas 2, 3 y 4.

Ejemplo 1

```bash
$ awk -F "\"*,\"*" 'NR==3 {print $2,$3,$4}' datos.csv

job933 599.6653 35.8897
```
Ejemplo 2
``` bash
$ awk -F "\"*,\"*" 'NR==2,NR==4 {print $2,$3,$4}' datos.csv

job932 381.3076 34.6114
job933 599.6653 35.8897
job945 523.3554 42.194
```
### Nota ###
Si tu archivo no es .csv y es .txt o es una variable dentro de un scrip no es necesario incluir la opción **-F "\"*,\"*"**, que solo se utiliza para indicar que los valores estan separados por comas. Entonces se escribiría:

```bash
awk 'NR==3 {print $2,$3,$4}' datos.txt
```
 o

```bash
awk 'NR==3 {print $2,$3,$4}' $datos
```
