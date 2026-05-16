# Day 13: Pull DVC-Tracked Data from Remote

## Task

A new xFusionCorp Industries team member has cloned the fraud-detection repository onto a fresh machine. The DVC remote is already configured to point at the team's SeaweedFS bucket, but `dvc pull` is failing. Diagnose the cause, correct the configuration, and pull the dataset.

**Environment:**
- S3 endpoint: `http://localhost:8333`
- Credentials: `weedadmin / weedadmin123`
- Dataset `data/raw/transactions.csv` is already pushed to the `dvc-storage` bucket
- `.dvc` pointer file is present, but the dataset and local cache are missing

**Required:** the `s3` remote must use `access_key_id = weedadmin` and `secret_access_key = weedadmin123`.

---

## Diagnosis

```
$ dvc pull
ERROR: failed to connect to s3 (dvc-storage/files/md5) - Unable to locate credentials
ERROR: failed to pull data from the cloud - 1 files failed to download
```

The `.dvc/config` was missing the `access_key_id` and `secret_access_key` lines — DVC tried to authenticate against SeaweedFS but had no credentials.

---

## Solution

```bash
cd /root/code/fraud-detection

dvc remote modify s3 access_key_id weedadmin
dvc remote modify s3 secret_access_key weedadmin123

dvc pull
```

### Expected output

```
Collecting                                                                               |0.00 [00:00,    ?entry/s]
Fetching
Building workspace index                                                                 |2.00 [00:00,  661entry/s]
Comparing indexes                                                                       |4.00 [00:00, 3.12kentry/s]
Applying changes                                                                         |1.00 [00:00, 1.10kfile/s]
A       data/raw/transactions.csv
1 file fetched and 1 file added
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `dvc pull` flow | Reads `.dvc` pointer → checks local cache → if missing, fetches from remote → places file in working tree |
| `Unable to locate credentials` | Generic S3 error meaning no credentials were resolved — check `.dvc/config`, env vars, and `~/.aws/credentials` |
| `dvc remote modify` vs editing the file | CLI is safer than `echo >>` because it updates an existing key in place instead of appending duplicates |
| MD5 verification | DVC verifies the downloaded file's hash against the `.dvc` pointer — content integrity is built in |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `solution.sh` | All commands needed to complete the task |
