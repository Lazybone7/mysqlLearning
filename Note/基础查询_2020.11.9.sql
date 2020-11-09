#------------------------------------基础查询------------------------------------------

USE myemployees

#去重
SELECT department_id FROM employees
SELECT DISTINCT department_id FROM employees

#将两个字段合并为一个字段
SELECT CONCAT( last_name,first_name) AS 姓名 FROM employees

#-----------------------------------------------------------------------
SELECT IFNULL(commission_pct,0) AS 奖金率,
	commission_pct
FROM
	employees;
#-----------------------------------------------------------------------
#显示表的所有结构，各个列用逗号隔开
SELECT CONCAT(`employee_id`, ',', `first_name`, ',', `email`, ',', IFNULL(commission_pct,0)) AS 结果
FROM 
	employees