Tutorial rápido: Publicar en Read the Docs
==========================================

.. note::
   Read the Docs Community es gratuito. También existe una versión de pago: Read the Docs for Business.

Requisitos
----------

- Cuenta en GitHub
- Cuenta en Read the Docs

---

1. Crear el repositorio
-----------------------

1. Inicia sesión en GitHub.
2. Ve al siguiente `link <https://github.com/readthedocs/tutorial-template/>`_.
3. Haz clic en **Use this template** > **Create a new repository**.
4. Ajusta lo siguiente:
   - **Nombre**: Así se llamará tu repositorio.
   - **Visibilidad**: selecciona **Público**.
5. Haz clic en **Create repository**.

.. image:: https://docs.readthedocs.com/platform/stable/_images/github-template.png
   :alt: Plantilla de GitHub

---

2. Importar el proyecto
-----------------------

1. En Read the Docs, haz clic en **Import a Project**.
2. Busca el nombre de tu proyecto y haz clic en el icono **+**.
   (Si no aparece, presiona **refresh your repositories**).
3. Completa los detalles y haz clic en **Next**.

.. image:: https://docs.readthedocs.com/platform/stable/_images/rtd-import-projects.gif
   :alt: Importación de proyecto

.. image:: https://i.imgur.com/ScIBCe4.jpeg
   :alt: Actualización de repositorios

---

3. Verificar la compilación
---------------------------

1. Haz clic en **Your documentation is building**.
2. Cuando termine, haz clic en **View docs** para ver el sitio publicado.

.. image:: https://i.imgur.com/i4vh0GW.png
   :alt: Compilación en proceso

.. image:: https://docs.readthedocs.com/platform/stable/_images/rtd-first-light.png
   :alt: Documentación publicada

---

4. Actualizar proyecto
----------------------

1. Ve al proyecto en Read the Docs.
2. Selecciona tu proyecto.
3. Abre la pestaña **Builds**.
4. Presiona **Rebuild version**.

.. image:: https://i.imgur.com/pjEgsLt.jpeg
   :alt: Actualización

---

Crear cuenta en Read the Docs
-----------------------------

1. Ve a la página de registro.
2. Haz clic en **Sign up with GitHub**.
3. Autoriza la app con **Authorize readthedocs**.

   .. image:: https://docs.readthedocs.com/platform/stable/_images/github-authorization.png
      :alt: Autorización de GitHub

   .. note::
      Se solicitan permisos para instalar webhooks.

4. Confirma tu correo y nombre de usuario.
   Luego haz clic en **Sign Up**.

   .. image:: https://docs.readthedocs.com/platform/stable/_images/rtd-empty-dashboard.png
      :alt: Panel vacío

Sintaxis de escritura
=====================

Negritas
--------
- Usando asteriscos dobles: **Texto en negritas**.

Cursivas (Italics)
------------------
- Usando asteriscos simples: *Texto en cursiva*.

Código/monospace
----------------
- Usando doble comillas invertidas: ``print("Hola mundo.")``.

Títulos y secciones
-------------------

- **Nivel 1 (título principal):**

  .. code-block:: rst

     Título Principal
     ================

- **Nivel 2 (subtítulo):**

  .. code-block:: rst

     Subtítulo
     ---------

- **Nivel 3 (Notas):**

  .. code-block:: rst

     .. note::
        Tu texto aqui

.. note::
   Nota bonita.