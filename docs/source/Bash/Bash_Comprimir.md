Comprimir
=========

*[DICOM]: Digital Imaging and Communication in Medicine

## Comprimir

Comprimir los archivos [__DICOM__](http://es.wikipedia.org/wiki/DICOM), reduce dramaticamente el uso de espacio de disco, por lo que es una practica recomendable. Además depende de una instrucción sencilla.  

Para comprimir un directorio se usa:

```
    tar cvzf archivo.tar.gz /archivo/*
```

Para extraer el contenido se utiliza:

```
    tar xvzf archivo.tar.gz
```

Para listar el contenido sin extraer:

```
    tar tvzf archivo.tar.gz
```

`f` : indica el nombre del archivo

`z` : indica que va comprimir con gzip el archivo

`j` : cuando se usa, indica el uzo de bzip que tiene una tasa mayor de compresión pero tarda mas y consume mas recursos

`v` : permite ver los avisos del proceso 

`c` : indica que se creara una archivo comprimido

`x` : indica que se descomprime el archivo 

`t` : genera un listado de los archivos que lo forman
