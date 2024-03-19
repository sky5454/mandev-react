#!/usr/bin/env bash

# Runs during git flow release finish and a tag message is given
#
# Positional arguments:
# $1 Message
# $2 Full version
#
# Return MESSAGE
#
# The following variables are available as they are exported by git-flow:
#
# MASTER_BRANCH - The branch defined as Master
# DEVELOP_BRANCH - The branch defined as Develop

MESSAGE=$1
VERSION=$2
# 同步远程tag，防止本地打版写入多个版本changelog-needed
git fetch --tags

BEHIND_COMMIT=$(git rev-list --count ..origin/main)
ROOT_DIR=$PWD

# 获取需要写入日志的package最近的一个tag
PREVIOUSTAG=$(git tag -l | tail -n 1)
# 获取semver格式的版本号
PACKAGE_VERSION=${VERSION%%-*}

# 获取两个tag之间的changelog信息
CHANGELOG_MESSAGE=`yarn cross-env PREVIOUS_TAG=$PREVIOUSTAG CURRENT_TAG=$VERSION  conventional-changelog -p custom-config -i -n ./scripts/changelog/changelog-option.cjs | tail -n +4 | sed '$d' | sed 's/(changelog-needed)/ /g'`

# 判断是否需要rebase，落后于target branch合并会失败
[ $BEHIND_COMMIT -ne 0 ] && { echo 'Please rebase main before finishing this branch'; exit 1; }

TEMP_CHANGELOG_MESSAGE=$(echo "### $PACKAGE_VERSION";git log -1 --pretty="#### %ci";printf "\n";echo "${CHANGELOG_MESSAGE}";printf "\n---\n\n";cat ./CHANGELOG.md)
echo "$TEMP_CHANGELOG_MESSAGE" > ./CHANGELOG.md

git add . > /dev/null
git commit --amend --no-edit --no-verify > /dev/null

echo $MESSAGE

exit 0