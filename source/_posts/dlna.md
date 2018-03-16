title: 基于DLNA的 移动端网络视频投屏技术初探
date: 
categories: 技术,DLNA
tags: 
description:

---

# 解决什么问题

* 如何将客户端保存的网络视频地址告诉智能电视盒子
* 合理实现基本播放控制
* 暂不讨论离线流媒体的传输控制

# DLNA是什么

* Digital Living Network Alliance
* 微软(Miracast)、苹果(AirPlay)、三星、索尼
* UPnP SSDP XML SOAP HTTP UDP TCP/IP

# UPnP协议

* 不依赖任何驱动、操作系统、API的传输控制协议
* 基于TCP/IP, HTTP
* 大部分路由器和智能家电都支持
* 存在安全漏洞（局域网内，https支持不好）

# DLNA/UPnP的逻辑架构

* 设备(Device)：扮演渲染/播放角色的设备
* 服务(Service)：提供播控服务
* 控制点(Control Point, CP)：发出播控指令

![image](/img/B276331C-1CED-4330-9A84-C330FE88E14C.jpeg)

# 1. 寻址

* 设备加入网络后确定自身IP
* DHCP

# 2.SSDP
* 基于HTTP（HTTPU、HTTPMU）
* 两种工作方式：
   1.主动通知(Notify)
   2.搜索-响应(HTTP扩展协议：M-SEARCH)
     1.)多播搜索消息、单播搜索消息

# 3. 获取设备的“登记信息”
* UUID
* 是否可进行播放
* 设备的“名片”（设备描述文档）

# SSDP搜索消息格式(UDP)

![image](/img/Picture1.png)

![image](/img/Picture2.png)

# SSDP响应消息格式

![image](/img/Picture3.png)


# 4. 获取设备的“名片”

* 设备描述文档, Device Description Document, DDD
* 描述提供何种服务和能力
* 基于TCP的HTTP请求


请求DDD响应消息格式

![image](/img/Picture4.png)


一个服务的定义格式

![image](/img/Picture5.png)


# 5. 获取设备的服务描述文档

* Service Description Document, SDD
* 接口文档
* 描述该设备的该服务的使用方法

拼接请求SDD的完整地址

![image](/img/Picture6.png)

SDD的响应消息格式

![image](/img/Picture7.png)


# 6. 请求服务

* POST请求
* 拼接基于SOAP格式的消息体
* 根据SDD定义传入相应服务的名字和参数

![image](/img/Picture8.png)

拼接服务动作请求消息格式(POST)

![image](/img/Picture9.png)

服务动作请求响应消息格式

![image](/img/Picture10.png)

# 全套流程

![image](/img/Picture11.png)


# 客户端DLNA库模型设计

![image](/img/Picture12.png)

![image](/img/Picture13.png)

![image](/img/Picture14.png)

# 安全

* 明文传输
* 无法预防投屏地址被抓取
* 无法使用HTTPS等安全传输协议，除非能和需要适配的DLNA设备厂商进行合作协商。
* 在无法干预DLNA设备的前提下，可使用token过期/服务端次数限定等方案。


END



