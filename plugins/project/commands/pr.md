---
description: Create PR from develop to main
argument-hint: <title> [body]
allowed-tools: Bash(git:*), Bash(gh:*)
---

Create a PR from develop to main following project conventions.

## Prerequisites

Must be on `develop` branch with changes to merge.

## Steps

### 1. Verify branch and state

```bash
BRANCH=$(git branch --show-current)
if [ "$BRANCH" != "develop" ]; then
  echo "ERROR: Must be on develop branch (currently on $BRANCH)"
  exit 1
fi
```

### 2. Check for uncommitted changes

```bash
if ! git diff --quiet HEAD; then
  echo "WARNING: Uncommitted changes detected"
  git status --short
fi
```

### 3. Push develop if needed

```bash
if git status | grep -q "ahead"; then
  git push origin develop
fi
```

### 4. Create PR

Use the first argument as title, second as body (optional):

```bash
gh pr create --base main --head develop \
  --title "$1" \
  --body "$(cat <<'EOF'
## Summary

$2

---
Created via /project:pr
EOF
)"
```

If no arguments provided, use interactive mode:

```bash
gh pr create --base main --head develop
```

## After PR creation

Remind the user:
- Review the PR at the returned URL
- After merge, run `/project:sync` to reset develop
