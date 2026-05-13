# Day 6: Set Up Code Quality Tools for ML Code

## Task

The xFusionCorp Industries ML team enforces code quality with `ruff` and `black` on every pull request. The project at `/root/code/fraud-detection/` currently fails both tools. Make it pass them.

**Requirements:**
- `ruff` and `black` both configured with line length of `120`
- `ruff` lint rule selection includes `E`, `F`, `W`, `I`, declared under `[tool.ruff.lint]`
- `ruff check src/` exits with status 0
- `black --check src/` exits with status 0

---

## Diagnosis

### `pyproject.toml`

| Issue | Original | Fix |
|-------|----------|-----|
| `ruff` line length | `88` | `120` |
| `ruff` select section | `[tool.ruff]` | `[tool.ruff.lint]` (required by ruff 0.1+) |
| `ruff` missing rules | `["E", "F"]` | `["E", "F", "W", "I"]` |
| `black` line length | `100` | `120` |

### `src/data/process_data.py`

| Issue | Fix |
|-------|-----|
| `import os` — unused import (triggers `F401`) | remove the line |

---

## Solution

### `pyproject.toml`

```toml
[project]
name = "fraud-detection"
version = "0.1.0"

[tool.ruff]
line-length = 120

[tool.ruff.lint]
select = ["E", "F", "W", "I"]

[tool.black]
line-length = 120
```

### `src/data/process_data.py`

Remove `import os` from the top of the file.

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `[tool.ruff.lint]` | Since ruff 0.1, lint rules must be declared in this subsection, not in `[tool.ruff]` |
| `E` / `F` / `W` | pycodestyle errors, pyflakes, and pycodestyle warnings |
| `I` | isort — import ordering rules |
| `F401` | Unused import — the violation triggered by `import os` |
| `black --check` | Validates formatting without modifying files; exits non-zero if anything would change |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `pyproject.toml` | Corrected tool configuration |
| `solution.sh` | All commands needed to complete the task |
