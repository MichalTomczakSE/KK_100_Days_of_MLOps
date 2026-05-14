#!/bin/bash
cat > /root/code/mlops-template/cookiecutter.json << 'EOF'
{
    "project_name": "my-ml-project",
    "author": "xFusionCorp",
    "python_version": "3.11",
    "ml_framework": ["sklearn", "pytorch", "tensorflow"]
}
EOF

cat > '/root/code/mlops-template/{{cookiecutter.project_name}}/requirements.txt' << 'EOF'
{% if cookiecutter.ml_framework == 'sklearn' %}
scikit-learn
{% elif cookiecutter.ml_framework == 'pytorch' %}
torch
{% elif cookiecutter.ml_framework == 'tensorflow' %}
tensorflow
{% endif %}
EOF

sed -i 's/cookiecutter.Author/cookiecutter.author/' '/root/code/mlops-template/{{cookiecutter.project_name}}/README.md'

cookiecutter /root/code/mlops-template/ -o /root/code/ --no-input project_name=churn-model ml_framework=sklearn