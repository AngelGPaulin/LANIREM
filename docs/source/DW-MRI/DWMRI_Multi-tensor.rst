Multi-resolution discrete-search
================================


MULTI-RESOLUTION DISCRETE-SEARCH
-----------------------

En este manual repasaremos paso por paso como implementar el método multi-tensor MRDS desarrollado por el Dr. Ricardo Coronado-Leija, para literatura mas extensa de como funciona el método, porfavor consulta el artículo `aquí <https://www.sciencedirect.com/science/article/abs/pii/S1361841517300956>`_.


MRDS sigue una serie de pasos para poder ser implementado, primero antes que nada vamos a cargar los módulos necesarios:

::

   module load mrtrix/3.0.4
   module load mrds/1.0

Antes de empezar, necesitamos preparar algunos datos que MRDS nos pedirá para su ejecución:

1. Scheme
-----------------------
El scheme no es nada mas que la información de los gradientes de difusión de la imágen, es decir, tus archivos ``.bvec`` y ``.bval``. Sin embargo, MRDS pide que estos esten juntos en un archivo de texto organizados de manera específica con 4 columnas en el orden *X Y Z b*, donde *x y x* es la dirección de los gradientes y *b* es el b-value asociado. 

Por ejemplo, si vemos como esta ordenado tu archivo ``.bvec`` original, vemos que esta de esta manera:

!`Captura de pantalla 2024-04-15 203253 <https://github.com/c13inb/c13inb.github.io/assets/129544525/444f378c-fb2c-414c-8790-34460953ebd2>`_

Lo mismo sucede para el archivo ``.bval``. Lo que necesitamos hacer es juntar ambos archivos y acomodar los datos en formato columna/tabla. Para esto, podemos usar un script que forma parte de los ``inb_tools`` que hace el trabajo!

::

   # Unimos los archivos .bvec y .bval:
   
   cat 64A_dwi.bvec 64A_dwi.bval > bvec_bval
   
   # Usamos el script para modificar la estructura
   
   transpose_table.sh bvec_bval > scheme

!`Captura de pantalla 2024-04-15 204054 <https://github.com/c13inb/c13inb.github.io/assets/129544525/f8b6cc05-97bf-46b3-b821-69464157fbac>`_

Vemos que las columnas siguen sin alinearse adecuadamente y esto es debido a que tenemos numeros muy largos despues del punto. Esto lo corregimos con el siguiente código:

::

   cut -d' ' -f1-4 scheme | while read a b c d; do printf "%.5f %.5f %.5f %.4f\n" "$a" "$b" "$c" "$d"; done > scheme_nuevo


Ahora vemos que ahora las columnas estan bien alineadas y en orden:

!`Captura de pantalla 2024-04-15 210516 <https://github.com/c13inb/c13inb.github.io/assets/129544525/f1434b1c-3852-4173-b6a8-a1bda1ca6c1a>`_

Como ultimo paso para el scheme, hay que remover los primeros bvals (b=21.01.08) y convertirlos en ceros, ya que MRDS no puede ser ejecutado sin volúmenes b=0, en este caso puedes tomar los mas bajos y convertilos. Aquí un código para poderlo hacer:


::

   shells=`mrinfo -bvalue_scaling false -grad scheme_nuevo 64A_dwi.nii -shell_bvalues`
   firstbval=`echo $shells | awk '{print $1}'`
   if (( $(echo "$firstbval > 0 " | bc -l)  ))
   then
   sed -i -e "s/${firstbval}/0.0000/g" $scheme
   fi



2. Máscara
-----------------------
Primero necesitamos una máscara del cerebro o del área de interes donde quieres que se implemente MRDS. Sin embargo, dado que MRDS se ejecuta utilizando una *response function*, asegurá que tu máscara incluya una estructura de alta anisotropía, como por ejemplo el cuerpo calloso. 
> La *response funcion* es definida como la señal esperada/ideal en un voxel que contiene una organización altamente coherente y perfecta de un solo manojo de fibras. Un gran ejemplo es el cuerpo calloso en su porción medial. 

Aquí hay de dos sopas, o creas una máscara general del cerebro utilizando ``dwi2mask`` o creas tu propio ROI/máscara binaria de la estructura y rebanada que quieras. Esta ultima opción requere que el ROI se dibuje manualmente (al menos que tengas un pipeline que lo haga por ti). Con fines didácticos y de tiempo, voy a crear un ROI utilizando ``mrview``:

::

   mrview 64A_dwi.nii.gz 
   ## Aquí haces tu ROI y lo guardas
::

   dwi2mask -grad scheme_nuevo 64A_dwi.nii.gz mascara_64A.nii.gz
!`Captura de pantalla 2024-04-16 160229 <https://github.com/c13inb/c13inb.github.io/assets/129544525/e1a33c5e-6651-43af-817a-b682edfcaf4d>`_


Ajuste de MRDS primera parte:
-----------------------

Una vez que tenemos estos preparativos, estamos listos para correr la primera parte de MRDS que es ajustando el DTI con un método no-linear. También puedes ajustarlo de manera más tradicional, etre otros, para esto hay que revisar la documentación y ajustar ``dti`` a tus necesidades y objetivos específicos:

::

   dti
   
   dti [ options ] dwi_input scheme tensor_output
   
           dwi_input
                   name of the input dwi file (.nii).
           scheme
                   name of the scheme (.txt) corresponding to the dwi image. Each line of the file must be:
                            x1 y1 z1 b1
                            x2 y2 z2 b2
                            x3 y3 z3 b3
                            .  .  .  .
                            .  .  .  .
                            .  .  .  .
                            xn yn zn bn
           tensor_output
                   name of the output diffusion tensor (.nii).
   
   Compute Diffusion Tensor from Diffusion Weighted Magnetic Resonance Images.
   
   Options:
   
            -save option
                   Which files to save: (0) tensors; (1) diff parameters; (2) both. Default: 2.
            -mask file(.nii)
                   mask for selecting the voxels that will be processed.
            -nonorm
                   Work with original signals Si (not recommended). By default the algorithm works with A_i = S_i/S_0.
            -beta num
                   For the spatial bilateral estimation of S0^{s}_{snr}, S0^{s}_{std} and S0^{s}_{mean}.
                   The estimation includes close voxels inside the range S0^{v}_{mean} +/- beta*S0^{v}_{std}.
                   (s) -> spatial, (v) -> voxel.
                   Default: beta = 0.5.
            -method name
                   select the method used for estimate the diffusion tensor coefficients.
                   the choices are:
                           -method naive      -> Log Linear Least Squares. Very simple implementation.
                           -method linear     -> Log Linear Least Squares. GSL Implementation.
                           -method nonlinear  -> Non Linear Least Squares. GSL Implementation.
                           Default: -nonlinear.
            -response nvoxels
                   Estimate and compute the mean of the diffusion tensor eigenvalues using the voxels
                   in the volume where there is high probability only one fiber bundle exist.
                   This could be used for starting point on other multi-fiber algorithms.
                   The algorithm will use the nvoxels with maximum FA in a confidence interval.
                   Setting nvoxels = 0 will use all voxels in the confidence interval.
            -adc
                   compute the apparent diffusion coefficient on each orientation of the scheme.
            -lps
                   compute the linear, planar and spherical coeficients of the diffusion tensor.
            -fa
                   compute the fractional anisotropy of the diffusion tensor.
            -md
                   compute the mean diffusivity of the diffusion tensor.
            -dec
                   compute the direction encoding color of the diffusion tensor DEC = FA*PDD.
            -mse
                   compute the mse of the signals for the estimated diffusion tensors and the measured signal.
            -correction num
                   Apply a transformation on the diffusion data in order to correct the Rician bias.
                   This is not a denoising, it is just a bias correction. The choices are:
                           -correction  0, 1, 2 -> No correction: y = x.
                           -correction  3, 4, 5 -> Gudbjartsson correction: y = sqrt(fabs(x*x - sigma*sigma)).
                           -correction  6, 7, 8 -> Gudbjartsson correction modified: y = sqrt(max(x*x - sigma*sigma,0.0)).
                           -correction  9,10,11 -> Manjon correction: y = sqrt(max(x*x - 2.0*sigma*sigma,0.0)).
                           -correction 12,13,14 -> Maximum Likelihood correction y_ML = max_y(p(x;y,sigma)).
                                                   Exhaustive evaluation.
                           -correction 15,16,17 -> Mean Posterior correction y = sum x*p(x).
                                                   Exhaustive evaluation.
                           -correction 18,19,20 -> Mean Posterior correction adaptive according to each measurement.
                           Aditional consideration.
                           num % 3 => 0 - min value = 0.
                           num % 3 => 1 - min value = estimated from data.
                           num % 3 => 2 - min value = physically plausible exp(-b*3e-3).
                           Default: -correction 8.
            -help
                   show this help
   

::

   dti 
   -mask ROI.nii \
   -response 0 \
   -correction 0 \
   -fa -md \
   -64A_dwi.nii \
   -scheme_nuevo.txt \
   -dwi.nii

Checamos nuestros outputs:

::

   ls dwi_DTInolin_*
   
   dwi_DTInolin_COMP_SIZE.nii    
   dwi_DTInolin_ISOTROPIC.nii  
   dwi_DTInolin_PDDs_CARTESIAN.nii           
   dwi_DTInolin_ResponseIsotropicMask.nii
   dwi_DTInolin_EIGENVALUES.nii  
   dwi_DTInolin_MD.nii        
   dwi_DTInolin_ResponseAnisotropicMask.nii  
   dwi_DTInolin_ResponseIsotropic.txt
   dwi_DTInolin_FA.nii           
   dwi_DTInolin_NUM_COMP.nii   
   dwi_DTInolin_ResponseAnisotropic.txt      
   dwi_DTInolin_Tensor.nii

Ajuste de MRDS segunda parte:
-----------------------

En esta segunda parte vamos a ajustar los multi-tensores voxel por voxel tomando algunos de los outputs de la primera parte. Esta segunda parte es un poco mas compleja en cuanto a los parámetros y también mucho mas tardado en correr. Veamos el manual del comando ``mdtmrds``:

::

   mdtmrds
    
   mdtmrds [ options ] dwi_input scheme mt_output
   
           dwi_input
                   name of the input dwi file (.nii).
           scheme
                   name of the scheme (.txt) corresponding to the dwi image. Each line of the file must be:
                            x1 y1 z1 b1
                            x2 y2 z2 b2
                            x3 y3 z3 b3
                            .  .  .  .
                            .  .  .  .
                            .  .  .  .
                            xn yn zn bn
           mt_output
                   name of the output multi-diffusion tensor file (.nii).
   
   Compute the Multiple Radially Symmetryc Diffusion Tensor from Diffusion Weighted Magnetic Resonance Images.
   Multi-Resolution Discrete-Search method is used.
   
   Options:
   
            -mask file(.nii)
                   mask for selecting the voxels that will be processed.
            -response l1,l2(,Diso)
                   By default the eigenvalues l1 = 1.5e-3, l2 = 0.3e-3 are used as initial response function.
                   Using this option, they could be specified so the eigenvalues of the tensor be [l1,l2,l2].
                   If isotropic compartment flag is set, Diso can be supplied as the third value. Default 0.8e-3.
            -nonorm
                   Work with original signals Si (not recommended). By default the algorithm works with A_i = S_i/S_0.
            -beta
                   For the spatial bilateral estimation of S0^{s}_{snr}, S0^{s}_{std} and S0^{s}_{mean}.
                   The estimation includes close voxels inside the range S0^{v}_{mean} +/- beta*S0^{v}_{std}.
                   (s) -> spatial, (v) -> voxel.
                   Default: beta = 0.5.
            -modsel name
                   select the criteria used for estimate the number of fiber bundles (#param k) on each voxel.
                   the choices are:
                           -modsel bic   -> Bayesian Information Critearia: BIC = -2 log L + n * log(k).
                           -modsel aic   -> Akaike Information Critearia:   AIC = -2 log L + 2 * k.
                           -modsel aicc  -> Akaike Information Critearia corrected for finite samples.
                           -modsel hqic  -> Hanan-Quinn Information Critearia: HQIC = -2 log L + 2k log(log(n))
                           -modsel l0    -> pseudo-l0 norm. n*MSE + lambda*sigma*sigma*log(n)*k (BIC: lambda = 1)
                           -modsel ftest -> F-test: F = [(RSS1-RSS2)/(p2-p1)] / [(RSS2)/(n-p2)] < pvalue.
                           -modsel bhq   -> compute BIC and HQIC.
                           -modsel all   -> compute all: bic, aic, aicc and hqic (sometimes needed).
                           Default: -ftest.
            -reg value
                   If the option modsel is ftest, this option sets the pvalue for performing the f-test.
                   If the option modsel is any other, this option will be ignored.
                   Defaults: 0.001.
            -alt
                   For the model selection, by default, the sigma dependent Gaussian Log Likelihood is used:
                   'log L(sigma) = -(n/2)[ log(2pi) + log(sigma^2) + (1/sigma^2) MSE ]'.
   
                   With this option a sigma free approximation of the Gaussian Log Likelihood is used instead:
                   'log L = -(n/2) ln(MSE).
   
                   If the option modsel is ftest, this option will be ignored.
            -method name
                   Select the method to use (based on the estimation of the eigenvalues).
                           -method fixed: The eigenvalues are not estimated, they are kept fixed during the process.
                           -method equal: The eigenvalues are estimated equal for all the bundles inside the voxel.
                           -method diff:  The eigenvalues are estimated different for each bundle inside the voxel.
                   Default: -method equal (is more stable).
            -iso
                   Adding the isotropic compartment to the estimation (Still not working properly).
            -each
                   By default, only the multi-tensor with the selected number of bundles is saved.
                   With this option the multi-tensors with N = 1,2,3,... are also saved.
            -intermediate
                   By default, only the multi-tensor(s) of the final stage are saved.
                   With this option, the multi-tensor(s) of the intermediate stages are also saved.
            -stages np1,np2,np3,...
                   Define the number of stages (resolutions of the orientation sets) used in the method.
                   npi defines the number of orientations for the orientation set used in the ith stage.
            -fa
                   compute the fractional anisotropy of the multi diffusion tensors on each voxel.
            -md
                   compute the mean diffusivity of the multi diffusion tensors on each voxel.
            -mse
                   compute the mse of the signals for the estimated multi diffusion tensors and the measured signal.
            -correction num
                   Apply a transformation on the diffusion data in order to correct the Rician bias.
                   This is not a denoising, it is just a bias correction. The choices are:
                           -correction  0, 1, 2 -> No correction: y = x.
                           -correction  3, 4, 5 -> Gudbjartsson correction: y = sqrt(fabs(x*x - sigma*sigma)).
                           -correction  6, 7, 8 -> Gudbjartsson correction modified: y = sqrt(max(x*x - sigma*sigma,0.0)).
                           -correction  9,10,11 -> Manjon correction: y = sqrt(max(x*x - 2.0*sigma*sigma,0.0)).
                           -correction 12,13,14 -> Maximum Likelihood correction y_ML = max_y(p(x;y,sigma)).
                                                   Exhaustive evaluation.
                           -correction 15,16,17 -> Mean Posterior correction y = sum x*p(x).
                                                   Exhaustive evaluation.
                           -correction 18,19,20 -> Mean Posterior correction adaptive according to each measurement.
                           Aditional consideration.
                           num % 3 => 0 - min value = 0.
                           num % 3 => 1 - min value = estimated from data.
                           num % 3 => 2 - min value = physically plausible exp(-b*3e-3).
                           Default: -correction 8.
            -help
                   show this help
   

Como indica el manual en la opción de ``response`` (leer arriba), debemos de especificar los dos primeros lamdas. Esta información esta contenida en el archivo ``dwi_DTInolin_ResponseAnisotropic.txt``. Para extraer esos datos y guardarlos en una variable puedes utilizar el siguiente código:

::

   responsef=`cat dwi_DTInolin_ResponseAnisotropic.txt | cut -d" " -f1,2 --output-delimiter=,`
Sin embargo, algunos de los puntos son claves:
* La selección del modelo (``-modsel``), donde eliges como se resuelve el número de poblaciones de fibras por voxel. Donde BIC (Criterio de Información Bayesiano) es de los mas robustos,  
* El método para estimar los eigenvalores (``-method``), este punto es crucial si lo que buscas es que tus tensores sean completamente **independientes** entre sí, si es así, ``diff`` es la opción. 


El siguiente código es un ejemplo de como puedes ajustarlo:
::

   mdtmrds
   -mask ROI.nii \
   -response $responsef \
   -correction 0 \
   -modsel bic \
   -fa -md \
   method diff 1 \
   each \
   64A_dw.nii \
   scheme_nuevo.txt \
   dwi.nii

Ahora vemos nuestros outputs:

::

    ls dwi_MRDS_Diff*
    
   dwi_MRDS_Diff_BIC_COMP_SIZE.nii
   dwi_MRDS_Diff_BIC_EIGENVALUES.nii
   dwi_MRDS_Diff_BIC_FA.nii
   dwi_MRDS_Diff_BIC_ISOTROPIC.nii
   dwi_MRDS_Diff_BIC_MD.nii
   dwi_MRDS_Diff_BIC_NUM_COMP.nii
   dwi_MRDS_Diff_BIC_PDDs_CARTESIAN.nii
   dwi_MRDS_Diff_V1_COMP_SIZE.nii
   dwi_MRDS_Diff_V1_EIGENVALUES.nii
   dwi_MRDS_Diff_V1_FA.nii
   dwi_MRDS_Diff_V1_ISOTROPIC.nii
   dwi_MRDS_Diff_V1_MD.nii
   dwi_MRDS_Diff_V1_NUM_COMP.nii
   dwi_MRDS_Diff_V1_PDDs_CARTESIAN.nii
   dwi_MRDS_Diff_V2_COMP_SIZE.nii
   dwi_MRDS_Diff_V2_EIGENVALUES.nii
   dwi_MRDS_Diff_V2_FA.nii
   dwi_MRDS_Diff_V2_ISOTROPIC.nii
   dwi_MRDS_Diff_V2_MD.nii
   dwi_MRDS_Diff_V2_NUM_COMP.nii
   dwi_MRDS_Diff_V2_PDDs_CARTESIAN.nii
   dwi_MRDS_Diff_V3_COMP_SIZE.nii
   dwi_MRDS_Diff_V3_EIGENVALUES.nii
   dwi_MRDS_Diff_V3_FA.nii
   dwi_MRDS_Diff_V3_ISOTROPIC.nii
   dwi_MRDS_Diff_V3_MD.nii
   dwi_MRDS_Diff_V3_NUM_COMP.nii
   dwi_MRDS_Diff_V3_PDDs_CARTESIAN.nii
Nuevamente te recomiendo mucho que explores tus outputs para que no sean una caja negra. Por lo pronto, podemos observar que hay cuatro sets de datos: ``V1``, ``V2``, ``V3`` y ``BIC``. Donde ``BIC`` son el resultdado final una vez aplicado el criterio de información bayesiana y son los que al final puedes utilizar para el análisis.

Entonces por el momento nos concentraremos en los output más relevantes:

::

   dwi_MRDS_Diff_BIC_COMP_SIZE.nii
   dwi_MRDS_Diff_BIC_FA.nii
   `dwi_MRDS_Diff_BIC_MD.nii`
   dwi_MRDS_Diff_BIC_NUM_COMP.nii
   dwi_MRDS_Diff_BIC_PDDs_CARTESIAN.nii
Donde ``dwi_MRDS_Diff_BIC_NUM_COMP.nii`` nos va a decir cuantos compartimentos (tensores) encontro en tus datos. En este ejemplo podemos ver que MRDS encontro en su mayoría tres compartimentos:

!`image <https://github.com/c13inb/c13inb.github.io/assets/129544525/f619b3af-b2e7-4bcf-9e57-158f6b56082e>`_

Una vez sabiendo que hay tres compartimentos, ``dwi_MRDS_Diff_BIC_COMP_SIZE.nii`` nos dirá el tamaño de cada uno, y tanto ``dwi_MRDS_Diff_BIC_FA.nii`` como ``dwi_MRDS_Diff_BIC_MD.nii`` será los mapas cuantitativos de cada compartimento. Ejemplo:

!`image <https://github.com/c13inb/c13inb.github.io/assets/129544525/c3716a90-aedd-4aa4-b655-d72f58a4b5b4>`_

Ahora, para visualizar tus fixels vamos a necesitar el archivo ``dwi_MRDS_Diff_BIC_PDDs_CARTESIAN.nii`` que contiene información de la dirección principal. Si bien odemos cargar los datos de la siguiente manera:
::

   mrview 64A_dwi.nii.gz -fixel.load dwi_MRDS_Diff_BIC_PDDs_CARTESIAN.nii

También puedes escalar tus PDD's de acuerdo al tamaño de cada tensor/compartimento para entender mejor la distribución de estos por voxel. Puedes hacerlo usando el siguiente script:
::

   #!/bin/bash
   
   PDDs=$1
   COMPSIZE=$2
   scaled_PDDs=$3
   
   tmpDir=$(mktemp -d)
   
   mrconvert -coord 3 0:2 $PDDs ${tmpDir}/PDD_0.mif
   mrconvert -coord 3 3:5 $PDDs ${tmpDir}/PDD_1.mif
   mrconvert -coord 3 6:8 $PDDs ${tmpDir}/PDD_2.mif
   
   mrinfo $COMPSIZE
   
   mrconvert -coord 3 0 $COMPSIZE ${tmpDir}/fraction_0.mif
   mrconvert -coord 3 1 $COMPSIZE ${tmpDir}/fraction_1.mif
   mrconvert -coord 3 2 $COMPSIZE ${tmpDir}/fraction_2.mif
   
   mrcalc ${tmpDir}/PDD_0.mif ${tmpDir}/fraction_0.mif -mul ${tmpDir}/scaled_PDD_0.mif
   mrcalc ${tmpDir}/PDD_1.mif ${tmpDir}/fraction_1.mif -mul ${tmpDir}/scaled_PDD_1.mif
   mrcalc ${tmpDir}/PDD_2.mif ${tmpDir}/fraction_2.mif -mul ${tmpDir}/scaled_PDD_2.mif
   
   
   mrcat -axis 3 ${tmpDir}/scaled_PDD_{0,1,2}.mif $scaled_PDDs
   
   rm -fR $tmpDir
   
Ahora sí visualizamos esos fixels escalados:

::

   mrview 64A_dwi.nii.gz -fixel.load scaled_PDDs.nii
