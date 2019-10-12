#!/usr/bin/env zsh
offical_remote=offical
offical_master=master
fix_branches=(nixos-gpg-module-fix)
if [[ ! $(git remote) =~ $offical_remote ]]; then
  git remote add $offical_remote https://github.com/sorin-ionescu/prezto.git
fi
git pull $offical_remote $offical_master
git merge $offical_master
for fix in $fix_branches; do
  git merge $fix
done
git push origin $(git branch --show-current)
