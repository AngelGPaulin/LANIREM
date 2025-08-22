Tractografía
============

Para realizar una tractografía, el proceso general consiste en definir una región de inicio, generar las líneas de corriente (streamlines) y finalmente filtrar los resultados para aislar los tractos de interés.

1. Delimitar la Región de Interés (ROI)
=======================================

El primer paso es delimitar una **Región de Interés (ROI)**, que es el área anatómica de donde partirán o por donde pasarán los *streamlines* (líneas de corriente de difusión).

La segmentación del área deseada se puede realizar con diversas herramientas de visualización, como:

* **MRtrix**: ``mrview``
* **Freesurfer**: ``freeview``
* **FSL**: ``fslview``

.. note::
   A esta ROI inicial se le denomina comúnmente **semilla** (seed), dado que de aquí nacerán todos los streamlines del análisis.

Puedes encontrar un tutorial detallado para dibujar ROIs en `mrview en este enlace <http://www.brain.org.au/software/mrtrix/tractography/roi.html>`_.

---

2. Generación de Streamlines (Siembra)
======================================

Una vez que el área de la semilla está bien delimitada, se procede a generar la tractografía con el comando ``tckgen``.

.. code-block:: bash

   tckgen <input_DWI> <output_tracts.tck> -seed_image <roi_semilla.mif> [OPTIONS]

¡Ahora sí tenemos nuestro primer resultado de la tractografía! 🥳

---

3. Filtrado o Disección Virtual
===============================

A menudo, el resultado inicial contiene muchas fibras que no son de nuestro interés. Para solucionar esto, se realiza una **disección virtual**, que consiste en filtrar los resultados para refinar el tracto.

Este proceso se realiza con el comando ``tckedit``, que permite incluir o excluir otras regiones anatómicas para aislar el tracto deseado.

.. important::
   Para poder filtrar los streamlines, es necesario dibujar previamente las ROIs adicionales que se utilizarán para definir qué áreas incluir (``-include``) y qué áreas excluir (``-exclude``).
