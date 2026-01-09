---
description: Check branch health and divergence
---

Quick diagnostic check for branch state and potential issues.

## Run these checks

### 1. Fetch and prune stale refs

```bash
git fetch origin --prune
```

### 2. Show all branches with tracking info

```bash
echo "=== Branches ==="
git branch -vv
```

### 3. Check divergence between develop and main

```bash
echo "=== Divergence ==="
if git rev-parse origin/develop >/dev/null 2>&1; then
  echo "develop ahead of main: $(git rev-list --count origin/main..origin/develop)"
  echo "main ahead of develop: $(git rev-list --count origin/develop..origin/main)"
else
  echo "develop branch does not exist on remote"
fi
```

### 4. Show uncommitted changes

```bash
echo "=== Uncommitted ==="
git status --short
```

### 5. Show recent main commits

```bash
echo "=== Recent main commits ==="
git log origin/main --oneline -5
```

## Interpreting results

| Finding | Action |
|---------|--------|
| develop ahead of main > 0 | Normal if PR pending |
| main ahead of develop > 0 | Run `/project:sync` |
| Both > 0 | Run `/project:sync` (divergence) |
| Uncommitted changes | Commit or stash before switching |
| develop doesn't exist | Create with `git checkout -b develop origin/main && git push -u origin develop` |
