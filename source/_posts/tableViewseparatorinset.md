title: iOS8 设置TableView Separatorinset 分割线从边框顶端开始
date: 2014-11-04 17:39:00
categories: 技术
tags: 
description:
---
转自：http://www.cocoachina.com/bbs/simple/?t233228.html


在ios8上 [TableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];不起作用

经过测试加入下面方法 在ios7 8上都可以正常工作

<!--more-->

-(void)viewDidLayoutSubviews
{
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsMake(0,0,0,0)];
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.tableView setLayoutMargins:UIEdgeInsetsMake(0,0,0,0)];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}