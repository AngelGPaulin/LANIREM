/tmp
====

Si quieres hacer pruebas que no requieran del clúster, puedes hacer carpetas dentro de  ``/tmp``, que vive físicamente en la computadora que estás usando. Ojo: Esta carpeta *no se exporta* al clúster, por lo que no podrás hacer uso de ningún comando de cluster con datos aquí, y si lo haces, vas a tener uno de tus jobs con status de :doc:`Cluster:-Errores-del-cluster`...

La otra opción es usar la carpetas que no se respaldan en el cluster, que son visibles por todo el cluster pero no se les hacen :doc:`Cluster:-Respaldo-de-datos`. Simple: nombra a tu carpeta ``temporal``, ``tmp``, o ``nobackup`` adentro de ``misc``, por ejemplo ``/misc/mansfield/lconcha/nobackup/mispruebas``.

Por favor, borra tus archivos una vez que hayas terminado de hacer tus pruebas.
