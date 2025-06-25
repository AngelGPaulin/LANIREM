1. Realizar un análisis FEAT de alto nivel (**higher-level analysis**) donde se promedie la activación de la primera condición A > B (ej. música > silencio) en todos los sujetos. En la pestaña de **Post-stats** se debe de seleccionar una máscara en el recuadro de **Pre-threshold masking**, esta máscara debe salir del resultado obtenido del análisis de alto nivel la segunda condición de interés
C > B (**cluster_mask_zstat#.nii.gz**).

2. Realizar un análisis FEAT de alto nivel de la segunda condición  C > B (ej. habla > silencio). Se repiten los pasos del punto 1, para este análisis se escoge la máscara del contraste de la primera condición A > B (**cluster_mask_zstat#.nii.gz**).

3. Los dos análisis FEAT nos arrojarán las regiones en común, éstos serán muy similares pues en ambos casos la áreas de búsqueda se delimitan por el contraste opuesto:

     ```a) música > silencio (delimitado por la máscara de habla > silencio)```

     ```b) habla > silencio (delimitado por la máscara de música > silencio)```
