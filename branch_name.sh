#!/bin/bash

BRANCH_NAME=$INPUT_BRANCH_NAME
DESTINATION_BRANCH=$INPUT_DESTINATION_BRANCH
MAIN_BRANCH=$INPUT_BRANCH_NAME_MAIN
DEVELOP_BRANCH=$INPUT_BRANCH_NAME_DEVELOP


if [[ -z "$BRANCH_NAME" ]]; then
    echo "ERROR: Branch name is not provided"
    exit 1
fi
echo "INFO : Branch name: '$BRANCH_NAME'"

if [[ -z "$DESTINATION_BRANCH" ]]; then
    echo "ERROR: Destination branch is not provided"
    exit 1
fi

if [[ "$DESTINATION_BRANCH" == "$MAIN_BRANCH" || "$DESTINATION_BRANCH" == "$DEVELOP_BRANCH" ]]; then
    echo "INFO : Destination branch '$DESTINATION_BRANCH' is valid"
else
    echo "ERROR: Destination branch '$DESTINATION_BRANCH' is not valid"
    echo "INFO : Valid destination branches are '$MAIN_BRANCH' or '$DEVELOP_BRANCH'"
    exit 1
fi

if [[ "$DESTINATION_BRANCH" == "$DEVELOP_BRANCH" ]];then

    if [[ "$BRANCH_NAME" != "$MAIN_BRANCH" && ! "$BRANCH_NAME" =~ ^(feature|bugfix)/.*$ ]]; then
        echo "ERROR: Branch name '$BRANCH_NAME' is not in the correct format"
        exit 1
    fi
elif [[ "$DESTINATION_BRANCH" == "$MAIN_BRANCH" ]]; then
    if [[ ! "$BRANCH_NAME" =~ ^(release|hotfix)\/[0-999]+\.[0-999]+\.[0-999]+$ ]]; then
        echo "Branch name $BRANCH_NAME is not in the correct format"
        exit 1
    fi
fi

echo "INFO : Branch name '$BRANCH_NAME' is in the correct format"