#!/bin/bash
cd /root/code/fraud-detection

dvc remote modify s3 url s3://dvc-storage
dvc remote modify s3 endpointurl http://localhost:8333
dvc remote default s3

dvc push
