#!/bin/bash
# Check if the last Bash command was a PR merge and remind about /project:sync

# Read stdin for hook input (JSON)
INPUT=$(cat)

# Extract the command that was executed
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Check if it was a PR merge command
if [[ "$COMMAND" == *"gh pr merge"* ]] || [[ "$COMMAND" == *"--squash"* && "$COMMAND" == *"merge"* ]]; then
  # Output reminder as system message
  cat << 'EOF'
{
  "hookSpecificOutput": {},
  "continue": true,
  "systemMessage": "PR merged! Run /project:sync to reset develop branch to main."
}
EOF
  exit 0
fi

# No match - continue silently
echo '{"continue": true}'
exit 0
