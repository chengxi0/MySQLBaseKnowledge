3 # 进阶排序查询
/*
语法：
select 查询列表 from 表名 （where 刷选条件 ） order by 排序列表 【asc \ desc】;
特点：1 asc 代表升序（可以省略，默认升序） ，desc 代表 降序
      2 order by 可以支持单个字段，多个字段 ，表达式， 函数（length（）） ，别名
      3 order by 一般放在查询语句的最后，出来limit语句之外
*/
	
# 案列 : 查询员工信息 ，要求工资从低到高排序
SELECT * FROM employees ORDER BY salary DESC ;	# 降序
SELECT * FROM employees ORDER BY salary ASC ;	# 升序
SELECT * FROM employees ORDER BY salary ;  # 默认是升序

# 案列 ：查询部门编号 >= 90的员工信息 ，按入职时间的先后顺序进行排序
SELECT * FROM employees WHERE department_id >= 90 ORDER BY hiredate  ;

# 案列 ： 按照年薪的高低显示员工的信息和年薪 （按表达式进行排序）
SELECT * , salary*12*(1 + IFNULL(commission_pct,0))AS 年薪 FROM employees ORDER BY salary*12*(1 + IFNULL(commission_pct,0));  
# 也可以通过   对 别名 进行排序
SELECT * , salary*12*(1 + IFNULL(commission_pct,0))AS 年薪 FROM employees ORDER BY 年薪 DESC;  

# 案例： 按照函数进行排序 按照姓名的长度进行显示员工姓名和工资 
SELECT LENGTH(last_name) AS 名字长度 , last_name , salary FROM employees ORDER BY 名字长度 DESC ;

# 案例: 查询员工信息 要求工资升序 再按员工编号进行降序排序 （ 即按照多个字段进行排序)
SELECT * FROM employees  ORDER BY salary ,employee_id DESC ;

# 练习题：
#1 查询员工的姓名 ，部门号 和 年薪 ，按年薪降序和名字升序 
SELECT last_na me AS 姓名 , department_id , salary*12*(1 + IFNULL(commission_pct,0)) AS 年薪 FROM employees ORDER BY
年薪 DESC , LENGTH(last_name) ;

#2 选择工资不在 8000 到 17000的员工的姓名和工资，工资降序
SELECT last_name  AS 姓名 ,salary AS 工资 FROM employees  WHERE salary < 8000  OR salary > 17000 ORDER BY salary DESC;
SELECT last_name  AS 姓名 ,salary AS 工资 FROM employees  WHERE  salary NOT BETWEEN 8000 AND 17000 ORDER BY salary DESC;

#3 查询邮箱中包含e 的员工信息，并先按照邮箱的字节数降序，再按部门号升序
SELECT * FROM employees WHERE email LIKE '%e%' ORDER BY LENGTH(email) DESC  , department_id  DESC; 