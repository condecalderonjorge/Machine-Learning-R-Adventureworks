# 📊 Análisis de Datos Masivos para el Negocio (AdventureWorks · R)

Este repositorio contiene el desarrollo completo de la **última actividad de la asignatura – Análisis de Datos Masivos para el Negocio**, utilizando datos derivados de AdventureWorks.  
Incluye **modelos predictivos, segmentación de clientes, análisis descriptivo y forecast de ventas** mediante **R**.

Su objetivo es demostrar competencias avanzadas en **tratamiento de datos, machine learning, estadística, R y analítica para negocio**.

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

Los datos utilizados están en: [DataSet SQL Analisis Masivo de Datos.xlsx](https://github.com/condecalderonjorge/Machine-Learning-R-Adventureworks/blob/main/data/DataSet%20SQL%20Analisis%20Masivo%20de%20Datos.xlsx)

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
```
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




