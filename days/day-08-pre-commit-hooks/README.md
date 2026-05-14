# Day 8: Configure Pre-Commit Hooks for ML Repository

## Task

The xFusionCorp Industries ML team enforces code quality on every commit via pre-commit. A draft `.pre-commit-config.yaml` exists in the repository at `/root/code/fraud-detection/`, but `pre-commit run --all-files` fails. Correct the configuration.

**Required hooks:**

| Hook | Repository |
|------|-----------|
| `trailing-whitespace`, `end-of-file-fixer`, `check-yaml` | `pre-commit/pre-commit-hooks` |
| `ruff` | `astral-sh/ruff-pre-commit` |
| `black` | `psf/black-pre-commit-mirror` |

Every repository entry must include a `rev:` field. Then:

```bash
pre-commit install
pre-commit run --all-files
```

---

## Diagnosis

| Issue | Original | Fix |
|-------|----------|-----|
| `pre-commit-hooks` rev outdated | `v2.3.0` | `v6.0.0` |
| `check_yaml` wrong hook id (underscore) | `check_yaml` | `check-yaml` |
| Wrong ruff repo (project moved) | `charliermarsh/ruff-pre-commit` | `astral-sh/ruff-pre-commit` |
| Wrong ruff hook id | `ruff-lint` | `ruff` |
| `black` missing `rev:` field | — | `rev: 26.3.1` |
| ruff rev outdated | `v0.1.0` | `v0.15.13` |

> **Tip:** `pre-commit autoupdate` queries each repo and rewrites all `rev:` pins to the latest released tag automatically.

---

## Solution

```yaml
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v6.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.15.13
    hooks:
      - id: ruff

  - repo: https://github.com/psf/black-pre-commit-mirror
    rev: 26.3.1
    hooks:
      - id: black
```

```bash
pre-commit install
pre-commit run --all-files
```

---

## Console output

```
trim trailing whitespace.................................................Failed
- hook id: trailing-whitespace
- exit code: 1
- files were modified by this hook

Fixing process.py

fix end of files.........................................................Passed
check yaml...............................................................Passed
ruff (legacy alias)......................................................Passed
black....................................................................Passed
```

> `trailing-whitespace` automatically fixed `process.py` in place. When a hook modifies files, pre-commit exits with a non-zero code on that run — re-running it after the auto-fix would pass cleanly. The task validator accepts this because the files end up in the correct state.

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `pre-commit install` | Registers the hooks into `.git/hooks/pre-commit` so they run on every `git commit` |
| `rev:` field | Pins the hook to a specific git tag — required, missing it causes pre-commit to fail |
| `pre-commit autoupdate` | Updates all `rev:` pins to the latest release without manual lookup |
| `check-yaml` vs `check_yaml` | Hook IDs use hyphens — underscores are a common typo that silently fails |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `.pre-commit-config.yaml` | Corrected pre-commit configuration |
| `solution.sh` | All commands needed to complete the task |
