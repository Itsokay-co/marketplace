---
description: Reset develop to main after PR merge
---

**CRITICAL:** Run this after every PR merge to prevent history divergence.

## Why this matters

When PRs are squash-merged, the original commits become orphaned. If develop isn't reset, it accumulates these orphaned commits, causing merge conflicts and the "70-commit divergence" problem.

## Steps

### 1. Fetch and prune stale refs

```bash
git fetch origin --prune
```

### 2. Switch to main and pull latest

```bash
git checkout main
git pull origin main
```

### 3. Recreate develop from main

This handles both reset and recreation scenarios:

```bash
git branch -D develop 2>/dev/null || true
git checkout -b develop origin/main
git push --force origin develop
```

### 4. Confirm

```bash
echo "develop synced to main"
git log --oneline -3
```

## When to run

- After every PR merge to main
- When you notice develop has diverged from main
- When `/project:health` shows divergence
