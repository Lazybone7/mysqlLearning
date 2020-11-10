#use myemplyees
#----------------------------排序查询---------------------------------------
/*
语法：
	select 查询列表
	from 表
	[where 筛选条件]
	order by 排序列表 [asc | desc]

*/
USE myemployees

#按单个字段排序
SELECT * FROM employees ORDER BY salary DESC;

#按表达式排序
SELECT *, salary * (1 + IFNULL(commission_pct,0))*12 薪资
FROM employees
ORDER BY salary * (1 + IFNULL(commission_pct,0))*12 DESC;

#按别名排序
SELECT *, salary * (1 + IFNULL(commission_pct,0))*12 薪资
FROM employees
ORDER BY salary * (1 + IFNULL(commission_pct,0))*12 DESC;

#按函数排序
SELECT LENGTH(last_name) 字节长度, last_name, salary
FROM employees
ORDER BY LENGTH(last_name) DESC;

#按多个字段排序
SELECT *
FROM employees
ORDER BY salary ASC, employee_id DESC;

/*
总结：
	order by 字句一般是放在查询语句的最后面，limit字句除外
*/