#!/bin/bash
JUPYTER_FILE="/root/code/jupyter_lab_config.py"
sed -i "s|c.ServerApp.port = 8000|c.ServerApp.port = 8888|" $JUPYTER_FILE
sed -i "s|c.ServerApp.ip = '1.1.1.1'|c.ServerApp.ip = '0.0.0.0'|" $JUPYTER_FILE
sed -i "s|c.ServerApp.notebook_dir = '/root/wrong-path'|c.ServerApp.notebook_dir = '/root/notebooks'|" $JUPYTER_FILE

mkdir -p /root/notebooks
source /root/code/ml-env/bin/activate
jupyter lab --config=/root/code/jupyter_lab_config.py --allow-root --no-browser &
