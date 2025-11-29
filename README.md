# Claude Code Research Agent Template

A minimal template for long-running research agents using Claude Code. Based on [Anthropic's guide on effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents).

## Quick Start

1. **Use this template** to create a new repository
2. **Add your research plan** as a markdown file (e.g., `research-plan.md`)
3. **Start Claude Code** and let it read `CLAUDE.md` and your research plan

```bash
# Clone your new repo
git clone <your-repo-url>
cd <your-repo>

# Set up environment with uv
uv venv
source .venv/bin/activate

# Start Claude Code
claude
```

## What's Included

- `CLAUDE.md` - Agent instructions for multi-session research workflows
- `README.md` - This file

## What You Bring

Your single research plan markdown file containing:
- Research goals and objectives
- Key resources (datasets, APIs, libraries)
- Success criteria
- Any constraints or requirements

## How It Works

Claude Code reads `CLAUDE.md` on startup, which instructs it to:

1. **Track progress** in `progress.txt` and `tasks.json`
2. **Focus on one task** per session
3. **Commit frequently** with descriptive messages
4. **Leave clear handoffs** for the next session

The agent will create the necessary tracking files and directory structure as it works.

## Example Research Plan

```markdown
# My Research Project

## Goal
Fine-tune a model for X task using Y dataset.

## Resources
- Dataset: https://huggingface.co/datasets/...
- Base model: ...
- Evaluation: ...

## Success Criteria
- Achieve X% accuracy on benchmark
- Model size under Y MB

## Constraints
- Single GPU training
- Must complete in N sessions
```

## Environment

This template uses [uv](https://github.com/astral-sh/uv) for Python environment management. Install uv first:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## License

MIT
