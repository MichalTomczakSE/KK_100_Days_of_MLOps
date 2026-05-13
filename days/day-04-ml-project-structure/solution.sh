#!/bin/bash
mkdir fraud-detection/data/{raw,processed}
mkdir fraud-detection/{tests,configs}

cat > fraud-detection/requirements.txt <<EOF
scikit-learn
pandas
numpy
mlflow
EOF

sed -i '1s/.*/# fraud-detection/' fraud-detection/README.md

mv fraud-detection/src/feature/ fraud-detection/src/features
mv fraud-detection/src/util/ fraud-detection/src/utils
