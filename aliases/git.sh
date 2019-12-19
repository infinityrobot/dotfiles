alias grs="git reset --soft HEAD~1"
# https://stackoverflow.com/questions/13064613/how-to-prune-local-tracking-branches-that-do-not-exist-on-remote-anymore
alias prune_local="git branch --merged master | grep -v '^[ *]*master$' | xargs git branch -d"
