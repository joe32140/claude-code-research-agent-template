# Research Workflow Rules

## Experiment Lifecycle

Every experiment follows: **Hypothesis → Setup → Execute → Analyze → Commit**

### Before Running an Experiment

1. State your hypothesis clearly (what you expect and why)
2. Verify data is correctly loaded (print shapes, samples, distributions)
3. Confirm resource requirements (GPU memory, disk space, time estimate)
4. Set up logging and output directories under `outputs/`

### After Running an Experiment

1. Record all metrics and key observations
2. Save outputs with descriptive names including config parameters
3. Commit results to git with `exp:` prefix
4. Update task status via `TaskUpdate`
5. Log unexpected findings — these often lead to the best insights

## Error Handling

1. Attempt at least two different solutions before marking a task as blocked
2. When blocked, create a new task describing the blocker and what was tried
3. Move to the next highest-priority unblocked task

## Task Selection Priority

1. Unblock any blocked tasks first
2. Complete in-progress tasks before starting new ones
3. Follow phase order (Data → Training → Evaluation)
4. Prioritize tasks with clear, measurable success criteria

## Incremental Progress

- Avoid attempting complete solutions in a single session
- Aim for clean, committable states at session end
- Each session should produce at least one meaningful commit
