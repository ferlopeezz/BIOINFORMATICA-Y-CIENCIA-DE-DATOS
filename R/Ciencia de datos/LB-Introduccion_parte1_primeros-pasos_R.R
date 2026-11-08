# =============================================================
# Laboratorio de introducción · Parte 1: Primeros pasos: cómo se le habla a un ordenador
# Asignatura: Ciencia de Datos · Grado en Biomedicina (UAX), 0431304
# -------------------------------------------------------------
# Este laboratorio es la ANTESALA del primer laboratorio con datos.
# No hay que entregar nada y no se evalúa.
#
# Cómo se usa: abre este archivo en RStudio y ejecuta bloque a bloque
# (sitúa el cursor en una línea y pulsa Ctrl + Enter; en Mac, Cmd + Enter).
# Lee lo que aparece en la consola ANTES de pasar a la línea siguiente.

# Casi todos los bloques terminan con una caja "INTERPRETACION DE RESULTADOS" que te
# dice qué deberías estar viendo y cómo se lee.
#
# No necesitas instalar NINGÚN paquete: todo lo que hay aquí es R "base",
# el idioma que trae R de fábrica. Los paquetes se explican en la Parte 2 y se
# usan en la Parte 3 (opcional).
#
# Idea que conviene tener presente desde el minuto uno: programar no es
# saberse las órdenes de memoria. Es aprender a decirle a la máquina, con
# precisión, algo que ya sabes hacer con la cabeza.
# =============================================================


# -------------------------------------------------------------
# Bloque 0. ¿Dónde estoy? Consola, script y entorno
# En la guía: «Consola y script».
# -------------------------------------------------------------
# RStudio tiene cuatro paneles. Los dos que importan ahora:
#   - El SCRIPT (donde estás leyendo esto): un archivo de texto con órdenes.
#     Se guarda, se comparte y se vuelve a ejecutar. Es el "cuaderno de laboratorio".
#   - La CONSOLA (abajo): donde R ejecuta y contesta. Lo que escribes ahí
#     se pierde al cerrar; por eso el trabajo que queramos mantener se escribe en el 
#     script y se guarda.

# Todo lo que empieza por # es un COMENTARIO: R lo ignora por completo.
# Los comentarios son para las personas, no para la máquina.

# Esta orden pregunta a R qué versión tiene instalada.
R.version.string

# Esta te dice en qué carpeta está trabajando R ahora mismo.
getwd()

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | R.version.string devuelve algo como "R version 4.4.1 (2024-06-14)".
# | Si no devuelve nada o da error, R no está bien instalado y el resto
# | del laboratorio fallara: revisa la instalacion antes de seguir.
# | getwd() imprime una ruta de carpeta. Ahora mismo da igual cual sea;
# | en la Parte 2 esa ruta pasa a ser importante.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 1. Tu primer programa
# En la guía: «Consola y script».
# -------------------------------------------------------------
# print() es una FUNCIÓN: una orden con nombre que hace una cosa concreta.
# Se reconoce porque va seguida de paréntesis. Lo que va dentro de los
# paréntesis es lo que le damos para que trabaje.
print("Hola. Este es mi primer programa.")

# Las comillas marcan que eso es TEXTO y no una orden. Sin comillas,
# print(Hola) buscaría un elemento llamado Hola y no lo encontraría.

# cat() también escribe en pantalla, pero sin comillas y pegando trozos.
# "\n" no es un error de tecleo: significa "salta de linea aqui".
cat("Estoy aprendiendo a programar.\n")
cat("Paciente:", "P01", "- Edad:", 71, "\n")

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | La consola muestra tres lineas. La primera sale entre comillas
# | (print conserva las comillas del texto) y las otras dos no (cat las quita).
# | En la tercera, cat ha pegado texto y numeros separandolos por un espacio.
# | Diferencia practica: print() para inspeccionar un elemento, cat() para
# | componer un mensaje legible.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 2. Los cuatro tipos de dato que vas a usar siempre
# En la guía: «Tipos de dato».
# -------------------------------------------------------------
# Un ordenador distingue el TIPO de cada dato, y de ese tipo depende lo
# que puede hacer con él. Con cuatro tipos cubres el 95 % de la asignatura.

# 1) Numérico: números, con o sin decimales.
71
36.8

# 2) Texto (en programación se llama "cadena de caracteres" o string).
#    Siempre entre comillas.
"P01"
"neumologia"

# 3) Lógico: solo dos valores posibles, verdadero o falso.
#    En R se escriben en MAYÚSCULAS y sin comillas.
TRUE
FALSE

# 4) Ausente: el dato que no está. En R se escribe NA (Not Available).
#    Es un valor especial: NO es cero, NO es texto vacío, es "no lo sé".
NA

# class() responde: ¿de qué tipo es esto?
class(71)
class("P01")
class(TRUE)
class(NA)

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | class() devuelve, en este orden: "numeric", "character", "logical" y
# | "logical" (el NA sin más se considera logico por defecto).
# | Por que importa: R deja sumar numeros pero no textos, y en cuanto un NA
# | entra en un calculo lo contamina entero.
# | En datos clinicos el NA es común: analiticas no hechas, campos sin
# | rellenar, etc.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 3. Variables: ponerle nombre a un dato
# En la guía: «Variables y operadores».
# -------------------------------------------------------------
# Una VARIABLE es una etiqueta pegada a un valor. Sirve para no repetir el
# dato y para que el código se lea como una frase.
# En R la asignación se escribe con  <-  (una flecha: "esto va a parar ahí").
# También funciona = , pero la convención del lenguaje es <- y la usaremos
# en toda la asignatura. En RStudio hay un atajo: Alt + guion (en Mac,
# Option + guion).
peso_kg <- 78
talla_m <- 1.72
id_paciente <- "P01"

# Para ver el contenido de una variable basta con escribir su nombre. Lo verás en la consola.
peso_kg
id_paciente

# Una variable se puede usar dentro de un cálculo. R sustituye el nombre
# por su valor y luego opera.
imc <- peso_kg / (talla_m^2)
imc

# Y se puede reasignar: la etiqueta se despega de un valor y se pega a otro.
peso_kg <- 80
peso_kg

# OJO: el IMC calculado antes NO se recalcula solo. Guarda el resultado del
# momento en que se ejecutó, no la fórmula. Esta es una de las confusiones
# más frecuentes al empezar (una hoja de cálculo sí lo recalcularía).
imc

# Reglas para nombrar: empieza por letra, sin espacios ni acentos ni signos,
# y en minúsculas separando palabras con guion bajo (edad_paciente, pcr_basal).
# El nombre no tiene ningún significado para R: se lo das tú, para tu yo futuro.

# ls() enumera lo que hay creado ahora mismo en la sesión (el "entorno").
ls()

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | peso_kg imprime 78 la primera vez y 80 despues de reasignarlo.
# | imc imprime 26.3656 las DOS veces, también después de cambiar el peso:
# | es un valor ya calculado, no una formula viva. Para actualizarlo hay que
# | volver a ejecutar la linea del calculo.
# | ls() devuelve los nombres creados hasta ahora: "id_paciente", "imc",
# | "peso_kg", "talla_m". Es lo mismo que ves en el panel Environment.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 4. Operadores: calcular y comparar
# En la guía: «Variables y operadores».
# -------------------------------------------------------------
# Aritméticos: los de toda la vida, más la potencia (^) y el resto (%%).
5 + 3
5 - 3
5 * 3
5 / 3
5^2
7 %% 2          # resto de dividir 7 entre 2

# Comparación: preguntan algo y devuelven TRUE o FALSE. Esto es la base de
# todos los filtros que harás en la asignatura.
edad <- 71
edad > 65
edad < 65
edad >= 71
edad == 71      # ATENCION: dos signos igual para PREGUNTAR si son iguales
edad != 71      # distinto de

# El error clásico: un solo = asigna, dos == comparan. Si escribes
# edad = 65 no estas preguntando nada: estas cambiando la edad a 65.

# Lógicos: combinan condiciones.
#   &  quiere decir "y"  (tienen que cumplirse las dos)
#   |  quiere decir "o"  (basta con una)
#   !  quiere decir "no" (le da la vuelta)
saturacion <- 93
edad > 65 & saturacion < 92
edad > 65 | saturacion < 92
!(edad > 65)

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | Los aritmeticos dan 8, 2, 15, 1.666667, 25 y 1.
# | Con edad=71: edad>65 es TRUE, edad<65 es FALSE, edad>=71 es TRUE,
# | edad==71 es TRUE y edad!=71 es FALSE.
# | Con saturacion=93: "edad>65 Y saturacion<92" es FALSE (la segunda falla)
# | pero "edad>65 O saturacion<92" es TRUE (basta con la primera).
# | Lectura clinica: acabas de escribir un criterio de gravedad. Un algoritmo
# | de triaje no es mas que muchas de estas condiciones encadenadas.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 5. Funciones: qué son y cómo se leen
# -------------------------------------------------------------
# Una FUNCIÓN es una máquina: introduces "algo", hace su trabajo y te devuelve
# un resultado. Se escribe  nombre(argumentos)  y siempre lleva paréntesis.
#   - nombre: qué máquina quieres usar (round, mean, sqrt...).
#   - argumentos: lo que le das para trabajar, separados por comas.
#   - valor devuelto: lo que sale. Si no lo guardas en una variable, se
#     imprime y se pierde.

sqrt(64)              # raíz cuadrada
round(3.14159, 2)     # redondear a 2 decimales
nchar("neumologia")   # cuántos caracteres tiene un texto
toupper("uci")        # pasar a mayúsculas

# Los argumentos se pueden dar por POSICIÓN (en el orden que espera la
# función) o por NOMBRE (más largo de escribir, pero mucho más claro).
round(3.14159, 2)
round(x = 3.14159, digits = 2)

# Guardar el resultado en vez de dejar que se imprima:
imc_redondeado <- round(imc, 1)
imc_redondeado

# Las funciones se anidan: la de dentro se ejecuta primero y su resultado
# entra en la de fuera. Se leen de dentro hacia fuera.
round(sqrt(64), 1)

# Cuando no sepas qué hace una función o qué argumentos admite, pregúntale
# a R. Se abre la ayuda en el panel de la derecha. Descomenta y ejecuta:
# ?round
# ?mean

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | sqrt(64) da 8; round(3.14159, 2) da 3.14; nchar("neumologia") da 10;
# | toupper("uci") da "UCI". Las dos formas de llamar a round dan lo mismo.
# | imc_redondeado guarda 26.4 (el IMC del Bloque 3 redondeado a 1 decimal).
# | round(sqrt(64), 1) da 8: primero la raiz, luego el redondeo.
# | Idea clave: casi todo lo que haras en esta asignatura es llamar a
# | funciones que otras personas ya han escrito y comprobado.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 6. Vectores: muchos datos en una sola caja
# En la guía: «Vectores y la tabla de datos».
# -------------------------------------------------------------
# Hasta ahora cada variable guardaba UN valor. Un VECTOR guarda una serie
# de valores del mismo tipo. Es la estructura básica de R y la razón por la
# que R resulta tan cómodo para trabajar con datos clínicos.
# Se construye con c(), de "combinar".
edades <- c(71, 58, 84, 46, 67, 79, 52, 90, 63, 75)
edades

# Funciones de resumen: se aplican al vector ENTERO de una vez.
length(edades)     # cuántos elementos hay
mean(edades)       # media
median(edades)     # mediana
sd(edades)         # desviación típica
min(edades)
max(edades)
range(edades)      # mínimo y máximo juntos
summary(edades)    # resumen de seis números

# Acceso por posición. En R se cuenta desde 1 (en Python, desde 0: es la
# diferencia que más despistes provoca al pasar de un lenguaje al otro).
edades[1]          # el primero
edades[10]         # el décimo
edades[c(1, 3, 5)] # varios a la vez

# Aritmética vectorizada: al operar sobre un vector, R opera sobre TODOS
# sus elementos sin que tengas que pedirlo. Esto es lo que hace que en R
# casi nunca necesites escribir bucles.
edades + 1
edades / 10

# Filtrado lógico: la comparación devuelve un vector de TRUE/FALSE, y ese
# vector se usa como máscara para quedarse con lo que interesa.
edades > 70                # la máscara
edades[edades > 70]        # los valores que la cumplen
sum(edades > 70)           # cuántos la cumplen (TRUE cuenta como 1)
mean(edades > 70)          # qué proporción la cumple

# Los vectores de texto y lógicos funcionan igual.
sexo <- c("H", "M", "M", "H", "H", "M", "H", "M", "H", "M")
table(sexo)                # tabla de frecuencias

# Y ahora el NA en acción. Basta un ausente para que la media no se pueda
# calcular: R prefiere devolver NA antes que darte un número engañoso.
pcr_con_hueco <- c(184.8, 44.6, NA, 12.5, 96.0)
mean(pcr_con_hueco)
mean(pcr_con_hueco, na.rm = TRUE)   # na.rm = "quita los NA antes de calcular"
is.na(pcr_con_hueco)                # ¿cuáles faltan?
sum(is.na(pcr_con_hueco))           # cuántos faltan

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | Sobre las 10 edades: length=10, media=68.5, mediana=69, sd=14.1,
# | min=46, max=90. summary() enseña de golpe el mínimo, los cuartiles, la
# | mediana, la media y el máximo (length y sd se piden aparte).
# | edades[1] da 71 y edades[10] da 75 (el ultimo).
# | edades>70 devuelve 10 valores TRUE/FALSE; edades[edades>70] devuelve
# | 71, 84, 79, 90 y 75; sum(...) da 5 y mean(...) da 0.5 (el 50 %).
# | table(sexo) da H=5 y M=5.
# | mean(pcr_con_hueco) devuelve NA (el ausente contamina el resultado) y
# | con na.rm=TRUE devuelve 84.475. is.na() marca TRUE solo en la 3a posicion.
# | Regla de oro: si un calculo te devuelve NA sin motivo aparente, lo
# | primero que hay que mirar es si hay ausentes en los datos.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 7. La tabla de datos (data frame)
# En la guía: «Vectores y la tabla de datos».
# -------------------------------------------------------------
# Un DATA FRAME es una tabla: varias columnas (vectores) de la misma
# longitud puestas una al lado de otra. Cada FILA es un caso (un paciente)
# y cada COLUMNA una variable. Es el formato de trabajo de toda la asignatura.
# Aquí lo construimos a mano con 10 pacientes ficticios; en la Parte 2
# lo leeremos ya hecho desde un archivo.
pacientes <- data.frame(
  id_paciente = c("P01", "P02", "P03", "P04", "P05",
                  "P06", "P07", "P08", "P09", "P10"),
  sexo = c("H", "M", "M", "H", "H", "M", "H", "M", "H", "M"),
  edad = c(71, 58, 84, 46, 67, 79, 52, 90, 63, 75),
  peso_kg = c(78, 64, 55, 92, 81, 60, 70, 48, 88, 67),
  talla_m = c(1.72, 1.60, 1.55, 1.80, 1.75, 1.58, 1.68, 1.50, 1.83, 1.62),
  pcr_mg_l = c(184.8, 44.6, 210.3, 12.5, 96.0, 155.2, 33.1, 240.7, 61.4, 128.9),
  saturacion_o2 = c(93, 96, 88, 98, 94, 90, 97, 86, 95, 91),
  ingreso_uci = c(0, 0, 1, 0, 0, 1, 0, 1, 0, 0)
)

# Primer vistazo obligatorio ante cualquier tabla nueva.
dim(pacientes)      # filas y columnas
nrow(pacientes)     # solo filas
ncol(pacientes)     # solo columnas
names(pacientes)    # nombres de las columnas
head(pacientes, 3)  # las 3 primeras filas
str(pacientes)      # estructura: cada columna con su tipo

# El símbolo $ entra en una columna concreta: tabla$columna.
pacientes$edad
mean(pacientes$edad)
mean(pacientes$pcr_mg_l)

# Selección por [fila, columna]. Dejar un hueco vacío significa "todas".
pacientes[1, ]              # fila 1 entera
pacientes[, "edad"]         # columna edad entera
pacientes[1, "edad"]        # el cruce de ambas: la edad del primer paciente
pacientes[1:3, c("id_paciente", "edad")]   # tres primeras filas, dos columnas

# Filtrar filas con una condición: la misma máscara lógica del bloque anterior,
# ahora aplicada a las filas de la tabla.
pacientes[pacientes$edad > 70, ]
pacientes[pacientes$saturacion_o2 < 92, c("id_paciente", "saturacion_o2")]

# Crear una columna nueva: se nombra con $ y se le asigna el cálculo.
# Fijate en que el calculo se hace sobre las 10 filas de una sola vez.
pacientes$imc <- round(pacientes$peso_kg / (pacientes$talla_m^2), 1)
pacientes$imc

# Y la primera pregunta con forma de investigación: ¿los que ingresaron en
# UCI eran distintos de los que no?
mean(pacientes$edad[pacientes$ingreso_uci == 1])
mean(pacientes$edad[pacientes$ingreso_uci == 0])
mean(pacientes$pcr_mg_l[pacientes$ingreso_uci == 1])
mean(pacientes$pcr_mg_l[pacientes$ingreso_uci == 0])

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | dim() da 10 filas x 8 columnas (9 despues de crear el IMC). str() muestra
# | que id_paciente y sexo son "chr" (texto) y el resto "num" (numerico).
# | mean(pacientes$edad) da 68.5 y mean(pacientes$pcr_mg_l) da 116.75.
# | El filtro por edad>70 devuelve 5 filas; el de saturacion<92 devuelve 4
# | pacientes (P03, P06, P08 y P10).
# | La columna imc calculada vale 26.4, 25.0, 22.9, 28.4, 26.4, 24.0, 24.8,
# | 21.3, 26.3 y 25.5.
# | Y el resultado interesante: la edad media es 84.3 en los 3 que fueron a
# | UCI frente a 61.7 en los 7 que no; la PCR media, 202.1 frente a 80.2.
# | Los que ingresaron en UCI eran mas mayores y con mas inflamacion.
# | Eso es exactamente lo que encontraras en la cohorte simulada de 1.800
# | pacientes a partir del primer laboratorio con datos. Acabas de hacer, con 10 filas y
# | R base, la version en miniatura del analisis de todo el curso.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 8. Condicionales: traducir una regla clínica a código
# En la guía: «Condicionales y bucles».
# -------------------------------------------------------------
# if / else ejecuta un trozo de código SOLO si se cumple una condición.
# La condición va entre paréntesis y el código a ejecutar entre llaves {}.
imc_paciente <- 26.4

if (imc_paciente < 18.5) {
  print("Bajo peso")
} else if (imc_paciente < 25) {
  print("Normopeso")
} else if (imc_paciente < 30) {
  print("Sobrepeso")
} else {
  print("Obesidad")
}

# Cómo se lee: R evalúa las condiciones de arriba abajo y se queda con la
# PRIMERA que resulta verdadera; las demás ni las mira. Por eso el orden
# importa y por eso no hace falta escribir "entre 25 y 30": si hemos llegado
# a esa línea es porque ya sabemos que no era menor de 25.

# Un if solo mira UN valor. Para clasificar las 10 filas de golpe se usa la
# versión vectorizada. ifelse() es el "si... entonces... si no..." aplicado
# a un vector entero.
pacientes$satura_mal <- ifelse(pacientes$saturacion_o2 < 92, "si", "no")
table(pacientes$satura_mal)

# Y cut() parte una variable numérica en categorías por puntos de corte.
# Es la forma natural de crear grupos de edad, estadios o cualquier
# clasificación clínica por umbrales.
pacientes$grupo_imc <- cut(pacientes$imc,
                           breaks = c(0, 18.5, 25, 30, Inf),
                           labels = c("Bajo peso", "Normopeso",
                                      "Sobrepeso", "Obesidad"),
                           right = FALSE)
table(pacientes$grupo_imc)

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | El if/else imprime "Sobrepeso": 26.4 no es menor que 18.5 ni que 25,
# | pero sí es menor que 30.
# | table(satura_mal) da "no"=6 y "si"=4.
# | table(grupo_imc) da Bajo peso=0, Normopeso=4, Sobrepeso=6, Obesidad=0.
# | El argumento right=FALSE hace que los intervalos sean [inicio, fin), es
# | decir cerrados por abajo y abiertos por arriba: un IMC de exactamente
# | 25.0 cae en "Sobrepeso", igual que en la definicion clinica.
# | (Ojo: sin el round() del Bloque 7, P02 daría 24.999999999999996, por cómo
# | guarda el ordenador los decimales, y caería en "Normopeso".)
# | Detalle que ahorra disgustos: cuando definas cortes, decide siempre a
# | que lado cae el valor exacto del limite y dejalo escrito.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 9. Bucles: repetir sin repetirse
# En la guía: «Condicionales y bucles».
# -------------------------------------------------------------
# Un BUCLE for recorre una colección y ejecuta lo mismo con cada elemento.
# Se lee: "para cada X dentro de esta lista, haz esto".
for (e in edades) {
  cat("Edad:", e, "\n")
}

# Muy a menudo se recorre por posición, no por valor, para poder leer
# varias columnas de la misma fila. seq_len(3) genera 1, 2, 3 (con
# seq_len(nrow(pacientes)) recorrerías todas las filas).
for (i in seq_len(3)) {
  cat("Paciente", pacientes$id_paciente[i],
      "- edad", pacientes$edad[i],
      "- IMC", pacientes$imc[i], "\n")
}

# Patrón clásico: un acumulador que se va llenando dentro del bucle.
suma <- 0
for (e in edades) {
  suma <- suma + e
}
suma
suma / length(edades)

# Y ahora lo importante. Ese bucle entero se escribe en R así:
sum(edades)
mean(edades)

# Los dos caminos dan el mismo número. En R, y también en Python, la versión
# sin bucle es más corta, más fácil de leer y muchísimo más rápida cuando
# los datos crecen. Con 10 pacientes da igual; con un millón, no da igual en
# absoluto. Esa diferencia se mide con un cronómetro en la Parte 2 y
# es la puerta de entrada al Big Data.
# Conclusión práctica: aprende a escribir bucles (los vas a leer en código de
# otras personas), pero por defecto busca primero la versión vectorizada.

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | El primer bucle imprime 10 lineas "Edad: 71", "Edad: 58"... hasta 75.
# | El segundo imprime 3 lineas con id, edad e IMC de P01, P02 y P03.
# | El acumulador deja suma=685 y suma/length(edades)=68.5, exactamente lo
# | mismo que devuelven sum(edades) y mean(edades).
# | Mismo resultado, mucho menos codigo. Recuerda esta comparacion.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 10. Escribir tu propia función
# En la guía: «Funciones propias y errores».
# -------------------------------------------------------------
# Cuando repites tres veces el mismo cálculo, conviene empaquetarlo con un
# nombre. Eso es escribir una función. La estructura es siempre la misma:
#   nombre <- function(parametros) { cuerpo; valor que devuelve }
# La palabra reservada es function. Los PARÁMETROS son los huecos que
# rellenarás al llamarla. En R, la función devuelve la última expresión
# evaluada, aunque escribir return() explícito se lee mejor.

calcular_imc <- function(peso, talla) {
  resultado <- peso / (talla^2)
  return(round(resultado, 1))
}

# Llamarla es exactamente igual que llamar a round() o a mean():
calcular_imc(78, 1.72)
calcular_imc(peso = 48, talla = 1.50)

# Otra función, esta vez para clasificar a partir de un IMC ya calculado:
clasificar_imc <- function(imc) {
  if (is.na(imc)) {
    return(NA)
  } else if (imc < 18.5) {
    return("Bajo peso")
  } else if (imc < 25) {
    return("Normopeso")
  } else if (imc < 30) {
    return("Sobrepeso")
  } else {
    return("Obesidad")
  }
}

clasificar_imc(26.4)
clasificar_imc(17.2)
clasificar_imc(NA)
clasificar_imc(calcular_imc(48, 1.50))   # una función dentro de otra: "Normopeso"

# Fíjate en que la primera comprobación es "¿es un ausente?". Prever el NA
# desde el principio evita la mitad de los errores en datos clínicos reales.

# sapply() aplica una función a cada elemento de un vector y recoge las
# respuestas. Es la alternativa idiomática al bucle for cuando el objetivo
# es transformar, no imprimir.
sapply(pacientes$imc, clasificar_imc)

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | calcular_imc(78, 1.72) da 26.4 y calcular_imc(48, 1.50) da 21.3, los
# | mismos valores que ya habia en la columna imc.
# | clasificar_imc devuelve "Sobrepeso", "Bajo peso" y NA.
# | sapply(...) devuelve las 10 clasificaciones: 6 "Sobrepeso" y 4 "Normopeso".
# | Idea de fondo: una funcion es una regla escrita UNA vez y aplicada
# | MUCHAS. Si manana cambian los puntos de corte, tocas un solo sitio.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 11. El error forma parte del oficio
# En la guía: «Funciones propias y errores».
# -------------------------------------------------------------
# Este bloque provoca errores A PROPÓSITO. Todo el mundo que programa ve
# mensajes rojos constantemente: no significan que hayas roto nada ni que
# se te dé mal. Son la forma que tiene R de decirte, con bastante precisión,
# qué no ha entendido. Aprender a leerlos es la habilidad que más tiempo te
# va a ahorrar en todo el curso.
#
# Usamos try() para que el error se muestre pero el script continúe.
# Si tu ordenador está en español, verás estos mensajes traducidos (a veces a
# medias): por ejemplo "objeto 'edda' no encontrado". El sentido es el mismo.

# ERROR 1. Objeto que no existe (casi siempre, una errata en el nombre).
try(print(edda))

# ERROR 2. Función que no existe (errata en el nombre de la función).
try(medi(edades))

# ERROR 3. Tipo equivocado: sumar texto y número.
try("3" + 4)

# ERROR 4. Argumento mal escrito.
try(round(3.14159, digitos = 2))

# ERROR 5. Y el más traicionero: el que NO da error.
# Pedir la posición 20 de un vector de 10 elementos no protesta: devuelve NA.
edades[20]

# Paréntesis y comillas sin cerrar merecen mención aparte porque no llegan a
# ejecutarse: si escribes  mean(edades   y pulsas Enter, la consola pasa a
# mostrar un signo + en vez del habitual > . Ese + significa "sigo esperando,
# tienes algo sin cerrar". Se sale pulsando la tecla Escape.

# Un aviso (Warning) no es un error: la orden SÍ se ha ejecutado, pero R te
# advierte de algo. Aquí intenta convertir texto a número y no puede.
as.numeric("hola")

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | 1) "object 'edda' not found": R busca un objeto con ese nombre exacto y
# |    no lo encuentra. Revisa la ortografia y las mayusculas (R distingue
# |    edad de Edad), y comprueba si llegaste a ejecutar la linea que lo creaba.
# | 2) 'could not find function "medi"': lo mismo pero con una funcion.
# |    O está mal escrita, o vive en un paquete que no has cargado.
# | 3) "non-numeric argument to binary operator": has pedido una operacion
# |    aritmetica con algo que no es un numero. El "3" entre comillas es texto.
# | 4) "unused argument (digitos = 2)": el argumento se llama digits, no
# |    digitos. R no adivina; ?round te dice el nombre exacto.
# | 5) edades[20] devuelve NA sin protestar. Este es el peligroso: el codigo
# |    sigue corriendo con un ausente dentro y el problema aparece tres pasos
# |    despues. Comprueba SIEMPRE las dimensiones con dim() o length().
# | 6) as.numeric("hola") devuelve NA con el aviso "NAs introduced by
# |    coercion": no es un error, es R avisando de que ha metido un ausente.
# | Metodo para depurar, en este orden: (a) lee la ULTIMA linea del mensaje,
# | (b) mira el nombre que aparece entrecomillado, (c) ejecuta por separado
# | los trozos de la orden para ver cual falla, (d) comprueba que el objeto
# | existe y es del tipo que crees.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 12. Comprueba que lo has seguido
# -------------------------------------------------------------
# stopifnot() no hace nada si todo va bien y se detiene con un error si algo
# no cuadra. Es un CHECKPOINT: una forma de que el propio código te diga si
# vas bien, sin tener que comparar números a ojo. Los verás a lo largo del curso.
stopifnot(nrow(pacientes) == 10)
stopifnot(ncol(pacientes) >= 9)
stopifnot(round(mean(pacientes$edad), 1) == 68.5)
stopifnot(sum(pacientes$ingreso_uci) == 3)
stopifnot(all(!is.na(pacientes$imc)))
cat("CHECKPOINT SUPERADO: la tabla tiene 10 pacientes, 3 en UCI y el IMC calculado.\n")

# Y ahora hazlo tú, con lo que ya sabes. Tapa la solución, escríbela a tu
# manera y luego descomenta las dos líneas (Ctrl + Shift + C) para comprobarla:
# si tu respuesta es correcta, el stopifnot de debajo no protestará.

# 1) Guarda en 'edad_maxima' la edad más alta de la tabla.
# edad_maxima <- max(pacientes$edad)
# stopifnot(edad_maxima == 90)

# 2) Guarda en 'n_hombres' cuántos pacientes son hombres.
# n_hombres <- sum(pacientes$sexo == "H")
# stopifnot(n_hombres == 5)

# 3) Guarda en 'pcr_media_uci' la PCR media de los que ingresaron en UCI.
# pcr_media_uci <- mean(pacientes$pcr_mg_l[pacientes$ingreso_uci == 1])
# stopifnot(round(pcr_media_uci, 1) == 202.1)

# +-- INTERPRETACION DE RESULTADOS --------------------------
# | Si todo ha ido bien veras el mensaje "CHECKPOINT SUPERADO" y ningun error.
# | Si stopifnot se detiene, el mensaje te dice exactamente que condicion ha
# | fallado: vuelve al bloque correspondiente y reejecutalo.
# | Los tres retos ya llevan la solucion escrita a proposito: este laboratorio
# | es para entender, no para lucirse. Tapa la linea, intentalo, y comparala.
# +---------------------------------------------------------


# -------------------------------------------------------------
# Bloque 13. Lo mismo, en Python
# -------------------------------------------------------------
# En esta asignatura conviven R y Python. No son dos mundos distintos: son
# dos formas de decir las mismas cosas. Esta tabla es tu diccionario.
#
#   IDEA                        R                        PYTHON
#   ------------------------    ----------------------   -----------------------
#   Comentario                  # texto                  # texto
#   Asignar                     x <- 5                   x = 5
#   Mostrar                     print(x)                 print(x)
#   Verdadero / falso           TRUE / FALSE             True / False
#   Ausente                     NA                       None / NaN
#   Tipo de un objeto           class(x)                 type(x)
#   Serie de valores            c(1, 2, 3)               [1, 2, 3]
#   Primer elemento             x[1]                     x[0]      (¡desde 0!)
#   Cuantos elementos           length(x)                len(x)
#   Media                       mean(x)                  st.mean(lista) / serie.mean()
#   Tabla de datos              data.frame(...)          pd.DataFrame(...)
#   Una columna                 tabla$edad               tabla["edad"]
#   Filtrar filas               tabla[tabla$edad>70, ]   tabla[tabla.edad>70]
#   Condicional                 if (c) { } else { }      if c: ... else: ...
#   Bucle                       for (i in v) { }         for i in v: ...
#   Definir funcion             f <- function(x) { }     def f(x): ...
#   Instalar / cargar           install.packages/library pip install / import
#
# Las dos diferencias que más despistan al principio:
#   1) R cuenta desde 1 y Python desde 0.
#   2) R delimita los bloques con llaves {} y Python con la SANGRÍA (los
#      espacios al principio de la línea). En Python la sangría no es
#      estética: es sintaxis, y si te equivocas el programa no arranca.
#
# Consejo para el curso: elige UN lenguaje y quédate en él. El otro está
# aquí como espejo, para que reconozcas el código cuando lo veas, no para
# que hagas todo dos veces.

# =============================================================
# Fin de la Parte 1.
# Siguiente paso: Parte 2 (leer datos de un archivo, organizar un
# proyecto reproducible y ver por que la velocidad importa cuando los datos
# crecen) y, si quieres, la Parte 3 (opcional), con el tidyverse.
# =============================================================
