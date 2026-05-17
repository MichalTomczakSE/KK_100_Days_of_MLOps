#!/bin/bash
cd /root/code/fraud-detection

sed -i 's|      - metrics.json|    metrics:\n      - metrics.json:\n          cache: false|' dvc.yaml

dvc repro
dvc metrics show
