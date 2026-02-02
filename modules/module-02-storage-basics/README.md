# Módulo 02: Fundamentos de Almacenamiento y Formatos de Datos

⏱️ **Tiempo Estimado:** 10-12 horas

## Prerequisitos

- Módulo 01: Fundamentos de Cloud (completado)

## Module Overview

Domina los fundamentos de almacenamiento de datos y formatos de archivo esenciales para data engineering. Profundiza en S3 como data lake, aprende a elegir formatos óptimos (JSON, CSV, Parquet, Avro), y comprende particionamiento y compresión para performance.

## Objetivos de Aprendizaje

Al finalizar este módulo, serás capaz de:

- [x] Diseñar data lakes con arquitectura medallion (Bronze/Silver/Gold)
- [x] Seleccionar formatos óptimos según caso de uso (analytical vs transactional)
- [x] Implementar particionamiento Hive-style para optimizar queries
- [x] Aplicar compresión (Snappy, Gzip, LZ4) según trade-offs
- [x] Convertir entre formatos con PyArrow y pandas
- [x] Calcular costos de almacenamiento y optimizar TCO
- [x] Implementar schema evolution en Parquet
- [x] Optimizar metadata con Glue Catalog

## Estructura

- **theory/**: Conceptos centrales y documentación de arquitectura
- **exercises/**: Ejercicios prácticos (6 ejercicios)
- **infrastructure/**: Configuración LocalStack/Docker para este módulo
- **data/**: Datasets de muestra y esquemas
- **validation/**: Tests automatizados para validar tu aprendizaje
- **scripts/**: Scripts de ayuda

## Comenzando

1. Asegurarse de que los prerequisitos estén completados
2. Instalar dependencias: `pip install -r requirements.txt`
3. Generar datos de muestra: `cd data/sample && bash generate_users.sh && cd ../..`
4. Leer `theory/concepts.md` para comprensión fundamental
5. Revisar `theory/architecture.md` para patrones de arquitectura AWS
6. Configurar infraestructura: `bash scripts/setup.sh`
7. Completar ejercicios en orden (01 hasta 06)
8. Validar tu aprendizaje: `bash scripts/validate.sh`

## Ejercicios

1. **Ejercicio 01**: Diseño de Data Lake Medallion - Diseñar arquitectura Bronze/Silver/Gold con S3, políticas de lifecycle, e IAM
2. **Ejercicio 02**: Conversión de Formatos de Archivo - Convertir entre CSV, JSON, Parquet, Avro con benchmarking de rendimiento
3. **Ejercicio 03**: Estrategias de Particionamiento - Implementar particionamiento estilo Hive (fecha, geografía, híbrido) para optimizar queries
4. **Ejercicio 04**: Optimización de Compresión - Comparar algoritmos de compresión Snappy, Gzip, LZ4, Zstd para Parquet
5. **Ejercicio 05**: Evolución de Esquema - Agregar columnas, manejar compatibilidad backward/forward en archivos Parquet
6. **Ejercicio 06**: Integración con Glue Catalog - Registrar datasets, crear crawlers, consultar con Athena

## Recursos

Ver `theory/resources.md` para:
- Documentación oficial de AWS
- Tutoriales en video y workshops
- Recursos de la comunidad
- Mapeo de certificaciones

## Validación

Ejecutar todas las validaciones:
```bash
bash scripts/validate.sh
```

O usar la validación global:
```bash
make validate MODULE=module-{module_id}-{module["name"]}
```

## Lista de Verificación de Progreso

- [ ] Leer toda la documentación de teoría
- [ ] Completado Ejercicio 01
- [ ] Completado Ejercicio 02
- [ ] Completado Ejercicio 03
- [ ] Completado Ejercicio 04
- [ ] Completado Ejercicio 05
- [ ] Completado Ejercicio 06
- [ ] Todas las validaciones pasando
- [ ] Listo para siguiente módulo

## Siguientes Pasos

Después de completar este módulo, estarás listo para:
[Lista de módulos que dependen de este]
