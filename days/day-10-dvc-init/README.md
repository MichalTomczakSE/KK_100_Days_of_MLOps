# Day 10: Install and Initialize DVC in an ML Project

## Task

The xFusionCorp Industries ML team is adopting DVC so that datasets and model files are versioned separately from code. Initialise DVC inside the existing Git repository at `/root/code/fraud-detection/` and record the initialisation in Git.

**Requirements:**
- Initialise DVC inside the existing git repo
- A `.dvc/` control directory and `.dvcignore` file must be created
- Stage every file DVC produces during initialisation
- Commit with the message `Initialize DVC`

---

## Solution

```bash
cd /root/code/fraud-detection
dvc init
git add .
git commit -m "Initialize DVC"
```

---

## Console output

```
$ dvc init
Initialized DVC repository.

You can now commit the changes to git.
```

After `dvc init` the following are created:
- `.dvc/` — DVC control directory (contains `config`, `.gitignore`, cache settings)
- `.dvcignore` — patterns DVC will skip (similar to `.gitignore`)

Both are automatically staged for git by DVC's internal logic, so `git add .` picks them up cleanly.

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `dvc init` | Must be run inside an existing git repo; creates `.dvc/` and `.dvcignore` |
| `.dvc/` directory | DVC's metadata store — analogous to `.git/` but for data |
| `.dvcignore` | Tells DVC which files to skip when scanning the project |
| DVC + Git split | Code lives in git, large data lives in DVC's remote cache — `.dvc` pointer files in git reference the data |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `solution.sh` | All commands needed to complete the task |
