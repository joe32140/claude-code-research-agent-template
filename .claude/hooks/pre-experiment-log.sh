#!/bin/bash
# PreToolUse hook: Reminds to log experiment plan before running
# Triggered before Bash tool use that looks like an experiment run

# Detect experiment-like commands: python/uv scripts, training runs, torch usage
if echo "$TOOL_INPUT" | grep -qE "(python|uv run|torchrun|accelerate launch).*\.(py|sh)"; then
    # Skip trivial commands (installs, version checks, one-liners)
    if echo "$TOOL_INPUT" | grep -qE "(--version|--help|pip install|uv add|uv pip)"; then
        exit 0
    fi

    # Check if progress/status.md was recently updated (within this session)
    if [ -f "progress/status.md" ]; then
        last_modified=$(stat -c %Y "progress/status.md" 2>/dev/null || stat -f %m "progress/status.md" 2>/dev/null)
        now=$(date +%s)
        age=$(( now - last_modified ))
        # If status.md was updated in the last 5 minutes, assume the agent already logged
        if [ "$age" -lt 300 ]; then
            exit 0
        fi
    fi

    echo "Reminder: Before running this experiment, make sure progress/status.md records what you're about to run and why. If Claude Code crashes mid-experiment, this is the recovery point."
fi
