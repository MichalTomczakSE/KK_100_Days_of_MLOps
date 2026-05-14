# Day 7: Package an ML Project as Installable Python Package

## Task

The xFusionCorp Industries deployment team needs the fraud-detection model code packaged as an installable Python distribution. A draft `pyproject.toml` exists at `/root/code/fraud-detection/`, but it does not build a wheel that meets the team's standard.

**Requirements for `pyproject.toml`:**

| Field | Required value |
|-------|---------------|
| `[build-system].requires` | `["setuptools>=61.0", "wheel"]` |
| `[build-system].build-backend` | `"setuptools.build_meta"` |
| `name` | `fraud_detection` |
| `version` | `0.1.0` |
| `requires-python` | `>=3.10` |
| `dependencies` | `["scikit-learn", "pandas", "numpy"]` |

Then build the package:

```bash
cd /root/code/fraud-detection
python3 -m build
```

The build must produce `fraud_detection-0.1.0-*.whl` under `dist/`.

---

## Diagnosis

| Issue | Original | Fix |
|-------|----------|-----|
| `[build-system]` section missing | — | add with setuptools and wheel |
| `name` | `fraud-detection` | `fraud_detection` (must match module path under `src/`) |
| `version` | `0.0.1` | `0.1.0` |
| `requires-python` | `>=3.8` | `>=3.10` |
| `dependencies` | `[]` | `["scikit-learn", "pandas", "numpy"]` |

---

## Solution

```toml
[project]
name = "fraud_detection"
version = "0.1.0"
description = "Fraud detection model for xFusionCorp Industries"
requires-python = ">=3.10"
dependencies = ["scikit-learn", "pandas", "numpy"]

[tool.setuptools.packages.find]
where = ["src"]

[build-system]
requires = ["setuptools>=61.0", "wheel"]
build-backend = "setuptools.build_meta"
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `[build-system]` | Tells pip which backend to use when building the package — without it, `python3 -m build` fails |
| `name` with underscore | Distribution name must match the directory under `src/` — `fraud-detection` (hyphen) would not find `src/fraud_detection/` |
| `[tool.setuptools.packages.find]` | Tells setuptools to look for packages inside `src/` rather than the project root |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `pyproject.toml` | Corrected package configuration |
| `solution.sh` | All commands needed to complete the task |
