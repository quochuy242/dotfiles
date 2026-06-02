# dotfiles

## Usage

Run `main.sh`

```
Usage:
  main.sh <command> [options]

Commands:
  install        Install dependencies
  apply          Apply dotfiles
  setup          Install + apply

Options:
  --mode link    Use symbolic links (default)
  --mode bind    Use bind mount
  --dry-run      Show actions without executing
  -h, --help     Show this help

Examples:
  main.sh install
  main.sh apply --mode link
  main.sh setup --mode bind
```

## Setup MCP for ampcode

### 1. Add token or api-key for mcp what you want

Copy `.env.example` and modify required values 

```
# Context7
CONTEXT7_API_KEY=your_context7_key

# GitHub
GITHUB_TOKEN=ghp_xxxxxxxxx

# Sentry
SENTRY_AUTH_TOKEN=xxxxxxxx
SENTRY_ORG=my-org
SENTRY_PROJECT=my-project
```

### 2. Setup global MCP config (recommended)

Location: `~/.config/amp/settings.json`, inside the file, define `amp.mcpServers` 

Example: 

```json
{
  "amp.mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "${CONTEXT7_API_KEY}"
      }
    },
    "github": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-github"],
      "env": {
        "GITHUB_TOKEN": "${GITHUB_TOKEN}"
      }
    },
    "playwright": {
      "command": "npx",
      "args": ["-y", "@playwright/mcp@latest"]
    },
    "sentry": {
        "url": "https://mcp.sentry.dev/mcp"
    }
  }
}
```