# Project Session Commands

Session workflow commands for multi-agent development. Based on [Anthropic's guidance for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents).

## Commands

| Command | Description |
|---------|-------------|
| `/project:start` | Initialize session - check git state, branch health, read progress |
| `/project:end` | End session - commit work, update progress, verify build |
| `/project:sync` | Reset develop to main after PR merge |
| `/project:health` | Branch diagnostics and divergence check |
| `/project:pr` | Create PR from develop to main |
| `/project:worktree` | Manage worktrees for parallel work |

## Workflow

```
Session Start          During Session         Session End
     │                       │                     │
     ▼                       ▼                     ▼
/project:start ──────► work on develop ──────► /project:end
     │                       │                     │
     │                       ▼                     │
     │              /project:pr (when ready)       │
     │                       │                     │
     │                       ▼                     │
     │              merge PR to main               │
     │                       │                     │
     │                       ▼                     │
     └────────────► /project:sync ◄────────────────┘
```

## Progress Tracking

The plugin expects a `.claude/progress.md` file for cross-session state:
- Current work in progress
- Recently completed items
- Blockers or decisions needed
- Notes for next session

Updated by `/project:end`, read by `/project:start`.

## Hook

After `gh pr merge` commands, a reminder appears to run `/project:sync`.

## Installation

```bash
/plugin install project@itsokay-marketplace
```

Then enable in your global settings:
```json
{
  "enabledPlugins": {
    "project@itsokay-marketplace": true
  }
}
```
