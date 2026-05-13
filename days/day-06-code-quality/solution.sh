#!/bin/bash
cat > /root/code/fraud-detection/pyproject.toml << 'EOF'
[project]
name = "fraud-detection"
version = "0.1.0"

[tool.ruff]
line-length = 120

[tool.ruff.lint]
select = ["E", "F", "W", "I"]

[tool.black]
line-length = 120
EOF

sed -i '/^import os$/d' /root/code/fraud-detection/src/data/process_data.py
