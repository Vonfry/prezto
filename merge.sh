#!/usr/bin/env zsh
offical_remote=offical
vonfry_remote=vonfry
merge_offical_branches=(master)
merge_vonfry_branches=(nixos-gpg-module-fix)
if [[ ! $(git remote) =~ $offical_remote ]]; then
  git remote add $offical_remote https://github.com/sorin-ionescu/prezto.git
fi
if [[ ! $(git remote) =~ $vonfry_remote ]]; then
  git remote add $vonfry_remote git@github.com:Vonfry/prezto.git
fi
for b in $merge_offical_branches; do
  git fetch $offical_remote $b
  git merge $offical_remote/$b
done
for b in $merge_vonfry_branches; do
  git fetch $vonfry_remote $b
  git merge $vonfry_remote/$b
done
git push $vonfry_remote $(git branch --show-current)
