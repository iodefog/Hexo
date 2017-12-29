title: Git submodule(子项目)使用
tag: git
categories: 技术


# Git submodule(子项目)使用


有种情况我们经常会遇到：某个工作中的项目需要包含并使用另一个项目。 也许是第三方库，或者你独立开发的，用于多个父项目的库。 现在问题来了：你想要把它们当做两个独立的项目，同时又想在一个项目中使用另一个。


1.从更新下载代码开始即使用了一个我没有用过的方式 submodules(子模块).


开始使用子模块
我们将要演示如何在一个被分成一个主项目与几个子项目的项目上开发。

我们首先将一个已存在的 Git 仓库添加为正在工作的仓库的子模块。 你可以通过在 git submodule add 命令后面加上想要跟踪的项目 URL 来添加新的子模块。 在本例中，我们将会添加一个名为 HLImagePicker 的库。

## 添加子模块

```base
✗ git submodule add https://github.com/iodefog/HLImagePicker
Cloning into '/Users/lhl/Desktop/Test/HLImagePicker'...
remote: Counting objects: 190, done.
remote: Compressing objects: 100% (44/44), done.
remote: Total 190 (delta 28), reused 49 (delta 18), pack-reused 126
Receiving objects: 100% (190/190), 103.92 KiB | 58.00 KiB/s, done.

```


如果这时运行 git status，你会注意到几件事。


```
✗ git status
On branch master
Changes to be committed:
  (use "git reset HEAD <file>..." to unstage)

	new file:   .gitmodules
	new file:   HLImagePicker


```

首先应当注意到新的 .gitmodules 文件。 该配置文件保存了项目 URL 与已经拉取的本地目录之间的映射：


```
 cat .gitmodules 
[submodule "HLImagePicker"]
	path = HLImagePicker
	url = https://github.com/iodefog/HLImagePicker

```

在 git status 输出中列出的另一个是项目文件夹记录。 如果你运行 git diff，会看到类似下面的信息：

```
git diff --cached xxxproject 
```

如果你想看到更漂亮的差异输出，可以给 git diff 传递 --submodule 选项。

```
git diff --cached --submodule
```

## 克隆含有子模块的项目

接下来我们将会克隆一个含有子模块的项目。 当你在克隆这样的项目时，默认会包含该子模块目录，但其中还没有任何文件：

```
git clone https://github.com/iodefog/Test
```

clone 完毕

```
 ls -a
.              .git           HLImagePicker  Test.xcodeproj
..             .gitmodules    Test

Test git:(master) cd HLImagePicker 
➜  HLImagePicker git:(master) ls
➜  HLImagePicker git:(master) 

```

其中有 HLImagePicker 目录，不过是空的。 你必须运行两个命令：git submodule init 用来初始化本地配置文件，而 git submodule update 则从该项目中抓取所有数据并检出父项目中列出的合适的提交。

```
$ git submodule init 
```

不过还有更简单一点的方式。 如果给 git clone 命令传递 --recursive 选项，它就会自动初始化并更新仓库中的每一个子模块。

```
$ git clone --recursive https://github.com/iodefog/Test

```


## 在包含子模块的项目上工作

现在我们有一份包含子模块的项目副本，我们将会同时在主项目和子模块项目上与队员协作。

拉取上游修改
在项目中使用子模块的最简模型，就是只使用子项目并不时地获取更新，而并不在你的检出中进行任何更改。 我们来看一个简单的例子。

子项目提交及更新

```
$ git pull
 
$ git commit -m"xxx"

$ git push

```

主项目更新子项目

```
// 更新某一个子项目
$ git submodule update --remote SubModuleTest

// 更新所有子项目
$ git submodule update --remote

// 更新服务器上的这个子模块有一个改动并且它被合并了进来
git submodule update --remote --merge

//
git submodule update --remote --rebase

```

其他人clone的项目更新

```
$ git fetch

$ git merge   

```

如果想要在子模块中查看新工作，可以进入到目录中运行 git fetch 与 git merge，合并上游分支来更新本地代码。


```
$ git log -p --submodule  查看这个信息。
```


启用项目子模块下的某分支，需要.gitmodules 文件中设置

```
[submodule "SubModuleTest"]
	path = SubModuleTest
	url = ../SubModuleTest
	branch = stable
```


如果我们在主项目中提交并推送但并不推送子模块上的改动，其他尝试检出我们修改的人会遇到麻烦，因为他们无法得到依赖的子模块改动。 那些改动只存在于我们本地的拷贝中。

为了确保这不会发生，你可以让 Git 在推送到主项目前检查所有子模块是否已推送。 git push 命令接受可以设置为 “check” 或 “on-demand” 的 --recurse-submodules 参数。 如果任何提交的子模块改动没有推送那么 “check” 选项会直接使 push 操作失败。

```
$ git push --recurse-submodules=check
```

另一个选项是使用 “on-demand” 值，它会尝试为你这样做。

```
$ git push --recurse-submodules=on-demand
```


移除子项目, 仅仅执行“rm -Rf SubModuleTest/” 是不行的

```
git rm -r SubModuleTest 
```

参考：[https://git-scm.com/book/zh/v2/Git-工具-子模块](https://git-scm.com/book/zh/v2/Git-工具-子模块)
