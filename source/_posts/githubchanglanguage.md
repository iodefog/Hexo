title: GitHub 修改语言到Objective-C
categories: 技术
tags: GitHub,语言,language,object-c

---
GitHub 修改语言到Objective-C

1.进入到项目的根目录
```ruby
touch .gitattributes
```

2.往.gitattributes写入文件,将项目里最多的文件强制转换为所希望的语言

<!--more-->

```ruby
*.swift linguist-language=objective-c
*.c linguist-language=objective-c
*.h linguist-language=objective-c
*.m linguist-language=objective-c
*.a linguist-language=objective-c

```

3.push到GitHub上，刷新界面即可看到语言已经变成 objective-c