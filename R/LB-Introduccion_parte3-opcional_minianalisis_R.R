# =============================================================
# Laboratorio de introducción · Parte 3 (opcional): minianálisis con el tidyverse
# Asignatura: Ciencia de Datos · Grado en Biomedicina (UAX), 0431304
# -------------------------------------------------------------
# Esta parte es OPCIONAL: no se entrega y no se evalúa. Repite el flujo de la
# Parte 2 (cargar, inspeccionar, resumir y visualizar) con el tidyverse, la
# colección de paquetes con la que trabajan muchos equipos que usan R.
#
# Es el recorrido guiado de la ampliación opcional de la guía, con el código
# ordenado y con comprobaciones. Si prefieres escribir tu propio script desde
# cero con los fragmentos de la guía (es lo que más enseña), hazlo primero y
# usa este después para comparar.
#
# Qué necesitas: este script, el archivo cohorte_neumonia.csv, que viene en la
# carpeta data del laboratorio (no lo muevas), y el tidyverse instalado
# (Bloque 0). Es la misma cohorte SIMULADA de la Parte 2, con fines docentes
# (no son pacientes reales).
#
# Las respuestas deben coincidir con las del cuaderno de Python de esta misma
# Parte 3.
#
# Necesitas R 4.1 o posterior (por el pipe |>).
# Para ejecutar todo de golpe usa Ctrl + Alt + R (en Mac, Cmd + Option + R) o
# Ctrl + Shift + Enter (Source with Echo); el botón Source a secas no enseña
# los resultados.
# =============================================================


# -------------------------------------------------------------
# Bloque 0. Instalar y cargar el tidyverse
# -------------------------------------------------------------
# Instalar se hace UNA sola vez por ordenador y tarda unos minutos, porque
# descarga muchos paquetes. Quita el # de la línea siguiente, ejecútala una
# vez y vuelve a ponerlo. Si pregunta si quieres compilar paquetes desde el
# código fuente ("from sources"), responde que no (n).
# install.packages("tidyverse")

# Cargar se hace en CADA sesión nueva de R, al principio del script.
library(tidyverse)

# Los tibbles muestran por defecto solo 3 cifras significativas (114,46 sale
# como «114.»). Con esta opción muestran 4.
options(pillar.sigfig = 4)

# +-- INTERPRETACIÓN DE RESULTADOS --------------------------
# | library(tidyverse) imprime los paquetes que ha cargado (dplyr, ggplot2,
# | readr...) y unos avisos de «conflictos»: significan que filter() y lag()
# | de dplyr tapan a las funciones de R base con el mismo nombre. Es normal.
# | Si sale «there is no package called 'tidyverse'», falta instalarlo.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 1. Cargar el dataset
# -------------------------------------------------------------
# read_csv() es la versión del tidyverse de read.csv(). Devuelve un «tibble»:
# un data frame que se imprime de forma más legible.
archivo <- "data/cohorte_neumonia.csv"          # con el proyecto (.Rproj) abierto
if (!file.exists(archivo)) {
  archivo <- "../data/cohorte_neumonia.csv"     # si trabajas desde la carpeta scripts
}
if (!file.exists(archivo)) {
  stop("No encuentro cohorte_neumonia.csv. Descomprime la carpeta del ",
       "laboratorio y abre su archivo .Rproj con doble clic.")
}
cohorte <- read_csv(archivo)

dim(cohorte)       # filas y columnas
glimpse(cohorte)   # una línea por variable: nombre, tipo y primeros valores
cohorte            # un tibble solo imprime las primeras filas

# +-- INTERPRETACIÓN DE RESULTADOS --------------------------
# | 1.800 filas x 21 columnas: la tabla tal como llega, sin ninguna columna
# | derivada. Al leer, read_csv() informa del tipo que ha dado a cada columna
# | (<dbl> número, <chr> texto, <date> fecha). A diferencia de read.csv(),
# | reconoce las fechas como fechas.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 2. Primera exploración descriptiva
# -------------------------------------------------------------
# El pipe |> pasa lo que tiene a su izquierda como primer argumento de la
# función de su derecha. Se lee «y entonces»: «coge la cohorte y entonces
# cuenta cuántos hay de cada valor de ingreso_uci».
cohorte |> count(ingreso_uci)

cohorte |> summarise(prevalencia_uci = mean(ingreso_uci),
                     edad_media      = mean(edad),
                     edad_mediana    = median(edad))

cohorte |> count(sexo)

cohorte |> summarise(diabetes       = sum(diabetes),
                     epoc           = sum(epoc),
                     insuf_cardiaca = sum(insuf_cardiaca),
                     hipertension   = sum(hipertension),
                     ins_renal      = sum(ins_renal))

# En la guía este bloque está escrito en R base. Hace lo mismo:
#   table(cohorte$ingreso_uci); mean(cohorte$ingreso_uci)
#   mean(cohorte$edad); median(cohorte$edad); table(cohorte$sexo)
#   colSums(cohorte[, c("diabetes", "epoc", "insuf_cardiaca", "hipertension", "ins_renal")])

# +-- INTERPRETACIÓN DE RESULTADOS --------------------------
# | ingreso_uci: 1.395 pacientes con 0 (no) y 405 con 1 (sí), una prevalencia
# | de 0,225 (22,5 %). Edad media 66,6 y mediana 65. Sexo: 979 H y 821 M.
# | La hipertensión es la comorbilidad más frecuente.
# | Esa prevalencia de 0,225 reaparece en los laboratorios: es la misma
# | cohorte la que acompaña a toda la asignatura.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 3. Los verbos de dplyr: filtrar, crear, agrupar y resumir
# -------------------------------------------------------------
# filter() se queda con las filas que cumplen una condición.
mayores <- cohorte |> filter(edad >= 65)
nrow(mayores)

# mutate() crea una columna nueva; cut() parte la edad en tramos.
cohorte |>
  mutate(grupo_edad = cut(edad, breaks = c(0, 49, 64, 79, Inf),
                          labels = c("<50", "50-64", "65-79", "80+"))) |>
  count(grupo_edad)

# group_by() parte la tabla por grupos y summarise() resume cada uno.
cohorte |>
  group_by(ingreso_uci) |>
  summarise(media_pcr = mean(pcr_mg_l), n = n())

# El ejemplo con el que la guía presenta el tidyverse, leído en voz alta:
# «coge la cohorte, quédate con los de 65 o más años, sepáralos por ingreso
# en UCI y calcula para cada grupo la PCR media y el número de pacientes».
cohorte |>
  filter(edad >= 65) |>
  group_by(ingreso_uci) |>
  summarise(media_pcr = mean(pcr_mg_l, na.rm = TRUE), n = n())

# +-- INTERPRETACIÓN DE RESULTADOS --------------------------
# | 954 pacientes tienen 65 años o más. Por tramos de edad: <50, 193;
# | 50-64, 653; 65-79, 616; 80+, 338 (suman 1.800).
# | PCR media por desenlace: aproximadamente 85,6 (no UCI) frente a 114,5
# | (UCI). Los que van a UCI llegan con más inflamación: ya aquí se intuye
# | que la PCR separa a los grupos.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 4. Primeros gráficos con ggplot2
# -------------------------------------------------------------
# ggplot2 construye el gráfico por capas, unidas con +: los datos, la
# estética (aes: qué variable va en cada eje) y la geometría (geom_: qué
# forma se dibuja).
ggplot(cohorte, aes(x = edad)) +
  geom_histogram(binwidth = 5) +
  labs(title = "Edad de la cohorte", x = "Edad (años)", y = "Pacientes")

# factor() convierte 0/1 en dos categorías, para que salga una caja por grupo.
ggplot(cohorte, aes(x = factor(ingreso_uci), y = pcr_mg_l)) +
  geom_boxplot() +
  labs(title = "PCR al ingreso según ingreso en UCI",
       x = "Ingreso en UCI (0 = no, 1 = sí)", y = "PCR (mg/L)")

# En R base, como en la guía:
#   hist(cohorte$edad)
#   boxplot(pcr_mg_l ~ ingreso_uci, data = cohorte)

# +-- INTERPRETACIÓN DE RESULTADOS --------------------------
# | El histograma de edad tiene su pico entre los 55 y los 70 años y una cola
# | hacia edades altas; la última barra sube porque hay 48 pacientes con 99
# | años exactos (el tope de la simulación). En el boxplot, la caja de PCR del
# | grupo UCI queda más alta: el gráfico comunica de un golpe lo que luego
# | confirmarán los contrastes estadísticos.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 5. Mini-EDA: cuatro preguntas y comprobación
# -------------------------------------------------------------
# 1) ¿Cuántos pacientes hay y cuántas variables tiene el dataset?
dim(cohorte)

# 2) ¿Cuál es la edad media y mediana de la cohorte?
cohorte |> summarise(media = mean(edad), mediana = median(edad))

# 3) ¿Qué porcentaje de pacientes ingresó en UCI?
cohorte |> summarise(porcentaje_uci = 100 * mean(ingreso_uci))

# 4) ¿La PCR al ingreso difiere visualmente entre los que ingresan en UCI y
#    los que no? Es el boxplot del Bloque 4.

stopifnot(nrow(cohorte) == 1800)
stopifnot(ncol(cohorte) == 21)
stopifnot(sum(cohorte$ingreso_uci) == 405)
stopifnot(round(mean(cohorte$edad), 1) == 66.6)
stopifnot(median(cohorte$edad) == 65)
stopifnot(nrow(mayores) == 954)
cat("CHECKPOINT SUPERADO: 1.800 pacientes y 21 variables, edad media 66,6\n")
cat("(mediana 65), 22,5 % en UCI y 954 pacientes de 65 o más años.\n")

# +-- INTERPRETACIÓN DE RESULTADOS --------------------------
# | Lo importante no es el resultado en sí, sino el flujo: cargar datos,
# | inspeccionar, resumir y visualizar. Es el patrón que se repite en cada
# | laboratorio de la asignatura, con preguntas más complejas y técnicas
# | más avanzadas, pero con la misma estructura mental.
# | Si alguna condición falla, casi siempre significa que se ha leído un
# | archivo distinto del que toca.
# +---------------------------------------------------------


# =============================================================
# Fin de la Parte 3 (opcional).
# Si has llegado hasta aquí sin errores, dominas el flujo básico con las
# herramientas del tidyverse. En el resto del curso puedes usarlo o seguir con
# R base: lo que importa es el flujo, no el dialecto.
# =============================================================
