# Módulo 11: Infrastructure as Code con Terraform

⏱️ **Duración estimada**: 16-20 horas  
🎯 **Nivel**: Intermedio a Avanzado  
📋 **Prerequisitos**: Módulos 01-02 completados

## 📖 Descripción del Módulo

Aprende a gestionar infraestructura cloud de forma **declarativa, reproducible y versionable** usando Terraform. Este módulo cubre desde conceptos básicos hasta patrones enterprise para producción.

### ¿Por qué Infrastructure as Code?

- 🚀 **Automatización**: Despliega infraestructura en minutos, no días
- 📝 **Documentación as Code**: La infraestructura se auto-documenta
- 🔄 **Reproducibilidad**: Ambientes idénticos dev/staging/prod
- 🔒 **Control de versiones**: History completo de cambios en Git
- 🧪 **Testing**: Valida infraestructura antes de aplicar
- 💰 **Costo-beneficio**: Destruye/crea entornos on-demand

## 🎯 Objetivos de Aprendizaje

Al completar este módulo, serás capaz de:

- ✅ Entender los fundamentos de Infrastructure as Code
- ✅ Escribir configuraciones de Terraform (HCL syntax)
- ✅ Gestionar el ciclo de vida completo: init → plan → apply → destroy
- ✅ Crear módulos reutilizables y componibles
- ✅ Gestionar state de forma segura (remote state + locking)
- ✅ Implementar estrategias multi-entorno (dev/staging/prod)
- ✅ Aplicar patrones de testing (Terratest)
- ✅ Configurar CI/CD para Terraform
- ✅ Implementar seguridad y compliance
- ✅ Diseñar arquitecturas production-ready

## 📚 Contenido del Módulo

### Teoría (3 documentos, ~30,000 palabras)

1. **[01-terraform-fundamentals.md](theory/01-terraform-fundamentals.md)** (2,891 líneas)
   - ¿Qué es IaC y por qué Terraform?
   - Sintaxis HCL
   - Providers, Resources, Data Sources
   - Variables, Outputs, State
   - Comandos fundamentales

2. **[02-terraform-advanced.md](theory/02-terraform-advanced.md)** (3,932 líneas)
   - Módulos: creación y uso
   - State management avanzado
   - Meta-arguments: count, for_each, depends_on
   - Dynamic blocks
   - Workspaces
   - Testing strategies

3. **[03-iac-patterns.md](theory/03-iac-patterns.md)**
   - CI/CD para Terraform
   - Seguridad y compliance
   - Estrategias multi-entorno
   - Disaster recovery
   - GitOps
   - Policy as Code (OPA)

### Ejercicios Prácticos (6 ejercicios progresivos)

| # | Ejercicio | Duración | Nivel | Descripción |
|---|-----------|----------|-------|-------------|
| 01 | [First Terraform](exercises/01-first-terraform/) | 2-3h | Básico | Tu primer bucket S3, workflow básico, state local |
| 02 | [Multi-Resource](exercises/02-multi-resource/) | 2-3h | Básico | Múltiples recursos, dependencias, count/for_each |
| 03 | [Modules](exercises/03-modules/) | 3-4h | Intermedio | Crear y usar módulos reutilizables |
| 04 | [Data Infrastructure](exercises/04-data-infrastructure/) | 3-4h | Intermedio | Data lake completo (S3, Glue, Athena) |
| 05 | [State Management](exercises/05-state-management/) | 2-3h | Avanzado | Remote state, locking, workspaces |
| 06 | [Production Ready](exercises/06-production-ready/) | 3-4h | Avanzado | Testing, CI/CD, security, DR |

### Infraestructura ([infrastructure/](infrastructure/))

- **terraform/**: Configuraciones de ejemplo
- **modules/**: Módulos reutilizables
  - `s3-bucket/`: Bucket S3 con seguridad
  - `data-lake/`: Data lake bronze/silver/gold
  - `iam-role/`: Roles y policies IAM
- **environments/**: Configs por entorno (dev/staging/prod)

### Validación ([validation/](validation/))

- `conftest.py`: Fixtures de pytest
- `test_terraform.py`: Tests automatizados
- 40+ tests para validar configuraciones

### Scripts ([scripts/](scripts/))

- `setup.sh`: Instalación y configuración inicial
- `validate.sh`: Validación completa del módulo

## 🚀 Getting Started

### 1. Verificar Prerequisitos

```bash
# Terraform 1.0+
terraform version

# AWS CLI (opcional para LocalStack)
aws --version

# Docker (para LocalStack)
docker --version

# Python 3.8+
python3 --version
```

### 2. Setup Inicial

```bash
cd modules/module-11-infrastructure-as-code

# Ejecutar setup automático
bash scripts/setup.sh

# O manual:
pip install -r requirements.txt
```

### 3. Estudiar Teoría

Lee en orden:
1. [theory/01-terraform-fundamentals.md](theory/01-terraform-fundamentals.md)
2. [theory/02-terraform-advanced.md](theory/02-terraform-advanced.md)
3. [theory/03-iac-patterns.md](theory/03-iac-patterns.md)

### 4. Completar Ejercicios

```bash
# Ejercicio 01
cd exercises/01-first-terraform
cat README.md  # Leer instrucciones
terraform init
terraform plan
# ... seguir el README

# Ejercicio 02
cd ../02-multi-resource
# ... y así sucesivamente
```

### 5. Validar Aprendizaje

```bash
# Validación completa
bash scripts/validate.sh

# O tests específicos
cd validation
pytest -v test_terraform.py
```

## 📊 Estructura Detallada

```
module-11-infrastructure-as-code/
├── README.md                 # Este archivo
├── STATUS.md                 # Estado de completitud
├── requirements.txt          # Dependencias Python
├── .gitignore
│
├── theory/                   # 📚 3 archivos, ~7,000 líneas
│   ├── 01-terraform-fundamentals.md
│   ├── 02-terraform-advanced.md
│   └── 03-iac-patterns.md
│
├── exercises/                # 🎯 6 ejercicios progresivos
│   ├── 01-first-terraform/
│   ├── 02-multi-resource/
│   ├── 03-modules/
│   ├── 04-data-infrastructure/
│   ├── 05-state-management/
│   └── 06-production-ready/
│
├── infrastructure/           # 🏗️ Templates y módulos
│   ├── terraform/
│   │   ├── examples/
│   │   └── backend/
│   ├── modules/
│   │   ├── s3-bucket/
│   │   ├── data-lake/
│   │   └── iam-role/
│   └── environments/
│       ├── dev/
│       ├── staging/
│       └── prod/
│
├── validation/               # ✅ Tests automatizados
│   ├── conftest.py
│   └── test_terraform.py
│
├── scripts/                  # 🔧 Automatización
│   ├── setup.sh
│   └── validate.sh
│
├── data/                     # 📊 Datos de ejemplo (opcional)
└── assets/                   # 🖼️ Diagramas (opcional)
```

## 🛠️ Tecnologías y Herramientas

### Core
- **Terraform**: 1.7+ (IaC tool)
- **HashiCorp Configuration Language (HCL)**: Lenguaje declarativo
- **AWS**: Provider principal

### Testing
- **pytest**: Framework de testing Python
- **Terratest**: Testing Go para Terraform
- **tflint**: Linter para Terraform
- **tfsec**: Security scanner

### Development
- **LocalStack**: AWS emulator local
- **Docker**: Para LocalStack
- **pre-commit**: Hooks de Git

### CI/CD
- **GitHub Actions**: Ejemplo de pipeline
- **GitLab CI**: Alternativa

## ✅ Checklist de Completitud

### Teoría
- [ ] Leído `01-terraform-fundamentals.md` completo
- [ ] Leído `02-terraform-advanced.md` completo
- [ ] Leído `03-iac-patterns.md` completo
- [ ] Entiendes el workflow: init → plan → apply → destroy
- [ ] Comprendes el concepto de state file

### Ejercicios
- [ ] Ejercicio 01: First Terraform ✅
- [ ] Ejercicio 02: Multi-Resource ✅
- [ ] Ejercicio 03: Modules ✅
- [ ] Ejercicio 04: Data Infrastructure ✅
- [ ] Ejercicio 05: State Management ✅
- [ ] Ejercicio 06: Production Ready ✅

### Habilidades Prácticas
- [ ] Puedo crear un recurso S3 con Terraform
- [ ] Puedo escribir un módulo reutilizable
- [ ] Entiendo cómo funciona remote state + locking
- [ ] Puedo implementar CI/CD para Terraform
- [ ] Puedo diseñar infraestructura multi-entorno
- [ ] Entiendo patrones de security y compliance

### Validación
- [ ] Todos los tests pasan: `pytest -v`
- [ ] Validación completa: `bash scripts/validate.sh`
- [ ] Código formateado: `terraform fmt -check -recursive`

## 📖 Recursos Adicionales

### Documentación Oficial
- [Terraform Documentation](https://developer.hashicorp.com/terraform/docs)
- [AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- [HCL Syntax](https://developer.hashicorp.com/terraform/language/syntax)

### Libros Recomendados
- "Terraform: Up & Running" by Yevgeniy Brikman
- "Infrastructure as Code" by Kief Morris

### Cursos
- [HashiCorp Learn Terraform](https://learn.hashicorp.com/terraform)
- [A Cloud Guru: Terraform Certified Associate](https://acloudguru.com/)

### Comunidad
- [Terraform Registry](https://registry.terraform.io/)
- [r/Terraform](https://reddit.com/r/terraform)
- [HashiCorp Discuss](https://discuss.hashicorp.com/c/terraform-core/)

## 🐛 Troubleshooting

### Error: "Terraform not found"
```bash
# Instalar Terraform
brew install terraform  # macOS
# O descargar desde: https://www.terraform.io/downloads
```

### Error: "Error locking state"
```bash
# Si el lock está stuck
terraform force-unlock <LOCK_ID>
```

### Error: "Provider not found"
```bash
# Reinicializar
rm -rf .terraform .terraform.lock.hcl
terraform init
```

### LocalStack no inicia
```bash
# Verificar Docker
docker ps

# Reiniciar LocalStack
docker restart localstack
```

## 🏆 Certificación

Este módulo prepara para:
- **HashiCorp Certified: Terraform Associate**
- AWS Certified Solutions Architect (knowledge de IaC)

## 🔗 Módulos Relacionados

**Prerequisitos:**
- ✅ Módulo 01: Cloud Fundamentals
- ✅ Módulo 02: Storage Basics

**Siguiente:**
- ➡️ Módulo 12: Serverless Processing
- ➡️ Módulo 13: Container Orchestration

## 💡 Tips para Éxito

1. **Práctica > Teoría**: Escribe Terraform real, no solo leas
2. **Empieza simple**: Master los básicos antes de avanzar
3. **Usa LocalStack**: Evita costos AWS mientras aprendes
4. **Git desde día 1**: Versiona toda tu infraestructura
5. **State es crítico**: Protégelo siempre
6. **Módulos > Copiar**: Reutiliza en lugar de duplicar
7. **Plan before apply**: SIEMPRE revisa el plan
8. **Destroy regularmente**: No dejes recursos corriendo

## 📞 Soporte

- **Issues**: Abre un issue en el repositorio
- **Preguntas**: Usa Discussions
- **Contribuciones**: Pull requests bienvenidos

---

**¡Hora de convertir clicks en código!** 🚀

Comienza con: [theory/01-terraform-fundamentals.md](theory/01-terraform-fundamentals.md)
