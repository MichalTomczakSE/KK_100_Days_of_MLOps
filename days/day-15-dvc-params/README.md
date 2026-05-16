# Day 15: Parameterize a DVC Pipeline

## Task

The xFusionCorp Industries ML team manages model hyperparameters through `params.yaml`. The fraud-detection project's `train` stage already wires `params.yaml` for `n_estimators`, but `dvc repro` currently fails. Correct the parameter wiring and demonstrate that DVC re-runs the `train` stage when the parameter changes.

**Requirements:**
- Every name listed under `params:` in `dvc.yaml` must resolve to a key in `params.yaml`
- After fix, `dvc repro` runs end to end
- Changing `n_estimators` (e.g., to `200`) and re-running `dvc repro` must re-execute only the `train` stage, and the new value must land in `dvc.lock`

---

## Diagnosis

```
$ dvc repro
ERROR: failed to reproduce 'train': Parameters 'n_estimators' are missing from 'params.yaml'.
```

The `dvc.yaml` references `n_estimators`, but `params.yaml` defined `n_estimator` (no `s`):

```yaml
# Broken
n_estimator: 100
```

---

## Solution

### Fix `params.yaml`

```yaml
n_estimators: 100
```

### Run the pipeline

```bash
cd /root/code/fraud-detection
dvc repro
```

### Demonstrate parameter tracking

Change the value and re-run — only `train` should re-execute:

```bash
sed -i 's/n_estimators: 100/n_estimators: 200/' params.yaml
dvc repro
```

### Expected output

```
Stage 'process_data' didn't change, skipping
Stage 'split_data' didn't change, skipping
Running stage 'train':
> python src/models/train.py
Trained RandomForestClassifier with n_estimators=200
Updating lock file 'dvc.lock'
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `params.yaml` | Central place to declare hyperparameters — keeps experiments code-free |
| `params:` in `dvc.yaml` | Names listed here are tracked exactly like `deps` — changing a value invalidates the stage |
| Stage skipping | DVC compares current hashes against `dvc.lock` and only re-runs stages whose inputs changed |
| `dvc.lock` records params | The exact param value used in the last successful run is captured — reproducibility is end-to-end |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `params.yaml` | Corrected parameter file |
| `solution.sh` | All commands needed to complete the task |
