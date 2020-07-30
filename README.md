# mbed LPC1768 bare-metal
Colección de programas de demostración para la placa mbed LPC1768. El proyecto esta basado en Make, y esta desarrollado integramente en ensamblador, sin utilizar las librerías mbed.

A continuación como se describe como importarlo en GNU MCU Eclipse y ejecutarlo en la placa.

---

## Clonar el proyecto
Clonar el proyecto usando Git:
* Desde un cliente, usar la opción **[Clone]**.
* Desde la linea de comandos utilizar el comando `git clone`.

---

## Importar el proyecto en Eclipse
Una vez clonado localmente, agregar el proyecto en Eclipse:
* Seleccionar **[File > Makefile project with existing code]**. 
* En la nueva ventana:
    * En **[Existing Code Location]** indicar el *path* al proyecto (usar el botón **[Browse...]**).
    * En **[Toolchain for Indexer]** seleccionar la opción *Cross ARM GCC* (¡importante!).

El proyecto debe aparecer ahora en la vista *Project Explorer*: 
* Hacer clic derecho sobre el mismo, y seleccionar **[Properties]** en el menú contextual.
* En la nueva ventana, seleccionar **[C/C++ Build > Settings]**. En la sección derecha de la ventana, en la pestaña **[Toolchains]**, el campo *Name* debe indicar *GNU MCU Eclipse ARM Embedded GCC (arm-none-eabi-gcc)* o bien *GNU Tools for ARM Embedded Processors*.
* Hacer clic en **[Ok]**.

---

## Compilar
Crear una copia del archivo `Makefile.config` con el nombre `Makefile.mine` y modificar en el mismo la variable `APP_NAME` con el ejemplo que se desee compilar.

Para compilar el proyecto se puede:
* Hacer clic derecho sobre el proyecto en la vista *Project Explorer* y seleccionar **[Build Project]** en el menú contextual.
* Seleccionar en la barra de menúes de Eclipse **[Project > Build Project]**.
* Hacer clic en el ícono *Build* (un martillo).

Si el proyecto compilo correctamente, en la vista **[Console]** debe indicarse que se generó correctamente el archivo `blink.elf`.

---

## Configurar entorno PyOCD
Primero, verificar que el `pyocd-gdbserver` este correctamente configurado en Eclipse:
* Seleccionar **[Windows > Preferences]** en el menú de Eclipse.
* En la nueva ventana, seleccionar **[MCU > Global pyOCD Path]** en la lista izquierda.
* En el campo *Executable* debe indicar `pyocd-gdbserver.exe` (sin la extensión en Linux o MacOS), y el campo *Folder* debe contener el *path* al ejecutable (por ejemplo, en Windows `C:\Python27\Scripts`).
* Hacer clic en **[Ok]**.

A continuación se creará y ejecutará una configuración de *debug*:
* Seleccionar **[Run > Debug Configurations...]** en el menú de Eclipse.
* En la nueva ventana, hacer doble clic sobre **[GDB PyOCD debugging]** en el menú izquierdo. Esto crea una nueva configuración basada en este perfil, con el nombre del proyecto activo.
* Seleccionar el nuevo perfil creado (*mbed-blinky-asm-makefile Default*).
* Luego, en el panel derecho:
    * En la pestaña **[Main]**, el campo *Project* debe indicar el nombre del proyecto (`mbed-blinky-asm-makefile`). El campo *C/C++ Application* debe indicar el nombre del archivo ELF, en este caso `blink.elf`. Si no estuviera presente escribir el nombre del mismo, o bien hacer clic en el botón **[Search project]** o **[Browse]** para buscarlo.
    * En la pestaña **[Debugger]**, el campo *Executable* debe contener el valor `${pyocd_path}\${pyocd_executable}`. Estas dos variables son reemplazadas por los valores especificados el menú **[MCU > PyOCD]**.
    * En la pestaña **[Startup]**, en la sección **[Run/Restart commands]**, reemplazar `main` por `_start` en el campo *Set breakpoint at*.
    * En la pestaña **[Common]**, seleccionar la opción **[Shared file:]**, indicando en el campo el nombre del proyecto. De esta manera la configuración para debugging es guardada en un archivo `*.launch` dentro del proyecto.
    * Hacer clic en el botón **[Apply]**. No cerrar la ventana aún.
    
Para ejecutar el programa por primera vez, conectar la placa si no lo estuviera aún y, hacer clic en el botón **[Debug]**, que esta en la parte inferior de la ventana. Es posible que Eclipse pregunte si se desea cambiar a la perspectiva *Debug*, responder que sí.

---
    
## Próximas ejecuciones
Para cargar el programa en la placa y ejecutarlo, la opción más sencilla es hacer clic ícono **[Debug]** en la barra de herramientas de Eclipse, que ejecuta el último perfil seleccionado. Si se desea cambiar el perfil, hacer clic en la flecha que se encuentra junto al ícono **[Debug]**, y de la lista desplegable que se presenta, seleccionar el proyecto, o bien hacer clic en **[Debug Configurations...]**, que abre la ventana de configuración del punto anterior.
