# Voltímetro con FPGA y VGA

**Autor:** Diego H. Mirarchi  
**Curso:** Final Digitales I - Segundo cuatrimestre 2024 - UNSAM  
**Proyecto:** Voltímetro utilizando FPGA y VGA 640×480 @ 60Hz

---

## Descripción

Los diagramas en bloques de cada código se encuentran en la carpeta `diagrams/`.

Se utilizaron los siguientes archivos provistos en el curso:
- `ffd.vhdl`
- `ROM.vhdl`
- `Voltimetro_Esquema_Arty_A7-35_top_level.vhdl`

Se testearon todos los bloques utilizando Vivado a través de los testbench, siendo el medio principal para debugear errores. Recién al simular todo correctamente se testeó experimentalmente.

---

## Problemas encontrados y soluciones

### 1. Frecuencia de muestreo vs. refresco de pantalla

**Problema:** Primero se probó con un contador de 330, pero generaba problemas ya que muestreaba más rápido de lo que tardaba en escribir en pantalla. Si el valor cambiaba (sobre todo los últimos dígitos por ruido) en medio del frame, cambiaba a graficar el nuevo valor generando glitches y viéndose ruido.

**Solución:** Se modificó a un contador de 330000, que muestrea cada 0.0132s, mientras que la pantalla refresca completa en 0.0167s. Esto implica que cada dígito se llega a dibujar completo sin problemas. Quizás lo más seguro sería usar 3300000 para tener mayor estabilidad, pero probando en la práctica con 330000 funcionó bien y no se llegan a percibir glitches.

### 2. Multiplexor de caracteres (mux_4b)

**Problema:** A la hora de seleccionar en el `mux_4b` a partir de `pixel_x` para saber qué carácter dibujar según la posición en pantalla, se encontraron dificultades para lograr combinacionalmente una salida de 4 bits a partir de la selección.

**Solución:** Se logró empleando un vector de bits que va desde (1,0,0,0,0) hasta (0,0,0,0,1) dependiendo de la posición del selector, y luego conectando el carácter correspondiente (4 bits) a su posición con ANDs y generate, todo en una gran OR, de tal manera que solo queda activa la salida con un '1'. De esta manera se divide horizontalmente en 5 partes de 128 píxeles, que se seleccionan a partir de los 3 bits más significativos de `pixel_x`.

### 3. Ventanas de sincronismo y video_on

**Problema:** Tuve problemas para lograr correctamente las ventanas de sincronismo y `video_on` utilizando lógica combinacional.

**Solución:** 
- **video_on:** Se logró pensando que desde 0 hasta un valor se mantiene en '1' y luego baja a '0' hasta que resetea, por lo que planteé la tabla de verdad con los bits más significativos uno a uno hasta lograr por inspección una expresión que cumpla.
- **Sincronismo:** Se logró utilizando flip-flops D que al llegar a un valor ponían en '1' la entrada del ffd, al llegar a otro valor lo ponían en '0', y en cualquier otro caso mantiene el valor anterior.

### 4. Tiempos del VGA en simulación

**Problema:** Al simular, los tiempos no coincidían con los indicados en el PDF de VGA (en `docs/`). El PDF dice que el backporch vertical es de 33 ciclos horizontales y que debería durar 0.992ms, pero al simular obtenía 1.056ms.

**Solución:** Luego de buscar el error, observé que 40e-9s × 800 × 33 = 1.056ms y que el PDF tenía un error. Por otro lado, 0.992ms equivalen a 31 ciclos horizontales. Dejé la ventana en 33 y al testear funcionó correctamente.

### 5. Activación del mux en zona específica de la pantalla

**Problema:** ¿Cómo activar la salida del mux únicamente en una zona de la pantalla? Sabiendo que verticalmente está separada en 480 píxeles, se optó por dividir en 128px × 3.75 y se decidió graficar en la segunda ventana de 128px. La dificultad estaba en lograr activar el MUX (4 bits) solo cuando `pixel_y` empezaba en `001xxxxxxx` (000 primer franja, 001 segunda, 010 tercera, 011 cuarta) utilizando combinacionales.

**Solución:** Se logró primero creando una variable que sea '1' cuando `pixel_y` empieza con 001, y esta se concatenó 4 veces, de esta manera se tiene o "1111" o "0000". Luego se armó una comparación parecida a la de un multiplexor para seleccionar entre `mux_out` o "1100" (carácter vacío) utilizando esta concatenación.
