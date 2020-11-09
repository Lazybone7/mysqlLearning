#----------------------------条件查询--------------------------------------
/*
语法：
	select 
		查询列表
	from 
		表名
	where
		筛选条件；
分类：
  一、按条件表达式筛选
	条件运算符：> < = != <> >= <=
  二、按逻辑表达式筛选
	逻辑运算符：&& 		||  	!
		    and	        or	not
  三、模糊查询
	like
	betwwen and
	in
	is null

*/

#按条件表达式筛选
#	练习：查询工资>12000的员工
	SELECT *
	FROM
		employees
	WHERE
		`salary` > 12000;
#	练习：查询部门编号不等于90号的员工名和部门编号
	SELECT  last_name, department_id
	FROM employees
	WHERE department_id <> 90
	
#三、模糊查询
/*	`%`代表一种通配符，代表任意多个字符，包含0个字符
	`_`代表任意单个字符
	
	BETWEEN AND: 包含临界值
	IN：IN列表的值必须统一或兼容；不支持通配符
	=或<> 不能用于判断null值
*/
#	练习：查看员工名中包含字符a的员工信息
	SELECT *
	FROM employees
	WHERE
	     last_name LIKE '%a%' 
#	练习：查看员工名中第二个字符为_的员工信息 
	#方式一				
	SELECT *
	FROM employees
	WHERE last_name LIKE '_\_%';
	#方式二 推荐使用ESCAPE进行转义
	SELECT *
	FROM employees
	WHERE last_name LIKE '_$_%' ESCAPE '$' ;
	
#	练习：查询员工的工种编号是IT_PROG、AD_VP、AD_PRES中的一个员工名和工种编号
	#方式一
	SELECT last_name,
	       job_id
	FROM 	employees
	WHERE job_id = 'IT_PROG' OR job_id = 'AD_VP' OR job_id = 'AD_PRES' ;
	
	#方式二
	SELECT last_name,
	       job_id
	FROM 	employees
	WHERE job_id IN('IT_PROG', 'AD_VP', 'AD_PRES') ;

/* <=>: 安全等于
is null : 仅仅可以判断NULL值,可读性高，建议使用
<=>: 	既可以判断NULL值，又可以判断普通的数值，可读性较差。 	
*/	