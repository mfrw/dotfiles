function snag -d "Pick desired files from a chosen branch and checkout in $CWD"
  # use fzf to choose source branch to snag a file FROM
  set branch (git for-each-ref --format='%(refname:short)' | fzf --prompt="Search for a Branch:> " --multi=1 --height 20% --layout=reverse --border)
  # avoid doing work if branch isn't set
  if test -n "$branch"
    # use fzf to choose files that differ from current branch
    set file (git diff --name-only $branch | fzf --prompt="Search for a file to checkout at CWD:> " --multi=1 --height 20% --layout=reverse --border --multi)
  end
  # Stop the operation, if there is already a file with the same name in $CWD.
  if test -e (basename $file)
    echo "$file: Already exists and this operation will overwirite the existing file!"
    echo ""
    echo "If you still want to continue, run the below command:"
    set bfile (basename $file)
    echo "git show $branch:$file > $bfile"
    return 1
  end

  # avoid checking out branch if files aren't specified
  if test -n "$file"
    git show $branch:$file > (basename $file)
  end
end
