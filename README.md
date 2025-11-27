# 📊 Análisis de Datos Masivos para el Negocio (AdventureWorks · R)

<<<<<<< HEAD
Este repositorio contiene el desarrollo completo de la **última actividad de la asignatura – Análisis de Datos Masivos para el Negocio**, utilizando datos derivados de AdventureWorks.  
Incluye **modelos predictivos, segmentación de clientes, análisis descriptivo y forecast de ventas** mediante **R**.

Su objetivo es demostrar competencias avanzadas en **tratamiento de datos, machine learning, estadística, R y analítica para negocio**.
=======
Este repositorio recoge la **última actividad para la asignatura – Análisis de Datos Masivos para el Negocio**, realizada sobre datos de *AdventureWorks*.  
El objetivo es demostrar competencias en **análisis de datos, machine learning clásico, segmentación de clientes y series temporales** utilizando **R**.
>>>>>>> 81d9ad8b757b0b25a3ca6610bcac0ee923229a72

---

## 1. 🎯 Objetivos del proyecto

- Analizar el perfil de clientes y su relación con la **compra de bicicletas**.
- Construir y comparar **modelos de clasificación**:
  - Regresión logística.
  - Árbol de decisión.
- Identificar segmentos mediante **k-means**.
- Analizar y predecir ventas diarias mediante **modelos de series temporales ARIMA**.
- Derivar conclusiones accionables para negocio a partir de evidencias cuantitativas.

---

## 2. 📁 Datos

Los datos utilizados están en: [DataSet_SQL_Analisis_Masivo_de_Datos.xlsx](data/DataSet_SQL_Analisis_Masivo_de_Datos.xlsx)

---

## 3. 📂 Estructura del repositorio

```text
.
├── data/
│   └── DataSet_SQL_Analisis_Masivo_de_Datos.xlsx
├── R/
│   └── 01_analisis_clientes_ventas_modelos.R
├── docs/
│   ├── Informe Análisis de datos masivos para el negocio.docx
└── README.md

---

## 4. 🔍 Flujo de trabajo analítico (resumen)

### 4.1. Preparación y exploración
- Importación de datos (`read_excel`), limpieza, recodificación.
- Detección de NA, outliers, correlaciones y `summary()`.
- Creación de dataset numérico para modelado.  

### 4.2. Modelos de clasificación
**Regresión logística**
- Train/test (80/20), `glm()`, matrices de confusión.
  
**Árbol de decisión**
- Modelo `rpart()`, visualización con `rpart.plot`.  

### 4.3. Importancia de variables
- Importancia en logística y árboles (Gini).
- Visualización con `barplot()`.  

### 4.4. Segmentación (K-means)
- Variables numéricas, número óptimo de clusters (`fviz_nbclust`, `NbClust`).
- Modelos 3–4 clusters y perfilado.  

### 4.5. Series temporales (ARIMA)
- Conversión a `ts()`, train/test.
- `auto.arima()`, `forecast()`, `accuracy()`.  

---

## 5. 📚 Librerías utilizadas (resumen)
`dplyr`, `psych`, `ggplot2`, `lattice`, `readxl`,  
`caret`, `rpart`, `rpart.plot`, `caTools`,  
`factoextra`, `NbClust`, `forecast`, `future`.




