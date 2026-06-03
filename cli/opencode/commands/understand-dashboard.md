---
name: understand-dashboard
description: Launch the interactive Understand-Anything knowledge graph dashboard
argument-hint: [project-path]
---

Launch the interactive web dashboard to visualize the codebase knowledge graph.

1. Find dashboard at `~/.understand-anything-plugin/packages/dashboard/`
2. Install deps: `cd <dashboard-dir> && pnpm install`
3. Start Vite: `GRAPH_DIR=<project-dir> npx vite --host 127.0.0.1`
4. Open the URL with token from the server output
