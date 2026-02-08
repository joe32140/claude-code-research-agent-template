# Progress Tracking

## Session Start

At the beginning of every session, read these files in order:

1. `progress/status.md` — Current state and blockers
2. `research-plan.md` — Goals, phase statuses, and success criteria
3. The current phase's `_summary.md` (e.g., `progress/phase-1-data/_summary.md`) if it exists

This gives you full context before starting work.

## Before Running an Experiment

Before executing any experiment script, update `progress/status.md` with:

- What you're about to run (script, key parameters)
- The hypothesis or goal
- Expected duration if known

This is your crash recovery point — if Claude Code dies mid-experiment, the next session can read `status.md` and know exactly what was in progress. A hook will remind you if you forget.

## After Each Experiment

1. **Create an entry** in the current phase folder using the template:
   - Copy `progress/templates/experiment.md` → `progress/phase-N-name/YYYY-MM-DD-short-description.md`
   - Fill in hypothesis, setup, results, and next steps
2. **Update the phase summary** (`progress/phase-N-name/_summary.md`):
   - Add a one-line entry with date, experiment name, and key result
3. **Update `progress/status.md`**:
   - Update "Last updated" date
   - Update "Recent Activity" with the latest experiment
   - Update "Key Metrics" table if any metrics changed
4. **Check off criteria in `research-plan.md`**:
   - If a success criterion was met, change `- [ ]` to `- [x]` and add the result
   - Example: `- [x] Accuracy >90% — achieved 92.1%`

## Key Decisions

When making a significant decision (architecture choice, approach change, etc.):

1. Create `progress/decisions/YYYY-MM-DD-decision-name.md` using `progress/templates/decision.md`
2. Add a note in `progress/status.md` under "Recent Activity"

## Phase Transitions

When a phase is complete and you move to the next:

1. **Finalize the current phase summary** — add a "Phase Complete" entry to `_summary.md`
2. **Create the next phase folder** — e.g., `progress/phase-2-baseline/`
3. **Create the next phase's `_summary.md`** with a header and empty entries list
4. **Update `progress/status.md`**:
   - Change "Current Phase" to the new phase
   - Note the transition in "Recent Activity"
5. **Update `research-plan.md`**:
   - Change the completed phase's status marker: `<!-- Status: IN PROGRESS -->` → `<!-- Status: COMPLETE -->`
   - Change the new phase's status marker: `<!-- Status: NOT STARTED -->` → `<!-- Status: IN PROGRESS -->`

## Format Rules

- `status.md` stays scannable — keep it under 30 lines, summarize rather than list everything
- Experiment entries are self-contained — anyone should understand the entry without reading other files
- All dates use YYYY-MM-DD format
- Phase folders follow the pattern: `phase-N-name` (e.g., `phase-1-data`, `phase-2-baseline`)
- Only the main agent writes to `progress/` — subagents report results back and the main agent logs them

## Creating Phase Folders

Phase folders are created on demand when a phase starts. The folder structure is:

```
progress/phase-N-name/
├── _summary.md          # Running log of all experiments in this phase
└── YYYY-MM-DD-*.md      # Individual experiment entries
```

The `_summary.md` format:

```markdown
# Phase N: [Name] — Summary

| Date | Experiment | Result |
|------|-----------|--------|
```
