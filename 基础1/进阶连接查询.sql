#进阶6 连接查询(多表查询)
/*
含义：当需要查询的字段来自于不同的表时需要用到连接查询
笛卡尔乘积现象：表1 m 行 ， 表2 n 行 结果 n*m行
发生的原因：没有有效的连接条件
避免：添加上有效的连接条件

分类：
	按年代分类：
	sql92标准：仅仅支持内连接
	sql99标准：【推荐】
	
	按功能分类：
	内连接：
		等值连接
		非等值连接
		自链接
	外连接：
		左外连接
		右外连接
		全外连接（sql不支持）
	交叉连接
*/
SELECT `name`,boyName FROM boys,beauty WHERE beauty.boyfriend_id = boys.id ;

# sql92语法：
#一 等值连接
/*
1 多表等值连接的结果为多表的交集部分
2 n表连接至少需要n -1个连接条件
3 多表的顺序没有要求
4 一般需要为表起别名
5 可以搭配前面介绍的子句使用，比如筛选条件，分组，排序
*/
#1 案例 ：查询员工名和对应的部门名
SELECT last_name , department_name FROM employees,departments 
WHERE employees.`department_id` = departments.`department_id`;
#2 查询员工名，工种号，工种名
SELECT last_name ,employees.job_id,job_title FROM employees ,jobs
WHERE employees.`job_id` = jobs.`job_id` ;
#但是我们一般都会起别名，这样书写起来更加简洁一点
SELECT last_name ,e.job_id,job_title FROM employees e , jobs j 
WHERE e.`job_id` = j.`job_id`;
#注意点：如果为表起了别名，那么就不能在查询的字段里面使用原来的表名
#这是执行顺序的问题，起了别名就不认识原来的名字了的

#3 添加筛选条件 
#案例： 查询有奖金的员工名和部门名
SELECT last_name ,department_name FROM employees e,departments d 
WHERE d.`department_id` = e.`department_id` && e.`commission_pct`IS NOT NULL;

#4 添加分组筛选
 #案例：查询每个城市的部门个数
 SELECT COUNT(*) ,city FROM departments d , locations l
 WHERE d.`location_id` = l.`location_id` 
 GROUP BY city ;
 
 #案例：查询有奖金的每个部门的部门名和部门的领导编号和该领导的最低工资
 SELECT department_name,d.manager_id,MIN(salary) FROM employees e ,departments d
 WHERE e.`department_id` = d.`department_id` AND commission_pct IS NOT NULL
 GROUP BY department_name;
 
#5 可以加排序
#案例：查询每个工种的工种名和员工的个数，并且按照员工个数降序
SELECT e.job_id,job_title,COUNT(*) FROM employees e ,jobs j
WHERE e.`job_id` = j.`job_id`
GROUP BY e.`job_id`
ORDER BY COUNT(*) DESC;

#6 三表连接
#案例：查询员工名，部门名和所在城市
SELECT last_name ,department_name,city FROM employees e ,departments d , locations l
WHERE e.`department_id` = d.`department_id` AND d.`location_id` = l.`location_id`;
 
 #二 非等值查询
 #案例：查询员工的工资和工资级别
 SELECT last_name , salary , grade_level FROM employees e,job_grades j
 WHERE e.`salary` BETWEEN j.`lowest_sal` AND j.`highest_sal`;
 
 #三 自连接（自己连接自己）
 # 案例：查询员工名和上级名称
 SELECT e.last_name ,e.`manager_id`, m.last_name ,m.`employee_id` FROM employees e , employees m
 WHERE e.`manager_id` = m.`employee_id`
 ORDER BY e.`last_name`;
 #这个题目充分体现了别名的好处
 
#练习题：
#1 显式员工表的最大工资，工资平均值
SELECT MAX(salary),AVG(salary) FROM employees ;

#2 查询员工表的employee_id ,job_id ,last_name,按department_id 降序，salary升序
SELECT employee_id,job_id ,last_name ,department_id,salary
FROM employees e
ORDER BY department_id DESC ,salary ;

#3 查询员工表的job_id 中包含a的和e的并且a在e前面
SELECT job_id FROM employees 
WHERE job_id LIKE '%a%e%';

#4 显示所有员工的姓名，部门号，部门名称
SELECT last_name , e.department_id , d.department_name FROM employees e, departments d
WHERE e.`department_id` = d.`department_id`;    

#5 查询90号部门的员工job_id和90号部门的location_id
SELECT e.job_id , l.location_id FROM employees e , departments l
WHERE e.`department_id` = l.`department_id` AND e.`department_id` = 90 ;

#6 选择所有有奖金的员工的last_name ,department_name,location_id,city
SELECT last_name ,department_name ,d.location_id ,city FROM employees e ,departments d,locations l
WHERE e.`department_id` = d.`department_id` AND d.`location_id` = l.`location_id` AND e.`commission_pct` IS NOT NULL;

#7 选择city在Toronto工作的员工的last_name ,job_id ,department_id,department_name 
SELECT e.last_name , e.job_id,e.department_id ,d.department_name FROM employees e , departments d , locations l
WHERE e.`department_id` = d.`department_id` AND d.`location_id` = l.`location_id` AND l.`city` = 'Toronto';

#8 查询每个工种每个部门的部门名，工种名和最低工资
SELECT department_name , job_title ,MIN(salary) FROM employees e , jobs j ,departments d
WHERE d.`department_id` = e.`department_id` AND e.`job_id` = j.`job_id`
GROUP BY j.`job_id` , e.`department_id`;

#9 查询每个国家下的部门个数大于2的国家编号
SELECT COUNT(*) , country_id FROM locations l , departments d 
WHERE l.`location_id` = d.`location_id` 
GROUP BY country_id
HAVING COUNT(*) >2;




#sql99语法：
/*
语法：
	select 查询列表
	from 表1 别名 【连接类型】
	join 表2 别名
	on 连接条件
	【where 筛选条件】
	【group by 分组】
	【having 筛选条件】
	【order by 排序列表】
分类：
内连接：inner
外连接：
	左外连接 left【outer】
	右外连接 right【outer】
	全外连接 full【outer】
交叉连接：cross	
*/

#一 内连接
/*
语法:
	select 查询列表 from 表1 别名 
	inner join 表2 别名
	on 连接条件;

分类：
等值
非等值
自连接
*/

#1 等值连接
#案例：查询员工名和部门名
SELECT last_name ,department_name FROM employees e
INNER JOIN departments d 
ON e.`department_id` = d.`department_id`;

#案例：查询名字中含有e的员工名和工种名（筛选）
SELECT last_name , job_title FROM employees e 
INNER JOIN jobs j
ON j.`job_id` = e.`job_id`
WHERE last_name LIKE '%a%';

#案例：查询部门个数 > 3 的城市名和部门个数(添加分组 + 帅选）
SELECT city ,COUNT(*) FROM locations l
INNER JOIN departments d
ON l.`location_id` = d.`location_id`
GROUP BY city
HAVING COUNT(*) > 3;


#案例：查询哪个部门的部门员工的个数 > 3 的部门名和员工个数，并按个数降序（添加排序）、
SELECT department_name ,COUNT(*) FROM departments d 
INNER JOIN employees e 
ON e.`department_id` = d.`department_id`
GROUP BY e.department_id 
HAVING COUNT(*) >  3
ORDER BY COUNT(*) DESC ;

#案例：查询员工名，部门名，工种名，并按部门名降序
SELECT last_name , department_name ,job_title FROM employees e
INNER JOIN departments d ON e.`department_id` = d.`department_id`
INNER JOIN jobs j ON j.`job_id` = e.`job_id`
ORDER BY department_name DESC ;









  
  
 
 
 
 
 
 
 
 



