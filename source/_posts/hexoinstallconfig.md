title: Hexo安装和配置
date: 2016-07-30 18:26:00
categories: 技术
tags: 
description:
---
#1. Git安装和设置
- github
	brew install git          #Mac电脑使用brew安装 
	sudo apt-get install git  #Ubuntu系统使用这条命令安装
然后设置好git账户
使用Github Page搭建博客, 需要在github建立仓库,仓库名为username.github.io

<!--more-->


- **gitcafe**
因为github速度稍微慢一点，所以用作备份站，主站用国内的gitcafe。
1) 先到[https://gitcafe.com/projects/new](https://gitcafe.com/projects/new)页面注册一个新的项目，**项目名需要与你的用户名相同**，默认分支选择gitcafe-pages,项目主页也是相同的[http://username.gitcafe.com](http://username.gitcafe.com/)
2) 采用和github同样的key文件，在 ~/.ssh/id_rsa.pub
如果没有，单独生成一个ssh-key
	ssh-keygen -t rsa -C "emailaddress" -f ~/.ssh/gitcafe
在SSH的文件夹下，可以看到gitcafe私钥和公钥文件：
	gitcafe
	gitcafe.pub
生成配置文件：
	touch ~/.ssh/config
添加以下内容：
	Host gitcafe.com www.gitcafe.com
	IdentityFile ~/.ssh/gitcafe
3) 登录[网站](https://gitcafe.com/account/public_keys)，将SSH文件夹下的 GitCafe.pub 中的内容复制到公钥框中即可。
4) 测试是否连上，共用的key，输入：
	ssh -T git@gitcafe.com -i ~/.ssh/id_rsa
单独的key，输入：
	ssh -T git@gitcafe.com -i ~/.ssh/gitcafe


###2. Node.js安装
	brew install node  #最新版的node.js的包中已经集成了npm包管理工具
使用以下命令验证是否安装成功
	node -v
	npm -v
如果运行hexo命令时，发现错误:
	-bash: hexo: command not found
是没有指定nodejs所致。可以使用下面方法解决：
如果机器没有安装过node，那么首先`brew install nvm`安装nvm。
其次需要在shell的配置文件(~/.bashrc, ~/.profile, or ~/.zshrc)中添加如下内容：
	export NVM_DIR=~/.nvm
	source $(brew --prefix nvm)/nvm.sh
然后设置别名
	nvm ls
	#v0.12.7
	
	nvm use 0.12.7
	#Now using node v0.12.7
	
	nvm alias default 0.12.7
	#default -> 0.12.7 (-> v0.12.7)
如果之前通过`brew install node`方式安装过node，那么需要先删除系统中存在的node：
	brew remove --force node
	sudo rm -r /usr/local/lib/node_modules
	
	brew prune
	sudo rm -r /usr/local/include/node
	
	# 检查brew是否正常
	brew doctor
###3. Hexo安装与设置
Node, npm和Git都安装成功, 开始安装hexo
	npm install hexo -g  #-g表示全局安装, npm默认为当前项目安装
	hexo version
如果遇到报错
	{ [Error: Cannot find module './build/Release/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
	{ [Error: Cannot find module './build/default/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
	{ [Error: Cannot find module './build/Debug/DTraceProviderBindings'] code: 'MODULE_NOT_FOUND' }
则用下列语句安装
`npm install hexo --no-optional`
Hexo使用命令:
	cd ~/git
	hexo init hexo  #执行init命令初始化到你指定的hexo目录
	cd hexo
	npm install    #install before start blogging
	hexo generate       #自动根据当前目录下文件,生成静态网页
	hexo server         #运行本地服务
浏览器输入[http://localhost:4000就可以看到效果。](http://localhost:4000%E5%B0%B1%E5%8F%AF%E4%BB%A5%E7%9C%8B%E5%88%B0%E6%95%88%E6%9E%9C%E3%80%82/)
**目录结构**
	.
	├── .deploy       #需要部署的文件
	├── node_modules  #Hexo插件
	├── public        #生成的静态网页文件
	├── scaffolds     #模板
	├── source        #博客正文和其他源文件, 404 favicon CNAME 等都应该放在这里
	|   ├── _drafts   #草稿
	|   └── _posts    #文章
	├── themes        #主题
	├── _config.yml   #全局配置文件
	└── package.json
###4. 添加博文
	hexo new "postName"  #新建博文,其中postName是博文题目
博文会自动生成在博客目录下`source/_posts\postName.md`
文件自动生成格式:
	title: "It Starts with iGaze: Visual Attention Driven Networkingwith Smart Glasses"  #博文题目
	date: 2014-11-21 11:25:38      #生成时间
	tags:                    #标签, 多个标签也可以使用格式[tag1, tag2, tag3,...]
	- tag1
	- tag2
	- tag3
	categories: [cat1,cat2,cat3]
	---
	正文, 使用 Markdown 语法书写
如果不想博文在首页全部显示, 并能出现阅读全文按钮效果, 需要在你想在首页显示的部分下添加
	<!--more-->
###5. 主题更改
	cd ~/git/hexo
	git clone git@github.com:litten/hexo-theme-yilia.git themes/yilia
在./_config.yml，修改主题为yilia
`theme: yilia`
Hexo[主题列表](https://github.com/hexojs/hexo/wiki/Themes)
另外推荐几个主题:
[iissnan/hexo-theme-next](https://github.com/iissnan/hexo-theme-next)
[TryGhost/Casper](https://github.com/TryGhost/Casper)
[kywk/hexo-theme-casper](https://github.com/kywk/hexo-theme-casper) #基于Casper
[daleanthony/uno](https://github.com/daleanthony/uno)
[A-limon/pacman](https://github.com/A-limon/pacman)
[AlxMedia/hueman](https://github.com/AlxMedia/hueman)
[ppoffice/hexo-theme-hueman](https://github.com/ppoffice/hexo-theme-hueman) #基于Hueman
[xiangming/landscape-plus](https://github.com/xiangming/landscape-plus) #基于官方
[hexojs/hexo-theme-landscape](https://github.com/hexojs/hexo-theme-landscape)
查看本地效果
	hexo g
	hexo s
###6. 部署到Git
以上内容都是在本地进行查看, 现在将博客部署到github或gitcafe上
####gitcafe
打开./_config.yml，修改如下信息：
	type: git
	repository: git@gitcafe.com:yourname/yourname.git
	branch: gitcafe-pages
branch要提交到gitcafe-pages，然后才能在username.gitcafe.io中看到提交的页面。
####Github
	deploy:
	  type: github
	  repo: https://github.com/lmintlcx/lmintlcx.github.io.git
	  branch: master
项目主页需要把 branch 设置为 gh-pages
####注意事项
- **所有键的冒号后面留一个空格，如`language:
 zh-CN`**
- **url不能为空,否则报错**
- `type: github`报错`hexo
 ERROR Deployer not found: github`的解决方法：
先运行 `npm install hexo-deployer-git --save`
再改为 `type: git`

完整配置信息如下：
	# Site #站点信息
	title: blog Name #标题
	subtitle: Subtitle #副标题
	description: my blog desc #描述
	author: me #作者
	language: zh-CN #语言
	timezone: Asia/Shanghai #时区
	
	# URL
	url: http://yoururl.com   #用于绑定域名, 其他的不需要配置
	root: /
	#permalink: :year/:month/:day/:title/
	permalink: posts/title.html
	permalink_defaults:
	
	# Directory #目录
	source_dir: source #源文件
	public_dir: public #生成的网页文件
	tag_dir: tags #标签
	archive_dir: archives #归档
	category_dir: categories #分类
	code_dir: downloads/code
	i18n_dir: :lang #国际化
	skip_render:
	
	# Writing #写作
	new_post_name: :title.md #新文章标题
	default_layout: post #默认模板(post page photo draft)
	titlecase: false #标题转换成大写
	external_link: true #新标签页里打开连接
	filename_case: 0
	render_drafts: false
	post_asset_folder: false
	relative_link: false
	future: true
	highlight: #语法高亮
	  enable: true
	  line_number: true #显示行号
	  auto_detect: true
	  tab_replace:
	
	# Category & Tag #分类和标签
	default_category: uncategorized #默认分类
	category_map:
	tag_map:
	
	# Date / Time format #日期时间格式
	## http://momentjs.com/docs/#/displaying/format/
	date_format: YYYY-MM-DD
	time_format: HH:mm:ss
	
	# Pagination #分页
	per_page: 10 #每页文章数, 设置成 0 禁用分页
	pagination_dir: page
	
	# Extensions #插件和主题
	## 插件: http://hexo.io/plugins/
	## 主题: http://hexo.io/themes/
	theme: next
	
	# Deployment #部署, 同时发布在 GitHub 和 GitCafe 上面
	deploy:
	- type: git
	  repo: git@gitcafe.com:username/username.git,gitcafe-pages
	- type: git
	  repo: git@github.com:username/username.github.io.git,master
	
	# Disqus #Disqus评论系统
	disqus_shortname: 
	
	plugins: #插件，例如生成 RSS 和站点地图的
	- hexo-generator-feed
	- hexo-generator-sitemap
保存之后，便可以使用`hexo d`上传到GitCafe。
部署成功,使用username.gitcafe.io进行访问, 或者设置个性域名，参考[官方Wiki](https://gitcafe.com/GitCafe/Help/wiki/Pages-%E7%9B%B8%E5%85%B3%E5%B8%AE%E5%8A%A9)。
###7.域名
- 绑定域名
不绑定域名的话只能通过 your_user_name.github.io 访问
申请域名推荐 [GoDaddy](https://www.godaddy.com/), 域名解析推荐 [DNSPod](https://www.dnspod.cn/Domain)

- 绑定顶级域名
新建文件 CNAME, 无后缀, 纯文本文件, 内容为要绑定的域名 blogname.com
如果要使用 www.blogname.com 的形式, 文件内容改为 www.blogname.com
DNS设置
主机记录@, 类型A, 记录值192.30.252.153
主机记录www, 类型A, 记录值192.30.252.153
参考 [Tips for configuring an A record with your DNS provider](https://help.github.com/articles/tips-for-configuring-an-a-record-with-your-dns-provider)

- 绑定子域名
比如使用域名blogname.com的子域名blog.blogname.com
CNAME文件内容为blog.blogname.com
DNS设置
主机记录blog, 类型CNAME, 记录值blogname.github.io
参考 [Tips for configuring a CNAME record with your DNS provider](https://help.github.com/articles/tips-for-configuring-a-cname-record-with-your-dns-provider)

- Gitcafe 绑定域名
项目管理界面, 左侧的导航栏中有自定义域名设置


###8.其他配置
**站点建立时间**
例如 © 2014 - 2015
站点配置文件新增字段 since
`since: 2014`
**侧栏设置**
post - 默认行为, 在文章页面(拥有目录列表)时显示
always - 在所有页面中都显示
hide - 在所有页面中都隐藏(可以手动展开)
`sidebar: post`
**头像设置**
编辑站点配置文件, 新增字段 avatar, 头像的链接地址可以是:
网络地址
`https://avatars2.githubusercontent.com/u/4962914?v=3&s=460`
站点内的地址
`/images/avatar.jpg #头像图片放置在主题的 source/images/`
`avatar: /images/avatar.png`
**菜单设置**
编辑主题配置文件的 menu
若站点运行在子目录中, 将链接前缀的 / 去掉
	menu:
	  home: /
	  archives: /archives
	  categories: /categories
	  tags: /tags
	  commonweal: /404.html
	  about: /about
**标签云页面**
添加一个标签云页面, 并在菜单中显示页面链接
新建tags页面
`hexo new page “tags”`
将页面的类型设置为 tags
	title: tags
	date: 2015-09-19 22:37:08
	type: "tags"
	---
关闭评论
	title: tags
	date: 2015-09-19 22:37:08
	type: "tags"
	comments: false
	---
在菜单中添加链接。 编辑主题配置文件, 添加 tags 到 menu 中
	menu:
	  tags: /tags
**分类页面**
添加一个分类页面, 并在菜单中显示页面链接
新建 categories 页面
`hexo new page categories`
将页面的类型设置为categories
	title: categories
	date: 2015-09-19 22:38:00
	type: "categories"
	---
关闭评论
	title: categories
	date: 2015-09-19 22:38:00
	type: "categories"
	comments: false
	---
在菜单中添加链接. 编辑主题配置文件, 添加 categories 到 menu 中
	menu:
	  categories: /categories
**RSS 链接**
编辑主题配置文件 rss 字段
`rss: false`
禁用Feed链接
`rss:`
默认使用站点的 Feed 链接, 需要安装 hexo-generator-feed 插件
浏览[http://localhost:4000/atom.xml查看是否生效](http://localhost:4000/atom.xml%E6%9F%A5%E7%9C%8B%E6%98%AF%E5%90%A6%E7%94%9F%E6%95%88)
`rss: http://your-feed-url`
指定特定的链接地址, 适用于已经烧制过 Feed 的情形
**自定义页面**
以关于页面为例
新建一个 about 页面
`hexo new page "about"`
编辑 source/about/index.md：
	title: About
	date: 2014-11-1 11:11:11
	---
	About Me
菜单显示 about 链接, 主题配置文件中将 menu 中 about 前面的注释去掉
	menu:
	  about: /about
###9.网站代码上传
设置完毕，为避免本地代码丢失，可以将hexo下的所有文件提交一份到服务器。
	#create project on gitcafe.com
	mkdir hexo-source
	cd hexo-source
	git init
	# copy all files in 'hexo' folder here
	git add ..
	git commit -m 'first commit'
	git remote add origin 'git@gitcafe.com:username/hexo-source.git'
	git push -u origin master
####参考文章
[使用Hexo搭建博客](http://blog.lmintlcx.com/post/blog-with-hexo.html)
[通过Hexo在Github上搭建博客教程](http://www.jianshu.com/p/858ecf233db9)
[有那些好看的hexo主题?](http://www.zhihu.com/question/24422335/answer/46357100)
