#!/bin/bash

# 切换到用户主目录
cd ~
# 获取当前用户路径
USERPATH=$(pwd)

# 清理 Xcode DerivedData 目录
echo "rm -rf $USERPATH/Library/Developer/Xcode/DerivedData/"
rm -rfv "$USERPATH/Library/Developer/Xcode/DerivedData/"

# 清理 Xcode Archives 目录
echo "rm -rf $USERPATH/Library/Developer/Xcode/Archives/"
rm -rfv "$USERPATH/Library/Developer/Xcode/Archives/"

# 清理 Xcode Products 目录
echo "rm -rf $USERPATH/Library/Developer/Xcode/Products/"
rm -rfv "$USERPATH/Library/Developer/Xcode/Products/"

# 清理 CoreSimulator Devices 目录
echo "rm -rf $USERPATH/Library/Developer/CoreSimulator/Devices/"
rm -rfv "$USERPATH/Library/Developer/CoreSimulator/Devices/"

# 清理 XCPGDevices 目录
echo "rm -rf $USERPATH/Library/Developer/XCPGDevices/"
rm -rfv "$USERPATH/Library/Developer/XCPGDevices/"

# 删除不可用的模拟器
echo "xcrun simctl delete unavailable"
xcrun simctl delete unavailable

# 清理用户和系统的废纸篓
echo "rm -rfv $USERPATH/.Trash /Volumes/*/.Trashes"
rm -rfv $USERPATH/.Trash /Volumes/*/.Trashes

# 清理用户缓存目录
echo "rm -rf $USERPATH/Library/Caches/"
rm -rvf "$USERPATH/Library/Caches/"

# 删除 Emacs 共享目录
echo "rm -rf /usr/share/emacs/"
rm -rvf /usr/share/emacs/

# 清理系统临时文件目录（需要 sudo 权限）
echo "sudo rm -rf /private/var/folders/*"
sudo rm -rvf /private/var/folders/*

# 清理系统日志目录（需要 sudo 权限）
echo "sudo rm -rf /private/var/log/*"
sudo rm -rf /private/var/log/*

# 注意：此脚本会删除大量系统和用户数据，请谨慎使用
# 建议在执行前备份重要数据
# 某些操作需要管理员权限，可能会要求输入密码
