# Research Agent Template

General-purpose template for long-running research agents using Claude Code. See @research-plan.md for project-specific goals.

## Task Management

Use Claude Code's native task system — do NOT create manual `tasks.json` or `features.json` files.

- **`TaskCreate`** to define research tasks with clear descriptions and success criteria
- **`TaskUpdate`** to mark tasks in_progress, completed, or blocked
- **`TaskList`** to check progress and find next work
- Focus on ONE task per session; complete or block it before moving on

## Progress Tracking

The `progress/` folder is the structured record of all research activity. See `.claude/rules/progress-tracking.md` for full details.

- **Session start**: Read `progress/status.md` first for current state, then `research-plan.md` for goals
- **After experiments**: Create an entry in the current phase folder, update `status.md` and phase `_summary.md`
- **Success criteria**: Check off `- [x]` items in `research-plan.md` as they're met, with result notes
- **Phase transitions**: Update status markers in `research-plan.md` and create the next phase folder
- **Key decisions**: Record in `progress/decisions/` using the decision template

Only the main agent writes to `progress/` — subagents report results back and the main agent logs them.

```
progress/
├── status.md              # Current state (read this first)
├── templates/             # Entry templates
├── phase-1-data/          # Created per phase as work begins
│   ├── _summary.md
│   └── YYYY-MM-DD-*.md
├── decisions/             # Key decision records
└── findings/              # Unexpected discoveries
```

## Agent Teams

For research involving parallel workstreams, use Claude Code's native agent teams:

- **When to use**: Multiple independent experiments, literature review + implementation in parallel, data processing while writing analysis
- **How**: `TeamCreate` → `TaskCreate` for each workstream → spawn teammates with `Task` tool
- Available custom subagents in `.claude/agents/`:
  - `literature-reviewer` — Web research, paper analysis (read-only)
  - `experiment-runner` — Run experiments in isolated context (keeps verbose output out of main context)
  - `data-analyst` — Data exploration, analysis, visualization

## Docker Environment

This template includes a Dev Container for running Claude Code in isolation with GPU support.

- **GPU**: CUDA 12.4, verify with `nvidia-smi`
- **Sudo**: Full access inside container
- **Network**: Unrestricted internet
- **Tools**: Node.js, Python, uv, git, GitHub CLI, CUDA toolkit
- **Workspace**: `/home/node/workspace` (mounted from host, persists)

### PyTorch with GPU

```bash
uv pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu124
```

## Python Environment

```bash
uv venv && source .venv/bin/activate    # Initial setup
uv add <package>                         # Add dependencies
uv run python src/main.py               # Run scripts
```

## Directory Structure

```
project-root/
├── .claude/
│   ├── agents/            # Custom subagents
│   ├── rules/             # Modular research rules (auto-loaded)
│   ├── hooks/             # Quality gate hooks
│   └── settings.json      # Shared project settings
├── .devcontainer/         # Docker config
├── CLAUDE.md              # This file
├── research-plan.md       # Research goals and plan (@-imported, living document)
├── progress/
│   ├── status.md          # Current state (read this first)
│   ├── templates/         # Entry templates
│   ├── phase-1-data/      # Created per phase
│   │   ├── _summary.md
│   │   └── YYYY-MM-DD-*.md
│   ├── decisions/         # Key decision records
│   └── findings/          # Unexpected discoveries
├── pyproject.toml         # Python project config
├── src/                   # Source code
├── data/
│   ├── raw/               # Original data
│   └── processed/         # Processed data
├── outputs/               # Experiment outputs
├── configs/               # Configuration files
└── notebooks/             # Exploration notebooks
```

## Constraints

- Do not modify test/benchmark code to pass tests
- Document deviations from the research plan
- Commit frequently with descriptive messages (see `.claude/rules/git-conventions.md`)
- All code must be reproducible (see `.claude/rules/code-standards.md`)

## Template Customization

When adapting this template:

1. Edit `research-plan.md` with your project goals, resources, and success criteria
2. Add project-specific rules to `.claude/rules/`
3. Customize subagents in `.claude/agents/` for your domain
4. Update `pyproject.toml` with your dependencies
