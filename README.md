# Claude Code Research Agent Template

A minimal template for long-running research agents using Claude Code. Based on [Anthropic's guide on effective harnesses for long-running agents](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents).

## Quick Start (Docker - Recommended)

Run Claude Code in an isolated Docker container to safely give it full permissions without risking your host system.

### Prerequisites

- Docker installed
- [NVIDIA Container Toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/latest/install-guide.html) (for GPU support)
- VS Code with [Dev Containers extension](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)
- `ANTHROPIC_API_KEY` environment variable set on your host

### Setup

1. **Clone this template**
   ```bash
   git clone <your-repo-url>
   cd <your-repo>
   ```

2. **Set your API key** (add to your shell profile for persistence)
   ```bash
   export ANTHROPIC_API_KEY="your-key-here"
   ```

3. **Open in VS Code**
   ```bash
   code .
   ```

4. **Reopen in Container**
   - Press `Ctrl+Shift+P` (or `Cmd+Shift+P` on Mac)
   - Select "Dev Containers: Reopen in Container"
   - Wait for the container to build (first time takes a few minutes)

5. **Run Claude Code in the terminal**
   ```bash
   claude --dangerously-skip-permissions
   ```

### What You Get

- **GPU access** with CUDA 12.4 (runs `nvidia-smi` on startup)
- Full sudo access inside container (safe - isolated from host)
- Full internet access
- Python + uv for environment management
- Git + GitHub CLI
- Persistent Claude config across sessions
- Your project files mounted at `/home/node/workspace`

## Quick Start (Local - Without Docker)

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
- `.devcontainer/` - Docker configuration for VS Code Dev Containers
- `README.md` - This file

## What You Bring

Your research plan markdown file containing:
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

This template uses [uv](https://github.com/astral-sh/uv) for Python environment management. It's pre-installed in the Docker container. For local use:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

## License

MIT
