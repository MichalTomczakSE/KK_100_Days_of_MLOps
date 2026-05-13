#!/bin/bash
cat > /root/code/fraud-detection/requirements.in <<EOF
# Fraud detection project dependencies
scikit-learn==1.8.0
mlflow==3.11.1
pandas==2.3.3
numpy==2.4.4
EOF

uv pip compile /root/code/fraud-detection/requirements.in -o /root/code/fraud-detection/requirements.txt
