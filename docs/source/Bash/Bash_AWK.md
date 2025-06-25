AWK
===

AWK es un lenguaje de programación diseñado para procesar datos basados en texto, ya sean ficheros o flujos de datos.

## Estructura de awk ##
**awk** bla bla bla bla bla pendiente

blablablabla blablablabla


``` bash
 awk bla bla bla BEGIN END print
```
## Declarar variables de BASH dentro de awk ##
awk -v d=INICIO '{print d " " $0}'

## Redireccionar valores generados por awk ##
Declarar las variables de BASH A awk


**awk** bla bla bla bla bla pendiente

``` bash
Td=`fslstats_rois $t2m $labels $Tal_DER "-M -S -P 50 -m -s -V"`
  Tdmean=$(awk '{print $1}' <<< "$Td")
```
## Agregar variables al PRINCIPIO o al FINALde una fila ##
Al **final**
``` bash
awk -v d=$dir '{print d " " $0}' tmp_struct0.txt > tmp.txt 
```
Al **principio**
```
bash awk -v d=$dir '{print d $0 " "}' tmp_struct0.txt > tmp.txt
```
## Selección de elementos, filas y columnas ##
[awk select](./Bash:-AWK-Selec) permite seleccionar elemento de un archivo con varias columnas y filas (.csv .txt etc) **awk** . Y puede ser una fila, una columna o varias, o un solo elemento.

## Operaciones ariméticas con variables de coma flotante  ##
Bash no puede realizar operaciones aritméticas con números con decimales, sin embargo, awk, si logra multiplicar, dividir, sumar y restar estos valores. Para esto revisar la entrada [awk arimet](./Bash:-AWK-Arimet).
