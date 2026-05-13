# Day 3: Fix a Broken uv Lockfile Specification

## Task

The xFusionCorp Industries ML team uses `uv` and lockfiles to keep Python dependencies reproducible across machines. A teammate has left behind a `requirements.in` specification that does not match the team's standard. Correct it and compile it into a pinned lockfile.

**Requirements for the corrected `requirements.in`:**
- Lists exactly these four top-level packages: `scikit-learn`, `mlflow`, `pandas`, `numpy`
- Every package carries a version constraint that `uv` can actually satisfy against PyPI

**Then compile it:**
```bash
uv pip compile requirements.in -o requirements.txt
```

The resulting `requirements.txt` must pin each of the four packages to an exact version using `==`, plus all resolved transitive dependencies.

---

## Diagnosis

The original `/root/code/fraud-detection/requirements.in` had three problems:

```python
# Fraud detection project dependencies
sklearn          # ❌ wrong package name — PyPI name is scikit-learn
mlflow>=100.0    # ❌ version 100.0 does not exist on PyPI — unsatisfiable constraint
numpy            # ❌ no version constraint
                 # ❌ pandas missing entirely
```

| Issue | Problem | Fix |
|-------|---------|-----|
| `sklearn` | Wrong PyPI package name | `scikit-learn` |
| `mlflow>=100.0` | Version 100.0 does not exist on PyPI | valid version constraint |
| `numpy` | No version constraint | add `==` constraint |
| `pandas` | Missing from the file | add with version constraint |

---

## Solution

### 1. Find available versions

```bash
uv pip freeze | egrep "scikit-learn|pandas|numpy|mlflow"
```

### 2. Correct the specification file

```python
# Fraud detection project dependencies
scikit-learn==1.8.0
mlflow==3.11.1
pandas==2.3.3
numpy==2.4.4
```

### 3. Compile into a pinned lockfile

```bash
cd /root/code/fraud-detection
uv pip compile requirements.in -o requirements.txt
```

This produces `requirements.txt` with the four top-level packages pinned with `==` plus all transitive dependencies resolved by `uv`.

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `requirements.in` | High-level specification — what the project needs (human-maintained) |
| `requirements.txt` | Pinned lockfile — exact versions for reproducible installs (generated) |
| `uv pip compile` | Resolves the `.in` spec against PyPI and writes the lockfile |
| `uv pip freeze` | Lists currently installed packages with exact versions — useful for finding valid version numbers |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `requirements.in` | Corrected high-level dependency specification |
| `solution.sh` | All commands needed to complete the task |
