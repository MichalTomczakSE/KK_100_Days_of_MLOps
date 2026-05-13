# Day 4: Create a Standard ML Project Structure

## Task

A colleague has started a new ML project at `/root/code/fraud-detection/`, but the layout does not match the xFusionCorp Industries standard. Bring the project in line with the team's conventions.

**Required final layout:**

```
fraud-detection/
├── data/
│   ├── raw/
│   └── processed/
├── models/
├── notebooks/
├── src/
│   ├── data/
│   ├── features/
│   ├── models/
│   └── utils/
├── tests/
├── configs/
├── requirements.txt
└── README.md
```

`requirements.txt` must list `scikit-learn`, `pandas`, `numpy`, `mlflow` (one per line). `README.md` must begin with `# fraud-detection`.

---

## Diagnosis

Original state (`tree fraud-detection/`):

```
fraud-detection/
├── README.md          # heading was "# Fraud" — wrong
├── data/              # missing raw/ and processed/
├── models/
├── notebooks/
├── requirements.txt   # wrong content
└── src/
    ├── data/
    ├── feature/       # ❌ wrong name — should be features/
    ├── models/
    └── util/          # ❌ wrong name — should be utils/
                       # (each dir already had __init__.py)
                       # ❌ tests/ missing
                       # ❌ configs/ missing
```

| Issue | Fix |
|-------|-----|
| `data/` missing subdirs | `mkdir data/{raw,processed}` |
| `src/feature/` wrong name | rename to `src/features/` |
| `src/util/` wrong name | rename to `src/utils/` |
| `tests/` missing | `mkdir tests` |
| `configs/` missing | `mkdir configs` |
| `requirements.txt` wrong content | overwrite with correct packages |
| `README.md` heading `# Fraud` | change first line to `# fraud-detection` |

---

## Solution

Run all commands from `/root/code/`:

```bash
# 1. Create missing data subdirectories
mkdir fraud-detection/data/{raw,processed}

# 2. Create missing top-level directories
mkdir fraud-detection/{tests,configs}

# 3. Fix requirements.txt
cat > fraud-detection/requirements.txt <<EOF
scikit-learn
pandas
numpy
mlflow
EOF

# 4. Fix README.md heading
sed -i '1s/.*/# fraud-detection/' fraud-detection/README.md

# 5. Rename wrong src/ subdirectories
mv fraud-detection/src/feature/ fraud-detection/src/features
mv fraud-detection/src/util/ fraud-detection/src/utils
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `data/raw/` vs `data/processed/` | Standard split: raw is immutable source data, processed is the output of transformation steps |
| `src/` layout | Separates importable source code from notebooks, configs, and tests |
| `sed -i '1s/.*/<text>/'` | In-place replacement of the first line of a file |

---
