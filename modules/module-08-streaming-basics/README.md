# Módulo 08: Fundamentos de Streaming

Procesamiento de streams en tiempo real listo para producción con Apache Kafka, Flink y AWS Kinesis.

---

## 🎯 Descripción General

Domina el streaming de datos en tiempo real y construye aplicaciones de streaming de grado productivo. Aprende Apache Kafka para mensajería distribuida, implementa transformaciones de streams con Python, y despliega procesamiento avanzado con Apache Flink.

**Duración**: 4-5 semanas (40-50 horas)  
**Nivel**: Intermedio a Avanzado  
**Prerequisitos**: Python, Docker, fundamentos de SQL

---

## 📚 Lo Que Aprenderás

### Conceptos Centrales de Streaming
- Paradigmas de procesamiento stream vs batch
- Fundamentos de arquitectura orientada a eventos
- Arquitectura de Apache Kafka (topics, particiones, grupos de consumidores)
- Semántica de entrega de mensajes (at-most-once, at-least-once, exactly-once)
- Estrategias de ventanas (tumbling, sliding, session)
- Gestión de estado en procesamiento de streams

### Habilidades Técnicas
- **Kafka**: Productores, consumidores, topics, particionamiento, replicación
- **Gestión de Esquemas**: Serialización Avro, Schema Registry, evolución de esquemas
- **Procesamiento de Streams**: Filtrado, mapeo, agregación, joins
- **Apache Flink**: DataStream API, event time, watermarks, checkpointing
- **AWS Kinesis**: Data Streams, Firehose, consumidores KCL
- **Patrones de Producción**: Monitoreo, manejo de errores (DLQ), escalado

### Patrones de Arquitectura
- Arquitecturas Lambda vs Kappa
- Microservicios orientados a eventos
- CQRS (Command Query Responsibility Segregation)
- Patrón Saga para transacciones distribuidas
- Change Data Capture (CDC)

---

## 🚀 Inicio Rápido

### 1. Configurar Ambiente (5 minutos)

\`\`\`bash
cd modules/module-08-streaming-basics
./scripts/setup.sh
\`\`\`

Esto hará:
- ✅ Iniciar Kafka, Zookeeper, Schema Registry (Docker)
- ✅ Crear topics (user-events, sensor-readings, transactions)
- ✅ Generar 300 eventos de ejemplo
- ✅ Verificar que todos los servicios estén corriendo

### 2. Verificar Instalación

\`\`\`bash
./scripts/validate.sh
\`\`\`

### 3. Explorar Kafka UI

Abre http://localhost:8080 en tu navegador para:
- Explorar topics y mensajes
- Monitorear grupos de consumidores
- Ver salud del cluster

### 4. Comenzar a Aprender

Comienza con [Ejercicio 01: Fundamentos de Kafka](exercises/01-kafka-basics/)

Guía completa: [GETTING-STARTED.md](GETTING-STARTED.md)

---

## ✅ ¡Módulo Completo!

Este módulo incluye:
- ✅ **18,500 palabras** de teoría comprensiva
- ✅ **6 ejercicios progresivos** (Kafka → Flink → Producción)
- ✅ **Infraestructura basada en Docker** (sin costos de nube)
- ✅ **3 esquemas Avro** para casos de uso realistas
- ✅ **Generador de eventos** con 350 líneas de código
- ✅ **40+ pruebas de validación**
- ✅ **Scripts de automatización** (setup, validate)
- ✅ **Referencias rápidas** (Kafka CLI, patrones de streaming)

Ver [GETTING-STARTED.md](GETTING-STARTED.md) para la ruta de aprendizaje completa.

---

## 🛠️ Tecnologías

- Apache Kafka 2.13
- Apache Flink 1.18
- Schema Registry 7.5
- AWS Kinesis
- Python (kafka-python, confluent-kafka, pyflink, boto3)
- Docker & Docker Compose

---

## 📖 Documentación

- [GETTING-STARTED.md](GETTING-STARTED.md) - Guía completa
- [theory/01-concepts.md](theory/01-concepts.md) - 8K palabras sobre fundamentos
- [theory/02-architecture.md](theory/02-architecture.md) - 7K palabras sobre Kafka/Flink/Kinesis
- [theory/03-resources.md](theory/03-resources.md) - 3.5K palabras sobre herramientas y aprendizaje
- [assets/kafka-quick-reference.md](assets/kafka-quick-reference.md) - Snippets de CLI y Python
- [assets/streaming-patterns.md](assets/streaming-patterns.md) - 13 patrones comunes

---

**¿Listo para empezar?** Ejecuta `./scripts/setup.sh` y comienza tu viaje en streaming!
