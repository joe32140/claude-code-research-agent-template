# Git Conventions

## Commit Prefixes

Use descriptive prefixes for all commits:

- `data:` — Data pipeline changes (download, preprocessing, augmentation)
- `exp:` — Experiment code and results
- `eval:` — Evaluation scripts and benchmark results
- `docs:` — Documentation updates
- `infra:` — Infrastructure, Docker, CI/CD, environment setup
- `fix:` — Bug fixes
- `refactor:` — Code restructuring without behavior change

## Commit Practices

- Commit after every meaningful change — small, atomic commits
- Write commit messages that explain *why*, not just *what*
- Include key metrics in experiment commit messages when applicable
- Example: `exp: lr sweep — 3e-4 best at 92.1% accuracy`

## What to Commit

- All source code changes
- Configuration files and hyperparameter configs
- Small result summaries and logs
- Documentation and progress notes

## What NOT to Commit

- Large data files (use `.gitignore`)
- Model checkpoints (use `.gitignore`)
- Virtual environments
- Credentials or API keys
