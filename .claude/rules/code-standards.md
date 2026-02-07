# Code Standards

## Reproducibility

- Set random seeds in all scripts (`random`, `numpy`, `torch`)
- Document library versions in `pyproject.toml`
- Save intermediate results to disk — don't rely on re-running long computations
- Use deterministic settings where possible (e.g., `torch.use_deterministic_algorithms(True)`)

## Data Pipeline

- Document data sources, versions, and download procedures
- Validate schema and expected distributions before processing
- Log sample counts, feature statistics, and class distributions
- Store raw data in `data/raw/`, processed data in `data/processed/`

## Experiment Outputs

- Save all outputs with full config (hyperparameters, data version, git hash)
- Log to both console and file (use Python `logging` module)
- Name output files descriptively: `{experiment}_{date}_{key_params}.{ext}`
- Store under `outputs/` with organized subdirectories

## Validation

- Include sanity checks: assert shapes, value ranges, and expected types
- Validate data at pipeline boundaries (load, transform, save)
- Print summary statistics at key checkpoints
