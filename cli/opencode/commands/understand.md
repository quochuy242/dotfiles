---
name: understand
description: Run Understand-Anything codebase analysis pipeline on the current project
argument-hint: [--full] [--language es]
---

Run the Understand-Anything analysis pipeline to build a knowledge graph of the codebase.

**Pre-flight:**
1. Verify plugin exists: `[ -d ~/.understand-anything-plugin ]`
2. Create intermediate dirs: `mkdir -p $PROJECT_ROOT/.understand-anything/{intermediate,tmp}`
3. Generate `.understandignore` if missing

**Execute deterministic scripts:**
```
node ~/.understand-anything-plugin/skills/understand/scan-project.mjs
node ~/.understand-anything-plugin/skills/understand/extract-import-map.mjs
node ~/.understand-anything-plugin/skills/understand/compute-batches.mjs
```

Load the understand skill at ~/.agents/skills/understand/SKILL.md and follow its instructions.

> **Note:** Understand-Anything agents are registered at `~/.understand-anything-plugin/agents/`.
> Symlink them into your opencode agents dir if needed:
> ```bash
> for f in ~/.understand-anything-plugin/agents/*.md; do
>   ln -sf "$f" /home/quochuy242/dotfiles/cli/opencode/agents/
> done
> ```
