#!/bin/bash
# PostToolUse hook: Reminds to update progress after git commits
# Triggered after Bash tool use containing "git commit"

# Check if the tool output contains a successful git commit
if echo "$TOOL_INPUT" | grep -q "git commit"; then
    echo "Reminder: Consider logging experiment results to progress.txt if this was a significant experiment commit."
fi
