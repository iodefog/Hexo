title: 如何通过Applescript来狂发imessage（最简单的流程）
date: 2014-12-11 11:14:00
categories: 技术
tags: 
description:
---
打开 APPLESCRIPT
输入以下代码
<!--more-->

```javascript
tell application "Messages"
        set myid to get id of first service
            set theBuddy to buddy "电话号码/iM邮箱" of service id myid
            repeat 1000 times       #1000是指次数，自定吧
                send "发送邮件" to theBuddy
                end repeat
        end tell
```


