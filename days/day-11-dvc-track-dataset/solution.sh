#!/bin/bash
cd /root/code/fraud-detection

git rm --cached data/raw/transactions.csv
dvc add data/raw/transactions.csv
git add data/
git commit -m "Track transactions dataset with DVC"
