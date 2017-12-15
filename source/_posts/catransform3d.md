title: CATransform3D等方法介绍说明
tags: object-c,ios,CATransform3D
categories : ios


----


概述
CATransform3D是一个用于处理3D形变的类,其可以改变控件的平移、缩放、旋转、斜交等,其坐标系统采用的是三维坐标系,即向右为x轴正方向,向下为y轴正方向,垂直屏幕向外为z轴正方向


方法介绍


### CATransform3DMakeTranslation实现以初始位置为基准,在x轴方向上平移x单位,在y轴方向上平移y单位,在z轴方向上平移z单位

```bash
// 格式
CATransform3DMakeTranslation (CGFloat tx, CGFloat ty, CGFloat tz)
// 样例
self.demoImageView.layer.transform = CATransform3DMakeTranslation(100, 100, 0);


注: 注: 当tx为正值时,会向x轴正方向平移,反之,则向x轴负方向平移;当ty为正值时,会向y轴正方向平移,反之,则向y轴负方向平移;当tz为正值时,会向z轴正方向平移,反之,则向z轴负方向平移

```

### CATransform3DMakeScale实现以初始位置为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍,在z轴方向上缩放z倍

```bash
// 格式
CATransform3DMakeScale (CGFloat sx, CGFloat sy, CGFloat sz)
// 样例
self.demoImageView.layer.transform = CATransform3DMakeScale(2, 0.5, 1);

注: 当sx为正值时,会在x轴方向上缩放x倍,反之,则在缩放的基础上沿着竖直线翻转;当sy为正值时,会在y轴方向上缩放y倍,反之,则在缩放的基础上沿着水平线翻转

```


#### CATransform3DMakeRotation实现以初始位置为基准,在x轴,y轴,z轴方向上逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度),x,y,z三个参数只分是否为0

```bash
// 格式
CATransform3DMakeRotation (CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
// 样例
self.demoImageView.layer.transform = CATransform3DMakeRotation(M_PI*0.25, 0, 0, 1);
注: 当x,y,z值为0时,代表在该轴方向上不进行旋转,当值为1时,代表在该轴方向上进行逆时针旋转,当值为-1时,代表在该轴方向上进行顺时针旋转
```


### CATransform3DTranslate实现以一个已经存在的形变为基准,在x轴方向上平移x单位,在y轴方向上平移y单位,在z轴方向上平移z单位

```bash
// 格式
CATransform3DTranslate (CATransform3D t, CGFloat tx, CGFloat ty, CGFloat tz)
// 样例
CATransform3D transform = CATransform3DIdentity;
transform.m34 = -1.0/500;
self.demoImageView.layer.transform = CATransform3DTranslate(transform, 0, 0, 100);
```

### CATransform3DScale实现以一个已经存在的形变为基准,在x轴方向上缩放x倍,在y轴方向上缩放y倍,在z轴方向上缩放z倍

```bash
// 格式
CATransform3DScale (CATransform3D t, CGFloat sx, CGFloat sy, CGFloat sz)
// 样例
CATransform3D transform = CATransform3DIdentity;
transform.m34 = -1.0/500;
self.demoImageView.layer.transform = CATransform3DScale(transform, 2, 0.5, 1);
```
### CATransform3DRotate实现以一个已经存在的形变为基准,在x轴,y轴,z轴方向上逆时针旋转angle弧度(弧度=π/180×角度,M_PI弧度代表180角度),x,y,z三个参数只分是否为0

```bash
// 格式
CATransform3DRotate (CATransform3D t, CGFloat angle, CGFloat x, CGFloat y, CGFloat z)
// 样例
CATransform3D transform = CATransform3DIdentity;
transform.m34 = -1.0/500;
self.demoImageView.layer.transform = CATransform3DRotate(transform, M_PI*0.25, 1, 0, 0);
```

### 特殊地,transform属性默认值为CATransform3DIdentity,可以在形变之后设置该值以还原到最初状态

```bash
// 样例
self.demoImageView.layer.transform = CATransform3DIdentity;
```


提供一个demo
[https://github.com/timelywind/YUAnimation](https://github.com/timelywind/YUAnimation)