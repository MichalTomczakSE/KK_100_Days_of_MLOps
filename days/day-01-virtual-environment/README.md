# Day 1: Create a Python Virtual Environment for ML

## Task

The xFusionCorp Industries data science team needs a standardised Python environment for their new ML project. Set up a virtual environment with the required ML libraries on the `controlplane` host.

**Requirements:**
- Create a Python virtual environment named `ml-env` under `/root/code/` using `python3 -m venv`
- Activate the environment and install: `numpy`, `pandas`, `scikit-learn`, `matplotlib`
- Generate a `requirements.txt` file using `pip freeze` and save it at `/root/code/requirements.txt`

---

## Solution

```bash
# 1. Create the virtual environment
python -m venv /root/code/ml-env

# 2. Activate it
source /root/code/ml-env/bin/activate

# 3. Install the required packages
pip install numpy pandas scikit-learn matplotlib

# 4. Pin the installed versions
pip freeze > /root/code/requirements.txt
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `python -m venv <path>` | Creates an isolated Python environment at the given path |
| `source .../bin/activate` | Switches the shell to use the venv's Python and pip |
| `pip freeze` | Lists all installed packages with exact pinned versions |
| `requirements.txt` | Standard file for reproducing an environment with `pip install -r` |
