Preprocesamiento en roedores
============================

Analizar datos de difusión puede ser bastante sencillo, pero para lograrlo se requiere que los datos estén en buenas condiciones. Estos pasos buscan corregir algunos artefactos de adquisición y limpiar los datos lo más posible, de manera que la estimación de parámetros de difusión sea adecuada. El preprocesamiento es habitualmente más tardado y latoso que el procesamiento mismo, y cada paso es toda un tópico en constante investigación y desarrollo. Aquí se describen los pasos que seguimos habitualmente (2024). El ejercicio está orientado a datos de roedor adquiridos con nuestro Bruker de 7 T, pero los conceptos son los mismos para datos de humanos. Estos pasos pueden usarse en su mayoría sin modificaciones con adquisiciones EPI3D.

En esta entrada vamos a repasar paso por paso como se realiza el preprocesamiento para fines didácticos. Al final podrás encontrar como utilizar el script ``inb_dwi_bruker_preproc.sh`` (disponible el 24 de agosto de 2021 en Don Clusterio) que encapsula todos estos pasos. Recuerda que tambíen puedes invocar el comando sin argumentos para aprender su uso. El script tiene la ventaja que además de hacer todo ésto, utiliza ``eddy_quad`` para hacer un reporte de control de calidad. Como bonus, se generan imágenes ``png`` para una rápida visualización de mapas RGB antes y después de pre-procesar los datos. **Ojo, que aunque existe el script, se recomienda leer esta entrada para que sepas qué hace esa caja negra.** El script está pensado en datos EPI-2D de rata, pero es probable que funcione en ratón, y con datos 3D-EPI. 

***

Convertir del bruker a formato nifti.
-----------------------
El primer paso es convertir/exportar tus imágenes del bruker a un formato nifti. Aquí voy a utilizar de ejemplo unos datos que adquirí durante la maestría y que pertenecen al laboratorio C13. Visita esta [entrada]() donde se explica a más detalle paso por paso el como exportar tus imágenes.

Primero localizo el archivo de mis adquisiciones en el directorio del bruker y para facilitar la explicación las conviertiré en una variable:
::

   BRUKERFOLDER=/misc/bruker7/data02/user/conchalab/20220104_085643_INB_C13_hluna_irm150d_rata64A_INB_C13_hluna_1_1
   SCANNUMBER=6

Segundo paso, cargo el módulo de ``brkraw``:
::

   module load brkraw/0.3.11

::

   brkraw tonii $BRUKERFOLDER -o ./64A_dwi -r 1 -s $SCANNUMBER

``tonii`` es el comando que convierte de Bruker a Nifti.

::

   
::

   
   
   Vamos a ver que despues de la conversion tendremos **tres** outputs:
   

64A_dwi.bvec
64A_dwi.bval  
64A_dwi.nii.gz
::

   
   Los archivos `.bvec` contiene información acerca de los autovectores, mientras que el archivo `.bval` son los autovalores. Fundamentales para las DWI. Y por ultimo tenemos la imagen `.nii.gz`.
   
   ⚠️ Siempre siempre revisa tus imágenes crudas para asegurarte que se convirtieron adecuadamente y segundo para saber el estado en el que estan y lo que se espera del preprocesamiento para mejorarlas!
   
   # Preprocesamiento
   
   ## 1.- Denoising
   Este paso es fundamental y normalmente el primer paso antes de cualquier otro. Consiste en remover el ruido proveniente de la señal. Aquí puedes utilizar el comando `dwidenoise`:
   
   `dwidenoise 64A_dwi.nii.gz 64A_dwi_denoised.nii.gz -noise 64A_dwi_noise.nii.gz`
   
   > Donde `dwidenoise` es el comando, despues viene el `input` (DWI cruda), seguido del `output` (mi nueva imagen con denoise) y por ultimo `-noise` y su correspondiente `output` para el ruido estimado.
   > Si quieres saber mas en como funciona haz clic aquí [aquí](https:/mrtrix.readthedocs.io/en/dev/dwi_preprocessing/denoising.html/)
   
   Ten paciencia que el denoising es tardadito... pero una vez completado puedes ver tu nueva imagen:
   
   ![image](https://github.com/c13inb/c13inb.github.io/assets/129544525/b2013c6c-eefa-4647-ab5d-6965b27533df)
   
   💡 Una bonita alternativa para el denoising es el algoritmo de [LPCA de José Manjón](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0073021), encapsulado en el script `inb_dwidenoise_LPCA_manjon.sh`. Suele quitar aún más ruido que `dwidenoise` (a veces demasiado, pero pruébalo!).
   
   ## 2.- Unringing
   Este proceso trata de minimizar los [anillos de Gibbs](http://mriquestions.com/gibbs-artifact.html) que pueden verse alrededor de bordes anatómicos muy prominentes. Para que sea eficiente, las imágenes deben adquirirse con llenado total del espacio k (es decir, sin Partial Fourier). Si se hizo denoising, este paso debe seguir inmediatamente, y por ningún motivo se debe hacer después de Eddy. 
   
::

   
   ## 4.- Eddy
   Este paso corrige inhomogeneidades geométricas inducidas por los gradientes de difusión. Además elimina rebanadas con adquisiciones comprometidas (outlilers), en las que la señal es demasiado baja en comparación a lo esperado. Esto último es común en adquisiciones 2D-EPI, y se debe a que los gradientes de plano no aguantaron el ritmo solicitado para llenar el espacio k tan rápido. Es de esperar un 10% de rebanadas outliers en toda la adquisición (algo común es una o dos rebanadas outliers por cada volumen, y la posición espacial de las rebanadas outliers deben ser aleatorias entre volúmenes).
   > ⚠️ Asegurate de que la computadora que estes utilizando tenga CUDA. Para instalarlo en tu laptop entra [acá](https://docs.nvidia.com/cuda/cuda-installation-guide-linux/index.html). Si estas trabajando en el Don Clústerio y no sabes si tu compu tiene CUDA, checa [aquí](https://github.com/c13inb/c13inb.github.io/wiki/CUDA).
   Para correr Eddy, los desarrolladores de FSL crearon una herramienta llamada `eddy_cuda10.2` (actualizado 2024) que ejecuta esta corrección y mucho más. Sin embargo, antes de correr eddy, necesitamos hacer una serie de  primeros pasos para preparar los datos de acuerdo a como lo pide el software. En su [pagina web](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy/UsersGuide/) tienen toda la información detallada de como hacerlo. Aquí lo resumiré con el ejemplo de la rata 64A.
   
   1) Primero necesitamos sacar una máscara binaria del cerebro de la rata. Aquí me iré por la fácil que es usar `dwi2mask`, pero existen muchas otras herramientas para hacerlo, incluso de manera manual. Usa la que más se acomode a tu análisis y la que mejor te realice la máscara. 
   
::

   
   2) Ahora necesitamos un archivo que describa los parametros de la adquisición de cada imágen.
echo "0 -1 0" $topup > acqp_64A_dwi.txt
::

0 -1 0 0.05
::

   Vemos que en el output tenemos `0 -1 0` que no es nada mas que la codificación en fase y `0.05` es la multiplicación entre el factor EPI y los ms de espacio entre ecos. Toda esta información al final son los parámetros de adquisición. Más información [aquí](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy/Faq#How_do_I_know_what_to_put_into_my_--acqp_file)
   
   3) Hay que crear un archivo índice que ayude a indicar que volúmenes (aquí 285) de DWI fueron tomadas con ciertos parametros de acuerdo al archivo acqp_64A_dwi.txt. En este caso, todos los volúemenes fueron adquiridos de igual manera.

for ((i=1; i<=285; i+=1)); do indx="$indx 1"; done

echo $indx > indice_64A_dwi.txt
::

1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1 1
::

   ⚠️ IMPORTANTE, estos archivos son particularmente importantes cuando uno tiene adquisiciones con inversión de la polaridad del gradiente de fase, pero en nuestro caso no hay tal cosa, así que los podemos generar fácilmente con estos comandos que siguen. Para adquisiciones con inversión de polaridad de fase, consulta la documentación en la página de [topup](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup/TopupUsersGuide), donde se describe cómo generar un B0map a partir de pares de adquisiciones con fases invertidas, que después se alimentan a `eddy`. Yo (lconcha, abril-julio 2021) hice varias pruebas con adquisiciones 2DEPI en el Bruker y no encontré mucha ventaja a usar adquisiciones con pares de dirección de fase y el uso de `topup`, por lo que en este ejercicio no se utiliza.
   
   Cargamos el módulo:
::

   Y corremos Eddy:
   
--imain=denoised_64A_dwi.nii.gz /
--mask=mascara_64A_dwi.nii.gz /
--index=indice_64A_dwi.txt /
--acqp=acqp_64A_dwi.txt /
--bvecs=64A_dwi.bvec /
--bvals=64A_d
--out 64A_dwi
::

   No olvides checar tus outputs!
   

64A_dwi.nii.gz  
64A_dwi_eddy_parameters
64A_dwi_eddy_command_txt        
64A_dwi_eddy_post_eddy_shell_alignment_parameters
64A_dwi_eddy_movement_rms      
64A_dwi_eddy_post_eddy_shell_PE_translation_parameters
64A_dwi_eddy_outlier_map              
64A_dwi_eddy_restricted_movement_rms
64A_dwi_eddy_outlier_n_sqr_stdev_map 
64A_dwi_eddy_rotated_bvecs
64A_dwi_eddy_outlier_n_stdev_map      
64A_dwi_eddy_values_of_all_input_parameters
64A_dwi_eddy_outlier_report

::

   Donde entre los outputs más relevantes son:
   + `64A_dwi.nii.gz`: Nuestro output principal. Incluye las imágenes ya corregidas, a las que se les minimizaró el movimiento entre volúmenes, así como las inhomogeneidades geométricas inducidas por corrientes eddy. Además, las rebanadas outliers fueron remplazadas por datos factibles dado un modelo simple. Estas son las imágenes que se usarán después para cualquier modelo de DWI.
   
   
   <img src="https://github.com/c13inb/c13inb.github.io/assets/129544525/91417b1b-17ba-4745-8722-a712108621af" width="450" height="300">
   
   
   + `64A_dwi.eddy_rotated_bvecs`. Los vectores de los gradientes de difusión, una vez que fueron corregidos de acuerdo a las transformaciones geométricas que se le hicieron a cada volumen correspondiente. Por ejemplo, si un volumen se rotó 10 grados, el gradiente se rota también. En conjunto con `64A_dwi.bval` podremos usar cualquier modelo de difusión. 
   
   ### 👁️  **Aquí hay unas consideraciones bastante importantes respecto a Eddy:**
   
   1. Los volúmenes considerados como b=0 no tienen vector asociado. Por alguna razón, en este archivo aparecen sus componentes x,y,z como `nan`. Esto va a hacernos la vida difícil para los siguientes pasos. Es fácil remplazar todas las ocurrencias de `nan` por un cero usando el fabuloso [`sed`](https://www.grymoire.com/Unix/Sed.html#uh-1):
::

   
   <img src="https://github.com/c13inb/c13inb.github.io/assets/129544525/52811ba4-9c84-494e-9567-73405a632841" width="700" height="350">
   
   
   2. De forma similar, el archivo `.bval` no tiene entradas con b=0 s/mm². El resonador calcula la contribución de los gradientes de codificación espacial al valor b, y habitualmente resulta en b=15 a 30 s/mm². Cambiar estas entradas a cero hará cambios realmente despreciables en toda estimación de parámetros de difusión, así que lo vamos a hacer ahora. 
   
   Solo debemos saber qué valor tenemos que cambiar, y suele ser el shell más bajo. Una manera simple es abrir el archivo `.bval` y revisar el número a cambiar, habitualmente en la primera entrada. Si la adquisición no inició con imágenes no pesadas a difusión, entonces usemos un método más robusto para encontrar el valor del shell con valor despreciable.

21.010828
-----------------------
::

   Y ahora podemos hacer el cambio a 0. Escribimos un nuevo archivo `bval_zeros`. Esto también lo podemos hacer en la terminal con `sed`: 
::

   + `64A_dwi_eddy_outlier_report`.  Un archivo de texto que nos dice qué rebanadas en cada volumen resultaron ser outliers. 
   
   + `64A_dwi_eddy_outlier_map`.  Un archivo de texto con una simple visualización como tabla que nos dice por cada rebanada (columnas) en cada volumen (renglones), si es un outlier.
   
   3. La mera verdad no logra registrar bien los volúmenes con SNR muy bajo, lo que suele suceder con alta resolución y bvalues altos (por ejemplo b=3000 s/mm²). Para el modelo del tensor no son útiles los bvalues altos, por lo que se sugiere no llegar más allá de 1200. Sin embargo, la mayoría de los solvers modernos para ajustar el tensor le dan un peso mayor o menor a cada dato dependiendo de su potencial de ser outlier. Por lo tanto, incluso dejando los volúmenes de bvals altos, los mapas resultantes son harto bonitos.
   
   ![](https://i.imgur.com/nsElYei.gif)
   
   En esta animación se aprecia que la posición espacial no es homogénea entre volúmenes. Los volúmenes con bvalue más alto están mal registrados con respecto a los otros shells.
   
   ## 3.- Corrección de inhomogeneidad de intensidades (biasfield correction)
   Este paso es también innecesario en caso de que se vaya a usar cualquier modelo que involucre dividir las DWI entre las b=0, como el modelo del tensor. De hecho, la enorme mayoría de los modelos hacen tal división en algún momento, pues lo que les interesa es la atenuación de la señal. 
   
   La notable excepción es deconvolución esférica (CSD), que estima la distribución de la probabilidad de orientaciones de fibras directamente de la señal DWI (no de la atenuación), a partir de la deconvolución de una función de respuesta que actúa como un prototipo de cómo se porta la señal DWI en el caso de una sola población de fibras. Como se estima una sola función de respuesta por set de datos, es crucial que la señal DWI tenga intensidades homogéneas en toda la extensión de la sustancia blanca. Esta última suposición se rompe fácilmente, sobre todo si adquirimos nuestras imágenes con una antena de superficie (como la 2x2 o la cryoprobe). 
   
   Usaremos `dwibiascorrect` de mrtrix, que en realidad es una envoltura para `N4BiasFieldCorrection` de [ANTS](http://picsl.upenn.edu/software/ants/). Por lo tanto, debes tener ANTS instalado. Los defaults de ambos comandos están diseñados para datos de humanos, así que es posible que se requiera un poco de ensayo y error hasta encontrar los adecuados. El comando en sí es muy fácil, mandando las opciones para ANTS a través de switches en `dwibiascorrect`. A continuación un ejemplo con opciones pasadas a ANTS que resultan en una buena corrección:
   
  -fslgrad 64A_dwi.eddy_rotated_bvecs bval_zeros \
  -mask mascara_64A_dwi.nii.gz \
  -ants.s 2 \
  -ants.b [10,3] \
   64A_dwi.nii.gz \
   64A_dwi_biascorr.nii.gz 
::

   ![](https://i.imgur.com/yVnbtRp.png)
   
   ## Checando el resultado del preprocesamiento
   Para terminar, veamos la diferencia entre un ajuste del modelo del tensor a los datos originales, y a los datos preprocesados. Usaremos mrtrix para hacer esta estimación, y truquitos para hacer todo en un jalón. Aprende a usar los pipes de mrtrix por [acá](https://mrtrix.readthedocs.io/en/latest/getting_started/command_line.html#unix-pipelines). Haremos mapas RGB del vector principal de difusión, a los que llamaremos `*_v1.nii.gz`.
   
   Primero, a partir de los datos originales:
::

   
   Ahora, a partir de los datos con denoise y eddy (no requerimos corrección de intensidad para el modelo del tensor, y no podemos hacer unring porque los datos tienen partial fourier):
::

   Y los vemos con `mrview`:
   
   <img src="https://github.com/c13inb/c13inb.github.io/assets/129544525/6b5687ec-6477-405c-87d7-36fe41e73320" width="900" height="380">
   
   Los mapas RGB son notablemente más claros cuando son derivados de imágenes preprocesadas. Hay mucho menos verde, que era causado por el drift de las imágenes a lo largo de la adquisición en dirección dorso-ventral, cosa que fue minimizada con el registro logrado con `eddy`. Aún quedan detalles, pero ciertamente estas imágenes ya están trabajables, sobre todo en sustancia blanca.
   
   ***
   
   # Script Don Clusterio
   
   Siempre es bueno aprender a procesar tus imágenes paso por paso para entender el proceso y que no sea una caja negra (muy muy obscura)... y también porque no, crear tu propio código de pre-procesamiento. Sin embargo, el profesor Dr. Luis Concha (Lab C-13) nos hizo la vida mucho mas fácil y creo un script que hace tooooooodo en una sola exhibición!
   
   El primer paso es cargar el modulo `inb_tools`, aun que este modulo debería de estar ya **cargado automaticamente**. 
   
   El script lo puedes mandar a llamar con solo escribir en la terminal `inb_dwi_bruker_preproc.sh` y al dar `enter` podemos ver un manual de que es lo que hace y que opciones tiene. Vemos que utiliza basicamente los mismos pasos que vimos antes, incluyendo el bias field correction:
   

inb_dwi_bruker_preproc.sh <-i dwi.nii.gz> [-i dwi2.nii.gz] <-o outbase>

Take one or more 2D-EPI DWI acquisitions and preprocess them according to:

0. Concatenate the input DWIs if there is more than one input.
1. dwidenoise (mrtrix, Exp2 estimator - Cordero-Grande 2019).
2. eddy (fsl), including eddy_quad for quality check
3. bias-field correction (N4BiasFieldCorrection). Parameters set for rat imaging.
::

   
   Vemos que primero pide un `-i` input (imágen DWI cruda) y despues un `-o` output (tu nueva imágen)
   
   También el script viene con una serie de opciones de acuerdo a tus necesidades. Ya sea el permutar los axes, re-escalar el voxel, corregir el movimiento (muy recomendado) y/o voltear alguno de los vectores. Este ultimo es necesario ya que al convertir desde Bruker,  uno de los vectores sale volteado! Hay que corroborar cual es de acuerdo a tus imágenes. 

-p            Permute axes to 0,2,1,3 (don't do it)
-s <factor>   Scale the image voxel dimensions by some factor (e.g. 2, or 10).
              Useful for eddy, as it is expecting human data, not from rodents.
-m            Perform motion correction (mcflirt) before running eddy.
              This is useful for removing image drift during acquisition.


Flip diffusion gradient vector components:
              You can use none, one or any combination of the following.
              This is useful if your conversion from bruker data messes up the gradients.
-x            Flip x component of diffusion gradient direction
-y            Flip y component of diffusion gradient direction
-z            Flip z component of diffusion gradient direction
-t            Keep temporary directory.
::

   
   Listo, una vez que sabemos que hace el script, lo podemos correr! (spoiler, tarda unos minutos)
   
module load fsl/6.0.7
module load mrtrix/3.0.4


inb_dwi_bruker_preproc.sh -i 64A_dwi.nii.gz -o inb_64A_dwi -m -s 10 -z
::

   
   Veamos nuestros outputs:
 
inb_64A_dwi_d.bval
inb_64A_dwi_d.bvec
inb_64A_dwi_deb.bval
inb_64A_dwi_deb.bvec
inb_64A_dwi_deb.nii.gz
inb_64A_dwi_de.bval
inb_64A_dwi_de.bvec
inb_64A_dwi_de.nii.gz
inb_64A_dwi_d_mask.nii.gz
inb_64A_dwi_d.nii.gz
inb_64A_dwi_de.files
::

   Ahora, vas a notar que hay tres archivos `.nii.gz`, `.bvec` y `bval`, pero cada uno tiene le antecede ya sea`d`, `de` y `deb`. ¿Que significa esto? Esto no es nada mas qué los outputs deribados de cada parte del pre-procesamiento y que el script los nombra asi como guía para saber que datos pertenecen a cada paso del pre-procesamiento:
   
   denoising:
inb_64A_dwi_d.bvec
inb_64A_dwi_d.nii.gz
::

   denoising + eddy:
inb_64A_dwi_de.bvec
inb_64A_dwi_de.nii.gz
::

   denoising + eddy + bias field correction:
inb_64A_dwi_deb.bvec
inb_64A_dwi_deb.nii.gz
::

   ...y todos los archivos deribados del eddy:
::

   
   Y nuestra nueva imágen!
::

   ![image](https://github.com/c13inb/c13inb.github.io/assets/129544525/3ae921f0-e405-409d-88e7-e8a7b2422d3b)
   
   
   Y al final, esta es la imágen que utilizarás para comenzar tus análisis. Mucha suerte! 😃 
   
   
