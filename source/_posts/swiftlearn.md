title: Swift 学习

---

1.通知

```
// 添加通知
NotificationCenter.default.addObserver(self, selector: #selector(back), name: NSNotification.Name(rawValue: "NotificationCenterName"), object: nil)

// 移除通知
NotificationCenter.default.removeObserver(self);

```

2.selector

```
// 方法1
UIBarButtonItem.init(image: UIImage.init(named: "fanhui"), style: UIBarButtonItemStyle.done, target: self, action: #selector(self.back))

// 方法2
cyanButton.addTarget(self, action: Selector("cyanButtonClick"), for: .touchUpInside)

```

3.类方法


```
 open class func Test(){
        NSLog("xxxx");
    }
    
// 调用方式
BaseViewController.Test();
```

```
// 带2个以上参数的类方法（以 _ 起始）
override class func tableView(_ tableView:UITableView, rowHeightFor object:Any)-> CGFloat
    {
        return 44;
    }


```

4.标注

```
// OC 
#pragma mark -说明文字

// Swift
// MARK: - 说明文字,带分割线
// MARK: 说明文字,不带分割线

```

5.@available

```
// OC
if(@available(iOS 11.0, *)) { }

// Swift
if #available(iOS 11.0, *) {  }

```

6.get 和 set 方法

```
var _name:String?
    var name:String?{
        get{
            return _name;
        }
        set{
//            只要外界通过.name给name赋值，就会把值给newValue
            _name = newValue
        }
    }
```
在开发过程中不建议这样使用，首先需要定义两个属性，很麻烦。


推荐使用这样的方式实现

```
 var gender:String?{
   willSet{
            //
            NSLog("==========")
        }
        didSet
        {
            NSLog("已经改变的时候", []);
        }
    }
 ```
 
 ```
 // 重写父类setter和getter， 使用 newValue 得到新值
 override var object: Any!{
        set {
            super.object = newValue;
            let item:BaseModel? = object as? BaseModel;
            self.titleLabel?.text = item?.wtKey;
        }
        get {
            return super.object;
        }
    }
 ```
 
 7.for 循环
 
 ```
 //OC风格的 for
 
 for var i = 0; i < 10; i++ {
    println(i)
}

// Swift风格的 for
// 遍历 0 ~ <10
for i in 0..<10 {
    println(i)
}

println("---")

// 遍历 0 ~ 10
for i in 0...10 {
    println(i)
}

// 特殊写法
for _ in 0...10 {
    println("hello")
}
 
```


# 字符串获取长度

Swift3.2

```
let currentCharactorCount = (textView.text?.characters.count)!

```

Swift4.0

```
let currentCharactorCount = textView.text!.count
```

# enum
```
// 映射到整型
enum Movement: Int {
    case Left = 0
    case Right = 1
    case Top = 2
    case Bottom = 3
}
```