title : iOS模拟器命令行安装ipa知识点（只能是模拟器app才可以）

---


## 查看支持的模拟器列表及UUID

```
xcrun simctl list
```

## 启动运行模拟器：

```
xcrun instruments -w 'iPhone 6 Plus'

```

## 在已经启动好的模拟器中安装应用：

```
// Usage: simctl install <device> <path>

xcrun simctl install booted Calculator.app
```

## 启动已安装的应用，需要用到bundleid

```
xcrun simctl launch booted com.sincefox.zoucai.first
com.sincefox.zoucai.first: 24517
```

也可以传入一些启动参数xcrun simctl launch booted com.taobao.tmall -DumplingsPort 7001。对应的客户端应用获取参数逻辑是：

```
[[[NSUserDefaults standardUserDefaults] dictionaryRepresentation] enumerateKeysAndObjectsUsingBlock:^(NSString * _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if([key isEqualToString:@"DumplingsPort"]){
                port = obj;
                *stop = YES;
            }
}];

```