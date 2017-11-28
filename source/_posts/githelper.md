title: Git中一些常用问题及解决方法
date: 2017-11-07 11:36:00
categories: Git
tags: git, ios

---

## 1.一键清除烦人的 .DS_Store 文件

```bash

find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch

```

<!--more-->


## 2.GitHub 修改语言到Objective-C

1.进入到项目的根目录
```ruby
touch .gitattributes
```

2.往.gitattributes写入文件,将项目里最多的文件强制转换为所希望的语言


```ruby
*.swift linguist-language=objective-c
*.c linguist-language=objective-c
*.h linguist-language=objective-c
*.m linguist-language=objective-c
*.a linguist-language=objective-c

```

3.push到GitHub上，刷新界面即可看到语言已经变成 objective-c