#!/usr/bin/env zsh
offical_remote=offical
vonfry_remote=vonfry
merge_offical_branches=(master)
merge_vonfry_branches=(nixos-gpg-module-fix)
current_branch=$(git branch --show-current)
have_branches=$(git branch)
have_remotes=$(git remote)

echo -e "\e[1;32mCheck offical remote in local..\e[0m"
if [[ ! $have_remotes =~ $offical_remote ]]; then
  git remote add $offical_remote https://github.com/sorin-ionescu/prezto.git
fi
echo -e "\e[1;32mCheck vonfry remote to local..\e[0m"
if [[ ! $have_remotes =~ $vonfry_remote ]]; then
  git remote add $vonfry_remote git@github.com:Vonfry/prezto.git
fi
echo -e "\e[1;32mPull offical remote to local..\e[0m"
for b in $merge_offical_branches; do
  if [[ ! $have_branches =~ $b ]]; then
    git branch $b --track $offical_remote/$b
  fi
  git checkout $b
  git pull $offical_remote $b
  git push $vonfry_remote  $b
done
echo -e "\e[1;32mPull vonfry remote to local..\e[0m"
for b in $merge_vonfry_branches; do
  if [[ ! $have_branches =~ $b ]]; then
    git branch $b --track $vonfry_remote/$b
  fi
  git checkout $b
  git pull $vonfry_remote $b
  git push $vonfry_remote $b
done
echo -e "\e[1;32mMerge fixes to current..\e[0m"
git checkout $current_branch
for b in $merge_offical_branches $merge_vonfry_branches; do
  git merge $b || exit -1
done
echo -e "\e[1;32mPush current branch..\e[0m"
git push $vonfry_remote $current_branch
