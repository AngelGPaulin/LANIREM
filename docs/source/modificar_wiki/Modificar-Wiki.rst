.. _colaborar-wiki:

======================================
Cómo colaborar con la Wiki del LANIREM 🧠
======================================

¡Gracias por tu interés en contribuir a la wiki! Tu colaboración es fundamental
para mantener esta documentación actualizada y útil para toda la comunidad.
Sigue estos sencillos pasos para empezar a colaborar.

.. note::
   A diferencia de otras wikis (como las de GitHub que se editan directamente),
   este proyecto utiliza un flujo de trabajo basado en **Pull Requests**.
   Esto nos permite revisar los cambios, discutirlos y mantener una alta
   calidad en la documentación.


1. Requisitos Previos
=====================

Para poder contribuir, necesitas tener lo siguiente:

* Una cuenta de **GitHub**.
* **Ser colaborador del repositorio**: Para poder subir tus cambios y crear un
  *Pull Request*, necesitas permisos de colaborador. Para esto, contacta al
  **Dr. Luis Concha** y proporciónale tu usuario de GitHub.
* Conocimientos básicos de **Git** (``clone``, ``branch``, ``commit``, y ``push``).
* Conocimientos básicos de **reStructuredText (RST)**. Es un lenguaje de
  marcado simple, muy similar a Markdown, pero más potente para la documentación técnica.
  Una `guía básica de RST para Sphinx <https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html>`_
  es un buen punto de partida.
* **Sphinx** instalado en tu computadora.

.. code-block:: bash

   pip install sphinx


2. Flujo de Trabajo
===================

Paso 2.1: Clonar el Repositorio
-------------------------------

Puedes crear y editar los archivos en cualquier editor de texto o IDE que prefieras
(Visual Studio Code es muy recomendado por su soporte para RST).
Para empezar, clona el repositorio de la wiki en tu máquina local.

.. code-block:: bash

   git clone https://github.com/AngelGPaulin/LANIREM.git


Paso 2.2: Crear una Nueva Rama
------------------------------

Es obligatorio trabajar en una rama separada. Esto mantiene el historial limpio
y facilita la revisión de cambios.

.. important::
   Para evitar confusiones, nombra la rama con tu nombre de usuario de GitHub
   o tu nombre de pila.

.. code-block:: bash

   cd LANIREM
   git checkout -b tu-nombre-de-usuario


Paso 2.3: Realizar tus Cambios
------------------------------

La wiki está escrita en **reStructuredText (RST)**. Aquí tienes algunas reglas
básicas para la organización:

**Nomenclatura de Archivos**
  El archivo ``.rst`` que crees o modifiques será tu página en la wiki.
  Usa nombres descriptivos y sigue estas reglas:

  * **Usa nombres cortos y en minúsculas**. Por ejemplo: ``instalacion_software.rst``.
  * **No uses los siguientes caracteres**: ``\ / : * ? " < > |``. Esto evita
    conflictos al clonar el repositorio en diferentes sistemas operativos (especialmente Windows).

**Añadir tu Página a la Barra Lateral**
  Para que tu página aparezca en el menú de navegación, debes añadir una referencia
  en la directiva ``.. toctree::`` (árbol de tabla de contenidos).
  Generalmente, esta se encuentra en el archivo ``index.rst`` de la sección
  a la que pertenece tu entrada.

**Organización y Mantenimiento**
  * Si tu entrada pertenece a una subcategoría, colócala en la carpeta correspondiente.
  * Si ves algo que ya está desactualizado o se puede mejorar, ¡échale una mano a la
    comunidad! Simplemente edita el archivo localmente y sigue los pasos para
    proponer tu cambio.


Paso 2.4: Compilar Localmente (Opcional pero recomendado)
---------------------------------------------------------

Antes de enviar tus cambios, compila la wiki para previsualizar el resultado final.
Desde la carpeta raíz del proyecto, ejecuta:

.. code-block:: bash

   make html

Esto generará los archivos HTML en la carpeta ``_build/html``. Abre
``_build/html/index.html`` en tu navegador para revisar que todo se vea como esperas.


Paso 2.5: Subir los Cambios
---------------------------

Una vez que estés satisfecho, sube tus cambios al repositorio remoto.

.. code-block:: bash

   git add .
   git commit -m "Docs: Agrega sección sobre la herramienta X"
   git push origin tu-nombre-de-usuario

.. warning::
   No intentes subir cambios directamente a la rama ``main``. El repositorio
   está protegido y la acción será rechazada. Siempre debes usar una rama
   separada y un *Pull Request*.


Paso 2.6: Crear un Pull Request (PR)
------------------------------------

Ve al repositorio en GitHub. Verás una notificación para crear un **Pull Request**
desde tu nueva rama. El PR es la herramienta para proponer, discutir y revisar
tus cambios antes de que se integren.

Un revisor aprobará tu PR y, si todo está correcto, lo fusionará con la rama
principal (``main``). Una vez fusionado, **Read the Docs se actualizará
automáticamente**.

¡Eso es todo! Tu contribución estará en línea.


Enlaces de Interés
==================

* **Repositorio en GitHub**: `LANIREM en GitHub <https://github.com/AngelGPaulin/LANIREM>`_
* **Wiki en Read the Docs**: `Documentación de LANIREM <https://lanirem.readthedocs.io/en/latest/Introduccion/introduccion.html>`_
* **Tutorial de reStructuredText**: `Guía básica de RST para Sphinx <https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html>`_