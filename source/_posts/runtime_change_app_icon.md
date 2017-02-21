title: 如何在运行时改变App的图标
date: 2015-09-09 14:55:00
categories: 技术
tags: 
description:
---
在你完成应用程序的beta版本后，最后会有些人去帮你测试，使你去完善应用程序……或者会有投资青睐。但是如果测试人员有一种简单地方式去检查构建版本的应用程序会不会有帮助呢？
这个教程将会向你展示这些，向你介绍一些或许很少有人知道的Xcode里面的功能。
你会相信在这个教程中你不会写一行Swift的代码吗？当然，你也不用写一句Objective-C代码。
这个教程会让你写一些bash shell脚本。你将会使用到ImageMagick，Terminal，Xcode，去写一个自动在你的app的图标上加上"debug"或者"beta"标识的脚本。
这个教程需要你有一些基本的Unix脚本的知识。你可以跟随一些shell脚本大神学习，但你也可以在[Bash初学者指南](http://www.tldp.org/LDP/Bash-Beginners-Guide/html/)或者[Bas脚本高级编程指南](http://www.tldp.org/LDP/abs/html)。
你想接下来做这些吗？
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441607807357502.png "1441607807357502.png")
app图标
**准备**
首先，你需要安装ImageMagick，这是一个非常强大的图形处理图软件套件，专门通过终端进行。你可以非常简单地通过Homebrew来安装ImageMagick。如果你没有安装Homebrew，或者你可能并不知道它是什么，你可以在主页上学习了解并安装它。
如果你已经安装了Homebrew，打开终端并输入：
1`brew update`这是确定你是否从Homebrew上安装的最新的安装包，这个也是确认你是否有安装Homebrew。
那么，现在，通过使用Homebrew来安装你所需要的安装包。现在输入下面的命令：
1`brew install ImageMagick`![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441607877260484.png "1441607877260484.png")
你将会看到一些列的东西通过Homebrew，展示了ImageMagick安装的详细过程，因此跟着步骤安装。
接下来，你也需要安装Ghostscript，因为你将使用的ImageMagick会依赖它。Ghostscript是一个软件套件用于呈现PDF和PS文件。你需要它是因为它提供了支持ImageMagick的字体。
安装Ghostscript通过运行下面的命令：
1`brew install ghostscript`如果中间发生错误，运行这个命令：
1`brew doctor`如果安装失败，你会得到一个消息，并告诉你如何去修复它。
这些是所有你需要安装的，以在本教程中使用。
**Llama你好**
ImageMagick中有许多命令，但在本教程中，你需要用到的是convert和composite（转换和组合）
convert：一张图片，修改它，然后保存为一张新的图片；
composite：一张图片，在它上面覆盖另外一张图片，然后存为新的第三张图片。
本教程中提供一些简单地图标供使用。当然，你也可以使用你自己的图标，但你需要修改为相应的文件名。在这里下载图标，对于本教程，将其放在桌面上。
这里的目标之一是覆盖构建版本应用程序的图标。所以你将看到如何使用ImageMagick覆盖文本图像将Hello World放在其中的一个图标上。打开终端并进入到放应用程序图标的文件夹:
1`cd ~/Desktop/AppIconSet`现在输入：
1`convert AppIcon60x60@2x.png -fill white -font Times-Bold -pointsize 18 -gravity south -annotate 0 ``"Hello World"` `test.png`我将会逐一分解这行命令，因此你将会明白它做了写什么：
1、AppIcon60x60@2x.png 是输入图片的名字;
2、fill white 设置文本为白色;
3、font Times-Bold 告诉ImageMagick使用什么字体;
4、pointsize 18 设置字体的大小为18;
5、gravity south 文本与图片的底部对齐
6、annotate 0 "Hello World" 告诉ImageMagick使带有"Hello World"文本注释的图片旋转的度数为0度；
7、test.png 输出的文件名，并且ImageMagick将会覆盖掉已经存在的文件。
如果你在终端上没有看到任何的错误，那么你将会在AppIconSet的文件夹中看到一个命名为test.png的文件，打开后你会看到这样：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441607918282555.png "1441607918282555.png")
提示：如果你看到了错误的消息，或者是脚本没有作用，那么可能是你没有安装所需的字体。通过运行下面的命令，看下你所能用的字体有哪些。
1`convert -list font`如果你没有Times这个字体，那么选择一个你可以使用的来代替。
现在，将beta标志加载图片上。在终端上输入：
1`composite betaRibbon.png test.png test2.png`这个是将betaRibbon.png放在test.png的上面，然后将合成的图片保存为test2.png
打开test2.png。等等，你看到的还是原来的test.png.
那么为什么会是这样呢？
test.png 大小是120x120的，然而，betaRibbon.png是1024x1014的，所以betaRibbon.png只有透明的那部分在test.png上，剩下的部分被裁剪掉了。
不相信我吗？那么试下相同的命令，但是将betaRibbon.png 和 test.png位置交换。
1`composite test.png betaRibbon.png test2.png`你现在将会看到一张在test.png的右上角带有beta的很大的图片：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441607958172223.png "1441607958172223.png")
为了得到我们想要的，你需要将betaRibbon.png的尺寸改为120x120的。在ImageMagick中这是非常容易的。仅仅输入：
1`convert betaRibbon.png -resize 120x120 smallBetaRibbon.png`这行命令是将betaRibbon.png的大小改为120x120，并保存为smallRetaRibbon.png
现在，执行下面：
1`composite smallBetaRibbon.png test.png test2.png`打开test2.png，然后你将看到我们期待的：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441607984757131.png "1441607984757131.png")
这些就是在本教程中你需要知道的ImageMagick的功能，但是这些仅仅是ImageMagick功能的冰山一角。点击ImageMagick的主页，查看更多关于它的功能。
**Xcode**
在这些图像处理工作之后，是时候回到我们熟悉的平台了。
打开Xcode，选择File\New\Project…选择 iOS\Application\Single View Application, 然后点击 Next. 工程命名为Llama Trot, 选择语言为 Swift, 然后设置设备为Universal. 然后将工程保存在桌面上。
你的目标是通过Xcode和ImageMagick，根据所选的构建配置，在每次构建时生成一个适当的图标。
Xcode能够在你的工程构建时运行脚本来做些事情。运行脚本仅仅是Unix脚本，就像你已经写过的，在你每次运行你的Xcode的项目时执行。
**设置一个运行脚本**
在你的工程中，选择Llama Trot的Target，然后选择Build Phases，点击+，在弹出的菜单中选择New Run Script Phase：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608008761182.png "1441608008761182.png")
你将会看到Run Script Phase添加到你的工程配置中。
在运行脚本时，Shell参数被自动设置为bin/sh，也就是说脚本将在bash Unix shel中执行。
下面的框是让你用来写脚本的。在框中输入：
1`echo ``"Hello World"`你的新的 build phase应该看起来像下面这样：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608176989836.png "1441608176989836.png")
构建并运行。你将看到什么也没发生。这事因为脚本打印的"Hello World"在你的构建日志中。
点击Report Navigator，Xcode的导航栏面板最右边的图标，点击最近构建的报告，像下图展示的这样。当你构建一个工程时，这里描述了Xcode为你做的所有的事情，你将会看到"Hello World"：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608189260183.png "1441608189260183.png")
**应用图标**
很好，现在你已经写了一个脚本输出"Hello World"，就像你作为一个开发者的职业生涯中已经做过一百万次打印"Hello World"。现在是时候修改应用的图标了。
**从你的脚本中找到应用图标**
将所有的应用图标都添加到Images.xcassets中，将每个图标拖到合适的AppIcon尺寸上：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608205491883.png "1441608205491883.png")
同时，你也要将debugRibbon.png 和 betaRibbon.png 放在和.xcodeproj同级的目录文件中。
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608213911896.png "1441608213911896.png")
为了使用icons，你的脚本需要知道致谢icons在哪里。用下面的代码代替你之前写的脚本：
12`echo ``"${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"``echo ``"${SRCROOT}"`1、第一行打印在你运行你的项目后的问佳佳路径，包含最后一个图标。
2、第二行打印项目文件所在的文件夹路径。
这是通过使用Xcode的一些构建设置的变量。
运行你的项目并查看构建报告。你将会看到描述你的工程最后产品的文件路径。在它下面，你将会看到你的项目工程所在的文件路径：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608232222846.png "1441608232222846.png")
定位到第一个文件夹，查看它所在的位置；你将看到你的app中所有的东西，包括所有的app图标。这里面是存放ImageMagick修改后的图标的地方。
通过在Application icon点击右键，然后选择Show Package Contents，你将看到这些图标。现在他们都是看起来非常正常的！
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608242647253.png "1441608242647253.png")
现在定位到打印的第二个文件路径。这个仅仅是你正常工程项目的文件夹。因此，应用图标在哪里呢？
前往有着相同名字的Llama Trot文件。在这里面你将看到Images.xcassets。打开Images.xcassets，你将会看到另外一个叫AppIcon.appiconset的文件。
应用图标就在这个文件夹中，你将通过ImageMagick来修改它们。假设你将你的工程保存到桌面上命名为Llama Trot，那么图标的路径为~/Desktop/Llama\ Trot/Llama\ Trot/Images.xcassets/AppIcon.appiconset
将脚本的最后一行替换为下面的代码，你将会得到原始图标的我完整路径：
12`IFS=$``'\n'``echo $(find ${SRCROOT} -name ``"AppIcon60x60@2x.png"``)`1、第一行设置IFS-internal字段分隔符换行符。如果你不这样做,第二行就会失败,因为文件名,Llama Trot,包含一个空格。如果你好奇没有第一行发生了什么，你可以将其删除后尝试一下。
2、第二行中此命令$ { SRCROOT }文件夹递归搜索文件AppIcon60x60@2x.png。
运行项目，你将会看到 AppIcon60x60@2x 完整的路径被打印出来：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608261988080.png "1441608261988080.png")
**将它们放在一起**
困难的事情就要结束了。现在是时候将它们放在一起，通过你的脚本来修改应用的图标。你将首先开始修改AppIcon60x60@2x.png，然后处理所有的应用图标。这就意味着你需要在Retina@2x的模拟器或者6Plus上测试。
通过结合ImageMagick的技术和你以前的脚本,最终你会得到下面的脚本。确保更新相应的脚本:
12345678910`IFS=$``'\n'``#1``PATH=${PATH}:/usr/local/bin``#2``TARGET_PATH=``"${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/AppIcon60x60@2x.png"``BASE_IMAGE_PATH=$(find ${SRCROOT} -name ``"AppIcon60x60@2x.png"``)``#3``convert betaRibbon.png -resize 120x120 resizedBetaRibbon.png``#4``convert ${BASE_IMAGE_PATH} -fill white -font Times-Bold -pointsize 18 -gravity south -annotate 0 ``"Hello World"` `- | composite resizedBetaRibbon.png - ${TARGET_PATH}`现在来分析发生了什么：
1、如果你省略第一行，编译将失败。你的终端有一个叫PATH的变量，来存储一些默认的本地脚本。对于所有的命令终端认为这是第一个，默认并不是Unix的一部分。这允许任何命令位于一个目录路径运行没有指定完整的命令的位置。Xcode需要将相同的PATH变量分享给你的终端。这行添加/user/local/bin到PATH变量，Homebrew安装的地方。
2、接下来的两行，获取本地的应用图标，然后分别将该路径保存到TARGET_PATH 和 BASE_IMAGE_PATH 变量中
3、这行是将betaRibbon.png的图标的尺寸改为合适的大小；
4、最后一行做了两件事情。首先，它在原始的应用图标上添加"Hello World"文本。然后该脚本执行合成的功能--将有beta标识的图片放置在其上面。然后将合成的图片保存为应用的图标。
提示：应用程序图标名字不是任意的。在最终的产品，应用程序图标的名称必须像AppIcon60x60@2x.png。Xcode使用此命名约定来确定使用哪个图标根据设备使用。
运行项目，在你的设备的主屏幕中看你的应用的图标；吐过你是在模拟其中，可以按Cmd + Shift + H 切换到主屏幕。你将会看到一个修改过的图标：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608292923083.png "1441608292923083.png")
**剩下的图标**
现在你已经处理了一个图标，现在该将这个脚本去处理所有的图标了，以使得在iPad、iPhone 6+等上显示。
要做到这一点,你就会把代码修改到一个函数,使图标图标的名称作为参数。然后为每个图标执行该函数。
修改脚本像下面这样：
1234567891011121314`PATH=${PATH}:/usr/local/bin``IFS=$``'\n'``function` `generateIcon () {``BASE_IMAGE_NAME=$1``TARGET_PATH=``"${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${BASE_IMAGE_NAME}"``BASE_IMAGE_PATH=$(find ${SRCROOT} -name ${BASE_IMAGE_NAME})``WIDTH=$(identify -format %w ${BASE_IMAGE_PATH})``convert betaRibbon.png -resize $WIDTHx$WIDTH resizedRibbon.png``convert ${BASE_IMAGE_PATH} -fill white -font Times-Bold -pointsize 18 -gravity south -annotate 0 ``"Hello World"` `- | composite resizedRibbon.png - ${TARGET_PATH}``}``generateIcon ``"AppIcon60x60@2x.png"``generateIcon ``"AppIcon60x60@3x.png"``generateIcon ``"AppIcon76x76~ipad.png"``generateIcon ``"AppIcon76x76@2x~ipad.png"`这使得整个图像处理代码为一个函数,称为generateIcon(),并且你将图标的名称传递给过程作为参数。脚本访问这个论点通过使用$1,并设置变量BASE_IMAGE_PATH.$ { BASE_IMAGE_PATH }然后放置AppIcon60x60@2x之前放置的地方。
你将会发现ImageMagick的一个新功能，Identity，这个功能会获取图片的信息。在这种情况下，你想使用通过格式化-format %w 得到的宽度在identify，去重新改变betaRibbon.png的大小。
现在，选择一个iPad或者一个iPhone6+的模拟器，然后运行该项目。这是因为字体的大小是用像素表示的，不同的设备屏幕有不同的像素密度。
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608312337691.png "1441608312337691.png")
这是很容易的。你真正想要的是根据整个图标通过一定的比例来设置文本的高度。
在你之前设置WIDTH变量的地方立即加入下面的脚本：
1`FONT_SIZE=$(echo ``"$WIDTH * .15"` `| bc -l)`这行是非常微妙的，但是它确实是设置一个FONT_SIZE变量可变宽度的五分之一。因为Unix算术不支持浮点运算,您必须使用bc程序。
basic calculator的缩写，bc能够处理浮点类型的计算。
现在，改变最后一行generateIcon() ，通过使用FONT_SIZE变量来代替18.最后脚本应该是下面这样：
123456789101112131415`PATH=${PATH}:/usr/local/bin``IFS=$``'\n'``function` `generateIcon () {``BASE_IMAGE_NAME=$1``TARGET_PATH=``"${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${BASE_IMAGE_NAME}"``BASE_IMAGE_PATH=$(find ${SRCROOT} -name ${BASE_IMAGE_NAME})``WIDTH=$(identify -format %w ${BASE_IMAGE_PATH})``FONT_SIZE=$(echo ``"$WIDTH * .15"` `| bc -l)``convert betaRibbon.png -resize $WIDTHx$WIDTH resizedRibbon.png``convert ${BASE_IMAGE_PATH} -fill white -font Times-Bold -pointsize ${FONT_SIZE} -gravity south -annotate 0 ``"Hello World"` `- | composite resizedRibbon.png - ${TARGET_PATH}``}``generateIcon ``"AppIcon60x60@2x.png"``generateIcon ``"AppIcon60x60@3x.png"``generateIcon ``"AppIcon76x76~ipad.png"``generateIcon ``"AppIcon76x76@2x~ipad.png"`运行你的工程项目在不同的设备上，你会发现好多了。
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608335189583.png "1441608335189583.png")
**构建号**
在图标上将"Hello World"文本换位构建号其实是很容易的事情。
版本的构建号可以在Info.plist中的CFBundleVersion找到。
因此，你要怎样将它放在你的脚本中呢？事实证明，你的Mac会通过一个程序来帮你实现。它叫PlistBuddy，你可以在/usr/libexec/中找到。
在你的脚本的最上面添加下面这行：
1`buildNumber=$(/usr/libexec/PlistBuddy -c ``"Print CFBundleVersion"` `"${PROJECT_DIR}/${INFOPLIST_FILE}"``)`这行是通过使用PlistBuddy来获取构建号。现在很简单的将"Hello World" 替换为$buildNumber：
1`convert ${BASE_IMAGE_PATH} -fill white -font Times-Bold -pointsize ${FONT_SIZE} -gravity south -annotate 0 ``"$buildNumber"` `- | composite resizedRibbon.png - ${TARGET_PATH}`在General中改变构建号为2015：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608374372321.png "1441608374372321.png")
现在运行。你将会看到一个有构建号的图标：
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608383827075.png "1441608383827075.png")
**构建配置**
太酷了！整个过程即将完成。你已经在项目每次运行时将一个beta标识和一个构建号添加在应用图标上。
但是你不想永远是一个beta标识和构建号。那该怎么办？
在Xcode中，到项目配置中。你将会看到两个默认的设置：Debug和Release。
点击+，选择Duplicate Release 然后将它命名为 Beta。
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608397374848.png "1441608397374848.png")
Dubug配置将是调试版本，Beta配置将是测试版本，Release配置将是释放发布版本。
现在你需要将这些配置放在你的脚本中，并通过CONFIGURATION来设置。在脚本总添加一个if来选择当前的配置。更新你的脚本如下：
123456789101112131415161718192021222324252627`IFS=$``'\n'``buildNumber=$(/usr/libexec/PlistBuddy -c ``"Print CFBundleVersion"` `"${PROJECT_DIR}/${INFOPLIST_FILE}"``)``versionNumber=$(/usr/libexec/PlistBuddy -c ``"Print CFBundleShortVersionString"` `"${PROJECT_DIR}/${INFOPLIST_FILE}"``)``PATH=${PATH}:/usr/local/bin``function` `generateIcon () {``BASE_IMAGE_NAME=$1``TARGET_PATH=``"${BUILT_PRODUCTS_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}/${BASE_IMAGE_NAME}"``echo $TARGET_PATH``echo $SRCROOT``echo $(find ${SRCROOT} -name ``"AppIcon60x60@2x.png"``)``BASE_IMAGE_PATH=$(find ${SRCROOT} -name ${BASE_IMAGE_NAME})``WIDTH=$(identify -format %w ${BASE_IMAGE_PATH})``FONT_SIZE=$(echo ``"$WIDTH * .15"` `| bc -l)``echo ``"font size $FONT_SIZE"``if` `[ ``"${CONFIGURATION}"` `== ``"Debug"` `]; then``convert debugRibbon.png -resize ${WIDTH}x${WIDTH} resizedRibbon.png``convert ${BASE_IMAGE_PATH} -fill white -font Times-Bold -pointsize ${FONT_SIZE} -gravity south -annotate 0 ``"$buildNumber"` `- | composite resizedRibbon.png - ${TARGET_PATH}``fi``if` `[ ``"${CONFIGURATION}"` `== ``"Beta"` `]; then``convert betaRibbon.png -resize ${WIDTH}x${WIDTH} resizedRibbon.png``convert ${BASE_IMAGE_PATH} -fill white -font Times-Boldr -pointsize ${FONT_SIZE} -gravity south -annotate 0 ``"$buildNumber"` `- | composite resizedRibbon.png - ${TARGET_PATH}``fi``}``generateIcon ``"AppIcon60x60@2x.png"``generateIcon ``"AppIcon60x60@3x.png"``generateIcon ``"AppIcon76x76~ipad.png"``generateIcon ``"AppIcon76x76@2x~ipad.png"`改变构建配置，通过选择 Product\Scheme\Edit Scheme…，选择Info，，然后基于你将要做的选择构建配置，Run，Archive，Profile等等。
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608417473437.png "1441608417473437.png")
这就是它!有构建数字和标识的应用图标!
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608427139280.png "1441608427139280.png")
beta
![blob.png](http://cc.cocimg.com/api/uploads/20150907/1441608439798289.png "1441608439798289.png")
debug
另外，代码可[点击下载](https://github.com/zmp1123/ChangeAppIcon)参考
转自：http://www.cocoachina.com/ios/20150909/13354.html
- 原文：[How To Change Your App Icon at Build Time](http://www.raywenderlich.com/105641/change-app-icon-build-time)

- 作者： Neil Dwyer

- 翻译：zmp1123

- 微信号：iOS开发者


