title: git 添加空文件方法
date: 2014-09-10 14:12:00
categories: 技术
tags: 
description:
---
http://stackoverflow.com/questions/115983/how-do-i-add-an-empty-directory-to-a-git-repository 
Another way to make a directory stay empty (in the repo) is to create a .gitignore inside that directory that contains two lines:
<!--more-->

在空目录下创建.gitignore文件。
文件内写入如下代码，可以排除空目录下所有文件被跟踪： 

	# Ignore everything in this directory 
	* 
	# Except this file !.gitignore 
