Tractografía
============


Para comenzar a hacer la tractografía se necesita primero delimitar una región de interés (ROI) de donde partirán los streamlines (lineas de corriente de difusion). Para esto hay que segmentar adecuadamente el area deseada pudiendo realizarlo en el visor de Mrtrix (mrview), Freesurfer (freeview) o FSL (fslview). Esa area se le denomina comunmente *semilla*, dado que de aquí partirán todos los análisis futuros.

Link para realizar ROIs en mrview: [[http://www.brain.org.au/software/mrtrix/tractography/roi.html]].

Una vez que ya este bien delimitada el area se procede a "sembrar la semilla" con el comando *tckgen*.
Ahora si tenemos nuestro primer resultado de la tractografía!!! sin embargo no siempre es lo que esperamos, ya que queda un poco llena de muchas otras fibras que no son de nuestro interés para esto se procede a realizar una disección virtual o un filtrado con el comando *tckedit* para incluir o excluir otras regiones de acuerdo a la anatomía que deseemos observar (previamente al filtrado se tienen que dibujar los ROIs que serán utilizados para incluir o excluir areas). 
