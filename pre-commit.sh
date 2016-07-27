#!/bin/sh
FILES_PATTERN='\.(js|coffee)(\..+)?$'
FORBIDDEN_CL='console.log'
FORBIDDEN_DBG='debugger;'
RED='\033[0;31m'
GREEN='\033[0;32m'
BROWN='\033[0;34m'
NO_COLOR='\033[0m'
SUCCESS=1

CL_COUNT=$(git diff --cached --name-only | \
        grep -E $FILES_PATTERN | \
        GREP_COLOR='4;5;37;41' xargs grep --color --with-filename -n $FORBIDDEN_CL | wc -l)

DBG_COUNT=$(git diff --cached --name-only | \
        grep -E $FILES_PATTERN | \
        GREP_COLOR='4;5;37;41' xargs grep --color --with-filename -n $FORBIDDEN_DBG | wc -l)

if [ "$CL_COUNT" -ne "0" ]; then
    git diff --cached --name-only | \
            grep -E $FILES_PATTERN | \
            GREP_COLOR='4;5;37;41' xargs grep --color --with-filename -n $FORBIDDEN_CL
    SUCCESS=0
fi


if [ "$DBG_COUNT" -ne "0" ]; then
    git diff --cached --name-only | \
            grep -E $FILES_PATTERN | \
            GREP_COLOR='4;5;37;41' xargs grep --color --with-filename -n $FORBIDDEN_DBG
    SUCCESS=0
fi

if [ "$SUCCESS" == "0" ]; then
        echo $RED"COMMIT REJECTED BY PRE-COMMIT HOOK!$NO_COLOR\nReason:$RED\tDebugging traces were found in changed files. Please remove them before committing again.$NO_COLOR"
        echo "Tip:$BROWN\tYou can use$GREEN git commit --no-verify$BROWN to bypass git hooks"
        exit 1
fi
