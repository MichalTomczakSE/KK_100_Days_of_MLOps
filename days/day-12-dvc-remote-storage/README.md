# Day 12: Configure a DVC Remote Storage

## Task

The xFusionCorp Industries ML team uses SeaweedFS as the shared S3-compatible object store for DVC-tracked data. A `.dvc/config` already declares a remote called `s3` for the fraud-detection project, but `dvc push` currently fails. Correct the configuration and push the tracked data into the SeaweedFS bucket.

**Environment:**
- S3 endpoint: `http://localhost:8333`
- Credentials: `weedadmin / weedadmin123` (already in `.dvc/config`)
- Bucket: `dvc-storage` (already created)

**Requirements for the `s3` remote:**
- Points at the `dvc-storage` bucket using `s3://`
- Uses the correct SeaweedFS S3 endpoint URL
- Marked as the default remote

After `dvc push`, the `dvc-storage` bucket must contain at least one object under the `files/md5/...` prefix.

---

## Solution

### Corrected `.dvc/config`

```ini
[core]
    remote = s3
['remote "s3"']
    url = s3://dvc-storage
    endpointurl = http://localhost:8333
    access_key_id = weedadmin
    secret_access_key = weedadmin123
```

### Commands

```bash
cd /root/code/fraud-detection

# Fix URL and endpoint values (edit .dvc/config manually or use dvc remote modify)
dvc remote modify s3 url s3://dvc-storage
dvc remote modify s3 endpointurl http://localhost:8333

# Mark s3 as default — adds [core] remote = s3 to the config
dvc remote default s3

# Push tracked data to the bucket
dvc push
```

### Expected output

```
Collecting                                                                               |1.00 [00:00,  790entry/s]
Pushing
1 file pushed
```

---

## Key concepts

| Concept | Explanation |
|---------|-------------|
| `[core] remote = ...` | Declares the default remote — `dvc push` and `dvc pull` use this when no remote is named on the command line |
| `dvc remote default <name>` | CLI shortcut that writes the `[core] remote` line into `.dvc/config` |
| `dvc remote modify <name> <key> <value>` | Edits a single field of a remote without rewriting the whole config |
| `endpointurl` | Required when using S3-compatible storage that is not AWS (SeaweedFS, MinIO, Wasabi, etc.) |
| `files/md5/...` prefix | DVC's content-addressable layout in the bucket — files are stored by their MD5 hash |

---

## Files in this folder

| File | Purpose |
|------|---------|
| `dvc-config` | Corrected `.dvc/config` content |
| `solution.sh` | All commands needed to complete the task |
