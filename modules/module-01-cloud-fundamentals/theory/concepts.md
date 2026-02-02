# Conceptos Fundamentales de Cloud Computing

**Tiempo de estudio estimado:** 3-4 horas  
**Nivel:** Fundamental  
**Prerequisitos:** Ninguno

---

## 1. Introducción al Cloud Computing

### ¿Qué es Cloud Computing?

Cloud Computing (Computación en la Nube) es la entrega bajo demanda de recursos de TI a través de Internet con un modelo de pago por uso. En lugar de comprar, poseer y mantener data centers y servidores físicos, puedes acceder a servicios tecnológicos como capacidad de cómputo, almacenamiento y bases de datos según lo necesites desde un proveedor cloud como AWS, Azure o Google Cloud.

### Características Esenciales del Cloud Computing

Según el NIST (National Institute of Standards and Technology), el cloud computing tiene cinco características esenciales:

1. **On-Demand Self-Service (Autoservicio bajo demanda)**
   - Provisiona recursos automáticamente sin interacción humana con el proveedor
   - Crea servidores, almacenamiento o bases de datos en minutos mediante consola o API
   - Ejemplo: Lanzar una instancia EC2 en AWS toma menos de 2 minutos

2. **Broad Network Access (Amplio acceso a la red)**
   - Acceso desde cualquier dispositivo con conexión a Internet
   - APIs disponibles para automatización
   - Consolas web, CLI, SDKs en múltiples lenguajes

3. **Resource Pooling (Agrupación de recursos)**
   - Recursos compartidos entre múltiples clientes (multi-tenant)
   - Asignación dinámica según demanda
   - El cliente generalmente no sabe la ubicación exacta de los recursos

4. **Rapid Elasticity (Elasticidad rápida)**
   - Escalar recursos hacia arriba o abajo automáticamente
   - Capacidad aparentemente ilimitada
   - Ejemplo: Auto Scaling Groups en AWS que añaden/remueven servidores según carga

5. **Measured Service (Servicio medido)**
   - Pago solo por lo que usas (pay-as-you-go)
   - Monitoreo, control y reporting del uso de recursos
   - Optimización de costos basada en métricas precisas

### ¿Por qué Cloud para Data Engineering?

El cloud computing es especialmente relevante para Data Engineering por varias razones:

**1. Escalabilidad para Grandes Volúmenes de Datos**
- Procesar terabytes o petabytes sin inversión inicial en hardware
- Escalar procesamiento horizontalmente para jobs de Spark o pipelines ETL
- Almacenamiento prácticamente ilimitado (S3 puede almacenar objetos infinitos)

**2. Costo Variable vs. Costo Fijo**
- No pagas por capacidad ociosa
- Procesa datos en batch solo cuando es necesario
- Ejemplo: Un pipeline que corre 1 hora/día solo cuesta 1/24 del costo de un servidor 24/7

**3. Velocidad y Agilidad**
- Experimenta con nuevas tecnologías sin procurement
- Provisiona clusters de Spark en minutos, no semanas
- Itera rápidamente en arquitecturas de datos

**4. Alcance Global**
- Replica datos cerca de tus usuarios en múltiples regiones
- Baja latencia para aplicaciones globales
- Cumplimiento con regulaciones de residencia de datos

**5. Serverless y Managed Services**
- Reduce overhead operacional (no gestionar parches, backups, HA)
- Enfócate en lógica de negocio, no en infraestructura
- Ejemplo: AWS Glue para ETL sin gestionar servidores Spark

---

## 2. Modelos de Servicio Cloud

Existen tres modelos principales de servicio cloud, formando una pirámide de abstracción:

### Infrastructure as a Service (IaaS)

**Definición:** Provisión de infraestructura fundamental de TI (cómputo, networking, almacenamiento) como servicio.

**Qué gestionas tú:**
- Sistema operativo
- Middleware
- Runtime
- Datos
- Aplicaciones

**Qué gestiona el proveedor:**
- Virtualización
- Servidores físicos
- Almacenamiento físico
- Networking físico

**Ejemplos en AWS:**
- **Amazon EC2:** Máquinas virtuales
- **Amazon EBS:** Almacenamiento en bloque
- **Amazon VPC:** Redes virtuales privadas

**Caso de uso en Data Engineering:**
```
Necesitas instalar una versión específica de Apache Kafka con configuraciones 
custom que no están disponibles en servicios managed. Usas EC2 para desplegar 
tu cluster de Kafka con control total sobre la configuración.
```

**Ventajas:**
- Control total sobre la infraestructura
- Flexibilidad máxima
- Puedes instalar cualquier software

**Desventajas:**
- Mayor responsabilidad operacional
- Debes gestionar OS, seguridad, patches
- Más complejidad

### Platform as a Service (PaaS)

**Definición:** Provisión de una plataforma de desarrollo y despliegue sin gestionar infraestructura subyacente.

**Qué gestionas tú:**
- Datos
- Aplicaciones

**Qué gestiona el proveedor:**
- Runtime
- Middleware
- Sistema operativo
- Virtualización
- Servidores
- Almacenamiento
- Networking

**Ejemplos en AWS:**
- **AWS Elastic Beanstalk:** Despliegue de aplicaciones web
- **AWS Lambda:** Funciones serverless
- **Amazon RDS:** Bases de datos relacionales managed
- **AWS Glue:** ETL managed con Spark

**Caso de uso en Data Engineering:**
```
Necesitas una base de datos PostgreSQL para tu data warehouse. En lugar de 
instalar y configurar PostgreSQL en EC2 (IaaS), usas Amazon RDS que gestiona 
automáticamente backups, patches, replicación y failover.
```

**Ventajas:**
- Menos overhead operacional
- Enfoque en desarrollo, no en infraestructura
- Built-in scalability y high availability

**Desventajas:**
- Menos control sobre configuración
- Vendor lock-in potencial
- Costos pueden ser mayores que IaaS

### Software as a Service (SaaS)

**Definición:** Provisión de aplicaciones completas a través de Internet.

**Qué gestionas tú:**
- Solo usas la aplicación

**Qué gestiona el proveedor:**
- Todo el stack tecnológico

**Ejemplos:**
- **Snowflake:** Data warehouse cloud-native
- **Databricks:** Plataforma de datos unificada
- **Fivetran:** Herramienta de ingesta de datos
- **Looker:** Business intelligence

**Caso de uso en Data Engineering:**
```
Necesitas ingestar datos de 50 fuentes SaaS (Salesforce, Google Analytics, etc.) 
a tu data warehouse. Usar Fivetran (SaaS) te da conectores pre-built y 
mantenidos, sin escribir código.
```

**Ventajas:**
- Cero gestión de infraestructura
- Actualizaciones automáticas
- Acceso inmediato

**Desventajas:**
- Menos flexibilidad
- Dependencia total del vendor
- Costos pueden escalar rápidamente

### Matriz de Comparación

| Aspecto | IaaS | PaaS | SaaS |
|---------|------|------|------|
| **Control** | Alto | Medio | Bajo |
| **Flexibilidad** | Máxima | Media | Limitada |
| **Tiempo de setup** | Horas/Días | Minutos | Inmediato |
| **Gestión operacional** | Alta | Media | Mínima |
| **Curva de aprendizaje** | Empinada | Moderada | Suave |
| **Costo inicial** | Bajo | Medio | Alto |
| **Escalabilidad** | Manual | Semi-automática | Automática |

### ¿Cuál elegir para Data Engineering?

En la práctica, usarás una **combinación de los tres**:

- **IaaS:** Para herramientas self-hosted específicas (Airflow, Kafka con configs especiales)
- **PaaS:** Para la mayoría de workloads (Lambda para transformaciones, RDS para metadatos, Glue para ETL)
- **SaaS:** Para herramientas de productividad (Databricks, Snowflake, Fivetran)

**Principio rector:** Usa el mayor nivel de abstracción que satisfaga tus requisitos. Solo baja de nivel cuando necesites control específico.

---

## 3. AWS Global Infrastructure

Entender la infraestructura global de AWS es crítico para diseñar arquitecturas resilientes y performantes.

### Regions (Regiones)

Una **AWS Region** es una ubicación geográfica física en el mundo donde AWS tiene múltiples data centers.

**Características:**
- AWS tiene **33+ regiones** actualmente (y creciendo)
- Cada región es completamente independiente
- Los datos en una región NO se replican automáticamente a otras regiones
- Cada región tiene un código único: `us-east-1`, `eu-west-1`, `ap-southeast-2`, etc.

**Factores para elegir una región:**

1. **Compliance (Cumplimiento)**
   - Regulaciones de residencia de datos (GDPR, leyes locales)
   - Ejemplo: Datos de ciudadanos europeos deben estar en regiones EU

2. **Latency (Latencia)**
   - Proximidad a usuarios finales
   - Ejemplo: Usuarios en Brasil → usar `sa-east-1` (São Paulo)

3. **Available Services (Servicios disponibles)**
   - No todos los servicios están en todas las regiones
   - Servicios nuevos generalmente lanzan primero en `us-east-1`

4. **Pricing (Precios)**
   - Los precios varían entre regiones
   - `us-east-1` suele ser la más barata, regiones Asia-Pacific más caras

**Ejemplo para Data Engineering:**
```
Tienes usuarios en América del Norte y Europa. Decides:
- Data Lake principal en us-east-1 (costo)
- Réplica read-only en eu-west-1 (latencia para usuarios EU)
- Replication con S3 Cross-Region Replication
```

### Availability Zones (AZs)

Una **Availability Zone** es uno o más data centers discretos con poder, networking y conectividad redundantes dentro de una región.

**Características clave:**
- Cada región tiene **mínimo 3 AZs** (algunas tienen 6+)
- AZs están **físicamente separadas** (diferentes edificios)
- Conectadas con **networking de baja latencia** (<2ms entre AZs)
- Nombradas: `us-east-1a`, `us-east-1b`, `us-east-1c`, etc.

**Visualización:**
```
Region: us-east-1
├── AZ: us-east-1a (Data Center 1, 2)
├── AZ: us-east-1b (Data Center 3, 4)
├── AZ: us-east-1c (Data Center 5, 6)
├── AZ: us-east-1d (Data Center 7)
├── AZ: us-east-1e (Data Center 8)
└── AZ: us-east-1f (Data Center 9)
```

**¿Por qué múltiples AZs?**

**Alta Disponibilidad:** Si un data center falla (incendio, corte eléctrico, desastre natural), tus aplicaciones siguen funcionando en otras AZs.

**Ejemplo de arquitectura multi-AZ para Data Engineering:**
```
Data Pipeline:
- Kinesis Data Stream: Réplicas en 3 AZs (automático)
- Lambda processors: Se despliegan en todas las AZs de la región
- RDS Database: Primary en AZ-A, Standby en AZ-B (Multi-AZ)
- S3: Datos replicados automáticamente entre AZs

Si us-east-1a falla → Kinesis sigue escribiendo en 1b y 1c
                    → Lambda sigue procesando
                    → RDS hace failover a AZ-B
                    → S3 sigue disponible
```

### Edge Locations

**Edge Locations** son puntos de presencia (PoP) distribuidos globalmente para entregar contenido con baja latencia.

**Características:**
- **450+ Edge Locations** en ~90 ciudades
- Mucho más numerosas que las regiones (33) o AZs (~100)
- Usadas principalmente por **CloudFront** (CDN) y **Route 53** (DNS)

**Uso en Data Engineering:**
```
Escenario: Dashboard de BI consumido por 10,000 usuarios globales

Sin Edge Locations:
- Todos los requests van a us-east-1
- Usuarios en Australia experimentan 200-300ms latency

Con CloudFront (Edge Locations):
- Dashboard assets (JS, CSS, imágenes) cacheados en edge
- Usuarios en Australia conectan a edge en Sydney: 20-30ms latency
- 10x mejora en performance
```

### Diagrama de Infraestructura Global

```mermaid
graph TB
    subgraph "AWS Global Infrastructure"
        subgraph "Region: us-east-1"
            AZ1[AZ-1a<br/>Data Centers 1,2]
            AZ2[AZ-1b<br/>Data Centers 3,4]
            AZ3[AZ-1c<br/>Data Centers 5,6]
        end
        
        subgraph "Region: eu-west-1"
            AZ4[AZ-1a<br/>Data Centers]
            AZ5[AZ-1b<br/>Data Centers]
            AZ6[AZ-1c<br/>Data Centers]
        end
        
        subgraph "Region: ap-southeast-2"
            AZ7[AZ-2a<br/>Data Centers]
            AZ8[AZ-2b<br/>Data Centers]
            AZ9[AZ-2c<br/>Data Centers]
        end
    end
    
    Edge1[Edge Location<br/>New York]
    Edge2[Edge Location<br/>London]
    Edge3[Edge Location<br/>Sydney]
    
    AZ1 -.->|CloudFront<br/>Distribution| Edge1
    AZ4 -.->|CloudFront<br/>Distribution| Edge2
    AZ7 -.->|CloudFront<br/>Distribution| Edge3
```

### Principios de Diseño para Data Engineering

1. **Design for Failure:** Asume que cualquier componente puede fallar
2. **Multi-AZ por defecto:** Para workloads de producción
3. **Multi-Region solo si es necesario:** Añade complejidad y costo
4. **Considera latencia:** Coloca datos cerca de donde se procesan

---

## 4. Identity and Access Management (IAM)

IAM es el servicio fundamental de seguridad en AWS. **Todo en AWS requiere autenticación y autorización vía IAM.**

### Conceptos Fundamentales

#### Users (Usuarios)

Un **IAM User** representa a una persona o aplicación que interactúa con AWS.

**Características:**
- Tiene credenciales permanentes (password o access keys)
- Puede tener permisos asignados directamente (no recomendado)
- Mejor práctica: Asignar permisos vía Groups

**Ejemplo:**
```
IAM User: john.doe@company.com
- Password: Para AWS Console
- Access Key ID: AKIAIOSFODNN7EXAMPLE
- Secret Access Key: wJalrXUtnFEMI/K7MDENG/bPxRfiCYEXAMPLEKEY
```

**Para Data Engineering:**
```
Escenario: Tienes 5 data engineers en tu equipo

❌ MAL:
- Todos comparten un solo user
- No sabes quién hizo qué cambio

✅ BIEN:
- Cada engineer tiene su propio IAM User
- Logs de CloudTrail muestran quién ejecutó cada acción
- Puedes revocar acceso individualmente
```

#### Groups (Grupos)

Un **IAM Group** es una colección de IAM Users.

**Ventajas:**
- Gestiona permisos a nivel de grupo, no usuario por usuario
- Un user puede pertenecer a múltiples grupos
- Simplifica administración a escala

**Ejemplo de estructura:**
```
Group: DataEngineers
├── Permissions: S3 Full Access, Glue Full Access, Athena Full Access
├── Members:
│   ├── john.doe@company.com
│   ├── jane.smith@company.com
│   └── carlos.garcia@company.com

Group: DataAnalysts
├── Permissions: S3 Read Access, Athena Full Access
├── Members:
│   ├── alice.johnson@company.com
│   └── bob.wilson@company.com
```

#### Roles (Roles)

Un **IAM Role** es una identidad con permisos específicos que puede ser **asumida** temporalmente por entidades de confianza.

**Key difference con Users:**
- **Users:** Credenciales permanentes
- **Roles:** Credenciales temporales (15min - 12hrs)

**Casos de uso principales:**

**1. EC2 Instances (más común)**
```
EC2 Instance → Asume IAM Role → Obtiene credenciales temporales → Accede a S3

Ventajas:
- No necesitas hardcodear access keys en la instancia
- Credenciales rotan automáticamente
- Puedes revocar acceso sin tocar la instancia
```

**2. Cross-Account Access**
```
Cuenta A (Producción) → Permite Cuenta B (Dev) → Asumir role

Escenario: Developers en cuenta Dev necesitan leer datos de S3 en cuenta Prod
Solución: Crear role en Prod que Cuenta Dev puede asumir temporalmente
```

**3. Lambda Functions**
```
Lambda Function → Execution Role → Permisos para:
├── Leer de S3
├── Escribir a DynamoDB
└── Enviar logs a CloudWatch
```

**4. Federated Access (SSO)**
```
Employee → Autentica con Okta/Azure AD → Asume Role en AWS → Acceso temporal

Ventaja: Single Sign-On, no gestionar passwords en AWS
```

#### Policies (Políticas)

Una **IAM Policy** es un documento JSON que define permisos.

**Anatomía de una Policy:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject"
      ],
      "Resource": "arn:aws:s3:::my-data-lake/*",
      "Condition": {
        "IpAddress": {
          "aws:SourceIp": "203.0.113.0/24"
        }
      }
    }
  ]
}
```

**Componentes:**
- **Version:** Siempre "2012-10-17" (versión del lenguaje de políticas)
- **Statement:** Array de declaraciones de permisos
  - **Effect:** `Allow` o `Deny`
  - **Action:** Qué operaciones (ej: `s3:GetObject`, `glue:*`)
  - **Resource:** En qué recursos (ARN)
  - **Condition:** (Opcional) Condiciones adicionales

**Tipos de políticas:**

**1. Managed Policies (AWS-managed):**
```
- AmazonS3FullAccess
- AWSGlueServiceRole
- AmazonAthenaFullAccess
```
Ventaja: Mantenidas por AWS, buenas para empezar  
Desventaja: Pueden ser muy permisivas

**2. Customer-Managed Policies:**
```
Políticas custom que creas para tus necesidades específicas
Ejemplo: "DataEngineerReadOnlyProduction"
```

**3. Inline Policies:**
```
Políticas embebidas directamente en un User/Group/Role
Uso: Relaciones 1:1 estrictas
```

**Ejemplo para Data Engineering - Policy restrictiva:**
```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "AllowReadFromRawBucket",
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "arn:aws:s3:::company-datalake-raw",
        "arn:aws:s3:::company-datalake-raw/*"
      ]
    },
    {
      "Sid": "AllowWriteToProcessedBucket",
      "Effect": "Allow",
      "Action": [
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      "Resource": "arn:aws:s3:::company-datalake-processed/*"
    },
    {
      "Sid": "DenyDeleteOnRawData",
      "Effect": "Deny",
      "Action": "s3:DeleteObject",
      "Resource": "arn:aws:s3:::company-datalake-raw/*"
    }
  ]
}
```

### Best Practices de IAM

1. **Never use Root Account credentials**
   - Root = acceso total, sin restricciones
   - Configura MFA en root
   - Solo usa root para tareas específicas (cambiar plan de pago, cerrar cuenta)

2. **Principle of Least Privilege**
   - Da solo los permisos mínimos necesarios
   - Empieza restrictivo, expande solo si es necesario
   - Revisa permisos regularmente con IAM Access Analyzer

3. **Use IAM Roles for applications**
   - Nunca hardcodees access keys en código
   - EC2 instances → IAM Role
   - Lambda functions → Execution Role
   - ECS tasks → Task Role

4. **Enable MFA for privileged users**
   - Users que pueden crear/eliminar recursos
   - Users con acceso a datos sensibles

5. **Rotate credentials regularly**
   - Access keys: Cada 90 días
   - AWS puede notificarte automáticamente

6. **Use CloudTrail for auditing**
   - Registra todas las llamadas API
   - Quién hizo qué, cuándo, desde dónde
   - Crítico para compliance y debugging

### IAM para Data Pipelines - Ejemplo Completo

**Escenario:** Pipeline que lee de S3, procesa con Lambda, escribe a DynamoDB

```
Step 1: Crear IAM Policy para Lambda
{
  "Statement": [
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject"],
      "Resource": "arn:aws:s3:::raw-data-bucket/*"
    },
    {
      "Effect": "Allow",
      "Action": ["dynamodb:PutItem"],
      "Resource": "arn:aws:dynamodb:us-east-1:123456789012:table/ProcessedData"
    },
    {
      "Effect": "Allow",
      "Action": ["logs:CreateLogGroup", "logs:CreateLogStream", "logs:PutLogEvents"],
      "Resource": "arn:aws:logs:*:*:*"
    }
  ]
}

Step 2: Crear IAM Role
Role Name: DataProcessingLambdaRole
Trust Policy: Lambda service can assume this role
Attach: La policy del Step 1

Step 3: Asignar Role a Lambda Function
En la configuración de Lambda → Execution Role → DataProcessingLambdaRole

Step 4: Lambda ejecuta con credenciales temporales
- Lambda asume el role automáticamente
- Obtiene credenciales temporales (1-6 horas según config)
- SDK de AWS (boto3) usa credenciales automáticamente
- Al expirar, Lambda solicita nuevas credenciales
```

---

## 5. Core AWS Services para Data Engineering

### Amazon S3 (Simple Storage Service)

**Qué es:** Almacenamiento de objetos escalable, durable y de bajo costo.

**Conceptos clave:**
- **Bucket:** Contenedor de objetos (nombres únicos globalmente)
- **Object:** Archivo + metadata (hasta 5TB por objeto)
- **Key:** Ruta del objeto (ej: `data/year=2024/month=01/file.parquet`)

**Por qué es fundamental para Data Engineering:**
```
S3 es el "sistema de archivos" de la nube para datos

Usos típicos:
├── Data Lake: Almacenamiento central para datos raw, processed, curated
├── Data Warehouse staging: Área de staging antes de cargar a Redshift/Snowflake
├── Backup y archivo: Retención de datos históricos
├── Logs y eventos: Almacenamiento de logs de aplicaciones
└── Datasets para ML: Training data para modelos de machine learning
```

**Storage Classes:**
```
S3 Standard: Acceso frecuente, baja latencia
└─→ S3 Intelligent-Tiering: Mueve datos automáticamente entre tiers
    └─→ S3 Standard-IA: Acceso infrecuente (backups mensuales)
        └─→ S3 Glacier: Archivo (backups anuales, compliance)
            └─→ S3 Glacier Deep Archive: Archivo a largo plazo (7-10 años)

Ejemplo de costos (us-east-1):
- Standard: $0.023/GB/mes
- Standard-IA: $0.0125/GB/mes
- Glacier: $0.004/GB/mes
- Deep Archive: $0.00099/GB/mes
```

**Features esenciales:**
- **Versioning:** Mantén múltiples versiones de objetos
- **Lifecycle Policies:** Transición automática entre storage classes
- **Replication:** Cross-Region o Same-Region replication
- **Event Notifications:** Trigger Lambda cuando suben archivos

### AWS Lambda

**Qué es:** Servicio de cómputo serverless que ejecuta código en respuesta a eventos.

**Características:**
- Sin servidores que gestionar
- Auto-scaling automático (0 a 1000s de ejecuciones concurrentes)
- Pago por milisegundo de ejecución
- Límite de 15 minutos por invocación

**Usos en Data Engineering:**
```
1. ETL ligero y transformaciones
   S3 (CSV) → Lambda → S3 (Parquet)

2. Orquestación de pipelines
   Lambda que invoca Glue jobs, EMR steps, Step Functions

3. Validación de datos
   Nuevo archivo en S3 → Lambda valida schema → Rechaza o acepta

4. API para consultas
   API Gateway → Lambda → Athena → Resultados

5. Real-time processing
   Kinesis Stream → Lambda → DynamoDB/S3
```

**Limitaciones importantes:**
- 15 min timeout (para procesos largos usa Glue, EMR, Batch)
- 10GB RAM máximo
- 512MB /tmp storage
- No persistente (cada invocación es stateless)

### Amazon EC2 (Elastic Compute Cloud)

**Qué es:** Máquinas virtuales (instancias) en la nube con capacidad de cómputo redimensionable.

**Instance Types relevantes para Data:**
```
Compute Optimized (C-family):
- c6i.xlarge: Para procesamiento batch intensivo
- Ejemplo: Procesar millones de registros con Python

Memory Optimized (R-family):
- r6i.2xlarge: Para in-memory processing (Spark)
- Ejemplo: Cluster de Spark con datasets grandes en RAM

Storage Optimized (I-family):
- i3.large: Para databases con alta I/O
- Ejemplo: Elasticsearch cluster para búsqueda de logs
```

**Cuándo usar EC2 vs. Lambda:**
```
Usa EC2 si:
- Proceso corre >15 minutos
- Necesitas control del OS
- Software específico no disponible en Lambda
- High-memory workloads (>10GB RAM)

Usa Lambda si:
- Proceso <15 minutos
- Event-driven
- Scaling automático es crítico
- No quieres gestionar servidores
```

### Amazon RDS (Relational Database Service)

**Qué es:** Bases de datos relacionales managed (PostgreSQL, MySQL, SQL Server, Oracle).

**Ventajas sobre EC2 + BD self-hosted:**
```
RDS Gestiona:
├── Backups automáticos (retention configurable)
├── Patches del motor de BD
├── High Availability (Multi-AZ)
├── Read Replicas (escalado de lecturas)
├── Monitoring con CloudWatch
└── Encryption at rest y in transit

Tú solo:
├── Diseñas esquema
├── Optimizas queries
└── Gestionas usuarios y permisos
```

**Usos en Data Engineering:**
```
1. Metadata Store
   - Airflow metadata database
   - Glue Data Catalog (usa RDS internamente)

2. Operational Databases
   - Transactional data source para ETL
   - Read replica para evitar impacto en producción

3. Small Data Warehouses
   - Datasets <1TB con queries SQL
   - Alternativa a Redshift para casos simples
```

**Ejemplo de architecture:**
```
Production App → RDS Primary (Multi-AZ)
                      ↓
                Read Replica (para reporting/ETL)
                      ↓
                ETL Job (Glue) → Extract data
                      ↓
                S3 Data Lake
```

---

## 6. AWS Pricing Models

Entender el modelo de costos es crítico para optimización y evitar sorpresas en la factura.

### On-Demand Pricing

**Modelo:** Pago por uso, sin compromisos.

**Características:**
- Sin costos upfront
- Sin contratos a largo plazo
- Paga solo por lo que usas

**Cuándo usar:**
```
✅ Workloads impredecibles
✅ Desarrollo y testing
✅ Short-term projects
✅ Aplicaciones con tráfico spiky
```

**Ejemplo de costos:**
```
Lambda:
- $0.20 por 1M de requests
- $0.0000166667 por GB-segundo

S3:
- $0.023 per GB/month (Standard storage)
- $0.0004 por 1000 GET requests

RDS PostgreSQL (db.t3.medium):
- $0.068 por hora = ~$50/mes
```

### Reserved Instances (RIs)

**Modelo:** Compromiso de 1 o 3 años a cambio de descuento de hasta 75%.

**Tipos:**
```
1. Standard RI: Máximo descuento, menos flexibilidad
2. Convertible RI: Cambiar instance type, menor descuento
3. Scheduled RI: Para workloads predecibles por horario
```

**Ejemplo de ahorro:**
```
EC2 m5.xlarge On-Demand: $0.192/hora × 24 × 365 = $1,681/año

EC2 m5.xlarge 3-year RI: $0.046/hora × 24 × 365 = $403/año

Ahorro: $1,278/año (76% descuento)
```

**Cuándo usar:**
```
✅ Workloads de producción estables
✅ Databases que corren 24/7 (RDS, Redshift)
✅ Base layer de Auto Scaling Groups
```

### Spot Instances

**Modelo:** Compra capacidad no utilizada con descuento de hasta 90%.

**Catch:** AWS puede terminar tu instancia con 2 minutos de aviso.

**Cuándo usar:**
```
✅ Batch processing tolerante a interrupciones
✅ Spark jobs que pueden reanudar desde checkpoint
✅ CI/CD test environments
✅ Data processing no time-sensitive

❌ Databases de producción
❌ Aplicaciones stateful sin checkpoint
❌ Real-time processing crítico
```

**Ejemplo para Data Engineering:**
```
EMR Cluster para procesamiento nocturno:
- Core nodes: On-Demand (master + state)
- Task nodes: 100% Spot (solo compute)

Costo On-Demand: 10 × m5.2xlarge × 8 horas = $30.72
Costo Spot (70% discount): = $9.22

Ahorro por job: $21.50
Ahorro mensual (30 jobs): $645
```

### Savings Plans

**Modelo:** Compromiso de gasto por hora durante 1 o 3 años.

**Ventajas vs. RIs:**
- Más flexibilidad (cualquier region, instance type, OS)
- Aplica automáticamente a Lambda, Fargate, EC2

**Ejemplo:**
```
Te comprometes a gastar $10/hora por 1 año = $87,600

AWS aplica descuento a:
├── EC2 instances (cualquier tipo)
├── Lambda invocations
├── Fargate containers
└── Automatically al uso que más descuento genere
```

### Free Tier

**12 meses gratuitos** desde creación de cuenta AWS:
```
EC2:
- 750 horas/mes de t2.micro o t3.micro

S3:
- 5GB de Standard storage
- 20,000 GET requests, 2,000 PUT requests

Lambda:
- 1M requests gratuitos/mes
- 400,000 GB-seconds de compute

RDS:
- 750 horas/mes de db.t2.micro
- 20GB de storage

DynamoDB:
- 25GB de storage
- 25 Read/Write Capacity Units

Athena:
- 10GB de data scanned/mes

Glue:
- 1M objects stored en Data Catalog
```

**Always Free (perpetuo):**
```
Lambda: 1M requests + 400,000 GB-sec/mes
DynamoDB: 25GB + 25 RCU/WCU
CloudWatch: 10 custom metrics, 10 alarms
```

### Cost Optimization Tips para Data Engineering

**1. Use S3 Intelligent-Tiering**
```bash
# Lifecycle policy automática para ahorrar en storage
aws s3api put-bucket-lifecycle-configuration \
  --lifecycle-configuration '{
    "Rules": [{
      "Status": "Enabled",
      "Transitions": [{
        "Days": 90,
        "StorageClass": "INTELLIGENT_TIERING"
      }]
    }]
  }'
```

**2. Compress Data**
```
CSV sin comprimir: 100GB × $0.023 = $2.30/mes
Parquet Snappy: 10GB × $0.023 = $0.23/mes

Ahorro: 90% en storage + menor costo en queries Athena
```

**3. Partition Data en S3**
```
Sin particiones:
s3://bucket/data/

Athena escanea TODO = $5 per TB scanned

Con particiones:
s3://bucket/data/year=2024/month=01/

Athena escanea solo necesario = $0.05 per query

100 queries: $500 vs. $5 → 99% ahorro
```

**4. Use Spot for Batch Workloads**
```python
# EMR con Spot instances
emr_client.run_job_flow(
    Instances={
        'InstanceGroups': [
            {
                'Name': 'Master',
                'Market': 'ON_DEMAND',  # Master siempre On-Demand
                'InstanceRole': 'MASTER',
                'InstanceType': 'm5.xlarge',
                'InstanceCount': 1
            },
            {
                'Name': 'Workers',
                'Market': 'SPOT',  # Workers en Spot para ahorrar
                'InstanceRole': 'CORE',
                'InstanceType': 'm5.2xlarge',
                'InstanceCount': 10,
                'BidPrice': '0.15'  # 70% menos que On-Demand
            }
        ]
    }
)
```

---

## 7. AWS Well-Architected Framework

Framework de best practices de AWS basado en 5 pilares. **Esencial para diseñar sistemas de producción.**

### Pilar 1: Operational Excellence

**Principio:** Ejecutar y monitorear sistemas para entregar valor de negocio.

**Para Data Engineering:**
```
1. Infrastructure as Code (IaC)
   - Todo en Terraform/CloudFormation
   - Versionado en Git
   - Reproducible y auditable

2. Monitoring y Observability
   - CloudWatch Logs para todos los servicios
   - Métricas custom (ej: registros procesados/minuto)
   - Alarmas para SLAs (99.9% de jobs exitosos)

3. Runbooks y Playbooks
   - Documentar procedimientos comunes
   - "Qué hacer si falla el pipeline nocturno"
   - Scripts de recovery automatizados
```

### Pilar 2: Security

**Principio:** Proteger información, sistemas y assets.

**Para Data Engineering:**
```
1. Encryption everywhere
   ├── At Rest: S3 con KMS, RDS encrypted
   ├── In Transit: TLS 1.2+ para todas las conexiones
   └── En processing: Spark con encryption

2. Principle of Least Privilege (IAM)
   - Roles específicos por servicio
   - Policies restrictivas
   - Auditar con Access Analyzer

3. Data Classification
   ├── Public: Open datasets
   ├── Internal: Analytics agregados
   ├── Confidential: PII, financial data
   └── Restricted: Secrets, credentials

4. Compliance
   - GDPR: Right to deletion (S3 lifecycle delete)
   - HIPAA: Encryption + audit logging (CloudTrail)
   - SOC2: Access controls + monitoring
```

### Pilar 3: Reliability

**Principio:** Sistemas que funcionan correctamente y se recuperan de fallas.

**Para Data Engineering:**
```
1. Multi-AZ por defecto
   - RDS Multi-AZ para metadata stores
   - S3 replica automáticamente entre AZs
   - Lambda se despliega en todas las AZs

2. Backups automatizados
   - S3 Versioning para data lake
   - RDS automated backups (7-35 días retention)
   - Glue Data Catalog backup con scripts

3. Graceful Degradation
   Ejemplo: Pipeline con 3 fuentes de datos
   - Source A falla → Log error, continúa con B y C
   - No falla todo el pipeline por un source

4. Idempotencia
   - Rerun de ETL produce mismo resultado
   - Upserts en lugar de inserts
   - Prevent duplicados con deduplication
```

### Pilar 4: Performance Efficiency

**Principio:** Usar recursos de manera eficiente para cumplir requisitos.

**Para Data Engineering:**
```
1. Columnar Formats
   CSV → Parquet: 10x menos storage + 10x queries más rápidos

2. Partitioning
   s3://data/year=2024/month=01/day=15/
   Query solo lee particiones necesarias

3. Right-sizing
   - Lambda: 1GB RAM para transformaciones ligeras
   - Glue: 2 DPU para datasets pequeños, 10 DPU para grandes
   - RDS: db.t3.medium para dev, db.r5.xlarge para prod

4. Caching
   - Athena query results cache (24 horas)
   - Lambda con /tmp para datos reutilizables
   - CloudFront para dashboards
```

### Pilar 5: Cost Optimization

**Principio:** Evitar gastos innecesarios.

**Para Data Engineering:**
```
1. Lifecycle Policies
   Raw data: Delete después de 90 días
   Processed data: Move a Glacier después de 1 año

2. Spot Instances
   EMR/Glue clusters para batch processing

3. Serverless donde sea posible
   Lambda < $1/millón de requests
   Athena: Pay per query ($5/TB scanned)
   vs. mantener cluster 24/7

4. Data Compression
   Parquet + Snappy = 90% menos storage

5. Reserved Capacity
   RDS, Redshift para workloads 24/7
```

---

## 8. Key Takeaways para Data Engineers

### Mental Models Esenciales

**1. Think in Services, not Servers**
```
Mentalidad tradicional:
"Necesito un servidor para procesar datos"

Mentalidad Cloud:
"Qué servicio resuelve mi problema con menos overhead?"

Ejemplo:
- Proceso de 5 minutos → Lambda (serverless)
- Proceso de 3 horas → Glue (managed Spark)
- Proceso de 12 horas → EMR (cluster ephemeral)
```

**2. Everything is API-driven**
```python
# No hay UI que hacer click manualmente
# Todo es programático y reproducible

# Crear bucket S3
s3_client.create_bucket(Bucket='my-data-lake')

# Lanzar EMR cluster
emr_client.run_job_flow(...)

# Query con Athena
athena_client.start_query_execution(...)
```

**3. Design for Cost**
```
Cada decisión arquitectónica tiene impacto en costos:

Mala práctica:
- Cluster EMR 24/7 → $5,000/mes
- Solo se usa 2 horas/día

Buena práctica:
- EMR ephemeral clusters
- Launch on-demand → Process → Terminate
- Costo: $300/mes (94% ahorro)
```

**4. Data Lakes como Fundamento**
```
Data Lake (S3):
├── Raw Zone: Datos originales inmutables
├── Processed Zone: Datos limpios y validados
├── Curated Zone: Datasets listos para análisis
└── Archive Zone: Datos históricos (Glacier)

Todo el ecosistema lee/escribe de/a S3:
- Athena queries desde S3
- Glue ETL: S3 → transform → S3
- EMR: S3 input/output
- Lambda: Triggered por S3 events
- SageMaker: Training data en S3
```

### Common Patterns

**Pattern 1: Event-Driven Processing**
```
S3 Upload Event → SNS → Lambda → Process → DynamoDB
                    ↓
                  SQS (for reliability)
```

**Pattern 2: Batch Processing**
```
CloudWatch Event (cron) → Step Function → Glue Job → S3
                                              ↓
                                           SNS (alertas)
```

**Pattern 3: Streaming Processing**
```
Kinesis Data Stream → Lambda → S3 (partitioned)
                        ↓
                   DynamoDB (real-time queries)
```

---

## 9. Escenario Real: E-Commerce Data Pipeline

**Contexto:** Tienda online con 100K transacciones/día necesita pipeline de analytics.

**Requisitos:**
1. Ingestar transacciones en tiempo real
2. Procesar datos y calcular métricas diarias
3. Almacenar para análisis histórico
4. Dashboard para stakeholders
5. Bajo costo (<$500/mes)

**Arquitectura AWS:**

```
1. Data Ingestion (Real-time)
   Website/Mobile App → API Gateway → Lambda → Kinesis Data Stream
   
   Costo: ~$50/mes
   - API Gateway: $3.50 per million requests
   - Lambda: Free tier cubre
   - Kinesis: $0.015 per shard-hour × 2 shards = $22/mes

2. Stream Processing
   Kinesis → Lambda (consumer) → S3 (partitioned Parquet)
                              → DynamoDB (current state)
   
   Costo: ~$80/mes
   - Lambda: Minimal (free tier)
   - S3: 30GB/mes × $0.023 = $0.70/mes
   - DynamoDB: On-demand, ~$50/mes para 100K writes + reads

3. Batch Processing (Daily)
   CloudWatch Event (daily) → Glue Crawler → Glue ETL Job → S3 (curated)
   
   Costo: ~$15/mes
   - Glue Crawler: $0.44/hr × 0.5hr/día = $6.60/mes
   - Glue Job: 2 DPU × $0.44/hr × 1hr/día = $13.20/mes

4. Analytics Layer
   Athena (query S3) ← QuickSight (dashboard)
   
   Costo: ~$50/mes
   - Athena: $5/TB scanned, ~100GB/mes = $0.50/mes
   - QuickSight: $9/user/mes × 5 users = $45/mes

5. Storage
   S3 (12 meses históricos):
   - 30GB/mes × 12 meses = 360GB × $0.023 = $8.30/mes
   - Lifecycle: >6 meses → Standard-IA → ahorro 45%

Total: ~$203/mes

Escalabilidad:
- 100K → 1M transactions/día
- Kinesis: Add shards (linear scaling)
- Lambda: Auto-scales
- Glue: Increase DPUs
- Estimated: ~$600/mes
```

**Ventajas de este diseño:**
- ✅ Serverless: Sin servidores que gestionar
- ✅ Auto-scaling: Maneja picos de tráfico
- ✅ Cost-effective: Pay only for use
- ✅ Resilient: Multi-AZ, S3 durability 99.999999999%
- ✅ Analytics-ready: Athena queries en segundos

---

## 10. Self-Assessment Questions

Responde estas preguntas para validar tu comprensión:

**1. Architecture Design**
```
Diseña una arquitectura AWS para:
- Ingestar logs de 1000 servidores (10GB/día)
- Procesar y almacenar para análisis
- Retener logs 7 años para compliance
- Budget: $200/mes

Considera:
- Qué servicios usarías
- Cómo optimizarías costos
- Dónde aplicarías lifecycle policies
```

**2. IAM Scenario**
```
Tienes un data engineer que necesita:
✅ Leer todos los buckets S3
✅ Ejecutar Glue jobs existentes
❌ NO debe poder eliminar buckets S3
❌ NO debe poder crear nuevos Glue jobs

Escribe la IAM Policy
```

**3. Cost Optimization**
```
Tu factura AWS es $5,000/mes:
- RDS PostgreSQL db.m5.2xlarge 24/7: $2,400
- EMR cluster 24/7 para batch jobs nocturnos: $1,800
- S3 storage 10TB sin lifecycle policies: $230
- Athena queries sobre CSV: $500

¿Cómo optimizarías a <$2,000/mes?
```

**4. Reliability**
```
Tu pipeline ETL falla cada 2-3 semanas con error:
"Lambda timeout después de 15 minutos"

El proceso:
- Lee 50,000 archivos CSV de S3
- Transforma con Pandas
- Escribe a Parquet

¿Qué arquitectura propondrías?
```

**5. Service Selection**
```
Necesitas procesar un dataset de 5GB diariamente:
- Lectura de S3
- Transformaciones (joins, aggregations)
- Escritura a otro bucket S3

Opciones:
A) Lambda
B) Glue (2 DPU)
C) EMR (3-node cluster)
D) EC2 con Spark

¿Cuál elegirías y por qué?
```

**6. Multi-Region Strategy**
```
Aplicación con usuarios en:
- 60% USA
- 30% Europa
- 10% Asia

Data lake en us-east-1.
Usuarios EU se quejan de lentitud en queries.

¿Cómo resolverías sin duplicar costos?
```

---

## Próximos Pasos

**Has completado el módulo teórico.** Ahora es momento de aplicar estos conceptos:

1. **Ejercicio 01:** Configura AWS CLI y crea tu primer bucket S3
2. **Ejercicio 02:** Crea policies IAM restrictivas
3. **Ejercicio 03:** Implementa S3 bucket policies
4. **Ejercicio 04:** Despliega tu primera Lambda function
5. **Ejercicio 05:** Infrastructure as Code con CloudFormation
6. **Ejercicio 06:** Cost optimization con lifecycle policies

**Recuerda:**
- Lee la teoría completamente antes de empezar ejercicios
- Revisa recursos adicionales en `theory/resources.md`
- Usa hints progresivos si te atascas
- Solo mira la solución cuando hayas intentado todo

**Tiempo estimado para ejercicios:** 5-8 horas

¡Éxito en tu aprendizaje! 🚀
