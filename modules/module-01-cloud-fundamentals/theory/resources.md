# Recursos de Aprendizaje: Cloud Fundamentals

Esta lista contiene recursos oficiales y de calidad verificada para profundizar en los conceptos del módulo.

---

## 📚 Documentación Oficial AWS

### Essential Reading

1. **AWS Well-Architected Framework**
   - URL: https://aws.amazon.com/architecture/well-architected/
   - Tiempo: 2-3 horas
   - Por qué: Framework de best practices usado por arquitectos AWS
   - Enfócate en: Los 5 pilares y cómo aplicarlos a data engineering

2. **AWS Global Infrastructure**
   - URL: https://aws.amazon.com/about-aws/global-infrastructure/
   - Tiempo: 30 minutos
   - Interactive map de regiones, AZs y edge locations
   - Entiende: Cómo elegir región según latency, compliance, costos

3. **IAM Best Practices**
   - URL: https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html
   - Tiempo: 1 hora
   - Crítico para seguridad en todos tus proyectos
   - Memoriza: Principle of least privilege, MFA, roles vs users

4. **Amazon S3 User Guide**
   - URL: https://docs.aws.amazon.com/s3/
   - Tiempo: 3-4 horas (lectura selectiva)
   - Secciones clave:
     - Storage classes and lifecycle management
     - Versioning
     - Event notifications
     - Performance optimization

5. **AWS Lambda Developer Guide**
   - URL: https://docs.aws.amazon.com/lambda/
   - Tiempo: 2 horas
   - Secciones clave:
     - Execution model
     - Permissions (execution role)
     - Best practices
     - Monitoring and troubleshooting

---

## 🎥 Videos Oficiales AWS

### AWS re:Invent Talks

**1. AWS re:Invent 2023: Building Data Lakes on AWS**
- YouTube: Buscar "AWS re:Invent 2023 data lakes"
- Duración: 50 minutos
- Speaker: AWS Solutions Architect
- Key Timestamps:
  - 00:00-10:00: Data lake architecture overview
  - 10:00-25:00: S3 as foundation (zones, partitioning)
  - 25:00-35:00: AWS Glue for cataloging and ETL
  - 35:00-50:00: Real customer case study
- Por qué: Aprende arquitectura de data lakes directamente de AWS

**2. AWS re:Invent 2022: Security Best Practices for Data Engineers**
- Duración: 45 minutos
- Key Timestamps:
  - 00:00-15:00: IAM policies and roles
  - 15:00-30:00: Encryption (KMS, at rest, in transit)
  - 30:00-45:00: VPC, security groups, endpoints
- Por qué: Seguridad desde el inicio, no como afterthought

**3. AWS re:Invent 2023: Serverless Data Processing at Scale**
- Duración: 60 minutos
- Key Timestamps:
  - 00:00-20:00: Lambda patterns for data processing
  - 20:00-40:00: Step Functions for orchestration
  - 40:00-60:00: Cost optimization techniques
- Por qué: Aprende cuándo usar serverless vs. containers/VMs

### AWS Digital Courses

**4. AWS Skill Builder: AWS Cloud Practitioner Essentials**
- URL: https://aws.amazon.com/training/digital/aws-cloud-practitioner-essentials/
- Duración: 6 horas (self-paced)
- Gratis con cuenta AWS
- Cubre:
  - AWS global infrastructure
  - Compute, storage, databases
  - Security and compliance
  - Pricing and support
- Por qué: Fundamentos sólidos antes de especializarte en data

**5. AWS Skill Builder: Getting Started with AWS Storage**
- Duración: 4 horas
- Gratis
- Deep dive en S3, EBS, EFS
- Por qué: S3 es el corazón de data engineering en AWS

---

## 🎓 Cursos de Instructores Reconocidos

### Stephane Maarek (Highly Recommended)

**6. Ultimate AWS Certified Cloud Practitioner**
- Plataforma: Udemy
- Duración: 14 horas
- Precio: ~$15-20 (espera sales de Udemy)
- Rating: 4.7/5 (500K+ students)
- Por qué: Mejor curso introductorio a AWS, muy didáctico
- Cubre: Todo lo necesario para entender AWS desde cero

**7. Ultimate AWS Certified Solutions Architect Associate**
- Plataforma: Udemy
- Duración: 27 horas
- Precio: ~$15-20
- Rating: 4.7/5 (800K+ students)
- Por qué: Profundiza en arquitecturas, incluye muchos servicios de data
- Nota: Más avanzado, considera para después de Module 04

### FreeCodeCamp (YouTube - GRATIS)

**8. AWS Certified Cloud Practitioner Training 2023**
- URL: https://www.youtube.com/watch?v=SOTamWNgDKc
- Duración: 13 horas
- Gratis
- Instructor: Andrew Brown (ExamPro)
- Por qué: Alternativa gratuita excelente a cursos pagos
- Tip: Velocidad 1.25x para contenido ya conocido

**9. AWS Certified Solutions Architect - Associate 2023**
- URL: Buscar en YouTube FreeCodeCamp AWS Solutions Architect
- Duración: 10+ horas
- Gratis
- Por qué: Cubre arquitecturas más complejas, útil para data engineering

---

## 📖 Blogs y Artículos Técnicos

**10. AWS Architecture Blog**
- URL: https://aws.amazon.com/blogs/architecture/
- Frecuencia: Semanal
- Por qué: Arquitecturas de referencia con diagramas y código
- Artículos recomendados:
  - "Building a Data Lake on AWS"
  - "Serverless Analytics Architecture"
  - "Cost Optimization for Data Workloads"

**11. AWS Big Data Blog**
- URL: https://aws.amazon.com/blogs/big-data/
- Frecuencia: 2-3 veces/semana
- Por qué: Específico para data engineering
- Busca artículos sobre: Glue, EMR, Athena, Lake Formation

**12. AWS Startups Blog - Data & Analytics**
- URL: https://aws.amazon.com/blogs/startups/tag/data-analytics/
- Por qué: Casos de uso reales de startups con presupuestos limitados
- Aprende: Cómo hacer más con menos ($)

---

## 🛠️ Hands-On Labs (Gratis)

**13. AWS Workshops**
- URL: https://workshops.aws/
- Categoría: Analytics & Data Lakes
- Workshops recomendados:
  - "Building a Data Lake on AWS"
  - "Serverless Data Processing"
  - "AWS Glue ETL Workshop"
- Tiempo: 2-3 horas por workshop
- Por qué: Práctica guiada con cuenta AWS real
- Costo: Free tier suficiente, cuidado de limpiar recursos después

**14. AWS Free Tier Hands-On Tutorials**
- URL: https://aws.amazon.com/getting-started/hands-on/
- Filtrar por: Storage, Analytics, Serverless
- Tutoriales paso a paso:
  - "Store and Retrieve a File with S3"
  - "Run a Serverless Hello World"
  - "Query Data in S3 with Athena"
- Tiempo: 15-30 min por tutorial
- Por qué: Familiarizarte con AWS Console y servicios básicos

---

## 📊 Whitepapers AWS (Lectura Avanzada)

**15. AWS Well-Architected Framework - Data Analytics Lens**
- URL: https://docs.aws.amazon.com/wellarchitected/latest/analytics-lens/
- Páginas: ~80
- Tiempo: 3-4 horas
- Por qué: Best practices específicas para data workloads
- Lee después de: Completar ejercicios del módulo

**16. Cost Optimization for Data Lakes**
- URL: Buscar en AWS whitepapers
- Por qué: Aprende a diseñar arquitecturas cost-effective desde el inicio

---

## 🎙️ Podcasts (Opcional - Para commutes)

**17. AWS Podcast**
- URL: https://aws.amazon.com/podcasts/aws-podcast/
- Episodios relevantes: Buscar "data" en el catálogo
- Duración: 20-30 min por episodio
- Por qué: Mantente actualizado con novedades AWS

**18. The Data Engineering Podcast**
- URL: https://www.dataengineeringpodcast.com/
- Episodios con "AWS" en el título
- Por qué: Perspectiva de practitioners, no solo teoría AWS

---

## 📱 Herramientas de Referencia

**19. AWS CLI Command Reference**
- URL: https://docs.aws.amazon.com/cli/
- Usa como referencia durante ejercicios
- Tip: Bookmarkea secciones de S3, IAM, Lambda

**20. AWS SDK for Python (Boto3) Documentation**
- URL: https://boto3.amazonaws.com/v1/documentation/api/latest/index.html
- Imprescindible para automatizar con Python
- Secciones clave: S3, Lambda, Glue, Athena

**21. AWS Pricing Calculator**
- URL: https://calculator.aws/
- Práctica: Estima costos de arquitecturas antes de implementar
- Usa en ejercicio 06 (Cost Optimization)

---

## 🌐 Comunidades y Foros

**22. AWS re:Post (Official Q&A)**
- URL: https://repost.aws/
- Reemplazo oficial de AWS Forums
- Por qué: Respuestas de AWS Solutions Architects y community experts

**23. r/aws (Reddit)**
- URL: https://reddit.com/r/aws
- Por qué: Comunidad activa, troubleshooting, arquitecturas compartidas
- Tip: Busca posts con "data engineering" o "data lake"

**24. AWS Slack Community**
- URL: Buscar "AWS Community Slack" en Google
- Canales relevantes: #analytics, #serverless, #lambda
- Por qué: Chat en tiempo real con otros learners y professionals

---

## 📝 Cheat Sheets y Referencias Rápidas

**25. AWS Services Overview**
- URL: https://aws.amazon.com/products/
- Uso: Vista general de todos los servicios AWS
- Tip: Explora categorías Analytics, Storage, Compute

**26. AWS Service Limits**
- URL: https://docs.aws.amazon.com/general/latest/gr/aws_service_limits.html
- Por qué: Conocer límites (ej: 1000 concurrent Lambdas) antes de diseñar

**27. Markdown Cheat Sheet para Mermaid Diagrams**
- URL: https://mermaid.js.org/syntax/examples.html
- Usa en: architecture.md y tus propios diagramas
- Por qué: Diagramas as code, versionables en Git

---

## 🎯 Roadmap de Consumo Sugerido

### Antes de Ejercicios (8-10 horas)

1. **Día 1-2:** Lee concepts.md completo (este módulo)
2. **Día 3:** AWS Cloud Practitioner Essentials (digital course) - Primeras 3 horas
3. **Día 4:** Video FreeCodeCamp AWS Cloud Practitioner (velocidad 1.5x) - Secciones IAM, S3, Lambda
4. **Día 5:** Lee architecture.md + AWS Well-Architected Framework overview

### Durante Ejercicios (5-8 horas)

- Usa AWS CLI Reference como consulta
- Consulta Boto3 docs cuando escribas Python
- Si te atascas: re:Post o Stack Overflow

### Después de Ejercicios (Opcional, profundizar)

- Stephane Maarek course (si quieres certificarte)
- AWS Workshops hands-on
- Whitepapers para diseño avanzado

---

## 🔖 Bookmarks Sugeridos

Crea carpeta en tu browser: **"AWS Data Engineering"**

Subcarpetas:
```
📁 AWS Data Engineering
├── 📁 Docs Oficiales
│   ├── IAM Best Practices
│   ├── S3 User Guide
│   ├── Lambda Developer Guide
│   └── Well-Architected Framework
├── 📁 Videos
│   ├── FreeCodeCamp AWS (YouTube)
│   └── AWS re:Invent Playlists
├── 📁 Blogs
│   ├── AWS Architecture Blog
│   └── AWS Big Data Blog
├── 📁 Tools
│   ├── AWS Pricing Calculator
│   ├── AWS CLI Reference
│   └── Boto3 Docs
└── 📁 Community
    ├── AWS re:Post
    └── r/aws
```

---

## ⚠️ Advertencias

**No caigas en "Tutorial Hell":**
- No veas todos los videos antes de practicar
- Alterna teoría (1 hora) → práctica (2 horas)
- Los ejercicios son más importantes que videos adicionales

**Evita distracciones:**
- No persigas cada servicio AWS (hay 200+)
- Enfócate en: S3, IAM, Lambda, Glue, Athena para data engineering
- Otros servicios los aprenderás cuando los necesites

**Free Tier limits:**
- Monitorea uso con AWS Budgets (configura alarma $5)
- Elimina recursos después de cada ejercicio
- LocalStack (en este curso) evita costos reales

---

## 📈 Próximos Pasos

Has revisado los recursos disponibles. Ahora:

1. ✅ Completa la lectura de `concepts.md` y `architecture.md`
2. ⏭️ Mira al menos 2 horas de videos recomendados
3. 🏗️ Comienza Exercise 01: AWS CLI & S3 Basics
4. 📖 Consulta estos recursos cuando tengas dudas específicas

**Recuerda:** La mejor forma de aprender cloud es **construyendo**. Estos recursos son complementarios a los ejercicios prácticos.

¡Adelante con los ejercicios! 🚀
