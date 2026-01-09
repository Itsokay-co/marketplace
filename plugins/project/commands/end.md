---
description: End session - commit work, update progress
---

Run these steps to leave a clean state for the next session/agent:

## 1. Check for uncommitted changes

```bash
git status
```

## 2. If changes exist, commit them

Ask the user for a commit message or suggest one based on changes:

```bash
git add -A
git commit -m "wip: <describe changes>"
```

## 3. Update progress file

Edit `.claude/progress.md` with:
- What was completed this session
- What's still in progress
- Any blockers or notes for next session

## 4. Verify clean state

Run build to catch errors before leaving:

```bash
npm run build
```

If build fails, warn the user and ask how to proceed:
- Fix the errors now
- Leave a note in progress.md about the failure
- Skip verification

## 5. Push changes

If there are unpushed commits:

```bash
git push origin HEAD
```

## 6. Summary

Report what was done and confirm the session is ending cleanly.
