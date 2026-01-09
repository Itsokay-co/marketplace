---
description: Manage worktrees for parallel feature work
argument-hint: <action> [name]
allowed-tools: Bash(git:*), Bash(wt:*)
---

Wrapper around the `wt` CLI for managing git worktrees.

## Actions

| Action | Usage | Description |
|--------|-------|-------------|
| `new` | `/project:worktree new feature-name` | Create new worktree |
| `list` | `/project:worktree list` | Show all worktrees |
| `remove` | `/project:worktree remove feature-name` | Delete worktree |
| `merge` | `/project:worktree merge feature-name` | Merge and cleanup |

## Prerequisites

Requires `wt` CLI: `npm install -g @johnlindquist/worktree`

## Execution

Based on the action argument:

### new

```bash
if ! command -v wt &> /dev/null; then
  echo "ERROR: wt CLI not found"
  echo "Install with: npm install -g @johnlindquist/worktree"
  exit 1
fi
wt setup $2
echo "Created worktree in sibling directory"
echo "cd to the new worktree to work on it"
```

### list

```bash
if ! command -v wt &> /dev/null; then
  git worktree list
else
  wt list
fi
```

### remove

```bash
if ! command -v wt &> /dev/null; then
  echo "ERROR: wt CLI not found"
  exit 1
fi
wt remove $2
```

### merge

```bash
if ! command -v wt &> /dev/null; then
  echo "ERROR: wt CLI not found"
  exit 1
fi
wt merge $2 --remove
echo "Merged and removed worktree"
```

## Native git fallback

If `wt` is not installed, use native git commands:

```bash
# Create worktree
git worktree add ../project-feature-name -b feature-name

# List worktrees
git worktree list

# Remove worktree
git worktree remove ../project-feature-name

# After merge, prune
git worktree prune
```
