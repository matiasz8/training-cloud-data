# 📚 Assets - Recursos Visuales y Referencias Rápidas

## 📋 Descripción General

Este directorio contiene recursos visuales y referencias rápidas diseñadas para facilitar el aprendizaje y consulta durante el trabajo con Python para Ingeniería de Datos.

## 📂 Estructura de Assets

```
assets/
├── README.md                          # Este archivo
├── cheatsheets/                       # Hojas de referencia rápida
│   ├── python-basics.md              # Fundamentos de Python
│   ├── pandas-reference.md           # Operaciones de Pandas
│   ├── data-cleaning.md              # Limpieza de datos
│   └── file-formats.md               # Formatos de archivo
└── diagrams/                          # Diagramas y flujos
    ├── data-flow.md                  # Flujos de datos ETL
    └── pandas-operations.md          # Operaciones de Pandas
```

## 🎯 Propósito

Los assets están diseñados para:

1. **Consulta Rápida**: Encontrar sintaxis y patrones comunes sin buscar en la documentación
2. **Referencia Visual**: Entender flujos de datos y transformaciones mediante diagramas
3. **Aprendizaje Activo**: Tener ejemplos concretos al alcance durante los ejercicios
4. **Solución de Problemas**: Guías rápidas para errores comunes y mejores prácticas

## 📝 Cheatsheets Disponibles

### 1. Python Basics (`cheatsheets/python-basics.md`)
- Variables y tipos de datos
- Estructuras de control (if/for/while)
- Funciones y lambdas
- Comprehensions
- Manejo de strings y colecciones
- **Cuándo usar**: Primeros ejercicios, repaso de sintaxis

### 2. Pandas Reference (`cheatsheets/pandas-reference.md`)
- Creación de DataFrames
- Selección de datos (loc/iloc/boolean indexing)
- Filtrado y transformación
- Operaciones de agrupación (groupby)
- Joins y merges
- Manejo de fechas
- **Cuándo usar**: Ejercicios 04, 05 y proyectos con datasets

### 3. Data Cleaning (`cheatsheets/data-cleaning.md`)
- Detección de valores nulos
- Estrategias para manejar nulls
- Eliminación de duplicados
- Conversión de tipos
- Normalización de datos
- Validación de calidad
- **Cuándo usar**: Ejercicio 05 (transformaciones), pipelines de limpieza

### 4. File Formats (`cheatsheets/file-formats.md`)
- CSV: Lectura/escritura, delimitadores
- JSON: Estructuras anidadas, normalización
- Parquet: Compresión, columnar storage
- Comparación de formatos
- Cuándo usar cada formato
- **Cuándo usar**: Ejercicio 03 (operaciones de archivos), decisiones de almacenamiento

## 📊 Diagramas Disponibles

### 1. Data Flow (`diagrams/data-flow.md`)
- Pipeline ETL completo (Extract → Transform → Load)
- Flujo de datos a través de los ejercicios
- Puntos de validación y checkpoints
- Transformaciones comunes
- **Cuándo usar**: Diseño de pipelines, comprensión del flujo general

### 2. Pandas Operations (`diagrams/pandas-operations.md`)
- Flujo de transformaciones de DataFrames
- Operaciones de filtrado y selección
- Procesos de agrupación y agregación
- Tipos de joins y sus resultados
- **Cuándo usar**: Ejercicio 04 y 05, debugging de transformaciones

## 🎨 Cómo Usar los Cheatsheets

### Durante los Ejercicios
```bash
# Abre el cheatsheet relevante en una pestaña del editor
# Mantén el cheatsheet visible mientras trabajas en el ejercicio
```

### Como Referencia Rápida
1. **¿Olvidaste sintaxis?** → Consulta el cheatsheet correspondiente
2. **¿No estás seguro del flujo?** → Revisa los diagramas
3. **¿Error inesperado?** → Revisa la sección de "Errores Comunes" en cada cheatsheet

### Durante el Estudio
- Imprime los cheatsheets más relevantes para tu trabajo actual
- Usa los diagramas para entender el "big picture" antes de codificar
- Consulta ejemplos específicos cuando necesites implementar un patrón

## 📐 Formato de los Diagramas

Los diagramas están escritos en **Mermaid**, un lenguaje de diagramas que se renderiza en Markdown. 

### Visualización
- **GitHub**: Los diagramas se renderizan automáticamente
- **VS Code**: Instala la extensión "Markdown Preview Mermaid Support"
- **Navegador**: Usa [Mermaid Live Editor](https://mermaid.live/)

## 💡 Tips de Uso

### Para Principiantes
1. Comienza con `python-basics.md` para refrescar conceptos
2. Usa `data-flow.md` para entender el objetivo final
3. Consulta cheatsheets específicos cuando lo necesites

### Para Usuarios Intermedios
1. Ten `pandas-reference.md` siempre a mano
2. Usa `data-cleaning.md` como checklist de calidad
3. Consulta `file-formats.md` al decidir formatos de salida

### Para Proyectos Reales
1. Diseña tu pipeline usando `data-flow.md` como guía
2. Implementa transformaciones consultando `pandas-operations.md`
3. Valida calidad usando patrones de `data-cleaning.md`

## 🔄 Actualizaciones

Los assets se actualizan periódicamente para incluir:
- Nuevos patrones descubiertos durante los ejercicios
- Mejoras en diagramas basadas en feedback
- Errores comunes reportados por estudiantes
- Mejores prácticas de la industria

## 📚 Recursos Complementarios

Los assets complementan:
- **Theory/** → Conceptos teóricos detallados
- **Exercises/** → Práctica hands-on
- **Validation/** → Verificación de conocimientos
- **Docs/** → Guías de troubleshooting

## 🤝 Contribuciones

Si encuentras errores o tienes sugerencias:
1. Revisa que el contenido sea técnicamente correcto
2. Asegúrate de que los ejemplos funcionen
3. Mantén el formato consistente con los demás assets
4. Prioriza claridad y concisión

---

**Última actualización**: Módulo 04 - Paso 7  
**Versión**: 1.0  
**Mantenedor**: Training Cloud Data
