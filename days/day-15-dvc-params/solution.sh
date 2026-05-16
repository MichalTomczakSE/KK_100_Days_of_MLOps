#!/bin/bash
cd /root/code/fraud-detection

sed -i 's/n_estimator:/n_estimators:/' params.yaml

dvc repro

sed -i 's/n_estimators: 100/n_estimators: 200/' params.yaml
dvc repro
