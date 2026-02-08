#!/bin/bash
# PostToolUse hook: Reminds to update progress after git commits
# Triggered after Bash tool use containing "git commit"

# Check if the tool output contains a successful git commit
if echo "$TOOL_INPUT" | grep -q "git commit"; then
    # Check if any progress files were included in the commit
    if git diff --name-only HEAD~1 HEAD 2>/dev/null | grep -q "^progress/"; then
        : # Progress was updated, no reminder needed
    else
        echo "Reminder: Consider updating progress/status.md and the relevant phase summary if this was a significant experiment commit."
    fi
fi
