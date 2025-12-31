#!/bin/bash

if [[ -z "${CI_COMMIT_MESSAGE}" ]]; then
    COMMIT_MSG=$(git log -1 --pretty=%B)
    echo "$COMMIT_MSG" > /tmp/.gitmessage
else
    COMMIT_MSG="$CI_COMMIT_MESSAGE"
    echo "$COMMIT_MSG" > /tmp/.gitmessage
fi

conventional-pre-commit /tmp/.gitmessage
JIRA_PATTERN='[A-Z][A-Z0-9]*[_-][0-9]+'

if echo "$COMMIT_MSG" | grep -qE '^(Merge|Revert|Release|Bump version|chore\(release\))'; then
  echo "JIRA ticket check skipped (exempted commit type)"
  exit 0
fi

if echo "$COMMIT_MSG" | grep -qE "$JIRA_PATTERN"; then
  echo "JIRA ticket found in commit message"
  exit 0
fi

echo ""
echo "ERROR: Commit message must reference a JIRA ticket"
echo ""
echo "Expected format (ticket in scope):"
echo "  feat(PROJECT-1234): short description"
echo "  fix(PROJECT-1234): short description"
echo ""
echo "Your commit message: "
echo "  $COMMIT_MSG"
echo ""
exit 1

