#!/bin/bash
cd /root/code/fraud-detection

dvc remote modify s3 access_key_id weedadmin
dvc remote modify s3 secret_access_key weedadmin123

dvc pull
