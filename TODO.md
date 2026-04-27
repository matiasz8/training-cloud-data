# 📋 TODO: Next Steps & Roadmap

**Status:** Phase 4 in progress (2/3) + Phase 5.2 in progress  
**Current Date:** April 26, 2026  
**Last Updated:** After Phase 5.1 migration guide creation

---

## 🔴 Phase 4: Pre-commit & CI Integration (PRIORITY: HIGH)

**Time Estimate:** 4-6 horas  
**Impact:** Automatiza validación en pre-commit + bloquea merges automáticamente

### Phase 4 Tasks

- [x] **4.1 - Create `.pre-commit-config.yaml`**
  - Location: Root of training-cloud-data/
  - Content: Register 2 validators as pre-commit hooks
    - validate_learning_labs.py
    - validate_english_content.py
  - Test: `pre-commit run --all-files`
  - Expected: Exit 0, validators execute
  - Effort: ~1-2h

- [x] **4.2 - Create `.github/workflows/validate-modules.yml`**
  - Trigger: On push to PR, on.pull_request
  - Jobs:
    - Run `validate-contract` (Makefile)
    - Run `validate-language` (Makefile)
    - Publish JSON report as PR comment
    - Block merge if exit ≠ 0
  - Test: Create test PR with intentional error
  - Expected: Workflow fails, comment appears
  - Effort: ~2-3h

- [ ] **4.3 - Test End-to-End PR Flow**
  - Create branch: `test/phase-4-pr-flow`
  - Modify module slightly (e.g., rename file)
  - Create PR
  - Verify:
    - Pre-commit ran ✅
    - GitHub Actions ran ✅
    - Report comment posted ✅
  - Merge if clean
  - Effort: ~1h

---

## 🟡 Phase 5: Full English Content Migration (PRIORITY: MEDIUM)

**Time Estimate:** 8-10 horas  
**Impact:** Elimina contenido mixto español/inglés

### Current State
- 9 módulos con secciones English appended (mixed language)
- Falta full content replacement

### Phase 5 Tasks

- [x] **5.1 - Study Migration Pattern**
  - Location: Refer to nan-ai-engineering-labs
  - Document: cómo convirtieron contenido español → English
  - Create: `docs/ENGLISH-MIGRATION-GUIDE.md`
  - Effort: ~1-2h

- [x] **5.2 - Full Content Replacement (9 Modules) - STARTED**
   - ✅ module-01-cloud-fundamentals: COMPLETE (commit 25e3b56)
       - README.md: Full English translation
       - theory/concepts.md: Translated (dictionary + deep-translator)
       - theory/architecture.md: Translated
       - theory/resources.md: Full English translation
       - All 6 exercises: README, hints files translated
       - Status/infrastructure/validation files: Translated
   - ✅ module-02-storage-basics: COMPLETE (commit 3a2de07)
   - ✅ module-03-sql-foundations: COMPLETE (commit 3a2de07)
   - ✅ module-04-python-for-data: COMPLETE (commit 3ff44c8)
   - ✅ module-05-data-lakehouse: COMPLETE (commit 3ff44c8)
   - ⬜ Remaining modules (06-09): Not yet started
     - module-06-etl-fundamentals
     - module-07-batch-processing
     - module-08-streaming-basics
     - module-09-data-quality
   - Next: Continue with modules 08-09 in next execution phase
  - Effort: ~6-8h (distributed)

- [ ] **5.3 - Re-validate After Migration**
  - Run: `make validate-all`
  - Expected: 0 errors, 0 warnings, 0 findings
  - Fix any issues found
  - Effort: ~1h

---

## 🟡 Phase 6: Skills Playbook & Templates (PRIORITY: MEDIUM)

**Time Estimate:** 6-8 horas  
**Impact:** Habilita autonomía de autores nuevos

### Phase 6 Tasks

- [ ] **6.1 - Create `docs/SKILLS-PLAYBOOK.md`**
  - Section 1: cloud-data-module-standardization
    - When to use
    - Step-by-step guide
    - Example: Run on module-01
    - Troubleshooting
  - Section 2: cloud-data-english-standards
    - When to use
    - Scope options (DEFAULT vs FULL_SCAN)
    - Example: Check existing module
    - Troubleshooting
  - Section 3: Integration with Copilot/GitHub Copilot Chat
    - How to invoke skills from Copilot
    - Common patterns
  - Effort: ~2-3h

- [ ] **6.2 - Create `shared/templates/NEW-MODULE-TEMPLATE/`**
  - Structure:
    ```
    NEW-MODULE-TEMPLATE/
    ├── README.md (preformatted with sections)
    ├── theory/
    │   ├── concepts.md (template)
    │   ├── architecture.md (example diagram)
    │   └── resources.md (empty)
    ├── exercises/
    │   ├── 01-example-exercise/
    │   │   ├── starter/
    │   │   ├── solution/
    │   │   ├── my_solution/
    │   │   └── hints.md
    │   └── ...
    ├── validation/
    │   ├── integration/
    │   └── data-quality/
    ├── infrastructure/
    ├── data/
    └── scripts/
  - Effort: ~1-2h

- [ ] **6.3 - Update CONTRIBUTING.md with Authoring Guide**
  - Section: "Creating a New Module"
    - Step 1: Copy NEW-MODULE-TEMPLATE
    - Step 2: Run validation
    - Step 3: Use cloud-data-module-standardization skill
    - Step 4: Use cloud-data-english-standards skill
    - Step 5: Create PR
  - Add reference to MODULE-CONTRACT-MATRIX
  - Effort: ~1-2h

- [ ] **6.4 - Create "New Module Quickstart" Script**
  - Location: `scripts/create-new-module.sh`
  - Functionality:
    - Prompt for module name
    - Copy from NEW-MODULE-TEMPLATE
    - Auto-generate README header
    - Run validators
    - Create branch
  - Usage: `./scripts/create-new-module.sh "module-xx-description"`
  - Effort: ~1-2h

---

## 🟢 Phase 7: Extended Learner Tracking (PRIORITY: LOW - Optional)

**Time Estimate:** 8-12 horas  
**Impact:** Progress tracking beyond file-system scan

### Phase 7 Tasks

- [ ] **7.1 - Extend `scripts/progress.py`**
  - Add learner state tracking
    - Read completion marks per module
    - Track exercise completion
    - Validate prerequisite satisfaction
  - Output: JSON dashboard data
  - Effort: ~4-6h

- [ ] **7.2 - Optional: Create Learner Dashboard**
  - Frontend: Simple HTML/JS
  - Features:
    - Progress bar per learner
    - Completed modules list
    - Prerequisite warnings
    - Time to completion estimate
  - Serve: `python -m http.server` from dashboards/
  - Effort: ~4-6h

---

## 📊 Summary Table

| Phase | Title | Priority | Time | Status | Next Action |
|-------|-------|----------|------|--------|------------|
| 4 | Pre-commit & CI | 🔴 HIGH | 4-6h | 🟨 IN PROGRESS (2/3) | Run end-to-end PR flow test (4.3) |
| 5 | English Migration | 🟡 MED | 8-10h | 🟨 IN PROGRESS (7/9 complete) | Continue with modules 08-09 |
| 6 | Skills Playbook | 🟡 MED | 6-8h | ⬜ TODO | Draft `SKILLS-PLAYBOOK.md` |
| 7 | Learner Tracking | 🟢 LOW | 8-12h | ⬜ OPTIONAL | Extend progress.py (nice-to-have) |

---

## ✅ Completed Phases (Reference)

### Phase 1: Infrastructure Foundation (COMPLETE ✅)
- ✅ 23 modules created
- ✅ Docker environment
- ✅ Automation scripts
- ✅ Shared utilities

### Phase 2: Documentation & Learning Path (COMPLETE ✅)
- ✅ README.md + LEARNING-PATH.md
- ✅ Setup guides
- ✅ Module prerequisites
- ✅ Progress tracking system

### Phase 3: Governance & Automation (COMPLETE ✅)
- ✅ AGENTS.md + CONTRIBUTING.md
- ✅ MODULE-CONTRACT-MATRIX.md
- ✅ Validators (2 scripts)
- ✅ Skills & Agents scaffolding
- ✅ Makefile targets
- ✅ Structural normalization (23/23 modules)
- ✅ Exercise asset bootstrap (119+ directories)
- ✅ Validation PASS (EXIT CODE 0)

---

## 🎯 Quick Commands

**Check current validation status:**
```bash
cd training-cloud-data/
make validate-all
```

**Run validators individually:**
```bash
make validate-contract      # Structural validation
make validate-language      # English-only validation
```

**Expected output after Phase 4-5:**
```
EXIT_CODE: 0
EXIT_CODE_EN: 0
✅ All validators passing
```

---

## 📝 Notes

- All completed phases have been validated with EXIT CODE 0
- Skills and agents are scaffolded, ready for detailed implementation
- New authors should follow CONTRIBUTING.md guidelines
- Reference `MODULE-CONTRACT-MATRIX.md` for structural requirements

---

**Last Session:** April 26, 2026  
**Current Owner:** nquiroga  
**Contact:** For governance questions, see AGENTS.md
