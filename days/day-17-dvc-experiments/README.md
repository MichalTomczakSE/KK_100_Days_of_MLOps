# Day 17: Run and Compare DVC Experiments

## Task

The xFusionCorp Industries data science team compares multiple training runs with different hyperparameters using DVC experiments. Run three experiments that vary the `n_estimators` hyperparameter, identify the best-performing one, and promote it to the tracked workspace.

**Requirements:**
- Run three DVC experiments, each with a different `n_estimators` across a reasonable range (e.g. `50`, `200`, `500`)
- Each experiment must produce a fresh `metrics.json`
- Compare them and pick the one with the highest `f1_score`
- Apply the chosen experiment so its `n_estimators`, `metrics.json`, and `models/model.pkl` become the tracked workspace state

The DVC extension's EXPERIMENTS view supports the same operations via UI (the `+` action to run, right-click → Apply to apply).

---

## Solution

### Run three experiments

```bash
cd /root/code/fraud-detection
for i in 50 200 500; do
  dvc exp run --set-param n_estimators=$i
done
```

Each `dvc exp run` creates a named experiment branch (auto-generated, e.g. `gaunt-lier`, `bound-mung`, `skint-glia`) without polluting `main`.

### Compare results

```bash
dvc exp show
```

Example output:

```
 Experiment                 Created    accuracy   f1_score   n_estimators
 workspace                  -              0.85       0.83   500
 main                       09:22 AM          !          !   100
 ├── 56dc77e [skint-glia]   09:36 AM       0.85       0.83   500
 ├── 2f0ddce [bound-mung]   09:36 AM       0.94       0.92   200    ← winner
 └── ed3ee0b [gaunt-lier]   09:36 AM     0.9175     0.8975   50
```

**Winner:** `n_estimators=200` with `f1_score=0.92`.

### Apply the winner to the workspace

Two equivalent ways:

**A. By experiment name (canonical):**

```bash
dvc exp apply bound-mung
```

Note: the experiment name is auto-generated and differs per run — check `dvc exp show` first.

**B. By re-pinning the param (deterministic across environments):**

```bash
echo "n_estimators: 200" > params.yaml
dvc repro
```

Used in `solution.sh` because it does not depend on the random experiment name. The result is the same: `params.yaml`, `metrics.json`, and `models/model.pkl` reflect the winning run.

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `dvc exp run --set-param k=v` | Runs the pipeline as a named experiment without touching `main`; param override is one-shot |
| Experiment names | Auto-generated slugs (e.g. `bound-mung`); use `-n` to name them yourself |
| `dvc exp show` | Tabular view comparing experiments — params, metrics, file hashes — same data as the DVC extension's EXPERIMENTS view |
| `dvc exp apply <name>` | Materialises an experiment into the workspace: `params.yaml`, outputs, and metrics |
| Stage skipping in experiments | `process_data` / `split_data` are cached — only `train` re-runs across the three experiments |
| `workspace` row | Always reflects current files; the `!` markers under `main` mean main has no metrics tracked yet |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `solution.sh` | All commands needed to complete the task |
