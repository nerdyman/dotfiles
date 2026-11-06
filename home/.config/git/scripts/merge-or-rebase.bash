#!/usr/bin/env bash
# git-merge-or-rebase <ref>: read-only check of whether to merge or rebase the current branch onto <ref>.
set -euo pipefail

target="${1:?usage: git merge-or-rebase <ref>}"
git rev-parse --verify --quiet "$target^{commit}" >/dev/null || { echo "unknown ref: $target" >&2; exit 2; }

head_branch="$(git rev-parse --abbrev-ref HEAD)"
base="$(git merge-base HEAD "$target")"
read -r behind ahead < <(git rev-list --left-right --count "$target...HEAD")
echo "$head_branch is $ahead ahead, $behind behind $target"

if [ "$behind" -eq 0 ]; then echo "Nothing to integrate: $target is already in $head_branch."; exit 0; fi
if [ "$ahead" -eq 0 ]; then echo "Fast-forward: $head_branch has no commits of its own. Either works, no conflicts possible."; exit 0; fi

conflicts=""
if ! out="$(git merge-tree --write-tree --name-only HEAD "$target" 2>&1)"; then
  conflicts="$(printf "%s\n" "$out" | tail -n +2 | sed "/^$/,\$d")"
fi
if [ -n "$conflicts" ]; then echo "Merge conflicts in:"; printf "%s\n" "$conflicts" | sed "s/^/  /"; else echo "Merge conflicts: none"; fi

pushed=0
if upstream="$(git rev-parse --abbrev-ref --symbolic-full-name "@{u}" 2>/dev/null)"; then
  shared="$(git merge-base HEAD "$upstream")"
  pushed="$(git rev-list --count "$base..$shared")"
  echo "Pushed commits a rebase would rewrite ($upstream): $pushed"
else
  echo "No upstream: nothing pushed"
fi

dirty="$(git status --porcelain --untracked-files=no | wc -l | tr -d " ")"
[ "$dirty" -gt 0 ] && echo "Uncommitted tracked changes: $dirty files (commit or stash first)"

if [ "$pushed" -gt 0 ]; then echo "Recommendation: merge (rebase needs a force-push)"; else echo "Recommendation: rebase (own commits are unpushed)"; fi
