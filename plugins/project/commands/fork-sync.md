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
  echo "ERROR: This repo is not a fork (no upstream parent)"
else
  echo "Fork: $CURRENT"
  echo "Upstream: $UPSTREAM"
fi
```

### 2. Check divergence status

```bash
echo "=== Divergence ==="
UPSTREAM=$(gh repo view --json parent --jq '.parent.nameWithOwner')
CURRENT=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
DEFAULT_BRANCH=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name')

if [ -n "$UPSTREAM" ]; then
  gh api "repos/$CURRENT/compare/$UPSTREAM:$DEFAULT_BRANCH...$DEFAULT_BRANCH" \
    --jq '"Ahead of upstream: \(.ahead_by)\nBehind upstream: \(.behind_by)"'
fi
```

### 3. Check for uncommitted changes

```bash
echo "=== Local State ==="
if [ -n "$(git status --porcelain)" ]; then
  echo "WARNING: Uncommitted changes exist - commit or stash before syncing"
  git status --short
else
  echo "Working directory clean"
fi
```

### 4. Sync fork with upstream

```bash
echo "=== Sync ==="
UPSTREAM=$(gh repo view --json parent --jq '.parent.nameWithOwner')
CURRENT=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')

if [ -z "$UPSTREAM" ]; then
  echo "Not a fork, nothing to sync"
else
  echo "Run one of:"
  echo "  Safe sync:  gh repo sync $CURRENT --source $UPSTREAM"
  echo "  Force sync: gh repo sync $CURRENT --source $UPSTREAM --force"
fi
```

### 5. Verify sync succeeded

```bash
echo "=== Verify ==="
UPSTREAM=$(gh repo view --json parent --jq '.parent.nameWithOwner')
CURRENT=$(gh repo view --json nameWithOwner --jq '.nameWithOwner')
DEFAULT_BRANCH=$(gh repo view --json defaultBranchRef --jq '.defaultBranchRef.name')

if [ -n "$UPSTREAM" ]; then
  gh api "repos/$CURRENT/compare/$UPSTREAM:$DEFAULT_BRANCH...$DEFAULT_BRANCH" \
    --jq '"Ahead: \(.ahead_by), Behind: \(.behind_by)"'
fi
```

## Interpreting results

| Finding | Action |
|---------|--------|
| Behind only (0 ahead, N behind) | Safe sync: `gh repo sync` |
| Ahead only (N ahead, 0 behind) | Force sync needed (loses fork commits) |
| Both > 0 | Force sync needed (diverged history) |
| 0/0 | Already synced, nothing to do |
| Not a fork | This command doesn't apply |
