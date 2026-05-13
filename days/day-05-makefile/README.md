# Day 5: Create a Makefile for ML Workflow Automation

## Task

The xFusionCorp Industries ML team uses a Makefile to orchestrate common tasks. A draft Makefile exists at `/root/code/fraud-detection/Makefile`, but `make all` does not complete successfully. Bring the Makefile in line with the team's standard.

**Required targets:**

| Target | Behaviour |
|--------|-----------|
| `setup` | Creates venv at `mlops-venv/` and installs from `requirements.txt` |
| `data` | Runs `python src/data/process_data.py` |
| `train` | Runs `python src/models/train.py` |
| `test` | Runs `pytest tests/` |
| `clean` | Recursively removes all `__pycache__/`, removes `.pytest_cache`, clears `models/` |
| `all` | Runs `setup → data → train → test` in order |

All six targets must be declared `.PHONY`. Recipes must be indented with a real tab character.

---

## Diagnosis

| Issue | Original | Fix |
|-------|----------|-----|
| No `.PHONY` declaration | missing | add `.PHONY: setup data train test clean all` |
| `clean` only removes top-level `__pycache__/` | `rm -rf __pycache__` | `find . -type d -name __pycache__ -exec rm -rf {} +` |
| `clean` missing `.pytest_cache` and `models/*` | — | add `rm -rf .pytest_cache models/*` |
| `all` missing `data` step | `all: setup train test` | `all: setup data train test` |

---

## Solution

```makefile
# fraud-detection Makefile

.PHONY: setup data train test clean all

setup:
	python3 -m venv mlops-venv && mlops-venv/bin/pip install -r requirements.txt

data:
	python src/data/process_data.py

train:
	python src/models/train.py

test:
	pytest tests/

clean:
	find . -type d -name __pycache__ -exec rm -rf {} +
	rm -rf .pytest_cache models/*

all: setup data train test
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `.PHONY` | Tells Make these are task names, not files — prevents conflicts if a file named `test` or `clean` exists |
| Tab indentation | Make requires a real tab (`\t`), not spaces — using spaces silently breaks recipes |
| `find -exec rm -rf {} +` | Recursively removes all matching directories across the whole tree |
| `models/*` vs `models/` | Clears contents of the directory without deleting the directory itself |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `Makefile` | Corrected Makefile |
| `solution.sh` | All commands needed to complete the task |
