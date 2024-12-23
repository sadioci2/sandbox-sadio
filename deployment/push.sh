#!/bin/bash
push_to_github() {
    # Get the root directory of the repository
    REPO_ROOT=$(git rev-parse --show-toplevel 2>/dev/null)

    if [ -z "$REPO_ROOT" ]; then
        echo "Error: Not a git repository or unable to determine the repository root."
        return 1
    fi

    # Navigate to the repository root
    cd "$REPO_ROOT" || {
        echo "Error: Unable to access repository root directory."
        return 1
    }

    # Pull the latest changes from the remote repository
    echo "Pulling the latest changes from the remote repository..."
    git pull || {
        echo "Error: Git pull failed. Please check your remote configuration or network connection."
        return 1
    }

    # List directories in the repository for selection
    echo "Select folders to push changes from (use space to separate multiple choices):"
    dirs=($(find . -type d -not -path "*/.*" -not -path "./.git" -not -path "."))

    for i in "${!dirs[@]}"; do
        echo "$((i+1))) ${dirs[i]}"
    done

    echo "Enter the numbers of the folders you want to select (e.g., 1 3 5):"
    read -r selected_indices

    # Validate and collect the selected folders
    selected_folders=()
    for index in $selected_indices; do
        if [[ $index -ge 1 && $index -le ${#dirs[@]} ]]; then
            selected_folders+=("${dirs[$((index-1))]}")
        else
            echo "Invalid selection: $index"
            return 1
        fi
    done

    echo "Selected folders:"
    for folder in "${selected_folders[@]}"; do
        echo "$folder"
    done

    # Stage changes in the selected folders
    for folder in "${selected_folders[@]}"; do
        git add "$folder"
    done

    # Prompt the user for a commit message
    echo "Enter a commit message:"
    read -r commit_message

    # Ensure a commit message is provided
    if [ -z "$commit_message" ]; then
        echo "Error: Commit message cannot be empty."
        return 1
    fi

    # Commit and push changes
    git commit -m "$commit_message"
    git push || {
        echo "Error: Git push failed. Please check your remote configuration or network connection."
        return 1
    }

    echo "Changes from the selected folders have been pushed to GitHub successfully!"
}

push_to_github
