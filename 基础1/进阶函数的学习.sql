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

#5 instr 返回字符串中出现第一次的索引，如果找不到就返回0
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
SELECT STR_TO_DATE('4-3-1999','%m-%d-%y');
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

#四 流程控制函数
#1 if 函数
SELECT IF(5>10,'大于' ,'小于');
 
# 查询 有奖金的员工名字
SELECT last_name , IF(commission_pct IS NULL, '没有，呵呵','有，哈哈') FROM employees ;


