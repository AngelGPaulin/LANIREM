Registro
========

:warning: OJO, en 2024 ya tenemos una mejor herramienta, ```inb_synthreg.sh`` <https://github.com/lconcha/inb_tools/blob/main/inb_synthreg.sh#L9>`_.

Registrar dos imágenes distintas es muy fácil cuando son del mismo sujeto y tienen el mismo contraste; si son de diferentes sujetos, todas del mismo contraste, pero las queremos llevar a un espacio estándar, estamos hablando de normalización, y como puede verse [[registration]], eso tampoco es difícil. El siguiente paso de complejidad es registrar dos imágenes del mismo sujeto pero con contrastes distintos (p.ej. una T1 con una T2). Habitualmente eso lo logramos utilizando una función de costo apropiada, *como mutual information*. Pero hay un caso muy difícil, aunque se trate de imágenes del mismo sujeto, que es cuando existen inhomogeneidades geométricas distintas entre las dos imágenes a registrar. Estas inhomogeneidades geométricas son, desgraciadamente, la norma en imágenes eco-planares (EPI) como las de contraste BOLD y las DWI, mientras que las imágenes T1 (SPGRE, por ejemplo), son inmunes a estos problemas. 


Por ejemplo si hacemos un registro lineal con flirt entre la T1 hacia un mapa de ADC, vemos que la parte mas anterior del cuerpo calloso de la T1 (rojos) está más anterior que la del mapa del ADC (grises):

[[images/selection_029.png]]

En esta página vamos a describir una estrategia para lograr el registro entre estas imágenes. Es importante hacer una aclaración: Es prácticamente imposible hacer un registro perfecto entre  imágenes T1 y EPI (algo que es casi garantizado, por ejemplo, entre T1 y T2). Esto es solo una estrategia que ha funcionado moderadamente bien, pero tiene mucho qué mejorar aún. 

La estrategia es utilizar mapas de volumen parcial de el LCR derivados de FAST de las imágenes T1, y vamos a registrar eso contra el mapa de ADC derivado de las imágenes DWI.

Para este ejemplo, vamos a asumir algunas cosas:
**$t1** es mi imagen pesada a T1 (a la que ya le hicimos [[brain_extraction_tool_bet]] )
,
**$adc**  es mi mapa de ADC derivado de mis DWIs (habiendo usado bet). 



::

   fast -v -S 1 -n 3 -t 1 -I 1 -g -N 
   
     -o Fast_t1 
   
     $t1 
   
Ahora haremos un primer registro entre la estimación del LCR de las imágenes T1 con el mapa de ADC. Ojo, la imagen fija es el ADC.

::

   
   flirt 
   
     -in Fast_t1_pve_0 
   
     -ref $adc 
   
     -omat lin.mat 
   
     -out lin_csf2adc_transformed 
   
Excelente, ahora vamos a afinar este registro entre imágenes utilizando un registro no lineal:

::

   
   fnirt -v 
   
     --in=Fast_t1_pve_0 
   
     --ref=$adc 
   
     --fout=field 
   
     --aff=lin.mat
   
   applywarp -v 
   
     -i $t1 
   
     -o t1_to_dwi 
   
     -r $adc 
   
     -w field 
   
Ahora, si vemos cómo se ve la imagen T1 (rojos) registrada no-linealmente con el mapa de ADC como referencia (gris), vemos que el cuerpo calloso encaja mucho mejor:

[[images/selection_030.png]]

Dado que esta es una operación que se realiza frecuentemente, existe un escript en el laboratorio para automatizar la tarea:

::

   inb_register_t1_to_dwi_via_csf.sh
    
   inb_register_t1_to_dwi_via_csf.sh <t1> <adc> <outbase> [Options]
    
   Note that t1 and adc must be skull-stripped
   
   
   Options
   
     -keep_tmp
     -tmpDir </some/folder>
   
    
    LU15 (0N(H4
    INB, Feb 2015.
    lconcha@unam.mx
   
