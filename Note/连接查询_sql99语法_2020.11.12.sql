#二.sql99语法
/*
语法
	select 查询列表
	from 表1 别名 [连接类型]
	join 表2 别名
	on 连接条件
	[where 筛选条件]
	[group by 分组]
	[having 筛选条件]
	[order by 排序列表]


分类			
					连接类型
	内连接（※） 			inner
	外连接				
		左外（※）		left[outer]
		右外（※）		right[outer]
		全外			full[outer]
	交叉连接			cross

*/


#-----内连接
/*
select 查询列表
	from 表1 别名
	[inner] join 表2 别名	
	on 连接条件
	[where 筛选条件]
	[group by 分组]
	[having 筛选条件]
	[order by 排序列表]
	
分类：
	等值
	非等值
	自连接

特点：
	1.添加排序、分组、筛选
	2.inner可以省略
	3.筛选条件放在where后面，连接条件放在on后面，提高分离性，便于阅读
	3.innner join连接 和 sql92中实现的等值连接的效果是一样的，都是查询多表的交集
	
	
*/
#                                        一、内连接
#1.等值连接

#练习 查询员工名和对应的部门名
SELECT salary, department_name
FROM employees e 
INNER JOIN departments d
ON e.`department_id` = d.`department_id`;

#练习 查看员工名、工种号、工种名(添加筛选)
SELECT last_name, e.job_id, job_title
FROM employees e
INNER JOIN jobs j
ON e.`job_id` = j.`job_id` 
WHERE last_name LIKE '%e%';

#练习 查询部门个数 > 3 的城市名和部门个数（分组+筛选）
SELECT COUNT(*), city
FROM departments d
INNER JOIN locations l
ON l.`location_id` = d.`location_id`
GROUP BY city
HAVING COUNT(*) > 3;

#练习 查询哪个部门的员工个数>3的部门名和员工个数，并按个数降序(排序)
SELECT	 department_name, COUNT(*)
FROM employees e
INNER JOIN departments d
ON d.`department_id` = e.`department_id`
GROUP BY department_name
HAVING COUNT(*) > 3
ORDER BY COUNT(*) DESC;

#练习 查询员工名、部门名、工种名，并按部门名降序（三表连接）
SELECT last_name, department_name, job_title
FROM employees e
INNER JOIN departments d ON e.`department_id` = d.`department_id`
INNER JOIN jobs j ON j.`job_id` = e.`job_id`
ORDER BY department_name DESC; 

#2.非等值连接

#练习：查询员工的工资和工资级别
SELECT salary, grade_level
FROM employees e
INNER JOIN job_grades jg ON e.`salary` BETWEEN lowest_sal AND highest_sal;

#练习：查询每个工资级别个数>20的个数，并按工资级别降序
SELECT COUNT(*),grade_level
FROM employees e
INNER JOIN job_grades jg ON e.`salary` BETWEEN lowest_sal AND highest_sal
GROUP BY grade_level
HAVING COUNT(*) > 20
ORDER BY grade_level DESC

# 3.自连接

#练习：查询姓名中包含k的员工名和上级的名称
SELECT e.last_name, m.last_name
FROM employees e
JOIN employees m 
ON e.`manager_id` = m.employee_id
WHERE e.last_name LIKE '%k%';



# 							二、外连接
/*
应用场景： 用于查询一个表中有，另一个表没有的记录

特点：
1. 外连接的查询结果为主表的所有记录
	如果从表中有和他匹配的，则显示匹配的值
	如果从表中没有和他匹配的，则显示null
	外连接查询的结果 = 内连接查询结果 + 主表中有而从表中没有的记录
2. 左外连接： left  join左边的是主表
   右外连接： right join右边的是主表
   左外和右外交换两个表的顺序，可以实现同样的效果
   
3.全外连接 = 内连接的结果 + 表1有而表2没有的记录 + 表1没有而表2有的记录
*/

#					(左/右)外连接
#练习 查询没有男朋友的女神名
SELECT b.name
FROM beauty b
LEFT OUTER JOIN boys bo ON b.`boyfriend_id` = bo.`id`
WHERE bo.id IS  NULL;

#查询哪个部门没有员工
SELECT department_name,e.*
FROM departments d
LEFT OUTER JOIN employees e ON e.`department_id` = d.`department_id`
WHERE  e.`employee_id` IS NULL;



#					交叉连接（笛卡尔乘积）
SELECT b.*, bo.*
FROM beauty b
CROSS JOIN boys bo


/*
总结：
sql92 vs sql99
		功能： sql99支持的较多
		可读性：sql实现的连接条件和筛选条件的分离，可读性较高
AB的交集 ：内连接
AB：A的全部： 左外		
AB：B的全部： 右外
AB并集：      全外		
*/


#课外练习：
#1. 查询编号>3 的女神的男朋友的信息，如果有请列出详细，如果没有，用null填充
SELECT b.id, b.`name`, bo.*
FROM beauty b
LEFT OUTER JOIN boys bo ON b.`boyfriend_id` = bo.`id`
WHERE b.`id` > 3;

#2.查询哪个城市没有部门
SELECT city
FROM locations l
LEFT OUTER JOIN departments d ON l.`location_id` = d.`location_id`
WHERE d.`department_id` IS NULL;
	
#3.查询部门名为SAL或IT的员工信息
SELECT e.*
FROM departments d 
LEFT OUTER JOIN employees e ON e.`department_id` = d.`department_id`
WHERE d.`department_name` IN('SAL', 'IT');

