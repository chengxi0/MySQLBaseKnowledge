#进阶5 分组查询
#引入 ：查询每个部门的平均工资
SELECT AVG(salary) , department_id FROM employees GROUP BY department_id ;
/*
基本语法：
select 分组函数 ，列（要求出现在group by 的后面）
from 表名
【where 筛选条件】
group by 分组列表
【order by 子句】
注意：查询列表必须特殊，要求分组函数和group by后面出现的字段

总结：分组查询中的筛选条件分为两类：
	分组前筛选：原始数据  group by 子句的前面    where
	分组后筛选： 分组后的结果 group by 子句的后面 having
	
	分组函数做条件放在having子句中
	能用分组前筛选尽量使用分组前筛选，涉及到性能问题
*/
#案列1 ；查询每个工种的最高的工资
SELECT MAX(salary) ,job_id FROM employees GROUP BY job_id ;

#案例2 ：查询每个位置上的部门个数
SELECT COUNT(*) ,location_id FROM departments GROUP BY location_id ;

#添加筛选条件
#案例1 ：查询邮箱中包含a字符的，每个部门的平均工资
SELECT AVG(salary) ,department_id FROM employees WHERE email LIKE '%a%' GROUP BY department_id ;

#案例2 ：查询有奖金的每个领导手下员工的最高工资
SELECT MAX(salary) ,manager_id FROM employees WHERE commission_pct IS NOT NULL GROUP BY manager_id ;

#案例3 ：查询哪个部门的员工人数大于2
#第一步先找出每个部门人工的个数
SELECT COUNT(*)  ,department_id FROM employees  GROUP BY department_id ; 
#第二步 利用第一步的结果集进行查询
#这里需要关键字 having....
SELECT COUNT(*) 结果  ,department_id FROM employees  GROUP BY department_id 
HAVING  结果 > 2; 

#案例4 查询每个工种有奖金的员工的最高工资 > 12000 员工编号和最高工资
SELECT job_id ,MAX(salary),salary ,employee_id FROM employees WHERE commission_pct IS NOT NULL GROUP BY job_id
HAVING  MAX(salary) > 12000 ;

#案例5 查询领导编号 > 102 的每一个领导手下的最低工资 > 5000 的领导编号是哪个，以及求其最低工资
SELECT manager_id ,MIN(salary) 结果   FROM employees WHERE manager_id > 102 GROUP BY manager_id 
HAVING 结果 > 5000;


# 按表达式或者函数分组
# 案例： 按员工的姓名长度分组，查询每一组的员工个数，筛选员工个数 >5 的有哪些
SELECT COUNT(*) ,LENGTH(last_name) AS 长度 FROM employees GROUP BY 长度 HAVING COUNT(*) > 5;

# 按多个字段分组
#案例：查询每个部门每个工种的员工的平均工资
SELECT AVG(salary) , department_id , job_id FROM employees GROUP BY department_id ,job_id;
#实际上是把同一个部门和同一个工种编号的人合并在一个组，再计算其平均工资


# 添加排序 
#案例：查询每个部门每个工种的员工的平均工资 并且显示平均工资高低顺序
SELECT AVG(salary),department_id , job_id FROM employees GROUP BY department_id ,job_id ORDER BY AVG(salary) DESC; 


# 练习题
#1 查询各个job_id 的员工工资的最大值，最小值，平均值，总和，并按job_id 升序
SELECT job_id ,MAX(salary) ,MIN(salary),AVG(salary),SUM(salary) FROM employees GROUP BY job_id ORDER BY job_id ;
#2 查询员工最高工资和最低工资之差
SELECT (MAX(salary) - MIN(salary)) AS 结果 FROM employees ; 
#3 查询各个管理者手下员工的最低工资，其中最低工资不低于6000，没有管理者的员工不计算在内
SELECT manager_id , MIN(salary) FROM employees WHERE manager_id IS NOT NULL GROUP BY manager_id 
HAVING MIN(salary) >= 6000 ;
#4 查询所有部门编号，员工数量和工资的平均值，并按平均工资降序
SELECT department_id , AVG(salary) ,COUNT(*) FROM employees GROUP BY department_id ORDER BY AVG(salary) DESC ;
#5 选择各个具有job_id的员工人数
SELECT job_id ,COUNT(*) FROM employees WHERE job_id IS NOT NULL GROUP BY job_id ;