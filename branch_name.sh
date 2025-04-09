#!/bin/bash

BRANCH_NAME=$INPUT_BRANCH_NAME
DESTINATION_BRANCH=$INPUT_DESTINATION_BRANCH
DESTINATION_BRANCH_NAMES=($INPUT_MAIN_BRANCH $INPUT_DEVELOP_BRANCH)

is_valid_branch() {
    for one_branch in "${DESTINATION_BRANCH_NAMES[@]}"; do
        if [[ "$one_branch" == "$1" ]]; then
            return 0
        fi
    done
    return 1
}

if [[ -z "$BRANCH_NAME" ]]; then
    echo "ERROR: Branch name is not provided"
    exit 1
fi
echo "INFO : Branch name: '$BRANCH_NAME'"

if [[ -z "$DESTINATION_BRANCH" ]]; then
    echo "ERROR: Destination branch is not provided"
    exit 1
fi

if is_valid_branch "$DESTINATION_BRANCH"; then
    echo "INFO : Destination branch '$DESTINATION_BRANCH' is valid"
else
    echo "ERROR: Destination branch '$DESTINATION_BRANCH' is not valid"
    echo "INFO : Valid destination branches are 'main' or 'develop'"
    exit 1
fi

if [[ "$DESTINATION_BRANCH" == "develop" ]];then

    if [[ "$BRANCH_NAME" != "main" && ! "$BRANCH_NAME" =~ ^(feature|bugfix)/.*$ ]]; then
        echo "ERROR: Branch name '$BRANCH_NAME' is not in the correct format"
        exit 1
    fi
elif [[ "$DESTINATION_BRANCH" == "main" ]]; then
    if [[ ! "$BRANCH_NAME" =~ ^(release|hotfix)\/[0-999]+\.[0-999]+\.[0-999]+$ ]]; then
        echo "Branch name $BRANCH_NAME is not in the correct format"
        exit 1
    fi
fi

echo "INFO : Branch name '$BRANCH_NAME' is in the correct format"