title: 修改git log中所有commit的用户名name和邮箱email
categories: git

-----------

## 利用脚本

代码根目录下创建：
`vi changelog.sh`, 粘贴如下代码并保存

```
#!/bin/sh

git filter-branch --env-filter '

OLD_EMAIL="lihongli@gmail.com"
CORRECT_NAME="iodefog"
CORRECT_EMAIL="iodefog@gmail.com"

if [ "$GIT_COMMITTER_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
```

把 OLD_EMAIL 、CORRECT_NAME 、 CORRECT_EMAIL 改成自己的新旧邮箱用户名即可；

## 执行代码：
`sh changelog.sh `

如果遇到如下错误 ：

```
Cannot create a new backup. A previous backup already exists in refs/original/ Force overwriting the backup with -f
```
则执行如下命令；

```
git filter-branch -f --index-filter 'git rm --cached --ignore-unmatch Rakefile' HEAD
```

## 最后覆盖远端仓库：

```
git push origin --force --all

git push origin --force --tags
```

