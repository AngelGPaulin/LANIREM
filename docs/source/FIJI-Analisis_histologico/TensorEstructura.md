Tensor de Estructura
====================

# **Tensor de Estructura con OrientationJ**

OrientationJ es una herramienta poderosa para analizar y caracterizar propiedades de las fibras, como la orientación y la anisotropía. Esta guía te mostrará cómo utilizar el plugin OrientationJ en FIJI, cómo ajustar las configuraciones según tus objetivos de análisis y cómo interpretar los datos resultantes.

Para obtener información más detallada, consulta la documentación oficial en su sitio web: [Documentación de OrientationJ](http://bigwww.epfl.ch/demo/orientation/).


### 1) Descargar e instalar el plugin.
Primero, descarga el plugin `OrientationJ_.jar` desde el sitio web de la documentación. Una vez descargado, arrastra y suelta el archivo en la carpeta "plugins" dentro del directorio de instalación de FIJI. Reinicia FIJI para activar el plugin.

### 2) Accediendo a OrientationJ
Después de reiniciar FIJI, encontrarás OrientationJ en el menú de plugins. El plugin ofrece varias opciones de análisis, cada una adaptada a diferentes aspectos de la exploración histológica.

### 3) Parámetros clave para el análisis
Antes de profundizar en las diferentes opciones, es esencial entender dos parámetros principales que necesitarás configurar:

* **Ventana Local**: El tamaño de la ventana local determina el vecindario de píxeles sobre los cuales se realiza el análisis, funcionando esencialmente como un kernel Gaussiano. El tamaño adecuado de la ventana depende de la estructura anatómica que estés analizando. Es crucial experimentar con diferentes tamaños de ventana para encontrar el más adecuado para tus objetivos de análisis. Una vez que hayas elegido un tamaño de ventana local, asegúrate de mantener la consistencia en todos los análisis para lograr comparabilidad.

* **Gradiente**: Deberás elegir un método de gradiente para el análisis. El gradiente de *Cubic Spline* es recomendado por los desarrolladores por su velocidad y precisión, aunque puedes explorar otras opciones si lo consideras necesario.


![Captura de pantalla 2024-08-13 a la(s) 4.25.32 p.m.](https://hackmd.io/_uploads/B1ep6LF5C.png)

---

Ahora revisemos las opciones de análisis:

## Análisis con OrientationJ

Esta es la opción **cualitativa** del tensor de estructura. Este análisis calculará una serie de imágenes basadas en la textura de la histología. Para este ejercicio, utilicé una tinción por inmunofluorescencia de MBP con un acercamiento a la cápsula interna del cerebro:
![Captura de pantalla 2024-08-13 a la(s) 5.37.16 p.m.](https://hackmd.io/_uploads/r1iZJOYc0.png)

En este caso, seleccioné todas las opciones para mostrar todas las funciones. ¿Qué significan?

* **Gradiente-X y Gradiente-Y**: Estos gradientes son las primeras derivadas de los valores de intensidad de la imagen en las direcciones horizontal (X) y vertical (Y). Proporcionan información sobre cómo cambia la intensidad de la imagen a lo largo de estos ejes, lo cual es crucial para detectar bordes y la orientación de las estructuras dentro de la imagen.

* **Energía**: Esto mide la cantidad total de variación de intensidad dentro de la ventana local. Se calcula a partir de los valores propios del tensor de estructura y refleja la fuerza general de la señal direccional. Por ejemplo, una alta energía puede indicar patrones de orientación fuertes y consistentes, mientras que una baja energía podría significar una distribución de orientaciones más isotrópica o aleatoria.

* **Orientación**: Se refiere a la dirección dominante de las estructuras dentro de la ventana local. Esto se calcula a partir del vector propio principal del tensor de estructura, representando básicamente el ángulo en el que están alineadas las estructuras.

* **Coherencia**: Esto cuantifica el grado de anisotropía, o uniformidad direccional, de la estructura. Una alta coherencia (1) indica que las estructuras están bien alineadas en una sola dirección, mientras que una baja coherencia (0) sugiere una estructura más aleatoria o isotrópica. Matemáticamente, se deriva de los valores propios del tensor de estructura, donde un valor alto de coherencia significa que la diferencia entre los valores propios es grande.

* **Color-Survey**: Esta es una representación visual de las orientaciones, donde diferentes orientaciones se asignan a colores específicos (dependiendo de su dirección). Cada color corresponde a una orientación específica, lo que permite una identificación rápida de patrones y anisotropías en la imagen.

Aquí abajo se muestran ejemplos de cómo se ven:

![Captura de pantalla 2024-08-13 a la(s) 5.37.36 p.m.](https://hackmd.io/_uploads/SktlfuY5A.png)

## OrientationJ Distribution

Esta opción te permite analizar la distribución de las orientaciones dentro de la imagen. Los parámetros en la sección *Structure Tensor* son similares a los de la opción `OrientationJ Analysis`, por lo que no proporcionarán información diferente. Sin embargo, **para este análisis, las configuraciones clave en las que enfocarse son las opciones `Histogram` y `Table`**:

![Captura de pantalla 2024-08-13 a la(s) 6.16.31 p.m.](https://hackmd.io/_uploads/SyG3v_Y9R.png)

Cuando se seleccionan, estas opciones generarán un histograma que muestra la distribución de orientaciones a lo largo de la imagen. El histograma traza la frecuencia de cada orientación en el eje Y en comparación con los grados correspondientes en el eje X. Esta representación visual ayuda a comprender la alineación general de las estructuras.

Además del histograma, y lo más importante, la misma información de distribución de orientaciones también se proporciona en un formato de tabla y se puede guardar como un archivo CSV para un análisis estadístico más detallado. Esta función es especialmente útil para un análisis de datos más detallado o personalizado fuera de FIJI.

![Captura de pantalla 2024-08-13 a la(s) 6.16.40 p.m.](https://hackmd.io/_uploads/S1MhDOKqC.png)

---

## OrientationJ Measure

Esta opción te permite calcular el Tensor de Estructura (ST, por sus siglas en inglés) dentro de Regiones de Interés (ROIs) específicas. Para seleccionar el área que deseas medir, usa la herramienta de rectángulo o círculo en la barra de herramientas de FIJI. Una vez que hayas definido el ROI, haz clic en el botón `Measure` en la ventana `OrientationJ Measure`. Esto superpondrá dos círculos en tu imagen de histología: un círculo morado que representa el ROI y una elipse naranja que representa el ST calculado.

La elipse naranja representa visualmente la anisotropía y la orientación principal (primer valor propio) de la estructura subyacente. Por ejemplo, si la elipse está alargada y alineada con las fibras, indica un alto grado de anisotropía y una orientación clara. En el ejemplo, el tensor número uno muestra una forma bien alineada y más delgada, lo que significa que la anisotropía es mayor en comparación con otros, como la elipse número dos. En el lado derecho de la ventana, encontrarás un resumen de los resultados, que puedes copiar para un análisis posterior.

Puedes medir tantas ROIs como necesites, y cada una será identificada con un número único tanto en la imagen como en la tabla de resultados. También puedes personalizar el color y el grosor de la línea de la elipse y el ROI haciendo clic en la sección `Options`.

![Captura de pantalla 2024-08-15 a la(s) 11.44.01 p.m.-2-2-2](https://hackmd.io/_uploads/SkZ8tw29A.png)

Otra función útil es la capacidad de crear una máscara binaria a partir de los ROIs seleccionados. Esta máscara se puede utilizar para un procesamiento adicional en FIJI que requiera áreas segmentadas.

![Captura de pantalla 2024-08-15 a la(s) 11.55.40 p.m.-2](https://hackmd.io/_uploads/r1rkjv390.png)

## OrientationJ Vector Field

Finalmente, esta opción te permite calcular y visualizar un campo vectorial en toda la imagen de histología. Esta representación vectorial se deriva de la orientación dominante y la anisotropía dentro de cada ventana local, proporcionando una guía visual de patrones y alineaciones en la imagen.

Puedes modificar el tamaño de la cuadrícula del campo vectorial, lo que controla el espacio entre los vectores. A medida que ajustas el tamaño de la cuadrícula, las líneas vectoriales abarcarán más o menos píxeles, cambiando efectivamente la resolución de la ventana local utilizada para calcular los vectores. Los tamaños de cuadrícula más pequeños resultan en un campo vectorial más denso, mientras que los tamaños de cuadrícula más grandes producen una representación más dispersa.

En el ejemplo siguiente, el tamaño de la cuadrícula se ajustó de 80 a 10. Se recomienda elegir un tamaño de cuadrícula que mejor se ajuste a la estructura subyacente de tu imagen para obtener la representación más precisa.

![Captura de pantalla 2024-08-16 a la(s) 12.18.24 a.m.](https://hackmd.io/_uploads/H1rlWMpqC.png)

Si bien la superposición de vectores proporciona una valiosa evaluación visual, la información más valiosa se encuentra en la opción `Table`. Esta tabla contiene datos esenciales como:

* **X y Y**: Las coordenadas de cada vector.
* **Orientación**: La orientación principal de cada vector.
* **Anisotropía (Coherencia)**: El grado de anisotropía asociado con cada vector.

Puedes guardar y exportar esta tabla para un análisis posterior en tu software preferido, lo que te permitirá una exploración más profunda de los patrones de orientación y anisotropía dentro de tu imagen.

![Captura de pantalla 2024-08-16 a la(s) 12.19.59 a.m.](https://hackmd.io/_uploads/B1WZWzTq0.png)

---

Espero que este tutorial le sea útil para cualquiera que esté realizando su análisis con el Tensor de Estructura.
Cualquier comentario o sugerencia para mejorar este tutorial es muy bienvenido! :smiley:
