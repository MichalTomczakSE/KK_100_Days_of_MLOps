# Day 14: Create a DVC Pipeline for Data Processing

## Task

The xFusionCorp Industries ML team uses DVC pipelines to keep data processing reproducible. A draft `dvc.yaml` exists in the fraud-detection project, but `dvc repro` does not complete the full pipeline. Correct the pipeline definition so it runs cleanly end to end.

**Required stages:**

| Stage | Deps | Outputs |
|-------|------|---------|
| `process_data` | `data/raw/transactions.csv`, `src/data/process_data.py` | `data/processed/clean_transactions.csv` |
| `split_data` | `data/processed/clean_transactions.csv`, `src/data/split_data.py` | `data/processed/train.csv`, `data/processed/test.csv` |

After the fix, `dvc repro` must complete end to end and `dvc status` must report no stale stages.

---

## Diagnosis

```
$ dvc repro
> python src/data/process.py
python: can't open file 'src/data/process.py': [Errno 2] No such file or directory
ERROR: failed to reproduce 'process_data'
```

| Issue | Original | Fix |
|-------|----------|-----|
| Wrong script name | `python src/data/process.py` | `python src/data/process_data.py` |
| Wrong output filename | `data/processed/clean.csv` | `data/processed/clean_transactions.csv` |
| Missing inter-stage dependency | `split_data` had only `src/data/split_data.py` in deps | add `data/processed/clean_transactions.csv` so DVC links the stages |

---

## Solution

```yaml
stages:
  process_data:
    cmd: python src/data/process_data.py
    deps:
      - data/raw/transactions.csv
      - src/data/process_data.py
    outs:
      - data/processed/clean_transactions.csv

  split_data:
    cmd: python src/data/split_data.py
    deps:
      - data/processed/clean_transactions.csv
      - src/data/split_data.py
    outs:
      - data/processed/train.csv
      - data/processed/test.csv
```

```bash
cd /root/code/fraud-detection
dvc repro
dvc status
```

### Expected output

```
Running stage 'process_data':
> python src/data/process_data.py
Processed 15 rows

Running stage 'split_data':
> python src/data/split_data.py
Train: 12 rows, Test: 3 rows

$ dvc status
Data and pipelines are up to date.
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `deps` | Inputs DVC watches for changes — if any change, the stage is re-run |
| `outs` | Files produced by the stage — DVC tracks them in `dvc.lock` and ignores them in git |
| Inter-stage dependency | Listing a previous stage's output as a downstream stage's dep is what builds the pipeline graph |
| `dvc.lock` | Auto-generated lockfile capturing hashes of all deps/outs — proves reproducibility |
| `dvc status` | Reports stages with stale outputs (deps changed but stage not re-run) |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `dvc.yaml` | Corrected pipeline definition |
| `solution.sh` | All commands needed to complete the task |
