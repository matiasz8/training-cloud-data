# Module 02: Storage Basics & Data Formats

⏱️ **Estimated Time:** 10-12 hours

## Prerequisites

- Module 01: Cloud Fundamentals (completed)

## Module Overview

Domina los fundamentos de almacenamiento de datos y formatos de archivo esenciales para data engineering. Profundiza en S3 como data lake, aprende a elegir formatos óptimos (JSON, CSV, Parquet, Avro), y comprende particionamiento y compresión para performance.

## Learning Objectives

By the end of this module, you will be able to:

- [x] Diseñar data lakes con arquitectura medallion (Bronze/Silver/Gold)
- [x] Seleccionar formatos óptimos según caso de uso (analytical vs transactional)
- [x] Implementar particionamiento Hive-style para optimizar queries
- [x] Aplicar compresión (Snappy, Gzip, LZ4) según trade-offs
- [x] Convertir entre formatos con PyArrow y pandas
- [x] Calcular costos de almacenamiento y optimizar TCO
- [x] Implementar schema evolution en Parquet
- [x] Optimizar metadata con Glue Catalog

## Structure

- **theory/**: Core concepts and architecture documentation
- **exercises/**: Hands-on practice exercises (6 exercises)
- **infrastructure/**: LocalStack/Docker setup for this module
- **data/**: Sample datasets and schemas
- **validation/**: Automated tests to validate your learning
- **scripts/**: Helper scripts

## Getting Started

1. Ensure prerequisites are completed
2. Read `theory/concepts.md` for foundational understanding
3. Review `theory/architecture.md` for AWS architecture patterns
4. Set up infrastructure: `bash scripts/setup.sh`
5. Complete exercises in order (01 through 06)
6. Validate your learning: `bash scripts/validate.sh`

## Exercises

1. **Exercise 01**: Medallion Data Lake Design - Design Bronze/Silver/Gold architecture with S3, lifecycle policies, and IAM
2. **Exercise 02**: File Format Conversion - Convert between CSV, JSON, Parquet, Avro with performance benchmarking
3. **Exercise 03**: Partitioning Strategies - Implement Hive-style partitioning (date, geography, hybrid) to optimize queries
4. **Exercise 04**: Compression Optimization - Compare Snappy, Gzip, LZ4, Zstd compression algorithms for Parquet
5. **Exercise 05**: Schema Evolution - Add columns, handle backward/forward compatibility in Parquet files
6. **Exercise 06**: Glue Catalog Integration - Register datasets, create crawlers, query with Athena

## Resources

See `theory/resources.md` for:
- Official AWS documentation
- Video tutorials and workshops
- Community resources
- Certification mapping

## Validation

Run all validations:
```bash
bash scripts/validate.sh
```

Or use the global validation:
```bash
make validate MODULE=module-{module_id}-{module["name"]}
```

## Progress Checklist

- [ ] Read all theory documentation
- [ ] Completed Exercise 01
- [ ] Completed Exercise 02
- [ ] Completed Exercise 03
- [ ] Completed Exercise 04
- [ ] Completed Exercise 05
- [ ] Completed Exercise 06
- [ ] All validations passing
- [ ] Ready for next module

## Next Steps

After completing this module, you'll be ready for:
[List of modules that depend on this one]
