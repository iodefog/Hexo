title : iOS开发中的一些技巧收集
tag : ios
categaries: 技术


---

### 1. cell 出现时加入动画

```
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{

    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    //x和y的最终值为1
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);
    }];
}
```

![image](/img/6ec8e8eba254dd2bcb6885212743dead.gif)


### 2.转场动画

```
// 选中某一行
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 选中后取消选中的颜色
    
    showInfoViewController *VC = [[showInfoViewController alloc]init];
    
    //插入动画
    CGRect rectInTableView = [tableView rectForRowAtIndexPath:indexPath];
    CGRect sourceRect = [tableView convertRect:rectInTableView toView:[tableView superview]];
    UITableViewCell * selectedCell = (UITableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    selectedCell.frame = sourceRect;
    selectedCell.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:selectedCell];
    [self bgView];
    [self.view addSubview:_bgView];
    [self.view bringSubviewToFront:selectedCell];
    self.tempView = [[UIView alloc] initWithFrame:selectedCell.frame];
    self.tempView.backgroundColor = [UIColor whiteColor];
    self.tempView.alpha = 0;
    [self.view addSubview:self.tempView];
    // 进行动画
    [UIView animateWithDuration:0.3 animations:^{
        selectedCell.transform = CGAffineTransformMakeScale(1.0, 1.1);
        self.tempView.alpha = 1;
    }];
    
    double delayInSeconds = 0.3;
    __block ViewController* bself = self;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [selectedCell removeFromSuperview];
        // 进行动画
        [UIView animateWithDuration:0.3 animations:^{
            bself.tempView.transform = CGAffineTransformMakeScale(1.0, SCREEN_HEIGHT / bself.tempView.frame.size.height * 2);
        }];
    });
    
    double delayInSeconds2 = 0.6;
    dispatch_time_t popTime2 = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds2 * NSEC_PER_SEC));
    dispatch_after(popTime2, dispatch_get_main_queue(), ^(void){
        // 进行动画
        [UIView animateWithDuration:0.3 animations:^{
            [bself.navigationController pushViewController:VC animated:NO];
        } completion:^(BOOL finished) {
            [bself.tempView removeFromSuperview];
            [bself.bgView removeFromSuperview];
        }];
    });
    
}

// 阴影视图
- (UIView *)bgView {
    if (nil == _bgView) {
        _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bgView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
    }
    return _bgView;
}

```


```
-(void)pushView{
    threeViewController *vc = [[threeViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromRight animations:nil completion:nil];
}

-(void)popview{
    [self.navigationController popViewControllerAnimated:YES];
    [UIView transitionWithView:self.navigationController.view duration:1 options:UIViewAnimationOptionTransitionFlipFromLeft animations:nil completion:nil];
}
```