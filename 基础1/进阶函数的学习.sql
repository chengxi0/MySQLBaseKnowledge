#进阶 常见函数的学习
/*
概念：类似于Java中的方法 ，将一组逻辑语句封装在方法体中，对外暴露方法名
好处：1 隐藏方法的实现细节 2 提高代码的复用性
特点：
	特别关注：叫什么（函数名） 干什么（函数的功能，返回值）
分类：
	单行函数：
	如 concat ，ifnull length....
	分组函数:
	功能做统计使用,又叫统计函数，聚合函数，组函数
*/

#一 字符函数
#1 length函数 计算字符个数
SELECT LENGTH('john') AS 结果;
SELECT LENGTH("周福成") AS 结果 ; #使用的是utf8字符集，一个汉字占三个字节

#2 concat 函数 拼接字符串
SELECT CONCAT(first_name , '_' ,last_name) FROM employees;

#3 upper lower
SELECT UPPER('john');
SELECT LOWER('JOhn');
#案例：将姓变成大写将名变成小写然后拼接
SELECT CONCAT(UPPER(last_name),'_' ,LOWER(first_name))  AS 姓名 FROM employees;

#4 substr substring
#注意索引是从 1 开始的
#截取从指定索引后面的内容
SELECT SUBSTR('爱上了你，没什么道理',6);
SELECT SUBSTR('爱上了你，没什么道理' FROM 6);
#截取指定索引处指定字符长度的字符
SELECT SUBSTR('爱上了你，没什么道理',6,3);
#案例：姓名中首字母大写其他字符小写然后用_拼接，显示出来
SELECT CONCAT(UPPER(SUBSTR(last_name,1,1)),LOWER(SUBSTR(last_name,2)), '_' ,LOWER(first_name)) FROM employees;

#5 instr 返回字符串中出现指定字符串的第一次的索引，如果找不到就返回0
SELECT INSTR('爱上了你，没什么道理','你') AS 结果;
SELECT INSTR('爱上了你，没什么道理','它') AS 结果;

#6 trim 去掉字符串两边的东西，可以自定义去掉某个字符，默认是是去掉空格
SELECT TRIM(" 李莫愁  ");
SELECT LENGTH(TRIM(' 李莫愁  '));
SELECT TRIM('s' FROM 'sssssssss李莫愁sssss')  结果;
#中间的是不会去掉的，trim只是负责去掉两边的字符
SELECT TRIM('s' FROM 'sssssssss李ssss莫愁sssss')  结果;

#7 lpad 用指定的字符实现左填充指定长度
SELECT LPAD('周芷若',5,'a');
SELECT RPAD('周芷若',2,'a');

#8 rpad 用指定的字符实现右填充指定长度
SELECT RPAD('周芷若',5,'a');
SELECT RPAD('周芷若',2,'a');
#若已经超过指定长度那么都是（r，l）就直接从左到右截取指定指定长度返回

# replace 代替
SELECT REPLACE('张无忌爱上了周芷若','周芷若','赵敏');
SELECT REPLACE('周芷若周芷若张若无忌爱上了周芷若','周芷若','赵敏');


#二 数学函数
#1 round 四舍五入函数
SELECT ROUND(1.34);
SELECT ROUND(1.56);
SELECT ROUND(1.346,2);

#2 ceil 向上取整，返回 >= 该参数的最小整数
SELECT CEIL(1.02);
SELECT CEIL(-1.01);

#3 floor 向下取整 返回 <= 该参数的最大整数
SELECT FLOOR(-9.99);
SELECT FLOOR(9.99);

#4 truncate 截断 
SELECT TRUNCATE(1.39,1);  #这个与一位小数后面的下一位小数四舍五入毫无关系

#5 mod 取余
/*
mod(a,b) ---> 是通过这样去计算的 a - a / b * b
所以a的符号影响取余符号的最终结果
*/
SELECT MOD(-10,3);
SELECT MOD(-10,-3);

#6 rand 随机数
SELECT ROUND(RAND()* 100,0) ;

#三 日期函数
#1 now 返回当前系统日期和时间
SELECT NOW();

#2 curdate 返回系统日期，不包括时间
SELECT CURDATE();

#3 curtime 返回系统时间， 不包括日期
SELECT CURTIME();

# 可以获取指定的部分 年 ，月 ，日 ，小时 ，分钟， 秒
SELECT YEAR(NOW());
SELECT YEAR('1999.4.3');
SELECT last_name ,YEAR(hiredate) AS 入厂日期 FROM employees;

#4 str_to_date 将日期格式的字符转换成指定格式的日期
#返回的是日期，记得匹配字符串里面
SELECT STR_TO_DATE('9.3.2000','%m.%d.%y');
SELECT STR_TO_DATE('4-3-1999','%c-%d-%Y');
/*
%Y ---- 四位的年份
%y -----2 位的年份
%m ------月份（补零）
%c ------ 月份（不补零）
%d -------日
%H -------小时（24小时）
%h -------小时（12小时）
%i -------分钟
%s -------秒
*/
# 查询入职日期为 1992---4--3 的员工信息
SELECT * FROM employees WHERE hiredate = '1992-4-3';
SELECT * FROM employees WHERE hiredate = STR_TO_DATE('4-3 1992','%c-%d %Y'); 

#5 date_format 将日期转换成字符
SELECT DATE_FORMAT(NOW(),'%c月%d日 %y年');
#案例 ：查询有奖金的员工名和入职日期（xx月/xx日 xx年）
SELECT last_name,DATE_FORMAT(hiredate,'%m月/%d日 %y年') FROM employees;

#6 datediff 计算两个日期相差的天数
#查询自己活了多少天
SELECT DATEDIFF(NOW() , '1999-5-17');
#四 流程控制函数
#1 if 函数
SELECT IF(5>10,'大于' ,'小于');
 
# 查询 有奖金的员工名字
SELECT last_name , IF(commission_pct IS NULL, '没有，呵呵','有，哈哈') FROM employees ;

#2 case 函数
/*语法：
mysql 中的case函数格式
case 要判断的字段或者表达式
when 常量1 then 要显示的值1或者语句1;
when 常量2 then 要显示的值2或者语句2;
。。。#注意点：如果是显示的值，那么就不需要加上分号 ,else 那里也不需要加上分号
else 要显示的值或者语句;
end
*/
#案例：查询员工的工资，要求
/*
部门编号 30 显示的工资为1.1 倍
部门编号 40 显示的工资为1.2 倍
部门编号 50 显示的工资为1.3 倍
其他的 显示为原来的工资
*/
SELECT salary  原来的工资, department_id ,CASE department_id 
WHEN 30 THEN salary*1.1 
WHEN 40 THEN salary*1.2
WHEN 50 THEN salary*1.3
ELSE salary
END 新的工资 FROM employees ;

#3 case 使用二 （区别于上面的使用，上面是等值判断，这个是可以应用到一个区间判断）
/*语法：
case 
when 条件1 then 执行的语句；或者显示的值
when 条件2 then 执行的语句；或者显示的值
else 执行的语句；或者显示的值
end
*/
#案例：查询员工的薪资情况
/*
如果工资大于20000 ，显示的是A级别
如果工资大于15000 ， 显示的是B级别
如果工资大于10000 ，显示的是C级别
其他 显示 D级别
*/
SELECT salary ,CASE  
WHEN salary >= 20000 THEN 'A级别'
WHEN salary >= 15000 THEN 'B级别'
WHEN salary >= 10000 THEN 'C级别'
ELSE 'A级别'
END AS 级别
FROM employees ;

#练习
#1 显示系统时间（日期和时间）
SELECT NOW();
#2 查询员工号，姓名，工资，以及工资提高百分之20后的结果（new salary）
SELECT job_id 员工号 , last_name 姓名, salary 原工资, salary*1.2 新工资 FROM employees ;
#3 将员工的姓名按照首字母排序并写出姓名的长度（length）
SELECT last_name , LENGTH(last_name) 姓名长度 FROM employees ORDER BY SUBSTR(last_name ,1,1) ;
SELECT last_name ,LENGTH(last_name) ,SUBSTR(last_name,1,1) 长度 FROM employees ORDER BY 长度;
#4 做一个查询，产生下面的效果
#<last_name>  earns <salary> monthly but wants <salary*3> 
SELECT CONCAT(last_name ,' earns ',salary, ' monthly but wants ',salary*3) FROM employees ;
#5 使用 case when 按照下面的条件
/*
job  grade 
AD_PRES A
ST_MAN  B
IT_PROG C
*/
SELECT job_id job ,CASE job_id 
WHEN 'AD_PRES' THEN 'A'
WHEN 'ST_MAN' THEN 'B'
WHEN 'IT_PROG' THEN 'C'
END AS grade
FROM employees ;

#五 分组函数
/*
功能：用作统计
分类 ：sum 求和 avg 求平均值，max 最大值， min 最小值，count 计数
特点：  1 sum avg 一般用来处理数值类型
	2 max min count 可以用来处理任何类型
	3 以上分组函数都忽雷null值（这个特别注意一下）
*/
#1 简单使用
SELECT SUM(salary) FROM employees;
SELECT AVG(salary) FROM employees;
SELECT MAX(salary) FROM employees;
SELECT MIN(salary) FROM employees;
SELECT COUNT(salary) FROM employees;

#2 可以搭配distinct使用
SELECT SUM(DISTINCT salary) FROM employees;
SELECT SUM(DISTINCT salary), SUM(salary)FROM employees;

#3 count 的详细介绍
#我们一般都是使用这个去统计行数
SELECT COUNT(*) FROM employees;
#而不使用这个
SELECT COUNT(salary) FROM employees;

#4 和分组函数一同查询的字段有要求，最后结果需要时规则的表格
#不会报错，就是这样写没有什么意义
SELECT SUM(salary) , employee_id FROM employees ;

#练习
#1 查询公司的员工工资的最大值，最小值，平均值，总和
SELECT MAX(salary) 最高 ,MIN(salary) 最低,AVG(salary) 平均 ,SUM(salary) 总和 FROM employees;
#2 查询员工表中最大的入职时间和最小入职时间的相差天数
SELECT DATEDIFF(MAX(hiredate),MIN(hiredate)) FROM employees;
#3 查询部门编号是为90 的员工个数
SELECT COUNT(departme nt_id) FROM employees WHERE department_id = 90 ;
SELECT COUNT(*) FROM employees WHERE department_id = 90 ;

#6 其他函数
#1 password('字符') md5(‘字符') 返回两种形式的字符加密形式
SELECT PASSWORD('周福成');




