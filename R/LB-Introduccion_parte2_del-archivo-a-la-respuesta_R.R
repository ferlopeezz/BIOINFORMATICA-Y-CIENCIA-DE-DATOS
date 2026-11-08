# =============================================================
# Laboratorio de introducción · Parte 2: Del archivo a la respuesta
#                   (y por qué la velocidad importa)
# Asignatura: Ciencia de Datos · Grado en Biomedicina (UAX), 0431304
# -------------------------------------------------------------
# Continúa la Parte 1. Allí los datos estaban escritos dentro del script;
# aquí vienen de un archivo, que es como llegan siempre en la vida real.
# No hay que entregar nada y no se evalúa.
# Para ejecutar todo de golpe usa Ctrl + Alt + R (en Mac, Cmd + Option + R) o
# Ctrl + Shift + Enter (Source with Echo); el botón Source a secas no enseña
# los resultados.
#
# Qué necesitas: este script y el archivo cohorte_neumonia.csv, que viene en la
# carpeta data del laboratorio (no lo muevas). Es una cohorte SIMULADA con
# fines docentes (no son pacientes reales): 1.800 pacientes ingresados por
# neumonía. Es la cohorte de referencia de este laboratorio de introducción.
#
# Sigue sin hacer falta instalar ningún paquete: todo es R base.
#
# Al terminar sabrás: dónde busca R los archivos, cómo se lee y se comprueba
# una tabla, cómo se le hacen preguntas, cómo se guarda lo que produces, y
# por qué la forma de escribir el código deja de ser un detalle estético en
# cuanto los datos crecen.
# =============================================================


# -------------------------------------------------------------
# Bloque 0. ¿Dónde busca R los archivos?
# En la guía: «Directorio de trabajo».
# -------------------------------------------------------------
# El motivo número uno por el que un script no arranca el primer día no es un
# error de programación: es que el archivo no está donde el programa lo busca.

# R siempre trabaja "desde" una carpeta, el DIRECTORIO DE TRABAJO.
getwd()

# Y estos son los archivos y carpetas que ve desde ahí. El CSV no sale
# directamente porque está dentro de la carpeta data: con el proyecto abierto
# verás "data"; desde la carpeta scripts verás los scripts (los datos están
# un nivel por encima, en "../data").
list.files()

# Hay dos maneras de nombrar un archivo:
#   - RUTA ABSOLUTA: la dirección completa desde la raíz del disco,
#     "C:/Users/ana/Documents/biomedicina/cohorte_neumonia.csv". Funciona en TU
#     ordenador y en ningún otro. Si mandas el script a alguien, se rompe.
#   - RUTA RELATIVA: la dirección contada desde el directorio de trabajo.
#     "../data/cohorte_neumonia.csv" significa "sube un nivel y entra en data".
#     Funciona en cualquier ordenador siempre que la carpeta del laboratorio
#     viaje entera (scripts y datos juntos). Es la que hay que usar SIEMPRE.

# Existe setwd() para cambiar de carpeta a mano, pero conviene no cogerle el
# gusto: convierte el script en algo que solo funciona en tu ordenador.
# La solución buena en RStudio es un PROYECTO. La carpeta del laboratorio ya
# trae uno (el archivo .Rproj): ábrelo con doble clic y el directorio de
# trabajo pasa a ser la carpeta del laboratorio, siempre. Para una carpeta
# tuya: File > New Project > Existing Directory. Cuesta treinta segundos y
# ahorra horas.
#
# Si trabajas en Google Colab con Python, el equivalente es subir el archivo
# con el panel de la izquierda o montar tu Google Drive.

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | getwd() imprime la carpeta actual y list.files() lo que hay dentro.
# | Con el proyecto del laboratorio abierto verás la carpeta "data" en esa
# | lista; si trabajas desde la carpeta "scripts", verás los scripts (los
# | datos están un nivel por encima, en "../data"). Si no ves ni "data" ni los
# | scripts, abre el proyecto del laboratorio antes de continuar: el Bloque 2
# | fallaría.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 1. Paquetes: qué son y por qué se instalan
# -------------------------------------------------------------
# R viene con un conjunto de funciones de fábrica (R "base"): read.csv, mean,
# table, hist... Todo lo que usamos aquí. Pero la mayor parte de lo útil vive
# en PAQUETES: colecciones de funciones que ha escrito otra gente y que se
# descargan de un repositorio público (CRAN).
#
# Hay dos verbos distintos y confundirlos es un clásico:
#   - INSTALAR: se hace UNA sola vez por ordenador. Descarga el paquete al disco.
#     install.packages("tidyverse")
#   - CARGAR: se hace en CADA sesión nueva de R, al principio del script.
#     library(tidyverse)
# La analogía: instalar es comprar el libro; cargar es sacarlo de la estantería
# y abrirlo. Comprarlo otra vez cada mañana no tiene sentido; abrirlo, sí.
#
# El tidyverse aparece en la Parte 3, que es opcional. Aquí no hace falta: así te
# aseguras de que este laboratorio funciona aunque no hayas instalado nada.

# Estos son los paquetes que R ya tiene cargados ahora mismo, sin que hayas
# pedido nada.
search()

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | search() devuelve una lista que empieza por ".GlobalEnv" (tus objetos) y
# | sigue con "package:stats", "package:graphics", "package:grDevices" y
# | otros, hasta "package:base", que es el último. Son los paquetes que R
# | carga siempre solo.
# | Si haces la Parte 3 (opcional), library(tidyverse) hara crecer esa lista con
# | dplyr, ggplot2, readr y compania.
# | Error típico asociado: 'could not find function "ggplot"' casi siempre
# | significa que el paquete existe pero se te ha olvidado la linea library().
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 2. Leer el archivo
# En la guía: «Leer y comprobar la tabla».
# -------------------------------------------------------------
# read.csv() lee un archivo de texto separado por comas y lo convierte en un
# data frame. Es la función de R base; en la Parte 3 (opcional) verás
# read_csv() (con guion bajo), la versión del paquete readr, que es más rápida.
archivo <- "data/cohorte_neumonia.csv"          # con el proyecto (.Rproj) abierto
if (!file.exists(archivo)) {
  archivo <- "../data/cohorte_neumonia.csv"     # si trabajas desde la carpeta scripts
}
if (!file.exists(archivo)) {
  stop("No encuentro cohorte_neumonia.csv. Descomprime la carpeta del ",
       "laboratorio y abre su archivo .Rproj con doble clic.")
}
cohorte <- read.csv(archivo)

# Un consejo que ahorra disgustos: no abras el CSV con Excel para guardarlo
# después. Excel en español lo reescribe con punto y coma y coma decimal, y
# read.csv() deja de leerlo bien.

# Antes de tocar nada: comprobar que ha entrado lo que esperabas.
# Esta comprobación NO es opcional. Media hora de análisis sobre una tabla mal
# leída es media hora tirada.
dim(cohorte)

# Y ahora el error que verás el primer día, provocado a propósito.
try(read.csv("cohorte_neumonía.csv"))

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | dim(cohorte) devuelve 1800 21: mil ochocientas filas (pacientes) y
# | veintiuna columnas (variables). Si te sale otra cosa, para y revisa.
# | El intento fallido devuelve "Error in file(...) : cannot open the
# | connection" y, debajo, el aviso que de verdad importa: "cannot open file
# | 'cohorte_neumonía.csv': No such file or directory" (fíjate en la tilde de
# | la i). En un R en español: "no se puede abrir la conexión" y "no fue
# | posible abrir el archivo".
# | Leccion doble. Primera: el nombre que le pasaste lleva tilde y el archivo
# | real no; R no adivina ni corrige, el nombre tiene que coincidir LETRA POR
# | LETRA, incluidas mayusculas, tildes y la extension .csv. Segunda: la
# | primera linea del error es generica y la informacion util está más abajo,
# | asi que conviene leer el mensaje ENTERO y no solo la primera linea roja.
# | Cuando veas ese mensaje, la respuesta está casi siempre en list.files().
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 3. La anatomía de una tabla
# En la guía: «Leer y comprobar la tabla».
# -------------------------------------------------------------
# Cuatro órdenes que conviene ejecutar SIEMPRE ante una tabla nueva, en este
# orden. Es la exploración mínima antes de creerse nada.

# 1) ¿Qué tamaño tiene?
dim(cohorte)
nrow(cohorte)
ncol(cohorte)

# 2) ¿Cómo se llaman las columnas?
names(cohorte)

# 3) ¿De qué tipo es cada una y qué pinta tienen los datos?
str(cohorte)

# 4) ¿Cómo son las primeras filas?
head(cohorte, 3)

# Y una quinta pregunta que salva análisis: ¿faltan datos?
sum(is.na(cohorte))
colSums(is.na(cohorte))

# Qué significa cada columna no lo dice el archivo de datos, lo dice el
# DICCIONARIO DE VARIABLES (cohorte_neumonia_diccionario.csv, que acompaña al
# CSV). Léelo antes de analizar nada: aquí, por ejemplo, ingreso_uci es la
# variable de resultado y vale 1 si el paciente acabó en la UCI.
# Regla de oro de la investigación con datos: si no sabes qué mide una
# columna, no la analices.

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | 1800 filas x 21 columnas. str() ensena que id_paciente, sexo, centro,
# | las fechas y servicio_ingreso son "chr" (texto) y el resto numericas
# | ("int" enteras, "num" con decimales).
# | Detalle importante: las fechas se han leido como TEXTO, no como fechas.
# | R no las reconoce solo. Convertirlas es parte del laboratorio de limpieza (wrangling).
# | sum(is.na(cohorte)) devuelve 0: esta version de la cohorte no tiene
# | ausentes. El laboratorio de limpieza trabaja con la
# | versión "sucia", que sí los tiene.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 4. Cinco preguntas a los datos
# En la guía: «Cinco preguntas a los datos».
# -------------------------------------------------------------
# Todo lo que sigue lo hiciste ya con 10 pacientes en la Parte 1. Es
# exactamente el mismo código: solo cambia el número de filas. Esa es la
# gracia de haber aprendido las estructuras primero.

# Pregunta 1. ¿Cuántos pacientes acabaron en la UCI?
table(cohorte$ingreso_uci)
mean(cohorte$ingreso_uci)

# Pregunta 2. ¿Qué edad tienen?
mean(cohorte$edad)
median(cohorte$edad)
sd(cohorte$edad)
range(cohorte$edad)

# Pregunta 3. ¿Cómo se reparten por sexo, centro y servicio?
table(cohorte$sexo)
table(cohorte$centro)
table(cohorte$servicio_ingreso)

# Pregunta 4. ¿Cuántos ingresaron con hipoxemia (saturación por debajo de 92 %)?
sum(cohorte$saturacion_o2 < 92)

# Pregunta 5. Y la que de verdad interesa: los que fueron a UCI, ¿eran distintos?
# tapply() aplica una función a un vector partiéndolo por grupos. Se lee:
# "la edad, partida por ingreso_uci, resumida con la media".
tapply(cohorte$edad, cohorte$ingreso_uci, mean)
tapply(cohorte$pcr_mg_l, cohorte$ingreso_uci, mean)
tapply(cohorte$saturacion_o2, cohorte$ingreso_uci, mean)

# Una tabla cruzada de dos variables categóricas, en proporción por fila
# (filas = epoc, columnas = ingreso en UCI):
round(prop.table(table(epoc = cohorte$epoc, uci = cohorte$ingreso_uci), margin = 1), 3)

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | 1) 1395 pacientes no fueron a UCI y 405 sí: una prevalencia de 0.225
# |    (el 22,5 %). Recuerda ese número: reaparece a lo largo de este
# |    laboratorio, y es la señal de que estás trabajando con la cohorte buena.
# | 2) Edad media 66.6 años, mediana 65, desviacion tipica 14.3, rango 29-99.
# | 3) Sexo: 979 hombres y 821 mujeres. Centros: HOS_A 841, HOS_B 611,
# |    HOS_C 348. Servicio (R lo ordena alfabéticamente): medicina_interna 298,
# |    neumologia 98, urgencias 1404.
# | 4) 68 pacientes ingresaron con saturacion por debajo de 92 %.
# | 5) Los que fueron a UCI tenian 76.4 años de media frente a 63.8; PCR de
# |    114.5 frente a 85.6; y saturacion de 94.4 frente a 95.8.
# |    La tabla cruzada anade el dato mas llamativo: entre los pacientes SIN
# |    EPOC, el 19,0 % acabo en UCI (0.190); entre los que SÍ tenian EPOC, el
# |    38,2 % (0.382).
# |    El riesgo se duplica.
# | Lectura: son mas mayores, mas inflamados, peor oxigenados y con mas
# | enfermedad pulmonar previa. El mismo patrón de edad e inflamación que viste con 10
# | pacientes en la Parte 1, ahora con 1.800 y con peso estadistico.
# | Estos son los numeros que en laboratorios posteriores se contrastan y modelan.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 5. El primer gráfico
# -------------------------------------------------------------
# Una tabla de números dice qué pasa; un gráfico dice qué forma tiene.
# Estos son de R base: la Parte 3 (opcional) los repite con ggplot2, que es
# más potente y más bonito, pero también más que aprender.

# Si RStudio da "figure margins too large", agranda el panel Plots y vuelve a
# ejecutar la línea.

# Histograma: cómo se reparte una variable numérica.
hist(cohorte$edad,
     breaks = 20,
     main = "Distribución de la edad al ingreso",
     xlab = "Edad (años)",
     ylab = "Número de pacientes",
     col = "lightblue")

# Diagrama de cajas comparando dos grupos.
boxplot(pcr_mg_l ~ ingreso_uci,
        data = cohorte,
        main = "PCR al ingreso según destino",
        xlab = "Ingreso en UCI (0 = no, 1 = si)",
        ylab = "PCR (mg/L)",
        col = c("lightblue", "salmon"))

# Guardar un gráfico en un archivo. El patrón es siempre el mismo: abres un
# dispositivo, dibujas, y lo CIERRAS con dev.off(). Si olvidas cerrarlo, el
# archivo queda vacío o corrupto.
png("grafico_edad.png", width = 800, height = 600)
hist(cohorte$edad,
     breaks = 20,
     main = "Distribución de la edad al ingreso",
     xlab = "Edad (años)",
     ylab = "Número de pacientes",
     col = "lightblue")
dev.off()
file.exists("grafico_edad.png")   # TRUE = el gráfico se ha guardado en tu carpeta de trabajo

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | El histograma enseña una distribución centrada en edades altas, con el
# | grueso de pacientes entre los 55 y los 80 años: es una neumonía de
# | población mayor, como cabe esperar. Fíjate en la última barra: sube porque
# | hay 48 pacientes con 99 años exactos (el tope de la simulación).
# | El boxplot enseña que la caja del grupo UCI (1) está más arriba que la del
# | grupo no-UCI (0): mas inflamacion en los que acabaron en cuidados
# | intensivos. Tambien veras bastantes puntos sueltos por encima: son los
# | valores extremos, habituales en la PCR.
# | Tras el bloque del png, file.exists("grafico_edad.png") devuelve TRUE: el
# | gráfico está guardado en tu carpeta de trabajo. dev.off() imprime el
# | dispositivo que queda activo (por ejemplo "null device 1"): es normal.
# | Nota de lectura: la caja va del primer al tercer cuartil, la linea de
# | dentro es la MEDIANA (no la media) y los bigotes llegan hasta el dato más
# | extremo que no se aleja de la caja más de 1.5 veces el rango
# | intercuartílico; lo que queda más lejos se dibuja como punto suelto.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 6. Guardar lo que produces
# En la guía: «Guardar resultados».
# -------------------------------------------------------------
# Un análisis que solo existe en la consola no sirve de nada. Todo lo que
# quieras conservar hay que escribirlo en un archivo.

# Creamos una tabla resumen pequeña, del tipo que acabaría en un artículo.
resumen <- data.frame(
  grupo = c("No UCI", "UCI"),
  n = as.numeric(table(cohorte$ingreso_uci)),
  edad_media = round(tapply(cohorte$edad, cohorte$ingreso_uci, mean), 1),
  pcr_media = round(tapply(cohorte$pcr_mg_l, cohorte$ingreso_uci, mean), 1)
)
resumen

# La guardamos en formato .csv. row.names = FALSE evita que R escriba una primera columna con los números
# de fila, que casi nunca interesa.
write.csv(resumen, "resumen_uci.csv", row.names = FALSE)

# Comprobar que se ha escrito de verdad (otra costumbre que conviene coger).
list.files(pattern = "csv")

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | La tabla resumen tiene 2 filas: "No UCI" con n=1395, edad media 63.8 y
# | PCR media 85.6; y "UCI" con n=405, edad media 76.4 y PCR media 114.5.
# | list.files(pattern = "csv") muestra ahora "resumen_uci.csv". El archivo
# | de datos original no sale porque está dentro de la carpeta data.
# | Puedes abrir el resumen con Excel: es texto plano separado por comas (si
# | Excel lo pone todo en una columna: Datos > Texto en columnas > Delimitado
# | > coma).
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 7. El cronómetro: por qué la forma de escribir el código importa
# En la guía: «El cronómetro y la reproducibilidad».
# -------------------------------------------------------------
# Este es el bloque que explica la palabra "Big Data" del temario, y la mejor
# forma de entenderlo es medirlo.
#
# En la Parte 1 viste que un bucle for y una función como mean() dan el
# mismo resultado. Con 10 pacientes eso es cierto y da igual cuál uses.
# Vamos a ver qué pasa cuando hay un millón.

# Primero, sobre la cohorte simulada de 1.800 pacientes.
# system.time() cronometra lo que se ejecute dentro de las llaves. La columna
# que hay que mirar es "elapsed": segundos de reloj de pared.
system.time({
  suma <- 0
  for (i in seq_len(nrow(cohorte))) {
    suma <- suma + cohorte$edad[i]
  }
  media_bucle <- suma / nrow(cohorte)
})

system.time({
  media_vectorizada <- mean(cohorte$edad)
})

# Comprobamos que dan lo mismo:
c(media_bucle, media_vectorizada)

# Con 1.800 filas los dos tardan prácticamente nada y la diferencia parece
# irrelevante. Ahora fabricamos una tabla de UN MILLÓN de filas remuestreando
# la cohorte (repetimos pacientes al azar; no es un dato nuevo, es un banco
# de pruebas). set.seed() fija el azar para que el resultado sea reproducible.
set.seed(123)
filas <- sample(seq_len(nrow(cohorte)), 1e6, replace = TRUE)
grande <- data.frame(
  edad = cohorte$edad[filas],
  pcr_mg_l = cohorte$pcr_mg_l[filas],
  saturacion_o2 = cohorte$saturacion_o2[filas],
  ingreso_uci = cohorte$ingreso_uci[filas]
)
dim(grande)

# Cuánto ocupa en memoria:
round(as.numeric(object.size(grande)) / 1024^2, 1)

# Y ahora las mismas dos formas de calcular la media, sobre un millón de filas.
system.time({
  suma <- 0
  for (i in seq_len(nrow(grande))) {
    suma <- suma + grande$edad[i]
  }
  media_bucle_g <- suma / nrow(grande)
})

system.time({
  media_vectorizada_g <- mean(grande$edad)
})

c(media_bucle_g, media_vectorizada_g)

# Un segundo experimento, para el error más caro que se comete al empezar:
# hacer crecer un objeto dentro de un bucle. Cada vez que se añade un elemento
# con c(), R copia el vector ENTERO en un sitio nuevo de la memoria.
valores <- grande$edad[1:20000]

# Version que hace crecer el vector en cada vuelta:
system.time({
  acumulador <- c()
  for (i in seq_len(20000)) {
    acumulador <- c(acumulador, valores[i])
  }
})

# La misma tarea, reservando el espacio de antemano:
system.time({
  acumulador2 <- numeric(20000)
  for (i in seq_len(20000)) {
    acumulador2[i] <- valores[i]
  }
})

# Y ahora la parte que hay que ver con los propios ojos: repetimos la version
# mala con el DOBLE de elementos. Si el coste creciera de forma proporcional,
# deberia tardar el doble.
valores2 <- grande$edad[1:40000]
system.time({
  acumulador3 <- c()
  for (i in seq_len(40000)) {
    acumulador3 <- c(acumulador3, valores2[i])
  }
})

# Liberamos la memoria: el objeto 'grande' ocupa bastante y ya no lo usamos.
rm(grande, filas, valores, valores2)
invisible(gc())

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | Los tiempos EXACTOS dependen de tu ordenador y cambian de una ejecución a
# | otra; lo que se mantiene es el orden de magnitud. Aproximadamente:
# |
# |   Sobre 1.800 filas      bucle ~0.001-0.02 s   mean() ~0.000 s
# |   Sobre 1.000.000 filas  bucle ~0.5-1.5 s      mean() ~0.001-0.002 s
# |
# | El bucle tarda cientos de veces más (mean() está en el límite del
# | cronómetro y a veces marca 0.000), y las dos medias son IDÉNTICAS (66.64
# | con la cohorte remuestreada). Mismo resultado, mismo número de datos,
# | cientos de veces más espera.
# | El segundo experimento es todavía más claro. Hacer crecer el vector con
# | c() tarda de decenas a cientos de veces más que reservar el espacio de
# | antemano, y eso con solo 20.000 elementos (aproximadamente 0.3-0.45 s
# | frente a unas milésimas de segundo).
# | Y al DOBLAR los elementos (de 20.000 a 40.000) no tarda el doble sino
# | aproximadamente 3-4 veces más (0.45 s -> 1.70 s): el coste crece de forma
# | CUADRÁTICA. Por eso el ejemplo se queda en 40.000: con un millón tardaría
# | muchos minutos.
# | La causa: c() no añade nada al vector existente, crea uno NUEVO y copia
# | todo lo anterior. En cada vuelta copia todo lo que ya lleva acumulado.
# |
# | POR QUÉ PASA ESTO: mean() hace el cálculo en código C compilado y recorre el
# | millon de numeros de una sola pasada en un bloque de memoria contiguo.
# | El bucle en R hace un millon de viajes de ida y vuelta, y en cada uno
# | comprueba tipos y hace copias. La diferencia no es "R es lento": es que
# | hay una forma de pedir las cosas que aprovecha como funciona la maquina.
# |
# | Y AQUI EMPIEZA EL BIG DATA. Nuestra tabla de un millon de filas y CUATRO
# | columnas ocupa unos 19 MB. Con las 21 columnas de la cohorte serían más
# | de 100 MB (aproximadamente 120 MB). Un registro sanitario nacional (decenas de millones de
# | pacientes, cientos de variables, años de seguimiento) se va a los cientos
# | de gigabytes: no cabe en la memoria de tu portatil, y ninguna forma de
# | escribir el bucle lo arregla.
# | Cuando los datos dejan de caber en memoria hay tres salidas, y las tres
# | están en el temario de la asignatura:
# |   1. NO traer los datos: dejarlos en una base de datos y pedirle a ella
# |      solo el resumen que necesitas. Eso es SQL.
# |   2. Traerlos a TROZOS: procesar por bloques y ir acumulando.
# |   3. REPARTIRLOS entre varias maquinas que trabajan a la vez. Eso es la
# |      computacion distribuida (Spark, Hadoop) de la que habla el Big Data.
# | Acabas de medir con un cronometro por que existen esas tres cosas.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 8. Que el análisis se pueda repetir dentro de un año
# En la guía: «El cronómetro y la reproducibilidad».
# -------------------------------------------------------------
# Un análisis reproducible es aquel que otra persona (o tú dentro de un año)
# puede volver a ejecutar y obtener EXACTAMENTE lo mismo. En investigación
# clínica esto no es una manía de programadores: es lo que separa un resultado
# defendible de una anécdota.
#
# Cinco costumbres, todas baratas:
#
# 1. UN SCRIPT, no la consola. Si solo existe en la consola, no existe.
#
# 2. ORDEN FIJO Y SIEMPRE EL MISMO:
#      cabecera (qué hace, quién, cuándo) -> librerías -> carga de datos ->
#      limpieza -> análisis -> resultados. (Este script de introducción no lo
#      sigue del todo: está ordenado para explicar.)
#
# 3. RUTAS RELATIVAS y un proyecto de RStudio (Bloque 0).
#
# 4. SEMILLA para cualquier cosa con azar. Sin set.seed(), dos ejecuciones dan
#    resultados distintos y nadie puede comprobar los tuyos.
set.seed(42)
sample(1:100, 5)
set.seed(42)
sample(1:100, 5)

# 5. DEJAR CONSTANCIA DEL ENTORNO. sessionInfo() imprime tu versión de R y de
#    cada paquete cargado. Pegarlo al final de un informe permite reproducir
#    el resultado años después, cuando las versiones hayan cambiado.
sessionInfo()

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | Las dos llamadas a sample() con la MISMA semilla devuelven exactamente los
# | mismos cinco numeros. Sin set.seed() saldrian distintos cada vez.
# | Esto es lo que hace reproducible una particion de datos, una imputacion o
# | una validacion cruzada: lo veras más adelante.
# | sessionInfo() imprime tu version de R, el sistema operativo y los paquetes
# | cargados. Es la "ficha tecnica" del analisis.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 9. Comprueba que lo has seguido
# -------------------------------------------------------------
stopifnot(nrow(cohorte) == 1800)
stopifnot(ncol(cohorte) == 21)
stopifnot(sum(cohorte$ingreso_uci) == 405)
stopifnot(round(mean(cohorte$ingreso_uci), 3) == 0.225)
stopifnot(round(mean(cohorte$edad), 1) == 66.6)
stopifnot(file.exists("resumen_uci.csv"))
cat("CHECKPOINT SUPERADO: cohorte de 1.800 pacientes, 405 en UCI (22,5 %),\n")
cat("edad media 66,6 años y resumen guardado en disco.\n")

# Tres retos con la solución escrita. Tápala, inténtalo y compara.

# 1) ¿Cuántos pacientes tienen EPOC?
# n_epoc <- sum(cohorte$epoc == 1)
# stopifnot(n_epoc == 327)

# 2) ¿Cuál es la estancia media en días?
# estancia_media <- mean(cohorte$estancia_dias)
# stopifnot(round(estancia_media, 1) == 8.1)

# 3) ¿Cuántos pacientes mayores de 75 años hay?
# n_mayores <- sum(cohorte$edad > 75)
# stopifnot(n_mayores == 464)

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | Si ves el mensaje CHECKPOINT SUPERADO (ocupa dos líneas), has leído la cohorte
# | correcta y has generado el archivo de resumen.
# | Si alguna condicion falla, el mensaje te dice cual: casi siempre significa
# | que se ha leido un archivo distinto del que toca.
# +---------------------------------------------------------


# =============================================================
# Fin de la Parte 2.
#
# Con las dos partes de este laboratorio ya tienes: los tipos de dato, las variables,
# las funciones, los vectores, las tablas, los condicionales, los bucles, tus
# propias funciones, la lectura de errores, la lectura de archivos, el
# guardado de resultados, la reproducibilidad y una idea medida de por que
# existe el Big Data.
#
# Siguiente paso (opcional): la Parte 3, la misma cohorte con el tidyverse (dplyr y
# ggplot2), que es como trabajan muchos equipos con R.
# =============================================================
