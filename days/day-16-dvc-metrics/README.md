# Day 16: Track ML Metrics with DVC

## Task

After training a model, the xFusionCorp Industries ML team wants DVC to surface metrics through `dvc metrics show` and the DVC extension's METRICS view. The fraud-detection pipeline already trains a model and writes a `metrics.json`, but DVC does not recognise the file as a metric. Wire it in correctly.

**Requirements:**
- The `train` stage in `dvc.yaml` must declare `metrics.json` as a DVC **metric**, not as a regular file output
- The metric must be declared with `cache: false` so the JSON lives in Git for diff history rather than in the DVC cache
- Re-run the pipeline with `dvc repro` so the metric registration takes effect
- `dvc metrics show` must report the `accuracy` and `f1_score` values from `metrics.json`
- Do not modify the Python files

---

## Diagnosis

The original `train` stage tracked `metrics.json` as a plain output:

```yaml
train:
  cmd: python src/models/train.py
  deps:
    - data/processed/train.csv
    - src/models/train.py
  outs:
    - models/model.pkl
    - metrics.json   # treated as a generic artefact — invisible to `dvc metrics show`
```

DVC has no way to know this file should be parsed as a metric, so it does not appear in `dvc metrics show` or the IDE's METRICS view.

---

## Solution

### Update `dvc.yaml`

Move `metrics.json` out of `outs:` and declare it under `metrics:` with `cache: false`:

```yaml
train:
  cmd: python src/models/train.py
  deps:
    - data/processed/train.csv
    - src/models/train.py
  outs:
    - models/model.pkl
  metrics:
    - metrics.json:
        cache: false
```

### Re-run the pipeline

```bash
cd /root/code/fraud-detection
dvc repro
```

### Verify

```bash
dvc metrics show
```

### Expected output

```
Running stage 'train':
> python src/models/train.py
Metrics: {'accuracy': 1.0, 'f1_score': 1.0}
Updating lock file 'dvc.lock'

$ dvc metrics show
Path          accuracy    f1_score
metrics.json  1.0         1.0
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `metrics:` block | Declares stage outputs that DVC should parse as scalar metrics (JSON / YAML / TOML) |
| `cache: false` | Keeps the file out of `.dvc/cache` and out of `.gitignore` — Git tracks it directly, so you get diffable history of metric values |
| `outs:` vs `metrics:` | Both are tracked outputs, but only `metrics` are surfaced by `dvc metrics show`, `dvc metrics diff`, and the IDE METRICS view |
| YAML dict-in-list syntax | `- metrics.json:` followed by an indented key under it lets you attach options like `cache: false` to a single list item |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `dvc.yaml` | Pipeline definition with `metrics.json` registered under `metrics:` with `cache: false` |
| `solution.sh` | All commands needed to complete the task |
