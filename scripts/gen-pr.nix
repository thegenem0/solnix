{ pkgs }:

pkgs.writeShellScriptBin "gen-pr" ''
  MAIN_BRANCH="main"
  MERGE_BASE=$(git merge-base "$MAIN_BRANCH" HEAD)

  if ! git diff --quiet; then
    echo "There are uncommitted changes in the working tree. Please commit or stash them before running this script."
    exit 1
  fi

  if ! git diff --quiet --staged; then
    echo "There are uncommitted changes in the staging area. Please commit or stash them before running this script."
    exit 1
  fi

  {
    function display_commits {
      local type=$1
      local title=$2
      local commits=$(git log "$MERGE_BASE"..HEAD --reverse --pretty=format:"- %s" --grep="^$type" | sed "s/^$type:\s*//")

      if [ -n "$commits" ]; then
        echo "#### $title"
        echo "$commits"
        echo ""
      fi
    }

    echo "### PR Summary"
    echo ""

    display_commits "feat" "Feature:"
    display_commits "fix" "Fix:"
    display_commits "docs" "Documentation:"
    display_commits "chore" "Chore:"
    display_commits "build" "Build:"
    display_commits "ci" "CI/CD:"
    display_commits "perf" "Perf:"
    display_commits "style" "Style:"

    breaking_changes=$(git log "$MERGE_BASE"..HEAD --reverse --pretty=format:"- %s" --grep="BREAKING CHANGE" | sed 's/^BREAKING CHANGE:\s*//')
    if [ -n "$breaking_changes" ]; then
      echo "#### Breaking Changes"
      echo "$breaking_changes"
      echo ""
    fi

    echo "### End of PR Summary"
  } | {
    if command -v pbcopy &> /dev/null; then
      pbcopy
      echo "PR summary has been copied to your clipboard."
    elif command -v xclip &> /dev/null; then
      xclip -selection clipboard
      echo "PR summary has been copied to your clipboard."
    elif command -v xsel &> /dev/null; then
      xsel --clipboard --input
      echo "PR summary has been copied to your clipboard."
    elif command -v wl-copy &> /dev/null; then
      wl-copy
      echo "PR summary has been copied to your clipboard."
    elif command -v clip &> /dev/null; then
      clip
      echo "PR summary has been copied to your clipboard."
    else
      echo "Clipboard copy command not found. Here is the PR summary:"
      cat
    fi
  }
''
