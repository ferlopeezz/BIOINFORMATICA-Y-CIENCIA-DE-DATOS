##########################################################################################
#####################                                                  ###################
#####################    TRABAJO ORDINARIA BIOINFORMÁTICA R            ###################
#####################                                                  ###################
##########################################################################################

# Alumno: Miguel Fernández López
# NP: 153718

autor <- "Miguel Fernández López - NP: 153718"
cat("Trabajo realizado por:", autor, "\n")


# Uso azul y naranja porque se distinguen bien con daltonismo tipo deuteranopia
# (evito la combinación rojo-verde, que es la que se confunde)
color_control   <- "#0072B2"   # azul
color_condicion <- "#E69F00"   # naranja


##### 1.- CARGAR EL ARCHIVO Y EXAMINARLO

# El archivo está separado por tabuladores y la primera fila son los nombres de las columnas,
# por eso uso sep="\t" y header=TRUE. Con row.names=1 la primera columna (el nombre del gen)
# pasa a ser el nombre de las filas
datos <- read.table("archivo-entrada.txt", sep = "\t", header = TRUE, row.names = 1)

head(datos)
tail(datos)
dim(datos)   # 619 genes (filas) y 6 columnas (3 control + 3 condición)

# Las 3 primeras columnas son el Control (C2, C1, C3) y las 3 últimas la Condición

control   <- datos[, 1:3]
condicion <- datos[, 4:6]
class(control)


##### 2.- MEDIA Y DESVIACIÓN ESTÁNDAR DE CADA GEN

# Uso apply con margin = 1 porque quiero hacerlo por filas (un valor por gen)
media_control   <- apply(control, 1, mean)
sd_control      <- apply(control, 1, sd)
media_condicion <- apply(condicion, 1, mean)
sd_condicion    <- apply(condicion, 1, sd)

head(media_control)
head(sd_control)
head(media_condicion)
head(sd_condicion)

# Añado las 4 columnas nuevas a la tabla original
datos$Media_Control   <- media_control
datos$SD_Control      <- sd_control
datos$Media_Condicion <- media_condicion
datos$SD_Condicion    <- sd_condicion

head(datos)
dim(datos)   # ahora tiene 10 columnas


##### 3.- HISTOGRAMAS DE LAS MEDIAS (EN UNA SOLA IMAGEN)

# Hay genes con valores muy altos y otros muy bajos,
# así que para los gráficos uso la transformación log2
# La transformación solo la uso para los gráficos, los cálculos van con los datos originales.

par(mfrow = c(1, 2))   # 1 fila y 2 columnas para meter los dos gráficos en la misma imagen

hist(log2(media_control + 1), col = color_control,
     main = "Histograma de la media del Control",
     xlab = "log2(media TPM + 1)", ylab = "Frecuencia",
     sub = autor)

hist(log2(media_condicion + 1), col = color_condicion,
     main = "Histograma de la media de la Condición",
     xlab = "log2(media TPM + 1)", ylab = "Frecuencia",
     sub = autor)

par(mfrow = c(1, 1))   # vuelvo a dejar la ventana gráfica normal


##### 4.- BOXPLOT DE CONTROL Y CONDICIÓN
limite_y <- max(log2(media_control + 1), log2(media_condicion + 1)) + 4

boxplot(log2(media_control + 1), log2(media_condicion + 1),
        names = c("Control", "Condición"),
        col = c(color_control, color_condicion),
        main = "Boxplot de la expresión media: Control vs Condición",
        ylab = "log2(media TPM + 1)",
        ylim = c(0, limite_y),
        sub = autor)

legend("topleft", legend = c("Control", "Condición"),
       fill = c(color_control, color_condicion), title = "Grupo")


##### 5.- NORMALIDAD Y COMPARACIÓN DE MEDIAS

# Primero compruebo la normalidad con el test de Shapiro-Wilk (H0: los datos son normales).
# Cojo todos los valores del control juntos y todos los de la condición juntos
valores_control   <- as.numeric(as.matrix(control))
valores_condicion <- as.numeric(as.matrix(condicion))

shapiro_control   <- shapiro.test(valores_control)
shapiro_condicion <- shapiro.test(valores_condicion)
shapiro_control
shapiro_condicion

# Si el p-value es menor que 0.05 rechazo H0, es decir, NO son normales.
# Si los dos grupos fueran normales uso t.test; si no, el test no paramétrico wilcox.test
if (shapiro_control$p.value > 0.05 & shapiro_condicion$p.value > 0.05) {
  normalidad <- TRUE
  print("Los datos son normales: uso t.test")
} else {
  normalidad <- FALSE
  print("Los datos NO son normales: uso wilcox.test")
}

# Las muestras son independientes (control y condición son grupos distintos)
# Uso los datos SIN transformar.
# (suppressWarnings es porque wilcox.test avisa de que hay empates, ya que hay muchos ceros,
# y salen muchos avisos y lo he tenido que buscar para ver como quitarlo.)
pvalue <- NULL
for (i in 1:nrow(datos)) {   # para cada gen
  x <- as.numeric(control[i, ])     # 3 réplicas del control del gen i
  y <- as.numeric(condicion[i, ])   # 3 réplicas de la condición del gen i

  if (normalidad) {
    test <- t.test(x, y)
  } else {
    test <- suppressWarnings(wilcox.test(x, y))
  }

  pvalue[i] <- test$p.value
}

head(pvalue)
length(pvalue)   
# Añado el p-value como columna nueva a la tabla original
datos$Pvalue <- pvalue
head(datos)
dim(datos)


##### 6.- GENES DIFERENCIALMENTE EXPRESADOS (pvalue < 0.05)

filtro_p <- pvalue < 0.05
genes_DE <- datos[filtro_p, ]
nrow(genes_DE)        # número de genes diferencialmente expresados
rownames(genes_DE)    # listado de los genes

# Diferencia de medias (Condición - Control): si es positiva el gen está más expresado
# en la Condición (sobreexpresado) y si es negativa está reprimido
diferencia <- datos$Media_Condicion - datos$Media_Control

sobreexpresados <- filtro_p & diferencia > 0
reprimidos      <- filtro_p & diferencia < 0

sum(sobreexpresados)
sum(reprimidos)
rownames(datos)[sobreexpresados]
rownames(datos)[reprimidos]

# Para justificar el resultado miro cuál es el p-value más pequeño que sale
min(pvalue)
sum(pvalue < 0.1)   

# También pruebo con la corrección de p-values que vimos en clase Benjamini-Hochberg
sum(p.adjust(pvalue, method = "BH") < 0.05)

cat("\nJUSTIFICACIÓN:\n")
cat("Los datos no son normales (Shapiro con p-value muy pequeño), así que se usa wilcox.test.\n")
cat("Pero solo hay 3 réplicas por grupo, y con 3 vs 3 solo existen 20 formas posibles de\n")
cat("ordenar las muestras (choose(6,3) = 20). Aunque un gen separe perfectamente el control\n")
cat("de la condición, el p-value más pequeño posible es 2/20 = 0.1 (o alrededor de 0.06 si\n")
cat("R usa la aproximación normal por los empates). En ambos casos es mayor que 0.05, por lo\n")
cat("que ningún gen puede salir significativo, aunque haya mucha diferencia entre las medias.\n")
cat("Es un problema del tamaño de muestra, no de que los genes no cambien.\n\n")


##### 7.- HEATMAP

# Para el heatmap necesito los paquetes gplots 
#install.packages("gplots")
#install.packages("RColorBrewer")
library(gplots)
library(RColorBrewer)

# Como con pvalue < 0.05 no sale ningún gen, no se puede hacer el heatmap con una tabla vacía.
# Entonces, si no hay genes diferencialmente expresados, uso los 40 genes con el p-value
# más pequeño (los supuesto mejores candidatos).
if (nrow(genes_DE) > 0) {
  genes_heatmap <- genes_DE
  titulo <- "Heatmap de los genes diferencialmente expresados"
} else {
  orden <- order(pvalue)               # posiciones de los genes ordenados de menor a mayor p-value
  genes_heatmap <- datos[orden[1:40], ]
  titulo <- "Heatmap de los 40 genes con menor p-value (ninguno con p < 0.05)"
}
dim(genes_heatmap)

# Cojo solo las 6 columnas de las muestras y las transformo con log2 (+1 por los ceros),
# porque es para un gráfico. Lo convierto en matriz como haciamos en clase
matriz <- log2(as.matrix(genes_heatmap[, 1:6]) + 1)
colnames(matriz) <- c("Control C2", "Control C1", "Control C3",
                      "Cond 1W5-TPM", "Cond 1W6-TPM", "Cond 1W5-COV")
head(matriz)



# Colores del heatmap: azul (valores bajos) -> blanco -> naranja (valores altos).

colores_heatmap <- colorRampPalette(c("#0072B2", "white", "#E69F00"))(100)

colores_muestras <- c(rep(color_control, 3), rep(color_condicion, 3))

heatmap.2(matriz, Rowv = TRUE, Colv = TRUE, cexCol = 0.8, cexRow = 0.6,
          col = colores_heatmap, scale = "row", trace = "none",
          density.info = "none", ColSideColors = colores_muestras,
          margins = c(9, 8),
          main = paste(titulo, "\n", autor), cex.main = 0.8)
# Barra de arriba: azul = Control, naranja = Condición
legend("topright", legend = c("Control", "Condición"),
       fill = c(color_control, color_condicion), cex = 0.7, bty = "n")


write.table(datos, "resultado_trabajo.txt", sep = "\t", quote = FALSE)
