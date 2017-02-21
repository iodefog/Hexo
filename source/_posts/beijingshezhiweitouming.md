title: 如何把导航背景设置为透明？
date: 2015-12-29 15:55:00
categories: 技术
tags: 
description:
---
这样子就透明了
Object-C

	  [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
	  [self.navigationController.navigationBar setShadowImage:[UIImage new]];
	


Swift：

	self.navigationController!.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
	self.navigationController!.navigationBar.shadowImage = UIImage()


