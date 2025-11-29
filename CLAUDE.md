# Research Agent Template Instructions

## Overview

This is a general-purpose template for long-running research agents using Claude Code. It implements patterns from [Anthropic's engineering guide on effective harnesses](https://www.anthropic.com/engineering/effective-harnesses-for-long-running-agents) to enable multi-session research workflows with persistent state and incremental progress.

## Environment Management

This project uses `uv` for Python environment management.

### Initial Setup

```bash
uv venv
source .venv/bin/activate  # Linux/macOS
# or: .venv\Scripts\activate  # Windows
uv pip install -r requirements.txt
```

### Adding Dependencies

```bash
uv add <package>           # Add and install a package
uv pip compile requirements.in -o requirements.txt  # If using requirements.in
```

### Running Scripts

```bash
uv run python src/main.py  # Run within uv-managed environment
```

## Session Startup Protocol

Every session must begin with these steps:

1. Run `pwd` to confirm working directory
2. Run `git log --oneline -10` to review recent commits and current state
3. Read `progress.txt` for documented decisions and completed work
4. Read `tasks.json` to identify the highest-priority incomplete task
5. Run `uv run python -c "print('Environment OK')"` to verify environment

## Progress Tracking

### Required Files

- **progress.txt**: Document all decisions, experiments, results, and blockers. Update after every significant action.
- **tasks.json**: Structured task list with status tracking. Use JSON format (more robust than Markdown for automated parsing).
- **features.json** (optional): For projects with discrete features, track specifications and completion status.

### Task Status Values

```json
{
  "id": "task-001",
  "description": "Implement data preprocessing pipeline",
  "status": "pending|in_progress|completed|blocked",
  "blockedReason": "Optional: why blocked",
  "completedAt": "ISO timestamp when done"
}
```

### Git Commit Conventions

- Commit after every meaningful change
- Use descriptive prefixes: `data:`, `exp:`, `eval:`, `docs:`, `infra:`, `fix:`
- Example: `data: implement trajectory extraction from dataset`

## Research Workflow

### Single-Task Focus

Each session should focus on ONE task:
- Do not context-switch between tasks
- Complete or explicitly block the current task before moving on
- Prefer tasks that produce measurable, verifiable results

### Task Selection Priority

1. Unblock any blocked tasks first
2. Complete in-progress tasks before starting new ones
3. Follow phase order if applicable (e.g., Data → Training → Evaluation)
4. Prioritize tasks with clear success criteria

### Incremental Progress Over Ambition

- Avoid attempting complete solutions in a single session
- Aim for clean, committable states at session end
- Leave clear handoff notes for the next session

## Experiment Management

### Before Running an Experiment

1. Document hypothesis in progress.txt
2. Verify data is correctly loaded (print samples)
3. Confirm resource requirements are met
4. Set up logging and output directories

### After Running an Experiment

1. Record all metrics in progress.txt
2. Save outputs with descriptive names
3. Commit results to git
4. Update tasks.json status
5. Document unexpected findings or failures

## Error Handling

### When Encountering Errors

1. Document the full error in progress.txt
2. Attempt at least two different solutions
3. If blocked after reasonable debugging, mark task as blocked with detailed notes
4. Move to next highest-priority task

### Blocked Task Format

```
BLOCKED: [task description]
Reason: [what failed]
Attempted: [solutions tried]
Next steps: [what might unblock this]
```

## Directory Structure

```
project-root/
├── CLAUDE.md              # This file - agent instructions
├── progress.txt           # Session-to-session progress notes
├── tasks.json             # Structured task tracking
├── features.json          # Feature specifications (optional)
├── pyproject.toml         # uv/Python project config
├── requirements.txt       # Pinned dependencies
├── src/
│   ├── __init__.py
│   └── ...                # Source code
├── data/
│   ├── raw/               # Original data
│   └── processed/         # Processed data
├── outputs/               # Experiment outputs
├── configs/               # Configuration files
└── notebooks/             # Exploration notebooks
```

## Code Standards

### General

- All scripts must be reproducible (set seeds, document versions)
- Save intermediate results to disk
- Include validation checks where appropriate
- Log statistics and key metrics

### Data Pipeline

- Document data sources and versions
- Validate schema and expected distributions
- Log sample counts and key statistics

### Experiments

- Always save outputs with full config
- Log to both console and file
- Use deterministic settings where possible

## Verification Checklist

Before marking any task complete:

- [ ] Code runs without errors
- [ ] Results are logged and committed
- [ ] progress.txt is updated
- [ ] tasks.json status is updated
- [ ] Any new files are added to git
- [ ] Handoff notes are clear for next session

## Constraints

- Do not modify test/benchmark code to pass tests
- Document any deviations from the research plan
- Keep progress.txt and tasks.json in sync
- Commit frequently with descriptive messages

## Template Customization

When adapting this template for a specific project:

1. Update the Overview section with project-specific goals
2. Add project-specific resources (datasets, APIs, libraries)
3. Define project-specific constraints
4. Create initial tasks.json with research phases
5. Document any project-specific tooling requirements
