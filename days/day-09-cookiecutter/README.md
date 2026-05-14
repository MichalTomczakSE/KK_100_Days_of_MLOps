# Day 9: Create a Custom ML Project Template with Cookiecutter

## Task

The xFusionCorp Industries ML platform team maintains a Cookiecutter template that new ML projects are generated from. A draft template exists at `/root/code/mlops-template/`, but it does not render. Correct the template and use it to generate a project.

**Template must declare four variables in `cookiecutter.json`:**

| Variable | Default |
|----------|---------|
| `project_name` | `my-ml-project` |
| `author` | `xFusionCorp` |
| `python_version` | `3.11` |
| `ml_framework` | `["sklearn", "pytorch", "tensorflow"]` (choices) |

**Generated `requirements.txt`** must contain `scikit-learn`, `torch`, or `tensorflow` depending on `ml_framework`.

**Generated `README.md`** must reference both `project_name` and `author`.

**Template directory `{{cookiecutter.project_name}}/`** must contain: `README.md`, `requirements.txt`, `data/`, `models/`, `src/`, `tests/`.

Then generate a project:

```bash
cookiecutter /root/code/mlops-template/ -o /root/code/ --no-input project_name=churn-model ml_framework=sklearn
```

---

## Diagnosis

| File | Issue | Fix |
|------|-------|-----|
| `cookiecutter.json` | `ml_framework` variable missing | add with array of choices |
| `requirements.txt` | `=` instead of `==` in Jinja2 conditions | fix to `==` |
| `requirements.txt` | missing `{% endif %}` | add at end |
| `README.md` | `cookiecutter.Author` (capital A) | fix to `cookiecutter.author` |

---

## Solution

### `cookiecutter.json`

```json
{
    "project_name": "my-ml-project",
    "author": "xFusionCorp",
    "python_version": "3.11",
    "ml_framework": ["sklearn", "pytorch", "tensorflow"]
}
```

### `{{cookiecutter.project_name}}/requirements.txt`

```
{% if cookiecutter.ml_framework == 'sklearn' %}
scikit-learn
{% elif cookiecutter.ml_framework == 'pytorch' %}
torch
{% elif cookiecutter.ml_framework == 'tensorflow' %}
tensorflow
{% endif %}
```

### `{{cookiecutter.project_name}}/README.md`

```markdown
# {{cookiecutter.project_name}}

Created by {{ cookiecutter.author }}.
```

### Generate the project

```bash
cookiecutter /root/code/mlops-template/ -o /root/code/ --no-input project_name=churn-model ml_framework=sklearn
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `ml_framework` as array | First element is the default; cookiecutter presents remaining elements as choices |
| `==` in Jinja2 | Single `=` is assignment — always use `==` for equality checks in Jinja2 templates |
| `{% endif %}` | Jinja2 requires explicit closing tag for `if` blocks |
| Variable casing | Cookiecutter variable names are case-sensitive — `author` ≠ `Author` |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `template/cookiecutter.json` | Corrected variable declarations |
| `template/{{cookiecutter.project_name}}/requirements.txt` | Corrected Jinja2 template |
| `template/{{cookiecutter.project_name}}/README.md` | Corrected README template |
| `solution.sh` | All commands needed to complete the task |
