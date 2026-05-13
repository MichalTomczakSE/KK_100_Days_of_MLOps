# Day 2: Set Up and Configure Jupyter Notebook Server

## Task

A teammate has configured a JupyterLab server for the xFusionCorp Industries data science team, but the server does not behave correctly. Inspect the configuration, diagnose the issues, and start the server.

**Environment:**
- JupyterLab is already installed in the virtual environment at `/root/code/ml-env/`
- The configuration file is at `/root/code/jupyter_lab_config.py`

**Requirements for the running server:**
- Listens on port `8888`
- Binds on `0.0.0.0` (not `127.0.0.1`)
- Notebook root directory is `/root/notebooks/`, and that directory must exist on disk

---

## Solution

### 1. Identify and fix the configuration issues

The original broken file had three wrong values:

| Setting | Original (broken) | Corrected |
|---------|------------------|-----------|
| `c.ServerApp.port` | `8000` | `8888` |
| `c.ServerApp.ip` | `'1.1.1.1'` | `'0.0.0.0'` |
| `c.ServerApp.notebook_dir` | `'/root/wrong-path'` | `'/root/notebooks'` |

The corrected configuration file:

```python
c.ServerApp.token = ''
c.ServerApp.password = ''
c.ServerApp.disable_check_xsrf = True
c.ServerApp.notebook_dir = '/root/notebooks'
c.ServerApp.port = 8888
c.ServerApp.ip = '0.0.0.0'
```

### 2. Create the missing notebook directory

```bash
mkdir -p /root/notebooks
```

### 3. Start JupyterLab

```bash
source /root/code/ml-env/bin/activate
jupyter lab --config=/root/code/jupyter_lab_config.py --allow-root --no-browser &
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `c.ServerApp.ip = '0.0.0.0'` | Binds on all interfaces — required for a proxy or external access |
| `c.ServerApp.port` | The port JupyterLab listens on |
| `c.ServerApp.notebook_dir` | Root directory shown in the file browser |
| `--allow-root` | Needed when running as the root user |
| `--no-browser` | Prevents JupyterLab from trying to open a browser on the server |
| `&` | Runs the process in the background |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `jupyter_lab_config.py` | Corrected JupyterLab configuration |
| `solution.sh` | All commands needed to complete the task |
