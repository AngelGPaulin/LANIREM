# Agilizando tu experiencia de usuario en Don Clusterio.

Si siempre usas la misma PC para trabajar gráficamente en Don Clusterio, este tutorial es para tí. Prepárate para acelerar todo tu entorno gráfico, y notarás que tu sesión en google-chrome o firefox vuelan, y que navegas más rápido las carpetas en el navegador de archivos. Es en serio, la experiencia es noche y día.

:zap:  Este tutorial no afecta ni beneficia las sesiones remotas, y solamente agiliza tu experiencia en la computadora donde siempre te sientas. Si eres nómada en el laboratorio, entonces deja ésto pasar.

## Descripción del problema
Cada usuario en linux tiene una carpeta `$HOME`, donde se guardan archivos de configuración, historial, etc. En el caso de sesiones gráficas, ahí también se graban tu cache e historial de navegadores de internet, navegadores de archivos, archivos temporales de libreoffice, etc. Debido a que en Don Clusterio tu `$HOME` está físicamente albergado en el servidor, todo el tráfico de google chrome, firefox, y demás, tiene que cruzar a través de la red desde tu computadora hacia el servidor. Esto sucede cientos de veces por segundo, por lo que la experiencia del usuario se va degradando.

Afortunadamente, es posible mover tus carpetas de cache a un disco local y así evitar tanto tráfico de red. Aunque hace mucho esto lo hacíamos con links simbólicos, es posible hacerlo de manera muy formal siguiendo las especificaciones del X Desktop Group (XDG). Si te sientes geek o quieres aprender, checa [este link](https://specifications.freedesktop.org/basedir-spec/latest/index.html). Si hoy no te sientes particularmente geek, baste decir que solo vamos a mover el cache y el config hacia un disco local. El resto de configuraciones se quedan en tu `$HOME` para que todo siga funcionando como siempre.

## Instrucciones

### Revisando disco

Antes de empezar, tenemos que asegurarnos que tenemos un disco duro local hacia dónde copiar nuestros archivos de cache y configuración. Casi todas las PCs de Don Clusterio tienen un disco montado en `/misc/NOMBRE_DE_LA_PC`. Si no lo tiene, este tutorial no te servirá, y pídele a la persona responsable de tu laboratorio que te compre un disco duro. 

:eye:  Como ejemplo, vamos a usar el usuario `nickcave`, que quiere cambiar su cache/config a la computadora `larmor`.

Revisamos si hay disco duro usando `df -hl` y vemos qué hay montado en `/misc`. En este ejemplo, vemos que sí existe `/misc/larmor`.

![image](https://github.com/user-attachments/assets/6317523a-9ad2-41fa-8543-f018657a553d)

Entonces, creamos un fólder en ese disco. Recuerda que si escribes en algún lugar en `/misc`, debes hacerlo dentro de una carpeta con tu nombre de usuario. [Checa acá si ya se te olvidó](https://github.com/c13inb/c13inb.github.io/wiki/Cl%C3%BAster:-Folder-almacenamiento-(misc)). **Asegúrate que existan al menos 20 GB libres en ese disco.**

Entonces, el usuario `nickcave` hace una carpeta llamada `/misc/larmor/nickcave/` (si ya existe, pues no la crea).

## Copiando cache y config

Usa el script `inb_config_XDG.sh`. Se le debe dar un argumento, que es la carpeta donde vamos a copiar nuestro cache/config. Para hacer la vida fácil, **nombra la carpeta como `XDG`**. En nuestro ejemplo:

![image](https://github.com/user-attachments/assets/b229f53e-97eb-46c9-b1ff-4b89bac27ca6)

:eye: Fíjate cómo el usuario `nickcave` está trabajando en `larmor`, misma máquina donde está el disco `/misc/larmor`. No andes haciendo ésto desde otra máquina o se va a tardar mucho porque estarás enviando todo a través de la red innecesariamente.

El script `inb_config_XDG.sh` copiará tus archivos y preparará dos archivos nuevos: `~/.profile` y `~/.pam_environment`. Cuánto se tarde en copiar dependerá de cuánto tienes en tu cache de firefox y google-chrome, por lo que se recomienda borrar tu caché previo a este paso (revisa cómo hacerlo en [chrome](https://support.google.com/accounts/answer/32050?hl=es-419&co=GENIE.Platform%3DDesktop) y [firefox](https://support.mozilla.org/es/kb/limpia-la-cache-y-elimina-los-archivos-temporales-)). Verás muchos archivos siendo copiados pasar por la terminal, pero al final verás:

![image](https://github.com/user-attachments/assets/6deb8a49-9aad-4be0-b7a6-759fcb996d90)

Y como siempre obedecemos las instrucciones, cerramos la sesión completamente (logout). Al volver a entrar (suponiendo que estás en la máquina que estamos agilizando), toooodo será mucho más rápido. **Disfruta tu nueva experiencia de usuario**.

## Consideraciones importantes
Para que el archivo `~/.profile` corra, **no deben existir `~/.bash_login` ni `~/.bash_profile`**. Si los tienes y les habías puesto cosas de configuración, pasa su contenido a `~/.bashrc` y reinicia tu sesión.


## Y qué onda con la terminal.
Nada, no pasa nada. Todo sigue como si no hubiéramos cambiado la configuración. Pero en `~/.profile` se quedaron unas líneas que revisan que todo esté bien, que serán útiles en caso de algún desperfecto. El aviso será como este:
![image](https://github.com/user-attachments/assets/8aad24a2-062c-494d-9773-50862aea4411)

Como puedes ver, con todo y aviso de errores, la terminal se puede usar. Es solo el login gráfico el que se verá afectado (ver Troubleshooting).

## Troubleshooting
El problema principal que puede tener todo ésto es que la PC donde está el disco que alberga tu carpeta `XDG` esté fuera de línea. Por ejemplo, que esté apagada o desconectada de la red. Esto hará que si haces login gráfico en otra PC, tu sesión te dará un error relacionado a XDG y te invitará a corregirlo lo más pronto posible. No panic. Puedes cerrar ese aviso, y usar tu sesión. Eso sí, estará lentita y no estará actualizado tu historial de navegación de internet, etc. Así que si esto sucede, avisa qué máquina está caída y le daremos su revisada.

## Revirtiendo los efectos
No puede ser más fácil: borra el archivo `~/.pam_environment` y reinicia tu sesión. Si quieres que se respete tu historial de navegación en internet, sincroniza las carpetas que tenías en tu `XDG` con los equivalentes dentro de tu `$HOME`. Si ya te animaste a hacer esto, es que sabes lo que estás haciendo, solo recordar que el default de esas carpetas están definidas en  [este link](https://specifications.freedesktop.org/basedir-spec/latest/index.html).






