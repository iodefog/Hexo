title: PHP学习
categories: 技术,PHP
tags: 
description:

---

PHP学习


## 1. 获取get和post方法中参数

get方法

```
<?php
$name=_GET('name');
echo $name;
?>
```

post方法都使用

```
<?php
$name=_POST('name');
echo $name;
?>
```
## 2.返回json值

数组

```
<?php
$name=$_POST["name"];
$age=$_POST["age"];
$gender=$_POST["gender"];

// 生成json字典
$arrayName = array("name" => $name,
					"age" => $age,
				    "gender" => $gender);

// 生成json数组
$arrayName2 = array($arrayName,$arrayName,$arrayName);
echo  json_encode($arrayName2);
?>
```

json_encode()只能转换UTF-8格式。否则就会为null。

转换编码

第一个参数，当前编码格式。
第二个参数，转换到的编码格式。
第三个参数，需要转换的值
```
$newArray = iconv('UTF-8',"GBK",$array);
```

## 3.组装json

1. 定义Response类，json()方法 进行参数组装
```
<?php
class Response{
	/**
	* 这里注释
	*/
	public static function json($code, $message='', $data=array()){
		if(!is_numeric($code)){
			return '';
		}
		$result = array(
			'code' => $code,
			'message' => $message,
			'data' => $data
		);

		echo json_encode($result);
		exit;
	}
}
?>
```


2. 使用组装类的方法

// 引用当前目录下的“response.php”文件
require_once('./response.php');

```
<?php
$name=$_POST["name"];
$age=$_POST["age"];
$gender=$_POST["gender"];

// 引用当前目录下的“response.php”文件
require_once('./response.php');

// 生成json字典
$arrayName = array("name" => $name,
					"age" => $age,
				    "gender" => $gender);
// 生成json数组
$response = Response::json("200", "成功",$arrayName);
echo  json_encode($response);
?>
```