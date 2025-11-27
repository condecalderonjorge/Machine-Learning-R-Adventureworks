#### Llamamos a las librerías necesarias para la realización de la actividad ####
library(forecast)
library(ggplot2)
library(lattice)
library(future)
library(caret)
library(rpart)
library(rpart.plot)
library(caTools)
library(dplyr)
library(psych)
library(factoextra)
library(NbClust)
#### Importamos los datos que vamos a usar ####
# Pestaña ST Ventas totales
library(readxl)
Datos_Ventas <- read_excel("G:/Mi unidad/Máster - Inteligencia de Negocio/1. Análisis de Datos Masivos para el Negocio (INTENE - E) - PER 11408/Actividad 3/Actividad03_ADM/DataSet SQL Analisis Masivo de Datos.xlsx", 
                                                   sheet = "ST Ventas Totales ")
View(DataSet_SQL_Analisis_Masivo_de_Datos)
# Pestaña Var Discreta Adq Bicicleta
library(readxl)
Datos_Clientes <- read_excel("G:/Mi unidad/Máster - Inteligencia de Negocio/1. Análisis de Datos Masivos para el Negocio (INTENE - E) - PER 11408/Actividad 3/Actividad03_ADM/DataSet SQL Analisis Masivo de Datos.xlsx", 
                                                   sheet = "Var Discreta Adq Bicicleta")
View(DataSet_SQL_Analisis_Masivo_de_Datos)
# Hacemos copia de ambos set de datos
cclientes <- Datos_Clientes
cventas <- Datos_Ventas
# Comprobamos si existen datos faltantes
which(is.na(cclientes))
colSums(is.na(cclientes))
# Transformamos las variables tipo character en variables numéricas
# MaritalStatus (Casado = 1; Soltero = 0)
unique(cclientes$MaritalStatus)
cclientes$MaritalStatus[cclientes$MaritalStatus == "M"] <- 1
cclientes$MaritalStatus[cclientes$MaritalStatus == "S"] <- 0
cclientes$MaritalStatus <- as.numeric(cclientes$MaritalStatus)
summary(cclientes$MaritalStatus)
# YearlyIncome
unique(cclientes$YearlyIncome)
cclientes$YearlyIncome[cclientes$YearlyIncome == "0-25000"] <- 1
cclientes$YearlyIncome[cclientes$YearlyIncome == "25001-50000"] <- 2
cclientes$YearlyIncome[cclientes$YearlyIncome == "50001-75000"] <- 3
cclientes$YearlyIncome[cclientes$YearlyIncome == "75001-100000"] <- 4
cclientes$YearlyIncome[cclientes$YearlyIncome == "greater than 100000"] <- 5
cclientes$YearlyIncome <- as.numeric(cclientes$YearlyIncome)
summary(cclientes$YearlyIncome)
# Gender
unique(cclientes$Gender)
cclientes$Gender[cclientes$Gender == "F"] <- 0
cclientes$Gender[cclientes$Gender == "M"] <- 1
cclientes$Gender <- as.numeric(cclientes$Gender)
summary(cclientes$Gender)
# Education
unique(cclientes$Education)
cclientes$Education[cclientes$Education == "Partial High School"] <- 0
cclientes$Education[cclientes$Education == "High School"] <- 1
cclientes$Education[cclientes$Education == "Partial College"] <- 2
cclientes$Education[cclientes$Education == "Graduate Degree"] <- 3
cclientes$Education[cclientes$Education == "Bachelors"] <- 4
cclientes$Education <- as.numeric(cclientes$Education)
summary(cclientes$Education)
# Occupation
unique(cclientes$Occupation)
cclientes$Occupation[cclientes$Occupation == "Manual"] <- 0
cclientes$Occupation[cclientes$Occupation == "Skilled Manual"] <- 1
cclientes$Occupation[cclientes$Occupation == "Clerical"] <- 2
cclientes$Occupation[cclientes$Occupation == "Professional"] <- 3
cclientes$Occupation[cclientes$Occupation == "Management"] <- 4
cclientes$Occupation <- as.numeric(cclientes$Occupation)
summary(cclientes$Occupation)
#### Análisis descriptivo de la base de datos ####
# Creamos un subset con las variables numéricas que nos interesan
cclientes_num <- select(cclientes,
                        TotalAmount,
                        BikePurchase,
                        Age,
                        MaritalStatus,
                        YearlyIncome,
                        Gender,
                        TotalChildren,
                        Education,
                        Occupation,
                        HomeOwnerFlag,
                        NumberCarsOwned)
# Análisis de las variables de clientes
str(cclientes_num)
summary(cclientes)
corPlot(cclientes_num, main = "Matriz de correlación", cex = 0.8, xlas = 2) # Matriz de correlación
summary(cclientes_num$TotalAmount) # Est. descriptivas TotalAmount
boxplot(cclientes_num) # Boxplot de todas las variables
boxplot(cclientes_num$TotalAmount) # Boxplot de TotalAmount
summary(cclientes_num$Age) #Est. descriptivas Age
boxplot(cclientes_num$Age) #Boxplot de Age
#### Modelos de clasificación ####
# Modelo de regresión logística
division <- sample.split(cclientes_num$BikePurchase, 
                         SplitRatio = 0.8) # Creamos la división para partir la BD en entrenamiento/test, ratio (80/20)
entrenamiento <- subset(cclientes_num, division == TRUE) # Creamos la partición de entrenamiento
test <- subset(cclientes_num, division == FALSE) # Creamos la partición de test
prop.table(table(cclientes_num$BikePurchase)) # Comprobamos las proporciones BD Original
prop.table(table(entrenamiento$BikePurchase)) # Comprobamos las proporcione subset entrenamiento
prop.table(table(test$BikePurchase)) # Comprobamos las proporciones subset test
# Estimamos el modelo con los datos de entrenamiento
logit_entrenamiento <- glm(BikePurchase~Age+
                                        MaritalStatus+
                                        YearlyIncome+
                                        Education+
                                        Occupation,
                                        data = entrenamiento, family = "binomial")
summary(logit_entrenamiento) # Lo visualizamos
prediccion_logit <- predict(logit_entrenamiento, type = "response") # Hacemos la predicción
prediccion_logit_cod <- ifelse(prediccion_logit > 0.5, 1, 0) # Codificamos los valores mayores a 0.5 como 1 y el resto com 0
confusionMatrix(as.factor(entrenamiento$BikePurchase), as.factor(prediccion_logit_cod)) # Realizamos la matriz de confusión
prediccion_logit_test <- predict(logit_entrenamiento,
                                 newdata = test,
                                 type = "response") # Repetimos la predicción con los datos test
prediccion_logit_test_cod <- ifelse(prediccion_logit_test > 0.5, 1, 0) # Codificamos
confusionMatrix(as.factor(test$BikePurchase), as.factor(prediccion_logit_test_cod)) # Matriz de confusión prediccion test par comparar métricas
# MOdelo de árbol de decisión
arbol_entrenamiento <- rpart(BikePurchase~Age+
                                          MaritalStatus+
                                          YearlyIncome+
                                          Education+
                                          Occupation,
                                          data = entrenamiento, method = "class")
summary(arbol_entrenamiento)
rpart.plot(arbol_entrenamiento)
pred_arbol_entrenamiento <- predict(arbol_entrenamiento,
                                    type = "class") # Hacemos la predicción con los datos de entrenamiento
confusionMatrix(as.factor(entrenamiento$BikePurchase), as.factor(pred_arbol_entrenamiento)) # Elaboramos la matriz de confusión
pred_arbol_test <- predict(arbol_entrenamiento,
                           newdata = test,
                           type = "class")
confusionMatrix(as.factor(test$BikePurchase), as.factor(pred_arbol_test))
#### Precisión de los modelos e importancia de las variables
# Modelo Logit
coef_logit <- coef(logit_entrenamiento) # Extraemos los coeficicentes
coef_logit <- coef_logit[-1] # Eliminamos la constante
importancia_coef_logit <- abs(coef_logit) # Nos quedamos con su valor absoluto
importancia_coef_logit_esc <- 100*importancia_coef_logit / max(importancia_coef_logit) # Los escalamos de 0 a 100
barplot(importancia_coef_logit_esc,
        main = "Importancia de las variables en el modelo Logit",
        col = "green",
        cex.names = 0.8,
        las = 2,
        ylab = "Puntutación escalada") # Gráfico de barras
# Árbol de decisión
importancia_arbol <- arbol_entrenamiento$variable.importance
barplot(importancia_arbol,
        main = "Importancia de las variables en el árbol de decisión",
        col = "blue")
#### Clusterización ####
cclientes_num2 <- cclientes_num[, -1] # Excluimos la variable TotalAmount del análisis
cor.plot(cclientes_num2, 
         main = "Matriz de Correlación", 
         cex = 0.8, 
         las = 2)
fviz_nbclust(cclientes_num2, kmeans, method = "wss") # Calculamos el nº óptimo de clusters utilizando el método del codo
NbClust(cclientes_num2, min.nc = 2, max.nc = 6, method = "kmeans")
cluster3 <- kmeans(cclientes_num2, 3) # Segmentamos en 3 clusters
cluster4 <- kmeans(cclientes_num2, 4) # Segmentamos en 4 clusters
arbol_cluster3 <- rpart(cluster3$cluster~cclientes_num2$BikePurchase+
                                        cclientes_num2$Age+
                                        cclientes_num2$MaritalStatus+
                                        cclientes_num2$YearlyIncome+
                                        cclientes_num2$Gender+
                                        cclientes_num2$TotalChildren+
                                        cclientes_num2$Education+
                                        cclientes_num2$Occupation+
                                        cclientes_num2$HomeOwnerFlag+
                                        cclientes_num2$NumberCarsOwned,
                                        method = "class") # Realizamos un árbol para interpretar la segmentación
rpart.plot(arbol_cluster3) # Lo visualizamos
#### Predicción ST ####
copia <- Datos_Ventas # Hacemos copia de los datos
copia_ts <- ts(copia$Sales...2, start = c(2011, 5, 31), frequency = 365) # cambiamos a serie temporal
plot(copia_ts, ylab = "Ventas", xlab = NULL) # Dibujamos la serie temporal
entrenamiento_ts <- copia[1:1063,] # Datos para predecir el modelo
entrenamiento_ts <- ts(entrenamiento_ts$Sales...2, start = c(2011, 5, 31), frequency = 365) # Le damos formato de ST
test_ts <- copia[1064:1124,] # Datos para validar el modelo
test_ts <- ts(test_ts$Sales...2, start = c(2014, 5, 1), frequency = 365) # Le damos formato de ST
plot(entrenamiento_ts)
plot(test_ts)
ARIMA <- auto.arima(entrenamiento_ts) # Estimamos el modelo ARIMA
prediccion_ARIMA <- forecast(ARIMA, 61) # Realizamos la predicción
plot(prediccion_ARIMA) # La visualizamos
linea_predicción <- prediccion_ARIMA$mean # Extraemos la línea de predicción
plot(test_ts) # Dibujamos los datos de validación
lines(linea_predicción, col = "red") # Dibujamos encima la línea de la predicción
accuracy(test_ts, linea_predicción) # Calculamos las métricas de precisión
ARIMA_completo <- auto.arima(copia_ts) # Estimamos el modelo ARIMA con todos los datos
prediccion_total <- forecast(ARIMA_completo, 61) # Hacemos la predicción con el modelo completo
plot(prediccion_total) # Lo dibujamos
linea_pred_total <- prediccion_total$mean # Extraemos la línea
plot(linea_pred_total, ylab = "Ventas", xlab = NULL) # La dibujamos
