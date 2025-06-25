Preprocesamiento con Designer
=============================

Preprocesamiento de datos con DESIGNER2 ##
-----------------------

[Designer](https://nyu-diffusionmri.github.io/DESIGNER-v2/) es un pipeline muy completo y fácil de usar para preprocesamiento de DWIs. Igual que [``dwifslpreproc``](https://mrtrix.readthedocs.io/en/dev/reference/commands/dwifslpreproc.html) , encapsula muchas herramientas disponibles en fsl y mrtrix, como [topup](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup), [eddy](https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy), y [mrdegibbs](https://mrtrix.readthedocs.io/en/dev/reference/commands/mrdegibbs.html). Pero quizás su herramienta más poderosa sea su [denoiser](https://nyu-diffusionmri.github.io/DESIGNER-v2/docs/designer/background/#dwi-denoising-with-mppca` <https://nyu-diffusionmri.github.io/DESIGNER-v2/>`_ es un pipeline muy completo y fácil de usar para preprocesamiento de DWIs. Igual que ```dwifslpreproc`` <https://mrtrix.readthedocs.io/en/dev/reference/commands/dwifslpreproc.html>`_ , encapsula muchas herramientas disponibles en fsl y mrtrix, como `topup <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/topup>`_, `eddy <https://fsl.fmrib.ox.ac.uk/fsl/fslwiki/eddy>`_, y `mrdegibbs <https://mrtrix.readthedocs.io/en/dev/reference/commands/mrdegibbs.html>`_. Pero quizás su herramienta más poderosa sea su `denoiser <https://nyu-diffusionmri.github.io/DESIGNER-v2/docs/designer/background/#dwi-denoising-with-mppca>`_.

La manera más fácil de usarlo es con [Singularity](singularity_presentation.md) (Apptainer).

::

   module load singularity
   
   designer_container=/home/inb/soporte/lanirem_software/containers/designer2.sif
   
   singularity run --nv $designer_container \
     designer \
     -eddy \
     -mask \
     -denoise \
     -rpe_pair bids/sub-26651/fmap/sub-26651_acq-hb_epi.nii.gz \
     -pe_dir AP \
     bids/sub-26651/dwi/sub-26651_acq-hb_dwi.nii.gz \
     outputdesigner.nii

El switch ``--nv`` permite a singularity utilizar CUDA. No es necesario usarlo si la máquina no tiene tarjeta NVIDIA (podemos revisar eso con ``lspci | grep VGA``).

![alt text](images/designer.png)


La mejoría de Designer2 con respecto a ``dwifslpreproc`` es notoria.
![alt text](images/designervsmrtrix.png)

:information_source: Revisa esta `tabla comparativa de denoisers <https://github.com/c13inb/c13inb.github.io/blob/master/images/denoisers.pdf>`_.
