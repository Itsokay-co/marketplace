# itsokay-co Plugin Marketplace

Official Claude Code plugin marketplace for itsokay-co.

## Installation

Add this marketplace to Claude Code:

```bash
/plugin marketplace add itsokay-co/marketplace
```

## Installing Plugins

Once the marketplace is added, install plugins with:

```bash
/plugin install plugin-name@itsokay-marketplace
```

Or browse available plugins interactively:

```bash
/plugin
```

## Team Setup

To make this marketplace available to all team members automatically, add to your project's `.claude/settings.json`:

```json
{
  "extraKnownMarketplaces": {
    "itsokay-marketplace": {
      "source": {
        "source": "github",
        "repo": "itsokay-co/marketplace"
      }
    }
  }
}
```

## Available Plugins

### From [anthropics/claude-code](https://github.com/anthropics/claude-code)

| Plugin | Description |
|--------|-------------|
| **code-review** | Automated code review with confidence-based scoring |
| **commit-commands** | Git workflow commands for committing, pushing, and PRs |
| **feature-dev** | Feature development with codebase exploration and architecture design |
| **frontend-design** | Production-grade frontend interfaces with high design quality |
| **pr-review-toolkit** | PR review agents for comments, tests, error handling, type design |
| **ralph-wiggum** | Ralph Wiggum technique for iterative development loops |
| **security-guidance** | Security warnings when editing files |

### From [paddo/claude-tools](https://github.com/paddo/claude-tools)

| Plugin | Description |
|--------|-------------|
| **gemini-tools** | Gemini 3 Pro for visual analysis and UI mockups |
| **codex** | OpenAI Codex for architecture analysis and code review |
| **dns** | DNS management via Spaceship and GoDaddy APIs |
| **headless** | Headless browser automation for site comparison and E2E testing |
| **mobile** | Mobile app testing for iOS, Android, React Native, Flutter |
| **miro** | Read and interpret Miro boards |

### Original

| Plugin | Description |
|--------|-------------|
| **project** | Session workflow commands — start, end, sync, health, PR, worktree |

## Adding Plugins

### Option 1: GitHub-hosted plugins

Add to `.claude-plugin/marketplace.json`:

```json
{
  "name": "my-plugin",
  "source": {
    "source": "github",
    "repo": "itsokay-co/my-plugin"
  },
  "description": "Plugin description",
  "version": "1.0.0",
  "author": {
    "name": "Author Name"
  },
  "license": "MIT"
}
```

### Option 2: Plugins in this repository

Place plugin files in the `plugins/` directory and reference them:

```json
{
  "name": "local-plugin",
  "source": "./plugins/local-plugin",
  "description": "Plugin description",
  "version": "1.0.0"
}
```

## Contributing

1. Fork this repository
2. Add your plugin to `marketplace.json`
3. Submit a pull request

## License

MIT
