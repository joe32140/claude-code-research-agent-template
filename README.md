# Claude Code Research Agent Template

A template for long-running research agents using Claude Code, leveraging native task management, agent teams, custom subagents, and auto memory for multi-session research workflows.

Based on [Anthropic's guide on effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents).

## Quick Start (Docker - Recommended)

Run Claude Code in an isolated Docker container with GPU support.

### Prerequisites

- Docker installed
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) (for GPU support)
- VS Code with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- `ANTHROPIC_API_KEY` environment variable set on your host

### Setup

1. **Clone and configure**
   ```bash
   git clone <your-repo-url>
   cd <your-repo>
   ```

2. **Set your API key** (add to shell profile for persistence)
   ```bash
   export ANTHROPIC_API_KEY="your-key-here"
   ```

3. **Edit `research-plan.md`** with your project goals, resources, and success criteria.

4. **Open in VS Code and reopen in container**
   - `Ctrl+Shift+P` → "Dev Containers: Reopen in Container"
   - Wait for the container to build (first time takes a few minutes)

5. **Run Claude Code**
   ```bash
   claude --dangerously-skip-permissions
   ```

### What You Get

- **GPU access** with CUDA 12.4
- Full sudo access inside container (safe — isolated from host)
- Full internet access for web research
- Python + uv for environment management
- Git + GitHub CLI pre-installed
- Persistent Claude config across sessions
- Your project files mounted at `/home/node/workspace`

## Quick Start (Local - Without Docker)

```bash
git clone <your-repo-url>
cd <your-repo>

# Set up Python environment
uv venv && source .venv/bin/activate

# Start Claude Code
claude
```

## What's Included

### Core Files

| File | Purpose |
|------|---------|
| `CLAUDE.md` | Agent instructions — project constitution |
| `research-plan.md` | Your research goals and phases (edit this!) |
| `.devcontainer/` | Docker configuration for VS Code Dev Containers |

### `.claude/rules/` — Modular Research Rules

Rules are auto-loaded by Claude Code. Each file covers a specific topic:

| File | Purpose |
|------|---------|
| `research-workflow.md` | Experiment lifecycle: hypothesis → execute → analyze → commit |
| `code-standards.md` | Reproducibility, logging, data validation |
| `git-conventions.md` | Commit prefixes and practices |

### `.claude/agents/` — Custom Subagents

Specialized agents you can spawn for focused tasks:

| Agent | Purpose | Tools |
|-------|---------|-------|
| `literature-reviewer` | Search papers, docs, web resources | WebSearch, WebFetch, Read |
| `experiment-runner` | Run experiments in isolated context | Bash, Read, Write, Edit |
| `data-analyst` | Data exploration and visualization | Bash, Read, Write |

### `.claude/hooks/` — Quality Gates

| Hook | Trigger | Purpose |
|------|---------|---------|
| `check-progress-updated.sh` | After `git commit` | Reminds to log experiment results |

## Key Features

### Native Task Management

No more manual `tasks.json` files. Claude Code's built-in task system tracks everything:

```
You: "Set up the data pipeline, train a baseline, and run evaluation"

Claude creates tasks with TaskCreate, tracks progress with TaskUpdate,
and checks what's next with TaskList — all persisted automatically.
```

### Agent Teams for Parallel Research

Spawn multiple agents to work in parallel on independent research streams:

```
You: "Research the latest approaches to X while running the baseline experiment"

Claude spawns a literature-reviewer to search papers while an
experiment-runner trains the baseline — both working simultaneously.
```

### Auto Memory

Claude Code remembers context across sessions automatically. No need to manually maintain state files — Claude picks up where it left off.

### Custom Subagents

The `.claude/agents/` directory defines specialized agents with restricted tool access. Spawn them with the Task tool:

- **Literature reviewer**: Read-only web research (can't modify your code)
- **Experiment runner**: Runs long training jobs in isolated context (keeps verbose output out of your main conversation)
- **Data analyst**: Explores datasets and generates visualizations

## How It Works

1. Claude reads `CLAUDE.md` on startup, which imports `@research-plan.md` for project context
2. `.claude/rules/` files are auto-loaded, providing research workflow guidelines
3. Claude uses native `TaskCreate`/`TaskUpdate`/`TaskList` for progress tracking
4. Auto memory persists context across sessions
5. Custom subagents in `.claude/agents/` handle specialized tasks
6. Hooks in `.claude/hooks/` enforce quality gates

## Customization

1. **`research-plan.md`** — Define your research goals, data sources, and success criteria
2. **`.claude/rules/`** — Add domain-specific rules (e.g., `ml-best-practices.md`)
3. **`.claude/agents/`** — Create project-specific subagents (e.g., `model-evaluator.md`)
4. **`.claude/settings.json`** — Add allowed domains for web access, configure hooks

## Environment

This template uses [uv](https://github.com/astral-sh/uv) for Python environment management. It's pre-installed in the Docker container. For local use:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## License

MIT
