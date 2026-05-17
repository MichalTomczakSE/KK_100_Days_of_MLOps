#!/bin/bash
cd /root/code/fraud-detection

# 1. Run three experiments, each varying n_estimators
for i in 50 200 500; do
  dvc exp run --set-param n_estimators=$i
done

# 2. Compare all experiments side-by-side
dvc exp show

# 3. Apply the winning configuration (n_estimators=200, highest f1_score)
#    Instead of `dvc exp apply <name>` — which depends on the auto-generated
#    experiment name (e.g. "bound-mung") that differs per environment — re-pin
#    params.yaml and re-run dvc repro to deterministically reproduce the winner.
echo "n_estimators: 200" > params.yaml
dvc repro
