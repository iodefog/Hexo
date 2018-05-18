title: 整站下载器,一个wget命令就搞定了！
categories: 技术

-----------

到处找整站下载器？何必那么麻烦，一个wget命令就搞定了！

或是想克隆扒皮别人的网站，或是想保持别人网站的内容保存下来离线浏览，这是我们一般都是百度搜索各种整站下载软件，挨个尝试哪个好用；

但是如果你会使用linux系统，真的没必要那么麻烦的，直接用wget一个简单的命令就可以轻松的完成整站下载任务，如果是在远程服务器上运行下载速度会非常快；

wget通常我们用来下载文件用的普通工具而已，其实只要添加参数就能够迅速完成网站克隆下载任务了；

Wget整站下载命令：
wget -r -p -np -k www.5yun.org

执行完该命令后，会在当前路径下生成一个www.5yun.org的文件夹，所有文件全部都会下载到这个目录之中；

Wget参数说明：
-r --recursive（递归） specify recursive download.（指定递归下载）
-k --convert-links（转换链接） make links in downloaded HTML point to local files.（将下载的HTML页面中的链接转换为相对链接即本地链接）
-p --page-requisites（页面必需元素） get all images, etc. needed to display HTML page.（下载所有的图片等页面显示所需的内容）
-np --no-parent（不追溯至父级） don't ascend to the parent directory.

额外参数：

-nc  断点续传
-o   生成日志文件

就是这么简单，就是粗暴，就是这么有效，想扒皮仿站的站长们来测试一下下吧！