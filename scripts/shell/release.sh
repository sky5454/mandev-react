# 获取当前分支名
branch_name=`git symbolic-ref --short -q HEAD`
# 分支类型
branch_type=`echo $branch_name | awk '{split($1, arr, "/"); print arr[1]}'`
# release、hotfix分支才需要打版
if [ $branch_type = "release" ] || [ $branch_type = "hotfix" ]; then
  # 获取版本号
  tag=`echo $branch_name | awk '{split($1, arr, "/"); print arr[2]}'`
  # 获取远程分支所有版本
  git fetch -p
  # 输出日志，并打版
  standard-version --release-as $tag
  # 合并分支到develop和master
  git flow $branch_type finish -n $tag 
fi
