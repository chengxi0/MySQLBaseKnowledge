#进阶1  基础查询
/*
基础语法：select
 select + 查询列表 + from + 表名
 注意点 ：
 a 查询的列表可以是：表中的字段，常量值，表达式，函数
 b 查询的结果是一个虚拟的表格，只是打印看一下，而实际上没有保存到
 c 在查询之前，我们一定要确保使用到 use 语句
*/
USE myemployees ;

#1 查询单个字段
SELECT first_name FROM employees;

#2 查询多个字段
SELECT first_name , email, salary FROM employees; 
SELECT first_name , salary ,email FROM employees; #与字段的顺序有关

#3 查询全部字段
	#方式1 这个书写简便，但是无法改变显示时的字段顺序
SELECT * FROM employees; 
	#方式2 这个可以直接点击左边的字段，但是要记得加上逗号，还有可以利用F12格式化代码
SELECT 
  `first_name`,
  `email`,
  `last_name`,
  `phone_number`,
  `salary`,
  `job_id`,
  `commission_pct`,
  `manager_id`,
  `department_id`,
  `hiredate` 
FROM
  employees ;
# ``这两个东西时着重符号，在关键字和字段名相同的时候，可以加上这个着重号进行区分

#4 查询常量值 
SELECT 100 ;
SELECT '我是水';
#MySQL 里面不区分字符和字符串的 ，都是直接使用单引号即可

#5 查询表达式
SELECT 900/5;

#6 查询函数
SELECT VERSION();
#实质就是打印这个函数的返回值

#7 起别名 利用 as 或者 空格
/*
使用字段的好处：
a 方便理解
b 如果要查询的字段有重名的情况，可以利用起别名进行区别
*/
SELECT 400*5 AS 结果 ;
SELECT first_name AS 名字 FROM employees ;
SELECT first_name AS 名 , last_name AS 姓 FROM employees ;
#还有一种方式起别名，就是把 as 省略，利用空格代替
#还有一种情况，就是如果起的别名是有空格之类的特殊符号 
#那么需要把其用双（单）引号引起来或者着重符号
SELECT salary AS `薪 水` FROM employees;

#8 去重 DISTINCT
#案例：查询员工表中所有的部门编号
SELECT department_id FROM employees; #这样寻找出了很多我们不需要的重复值
#因此我们可以使用 distinct 关键字
SELECT DISTINCT department_id FROM employees ;

#9 mysql 的 + 号的作用
#在MySQL中的 ＋ 号只有运算符的作用
#而在Java中的 + 号 可以做运算符，也可以做字符串拼接
SELECT 90 + 100 ;   #做加法运算
SELECT 'a123a' + 20 ;  
#如果是字符型和数值进行运算，那么它会试图转换成数值，在做加法
#如果转换成功，那么就继续做加法
#如果转换不成功，那个字符串就会变成0
#还有一个需要注意，任何和null相加都等于null
#那么MySQL是怎么做到字符拼接的呢？
#利用concat函数进行拼接
SELECT CONCAT(last_name ,first_name) AS 姓名 FROM employees;  

#最后做几个案例练习
#1 显示departments 的所有结构，并查询其中的所有数据
DESC departments; 
SELECT * FROM departments ;

#2 显示employees表中job_id全部，不能重复
SELECT DISTINCT job_id FROM employees; 




