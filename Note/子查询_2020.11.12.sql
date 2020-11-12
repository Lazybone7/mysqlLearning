#--------------------------------------子查询
/*
含义：
	出现在其他语句中的select语句称为子查询或内查询
	外部的查询语句称为主查询或外查询

分类：
	按子查询出现的位置：
		select 后面：
			仅仅支持标量子查询
		from 后面：
			支持表子查询
		where或having后面：☆
			标量子查询(单行) √
			列子查询(多行)   √	
			行子查询   
			
		exists后面(相关子查询)
			表子查询
	按结果集的行列数不同：
		标量子查询 （结果集只有一行一列）
		列子查询（结果集只有一列多行）
		行子查询（结果集只有一行多列）
		表子查询（结果集一般为多行多列）
		
			



*/


#一、where或having后面
/*
1.标量子查询（单行子查询）
2.列子查询（多行子查询）
3.行子查询（一行多列）

特点：
	(1)子查询放在小括号内
	(2)子查询一般放在条件的右侧
	(3)标量子查询，一般搭配着单行操作符(< > >= <= = <>)使用
	(4)列子查询，一般搭配着多行操作符(IN、ANY/SOME、ALL)使用
	(5)子查询的执行优先于主查询的执行，子查询的条件用到了主查询的结果
	
	
*/

#1.标量子查询
#练习 谁的工资比Abel高
SELECT last_name
FROM employees
WHERE salary > (
	SELECT salary
	FROM employees
	WHERE last_name = 'Abel'
);
	
#练习 返回job_id与141号员工相同，salary比143号员工多的员工姓名，job_id和工资
SELECT last_name, job_id, salary
FROM employees 
WHERE job_id = (
	SELECT job_id
	FROM employees
	WHERE employee_id = 141
) AND salary > (
	SELECT salary
	FROM employees
	WHERE employee_id = 143
);

#练习 返回公司工资最少的员工的last_name,job_id和salary
SELECT last_name, job_id, salary
FROM employees
WHERE salary = (
	SELECT MIN(salary)
	FROM employees
)

#练习 查询最低工资大于50号部门最低工资的部门id和其最低工资
SELECT department_id,MIN(salary)
FROM employees
GROUP BY department_id
HAVING MIN(salary) > ( 
	SELECT MIN(salary)
	FROM employees
	WHERE department_id = 50
);

#列子查询(多行子查询)
#练习：返回location_id是1400或1700部门中的所有员工的姓名
SELECT last_name
FROM employees
WHERE department_id IN(
	SELECT  department_id
	FROM departments
	WHERE location_id IN(1400,1700)
)

#练习：返回其他部门中比job_id为`IT_PROG`部门任意工资低的员工的员工号、姓名、job_id以及salary

SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ANY(
	SELECT salary
	FROM employees
	WHERE job_id = 'IT_PROG'
) AND job_id <> 'IT_PROG';

#练习：返回其他部门中比job_id为`IT_PROG`部门所有工资都低的员工的员工号、姓名、job_id以及salary
SELECT employee_id, last_name, job_id, salary
FROM employees
WHERE salary < ALL(
	SELECT salary
	FROM employees
	WHERE job_id = 'IT_PROG'
) AND job_id <> 'IT_PROG';

#行子查询(多行子查询)（了解即可）



#二、select后面
/*
	仅仅支持标量子查询
*/
#练习： 查询每个部门的员工个数
SELECT d.*,(
	SELECT COUNT(*)
	FROM employees e
	WHERE e.department_id = d.`department_id`
)
FROM departments d;


#三、from后面
#练习 查询每个部门的平均工资的平均等级
/*
将子查询结果充当一张表，要求必须去别名
*/
SELECT grade_level, avgs.*
FROM job_grades
INNER JOIN (
	SELECT AVG(salary) ag,department_id
	FROM employees
	GROUP BY department_id
)avgs 
WHERE avgs.ag BETWEEN lowest_sal AND highest_sal;


#四、exists后面（相关子查询）
/*
语法
exists(完整的查询语句)
结果： 1 或 0
*/

#练习 查询有员工的部门名
SELECT department_name
FROM departments d
WHERE EXISTS(
	SELECT *
	FROM employees e
	WHERE d.`department_id` = e.`department_id`
);
