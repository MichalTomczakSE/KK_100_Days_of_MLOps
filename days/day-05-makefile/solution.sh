#!/bin/bash
python3 << 'EOF'
content = """\
# fraud-detection Makefile

.PHONY: setup data train test clean all

setup:
\tpython3 -m venv mlops-venv && mlops-venv/bin/pip install -r requirements.txt

data:
\tpython src/data/process_data.py

train:
\tpython src/models/train.py

test:
\tpytest tests/

clean:
\tfind . -type d -name __pycache__ -exec rm -rf {} +
\trm -rf .pytest_cache models/*

all: setup data train test
"""
with open('/root/code/fraud-detection/Makefile', 'w') as f:
    f.write(content)
EOF
