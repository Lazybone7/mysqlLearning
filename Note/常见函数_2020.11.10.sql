#------------------------------------------------------常见函数--------------------------------------------
/*
好处：1.隐藏了实现细节		2.提高代码复用性
调用：select 函数名(实参列表)[from 表]
特点：
	1.叫什么
	2.干什么
分类：
	1.单行函数：
	如 concat、length、ifnull等
	
	2.分组函数
	功能：做统计使用，又称为统计函数、聚合函数、组函数



*/

#1. 字符函数

#length 获取参数值的字节个数
SELECT LENGTH('john');
SELECT LENGTH('山东卫视abc');
#查看字符集
SHOW VARIABLES LIKE '%char%';

#2.concat 拼接字符串
SELECT CONCAT(last_name,first_name) 姓名
FROM employees

#3.upper、lower
SELECT CONCAT(UPPER(last_name), LOWER(first_name)) 姓名 FROM employees

#4.substr、substring
#[注]：sql中索引值从1开始

#substr：截取从k开始的字符
SELECT SUBSTR('Hello mySql',3) out_put;

#substr：截取从k开始,长度为len的字符
SELECT SUBSTR('Hello mySql',4,5) out_put;

#5.instr:
#查找字符串中含有指定字符的开头索引
SELECT INSTR('Hello mySql','lo') out_put;

#6.trim：去除字符串开头和结尾的空格
SELECT TRIM('      hello mysql    ');
#去除字符串中开头和结尾的指定字符
SELECT TRIM('a' FROM 'ahello mysqlaaaaaaa');

#7. lpad：向左补全字符串，达到指定长度
SELECT LPAD('mysql', 10, '*');

#   rpad  向右补全字符串，达到指定长度
SELECT RPAD('mysql', 10, '#');

#8.replace 替换
#将字符串中的指定字符替换成指定字符
SELECT REPLACE('hello,mysql', 'mysql', 'sqlserver');
