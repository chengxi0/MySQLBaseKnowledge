#进阶2 条件查询
/*
select 查询列表 from 表名 where 筛选条件 ; 	
按查询条件可以分成三类：
	一简单的条件运算符 ： > < >= <= =(Java中使用==) != <>(MySQL推荐)
	二逻辑运算符：&& || ! 但在MySQL中使用 and or not (连接条件)
	三模糊查询:like ,between and , in , is null is not null
*/
USE myemployees ;

#案例1 查询工资大于12000的员工信息
SELECT * FROM employees WHERE salary > 12000 ;

#案列2 查询部门编号不等于90的员工名和部门编号
SELECT first_name ,department_id FROM employees WHERE department_id != 90 ;

#案列3 查询工资在10000 到 20000 之间的员工名，工资，和奖金
SELECT first_name , salary ,commission_pct FROM employees WHERE salary >= 10000 AND salary <= 20000;

#案例3 查询部门编号不在90 到 110 之间，或者 工资高于15000 的员工信息
SELECT * FROM employees WHERE department_id < 90 OR department_id > 110 OR salary > 15000 ;

# like 
/*
一 一般和通配符搭配使用
二 通配符： % 表示任意多个字符  _ 表示单个字符	
*/
#案列1 查询员工中名字包含 a 的员工信息
SELECT * FROM employees WHERE first_name LIKE '%a%' ;

#案列2 查询员工名字中第三个字符位n 第五个为y的员工信息
SELECT * FROM employees WHERE first_name LIKE '__n_e%' ;

#案例3 查询员工名中第二个字符为 _ 下划线的员工信息
SELECT * FROM employees WHERE last_name LIKE '_\_%' ;
/*
因此这里涉及转义字符 escape 关键字 设置某字符为转义字符
*/
SELECT * FROM employees WHERE last_name LIKE '_$_%' ESCAPE '$' ;
#注意点：如果字段是可以用到null值的话，那么用like 和 '%%'就不会匹配到


#between and 
/*
注意点：
1 使用between and 可以提高语句的简洁度
2 包含临界值
3 不要调换两个临界值的位置
*/
#案例 查询员工编号在100到120 之间的员工信息
SELECT * FROM employees WHERE employee_id BETWEEN 100 AND 120 ;

#in 
/*
1 使用in 可以提高语句简洁度
2 in列表里面的值的类型必须一致或者兼容
3 in列表里面不能识别通配符
*/
#案列 查询员工的工种编号是 IT_PROG AD_VP AD_PRES 的员工信息
SELECT * FROM employees WHERE job_id IN ('AD_PRES','AD_VP' ,'IT_PROG');

#is null 或者 is not null
/*
<> or = 是不能够判断null 值
此时就需要用到这两个东西了
还有is关键字是不能之间跟数字之类匹配的，它是跟null ....
*/
#案例 查询有奖金的员工名和奖金率
SELECT last_name , commission_pct FROM employees WHERE commission_pct IS NOT NULL;



















