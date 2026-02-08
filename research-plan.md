# Research Plan

<!--
  This file is imported by CLAUDE.md via @research-plan.md.
  Claude reads this at the start of every session to understand your research goals.
  Replace the sections below with your project-specific content.

  NOTE FOR THE AGENT: This is a living document. As you work through phases:
  - Update the Status markers on phase headers (NOT STARTED → IN PROGRESS → COMPLETE)
  - Check off success criteria as they're met: - [ ] → - [x]
  - Add result notes next to checked criteria (e.g., "- [x] Accuracy >90% — achieved 92.1%")
-->

## Goal

<!-- What are you trying to achieve? Be specific and measurable. -->

Example: Fine-tune a language model for domain-specific question answering, achieving >90% accuracy on the evaluation benchmark.

## Resources

<!-- List datasets, models, APIs, and key libraries. -->

- **Dataset**: [URL or description]
- **Base Model**: [model name and source]
- **Evaluation Benchmark**: [description]
- **Key Libraries**: [e.g., transformers, pytorch, etc.]

## Phases

<!-- Break your research into sequential phases. Each phase becomes a set of tasks. -->

### Phase 1: Data Preparation <!-- Status: NOT STARTED -->
- Download and inspect the dataset
- Implement preprocessing pipeline
- Validate data quality and distributions

### Phase 2: Baseline <!-- Status: NOT STARTED -->
- Set up training infrastructure
- Train baseline model with default hyperparameters
- Establish baseline metrics

### Phase 3: Experimentation <!-- Status: NOT STARTED -->
- Hyperparameter tuning (learning rate, batch size, etc.)
- Architecture variations
- Data augmentation strategies

### Phase 4: Evaluation <!-- Status: NOT STARTED -->
- Run final model on held-out test set
- Compare against baselines and prior work
- Error analysis on failure cases

## Success Criteria

<!-- How do you know when you're done? -->

- [ ] Metric X exceeds threshold Y on the evaluation benchmark
- [ ] Model runs within resource constraints (GPU memory, inference time)
- [ ] Results are reproducible from committed code

## Constraints

<!-- Any limitations on compute, time, approach, etc. -->

- Single GPU training
- Must use [specific framework/approach]
- Complete within N sessions
