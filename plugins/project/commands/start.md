---
description: Initialize session - check state and show recent activity
---

Run these checks at session start:

## 1. Git state (with prune to clear stale remote refs)

```bash
git fetch origin --prune
git status
```

## 2. Branch divergence

Check if develop exists and its divergence from main:

```bash
if git rev-parse origin/develop >/dev/null 2>&1; then
  echo "develop vs main: $(git rev-list --count origin/main..origin/develop) ahead, $(git rev-list --count origin/develop..origin/main) behind"
else
  echo "develop branch does not exist - create with: git checkout -b develop origin/main && git push -u origin develop"
fi
```

## 3. Recent commits

```bash
git log --oneline -10
```

## 4. Read progress file

```bash
cat .claude/progress.md 2>/dev/null || echo "No progress file"
```

## 5. Check for uncommitted work

If the working tree is dirty, warn before proceeding and ask if the user wants to:
- Commit the changes
- Stash them
- Continue anyway

## 6. Report and ask

After running checks, summarize findings and ask: "What would you like to work on?"
