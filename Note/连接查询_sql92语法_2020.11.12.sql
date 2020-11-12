#--------------------------------连接查询----------------------------------------------------
/*
又称多表查询，当查询的字段来自于多个表时，就会用到连接查询

笛卡尔乘积现象： 表1：有m行，表2：有n行	结果：m*n行
发生原因：没有有效的连接条件
如何避免：添加有效的连接条件


分类：
	按年代分类：
	sql92标准：	仅仅支持内连接
	sql99标准[推荐]	支持内连接 + 外连接(左外 + 右外) + 交叉连接
	
	按功能分类：
		内连接
			等值连接
			非等值连接
			自连接
		外连接
			左外连接
			右外连接
			全外连接
		交叉连接
		

*/

#sql92标准
#                                                           等值连接
/*
1.多表等值连接的结果为多表的交集部分
2.n表连接，至少需要n-1个连接条件
3.多表的顺序没有要求
4.一般需要为表其别名
5.可以搭配前面介绍的所有字句，比如排序、分组、筛选

*/
SELECT NAME, boyname
FROM boys,beauty
WHERE boyfriend_id = boys.id;

#练习 查询员工名和对应的部门编号	
SELECT last_name,employees.department_id
FROM departments, employees
WHERE employees.department_id = departments.department_id ;




#查看员工名、工种号、工种名
# [注] 如果为表起了别名， 则查询的字段就不能使用原来的表名去限定
SELECT last_name, e.job_id, j.job_title
FROM employees e, jobs j
WHERE e.job_id = j.job_id;

#两个表的位置是可以调换的
SELECT last_name, e.job_id, j.job_title
FROM  jobs j, employees e
WHERE e.job_id = j.job_id;

#---------------------------------填加筛选
#练习：查询有奖金的员工名、部门名
SELECT last_name,department_name,commission_pct
FROM employees, departments
WHERE commission_pct IS NOT NULL AND employees.`department_id` = departments.`department_id`


#练习：查询城市名中第二个字符为o的部门名和城市名
SELECT department_name, city
FROM departments, locations
WHERE city LIKE '_o%' AND departments.`location_id` = locations.`location_id`;	

#------------------------添加分组
#练习：查询每个城市的部门个数
SELECT COUNT(*),city
FROM departments, locations
WHERE departments.`location_id` = locations.`location_id`
GROUP BY city;	

#练习：查询有奖金的每个部门名和部门的领导编号和该部门的最低工资
SELECT MIN(salary),department_name,d.manager_id,commission_pct
FROM departments d, employees e
WHERE commission_pct IS NOT NULL AND d.`department_id` = e.`department_id`
GROUP BY  department_name;

#-----------------------------排序
#练习：查询每个工种的工种名个员工的个数，并按员工个数降序
SELECT e.job_id, job_title, COUNT(*)
FROM jobs j, employees e
WHERE j.`job_id` = e.`job_id`
GROUP BY j.`job_id`
ORDER BY COUNT(*) DESC;

#----------------------------实现三表连接
#练习：查找员工名、部门名、和所在的城市
SELECT last_name, department_name, city
FROM departments d, employees e, locations l
WHERE d.`department_id` = e.`department_id` 
AND  d.`location_id` = l.`location_id`;	



#									非等值连接

#练习：查询员工的工资和工资级别
SELECT salary, grade_level
FROM employees, job_grades
WHERE salary BETWEEN lowest_sal AND highest_sal
AND grade_level = 'A';

#                                                                         自连接(在一张表内查两次)
#练习：查询员工名和上级的名称
SELECT e.employee_id, e.last_name, m.employee_id, m.last_name
FROM employees e,employees m
WHERE e.`manager_id` = m.employee_id;
