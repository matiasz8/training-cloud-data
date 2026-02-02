# Module 01: Cloud Fundamentals

⏱️ **Estimated Time:** 8-12 hours (3-4 hours theory + 5-8 hours exercises)

## Prerequisites

- None - This is a foundation module
- Basic command-line familiarity helpful but not required
- AWS account NOT required (usamos LocalStack)


## Module Overview

Este módulo te da las bases sólidas de AWS y cloud computing necesarias para data engineering. Aprenderás desde los conceptos fundamentales hasta implementaciones prácticas usando LocalStack (sin costos de AWS).

**¿Qué construirás?**
- Sistema de almacenamiento S3 con estructura de data lake
- Políticas IAM restrictivas para seguridad
- Funciones Lambda para procesamiento serverless
- Infraestructura completa con CloudFormation
- Pipeline de optimización de costos

**¿Por qué este módulo es importante?**
Todos los módulos siguientes asumen conocimiento sólido de AWS. Sin estos fundamentos, te costará entender arquitecturas avanzadas de data pipelines.

## Learning Objectives

Al completar este módulo, serás capaz de:

- [x] Explicar los 5 características esenciales del cloud computing según NIST
- [x] Diferenciar entre IaaS, PaaS y SaaS y elegir el apropiado según requisitos
- [x] Diseñar arquitecturas multi-AZ para alta disponibilidad
- [x] Implementar IAM policies restrictivas siguiendo principle of least privilege
- [x] Crear y gestionar buckets S3 con estructura particionada (data lake)
- [x] Desarrollar funciones Lambda para procesamiento event-driven
- [x] Optimizar costos usando storage classes, lifecycle policies y right-sizing
- [x] Aplicar AWS Well-Architected Framework a data pipelines
- [x] Usar AWS CLI para automatizar operaciones de infraestructura
- [x] Troubleshootear problemas comunes de AWS e infraestructura cloud

## Structure

- **theory/**: Core concepts and architecture documentation
- **exercises/**: Hands-on practice exercises (6 exercises)
- **infrastructure/**: LocalStack/Docker setup for this module
- **data/**: Sample datasets and schemas
- **validation/**: Automated tests to validate your learning
- **scripts/**: Helper scripts

## Getting Started

### Camino Recomendado (8-12 horas total)

**📖 Fase 1: Teoría (3-4 horas)**

1. Lee `theory/concepts.md` completamente (~2 horas)
   - Toma notas de conceptos clave
   - Responde las self-assessment questions al final

2. Estudia `theory/architecture.md` (~1 hora)
   - Analiza los diagramas de arquitectura
   - Identifica patrones que aplicarás en ejercicios

3. Revisa `theory/resources.md` (~30 min)
   - Bookmarkea recursos oficiales AWS
   - Mira al menos 1 video recomendado (opcional)

**🛠️ Fase 2: Setup (15-20 min)**

4. Verifica que LocalStack está corriendo:
   ```bash
   cd ../../..  # Vuelve a raíz del proyecto
   make up
   docker ps | grep localstack
   ```

5. Instala AWS CLI si no lo tienes:
   ```bash
   # macOS
   brew install awscli
   
   # Ubuntu/Debian
   sudo apt install awscli
   
   # O via pip
   pip install awscli
   ```

6. Configura credenciales dummy para LocalStack:
   ```bash
   aws configure
   # Access Key: test
   # Secret Key: test
   # Region: us-east-1
   ```

**💻 Fase 3: Ejercicios (5-8 horas)**

7. Completa ejercicios en orden:
   - Cada ejercicio tiene: README → starter/ → my_solution/ → hints.md → solution/
   - Trabaja SOLO en `my_solution/` (copia starter/ primero)
   - No mires solution/ hasta intentar con hints

8. Valida después de cada ejercicio:
   ```bash
   ../../scripts/validate-module.sh 01
   ```

**✅ Fase 4: Validación Final (15 min)**

9. Ejecuta todas las validaciones:
   ```bash
   cd scripts/
   bash validate.sh
   ```

10. Verifica tu progreso:
    ```bash
    cd ../../..  # Raíz del proyecto
    make progress
    ```

## Exercises

### 1. **AWS CLI & S3 Basics** - 45-60 min
   - Configurar AWS CLI para LocalStack
   - Crear buckets con estructura particionada (year/month/day)
   - Subir, descargar y copiar objetos
   - Listar con prefixes y obtener metadata
   - **Entregable:** Script automatizado `s3_operations.sh`

### 2. **IAM Policies & Security** - 60-75 min
   - Crear users, groups y roles
   - Escribir IAM policies restrictivas (least privilege)
   - Implementar S3 bucket policies
   - Cross-account access scenarios
   - **Entregable:** Políticas JSON y documentación de permisos

### 3. **S3 Advanced Features** - 60-75 min
   - Configurar versioning y MFA delete
   - Implementar lifecycle policies (Standard → IA → Glacier)
   - Setup cross-region replication
   - S3 event notifications a Lambda
   - **Entregable:** Configuración completa de bucket productivo

### 4. **Lambda Functions** - 75-90 min
   - Crear Lambda para procesamiento de archivos S3
   - Configurar execution roles y permissions
   - Implementar error handling y retry logic
   - Logging con CloudWatch
   - **Entregable:** Función Lambda que procesa CSV → JSON

### 5. **Infrastructure as Code (CloudFormation)** - 75-90 min
   - Escribir templates YAML para S3 + Lambda + IAM
   - Parametrización y outputs
   - Stack updates y changesets
   - Rollback scenarios
   - **Entregable:** Template reutilizable de data pipeline básico

### 6. **Cost Optimization** - 60-75 min
   - Analizar factura simulada de AWS
   - Implementar lifecycle policies para ahorrar storage
   - Configurar budgets y alarmas
   - Comparar costos: On-Demand vs Reserved vs Spot
   - **Entregable:** Plan de optimización con ahorros proyectados

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
