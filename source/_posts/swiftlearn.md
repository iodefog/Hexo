title: Swift 学习

---

1. 通知

```
// 添加通知
NotificationCenter.default.addObserver(self, selector: #selector(back), name: NSNotification.Name(rawValue: "NotificationCenterName"), object: nil)

// 移除通知
NotificationCenter.default.removeObserver(self);

```

2. selector

```
// 方法1
UIBarButtonItem.init(image: UIImage.init(named: "fanhui"), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.back))

// 方法2
cyanButton.addTarget(self, action: Selector("cyanButtonClick"), for: .touchUpInside)

```

3. 类方法


```
 open class func Test(){
        NSLog("xxxx");
    }
    
// 调用方式
BaseViewController.Test();
```

4. 标注

```
// OC 
#pragma mark -说明文字

// Swift
// MARK: - 说明文字,带分割线
// MARK: 说明文字,不带分割线

```

5. @available
```
// OC
if(@available(iOS 11.0, *)) { }

// Swift
if #available(iOS 11.0, *) {  }

```