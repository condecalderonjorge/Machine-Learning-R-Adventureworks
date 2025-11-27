# Análisis de Datos Masivos para el Negocio (AdventureWorks con R)

Este repositorio recoge la **última actividad para la asignatura – Análisis de Datos Masivos para el Negocio**, realizada sobre datos de *AdventureWorks*.  
El objetivo es demostrar competencias en **análisis de datos, machine learning clásico, segmentación de clientes y series temporales** utilizando **R**.

---

## 1. Objetivos del proyecto

- Analizar el perfil de los clientes y su relación con la **compra de bicicletas**.
- Construir y comparar **modelos de clasificación**:
  - Regresión logística.
  - Árboles de decisión.
- Segmentar la base de clientes mediante **clusterización (k-means)**.
- Predecir las **ventas diarias futuras** con un modelo de **series temporales (ARIMA)**.
- Traducir los resultados técnicos en **insights de negocio** accionables.

---

## 2. Datos

Los datos proceden del fichero:

- `data/DataSet_SQL_Analisis_Masivo_de_Datos.xlsx`  
  - Hoja **"ST Ventas Totales"**: ventas diarias (serie temporal) desde 2011 a 2014. :contentReference[oaicite:3]{index=3}  
  - Hoja **"Var Discreta Adq Bicicleta"**: panel de clientes con:
    - Variable objetivo: `BikePurchase` (compra/no compra de bicicleta).
    - Variables explicativas: edad, estado civil, renta anual, educación, ocupación, género, hijos, coche en propiedad, etc.   

---

## 3. Estructura del repositorio

```text
.
├── data/
│   └── DataSet_SQL_Analisis_Masivo_de_Datos.xlsx
├── R/
│   └── 01_analisis_clientes_ventas_modelos.R
├── docs/
│   ├── Informe_Actividad_3_ADM.pdf
│   └── COMPETENCIAS.md   (opcional)
└── README.md
