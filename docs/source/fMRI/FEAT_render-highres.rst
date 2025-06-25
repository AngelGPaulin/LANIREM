FEAT render highres
===================

¿Para qué sirve el comando render highres?
-----------------------

Este comando permite integrar como una sola imagen un fondo anatómico o funcional con un mapa estadístico de activación.

La estructura del comando es la siguiente:

    renderhighres <directorio feat> <espacio> <fondo> <autoumbral> [mínZ máxZ]
  
    directorio feat: Seleccionar la carpeta FEAT que contenga el mapa estadístico a emplear.

    espacio: Seleccionar entre "standar" o "highres".

    fondo: Seleccionar entre "standar" o "highres".

    autoumbral: Seleccionar "0" o "1". En caso de elegir "1", se emplearán los umbrales calculados para el mapa estadístico; de lo contrario, se utilizaran los valores de mínZ y máxZ.
