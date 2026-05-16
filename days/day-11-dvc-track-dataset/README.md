# Day 11: Track a Dataset with DVC

## Task

A teammate has added the transactions dataset to the xFusionCorp Industries fraud-detection repository, but it was committed directly to Git instead of being tracked with DVC. Bring the repository in line with the team standard — every dataset under `data/` must be tracked by DVC, not by Git.

**Requirements:**
- Stop Git from tracking `data/raw/transactions.csv` without deleting it from disk
- Track the same dataset with DVC so a `.dvc` pointer file is produced and `data/raw/.gitignore` excludes the dataset itself
- Stage the new `.dvc` pointer and the new `.gitignore`, then commit with the message `Track transactions dataset with DVC`

> The dataset is already tracked by Git in the initial repository state — `dvc add` alone would refuse to track a file that Git already knows about, so the file must first be removed from Git's index with `git rm --cached`.

---

## Solution

```bash
cd /root/code/fraud-detection

# 1. Untrack the file from git (keeps it on disk)
git rm --cached data/raw/transactions.csv

# 2. Hand the file to DVC
dvc add data/raw/transactions.csv

# 3. Stage everything DVC produced
git add data/

# 4. Commit
git commit -m "Track transactions dataset with DVC"
```

---

## What `dvc add` produces

```
data/raw/
├── .gitignore             ← new — tells git to ignore the actual data file
├── transactions.csv       ← stays on disk, now ignored by git
└── transactions.csv.dvc   ← new — pointer file (tracked by git) with the data's hash
```

Resulting commit:

```
3 files changed, 6 insertions(+), 11 deletions(-)
 create mode 100644 data/raw/.gitignore
 delete mode 100644 data/raw/transactions.csv
 create mode 100644 data/raw/transactions.csv.dvc
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `git rm --cached <file>` | Removes the file from git's index but leaves it on disk — required when a file moves from git to DVC tracking |
| `.dvc` pointer file | Small YAML file containing the data's MD5 hash and metadata; this is what git versions |
| Generated `.gitignore` | DVC writes one in the data's directory so git stops tracking the actual data file |
| `dvc config core.autostage true` | Optional setting — makes DVC auto-stage the generated git files so `git add` is not needed |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `solution.sh` | All commands needed to complete the task |
