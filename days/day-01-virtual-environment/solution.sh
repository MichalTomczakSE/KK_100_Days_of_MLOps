#!/bin/bash
python -m venv /root/code/ml-env
source /root/code/ml-env/bin/activate
pip install numpy pandas scikit-learn matplotlib
pip freeze > /root/code/requirements.txt
