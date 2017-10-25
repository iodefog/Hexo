title: Mac 远程控制，邮件关机，重启等，利用AppleScript
date: 2016-12-30 11:57:00
categories: 技术
tags: 
description:
---
**首先：开关机动作**



```python
tell application "Finder" to shut down

tell application "Finder" to sleep

tell application "Finder" to restart 
```

<!--more-->


分别保存文件为  关机  睡眠 重启
**第二步：打开邮件->偏好设置->规则**
**
**
**第三步：设置规则，如下**
![]()

最终现象如下
![]()



Location 命令
这个命令允许你打开一个特定的位置（不管路径位于你的 Mac 上，还是在网络上）。这个命令最常用于操纵Finder。例如：如果你想打开”apple4.us”，你可以输入下面的命令：



```python
tell application "Finder" to open location "http://apple4.us"
```


记住，当你指定应用程序的时候，一定在其名字上加双引号（如这里的“Finder”）。当你输入一个 URL 的时候，一定要加上这个URL的协议前缀（如，http://，afp://，ftp://，等），同样，你也要在 URL 上加双引号。你也可以指定你的浏览器打开一个URL，如下：


```python
tell application "Safari" to open location "http://apple4.us"
```

如果你没有马上实验第一条命令的话，你也许会想，这个命令和上一个命令有什么区别呢？难道 Finder 还能当浏览器用？实际上，第一条命令中，我们让 Finder 打开一个 Web 路径时，Finder 会调用系统默认的浏览器来打开它。

Say 命令
你可以用 Say 命令来让 Mac 跟你说话（按，记得吗，Leopard 的[300
 个新特征之一](http://www.apple.com/macosx/features/300.html#universalaccess)中就包含了增强的语音模拟系统！）。Say 是最简单的一个 AppleScript 命令了。例如，如果你想用默认的 Mac 的话音说“Hello, my name is Macintosh.”，你可以输入：


```python
tell application "Finder" to say "Hello, my name is Macintosh."

```

用这个命令，可以让你的 Mac 说任何你输入的话，只要记住，把你想让 Mac 说的话用双引号包围起来就行了。如果你想试试 Mac 能说的其他声音，你可以在最后加上 using 和“说话人”的名称。


```python
tell application "Finder" to say "Hello, my name is Macintosh." using "Bruce"

```

或


```python
tell application "Finder" to say "Hello, my name is Macintosh." using "Vicki"

```


显示对话框
当你把 Mac 分享给其他人使用时，你想在他/她登录后给他/她一些使用提示，这个命令就非常有用了！（关于这个，我会在后面的文章中会详细介绍的，请关注！）使用这个命令会在屏幕上显示一个对话框。例如，如果你想显示一个“Hello, there”的对话框，你可以使用下面这个命令：


```python
tell application "Finder" to display dialog "Hello, there."

```


运行这个脚本，一个小对话框会出现，并显示你刚才输入的问候语。



构建一个脚本
现在，让我们来使用我们已经学到的命令来显示对话框，并使用 Say 命令：


```python
tell application "Finder" to display dialog "Hello there, click OK and I will talk to you."

tell application "Finder" to say "Hello, my name is Macintosh; I like Apples."
```


