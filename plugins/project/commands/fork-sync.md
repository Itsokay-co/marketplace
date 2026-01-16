---
description: Sync fork with upstream repository
---

Safely sync a forked repository with its upstream source.

## Run these checks

### 1. Detect fork and upstream

```bash
echo "=== Fork Info ==="
UPSTREAM=$(gh repo view --json parent --jq '.parent.nameWithOwner // empty')
CURRENT=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')

if [ -z "$UPSTREAM" ]; then
  echo "This repo is not a fork (no upstream parent)"
  exit 0
fi

echo "Fork: $CURRENT"
echo "Upstream: $UPSTREAM"
```

### 2. Check divergence status

```bash
echo "=== Divergence ==="
UPSTREAM=$(gh repo view --json parent --jq '.parent.nameWithOwner')
CURRENT=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
DEFAULT_BRANCH=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name')

gh api "repos/$CURRENT/compare/$UPSTREAM:$DEFAULT_BRANCH...$DEFAULT_BRANCH" \
  --jq '"Ahead of upstream: \(.ahead_by)\nBehind upstream: \(.behind_by)"'
```

### 3. Check for uncommitted changes

```bash
echo "=== Local State ==="
if [ -n "$(git status --porcelain)" ]; then
  echo "WARNING: Uncommitted changes exist"
  git status --short
else
  echo "Working directory clean"
fi
```

### 4. Sync decision

Based on the divergence:

| Status | Action |
|--------|--------|
| Behind only | Safe sync: `gh repo sync FORK --source UPSTREAM` |
| Ahead only | Force sync needed (will lose fork-only commits) |
| Both | Force sync needed (diverged) |
| 0/0 | Already synced |

### 5. Execute sync (if needed)

```bash
# Safe sync (when only behind)
gh repo sync FORK --source UPSTREAM

# Force sync (when ahead or diverged)
gh repo sync FORK --source UPSTREAM --force
```

### 6. Verify sync

```bash
echo "=== Verify ==="
gh api "repos/$CURRENT/compare/$UPSTREAM:$DEFAULT_BRANCH...$DEFAULT_BRANCH" \
  --jq '"Ahead: \(.ahead_by), Behind: \(.behind_by)"'
```

## When to use

- Before starting work on a fork
- When `/project:health` shows fork divergence
- After accidentally committing to fork's main branch
- Periodically to stay in sync with upstream
