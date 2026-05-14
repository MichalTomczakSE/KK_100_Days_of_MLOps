#!/bin/bash
cat > /root/code/fraud-detection/.pre-commit-config.yaml << 'EOF'
repos:
  - repo: https://github.com/pre-commit/pre-commit-hooks
    rev: v6.0.0
    hooks:
      - id: trailing-whitespace
      - id: end-of-file-fixer
      - id: check-yaml

  - repo: https://github.com/astral-sh/ruff-pre-commit
    rev: v0.15.13
    hooks:
      - id: ruff

  - repo: https://github.com/psf/black-pre-commit-mirror
    rev: 26.3.1
    hooks:
      - id: black
EOF

cd /root/code/fraud-detection
pre-commit install
pre-commit run --all-files
