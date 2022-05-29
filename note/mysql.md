> MySQL数据库
> ===





mycli的安装
===

```sql
$ sudo apt-get update
$ sudo apt-get install mycli


sudo systemctl status mysql
sudo apt update
sudo apt install mysql-server
service mysql status


ALTER USER 'root'@'localhost' IDENTIFIED BY 'lc_konglc';
mysqld --shared-memory --skip-grant-tables
```

> **mysql数据的登录:**

```bash
alias loginsql='mysql -ulc_konglc -h192.168.163.132 -plc_konglc'
vim ~/.bashrc
修改配置文件如下:
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
##############################
alias loginsql='mysql -ulc_konglc -h192.168.163.132 -plc_konglc'
source ~/.bashrc
```



> **MySQL**登录并执行sql: -e选项
>
>  mysql -ulc_konglc -h192.168.10.132 -P12666 -plc_konglc -DchaoDb -e 'show full processlist' > 1.txt



> **mysqlreport安装 :**

> **mysql配置文件**

```bash
-- mysql配置文件
/etc/mysql/mysql.conf.d/mysql.cnf
[mysql]
default-character-set=utf8
```

`mysql`配置文件

```bash
配置文件
/etc/mysql/mysql.conf.d/mysqld.cnf 
#
# The MySQL database server configuration file.
#
# One can use all long options that the program supports.
# Run program with --help to get a list of available options and with
# --print-defaults to see which it would actually understand and use.
#
# For explanations see
# http://dev.mysql.com/doc/mysql/en/server-system-variables.html

# Here is entries for some specific programs
# The following values assume you have at least 32M ram

[mysqld]
#
# * Basic Settings
#
user            = mysql
# pid-file      = /var/run/mysqld/mysqld.pid
# socket        = /var/run/mysqld/mysqld.sock
## 端口号
port           = 3306
character_set_server=utf8
# datadir       = /var/lib/mysql


# If MySQL is running as a replication slave, this should be
# changed. Ref https://dev.mysql.com/doc/refman/8.0/en/server-system-variables.html#sysvar_tmpdir
# tmpdir                = /tmp
#
# Instead of skip-networking the default is now to listen only on
# localhost which is more compatible and is not less secure.
bind-address            = 192.168.163.132
mysqlx-bind-address     = 192.168.163.132
#
# * Fine Tuning
#
key_buffer_size         = 16M
max_allowed_packet      = 64M
# thread_stack          = 256K

# thread_cache_size       = -1

# This replaces the startup script and checks MyISAM tables if needed
# the first time they are touched
myisam-recover-options  = BACKUP

## 表示允许同时访问 MySQL 服务器的最大连接数。其中一个连接是保留的，留给管理员专用的表示允	许同时访问 MySQL 服务器的最大连接数。其中一个连接是保留的，留给管理员专用的
# max_connections        = 151

# table_open_cache       = 4000

#
# * Logging and Replication
#
# Both location gets rotated by the cronjob.
#
# Log all queries
# Be aware that this log type is a performance killer.
# general_log_file        = /var/log/mysql/query.log
# general_log             = 1
#
# Error log - should be very few entries.
#
log_error = /var/log/mysql/error.log
#
# Here you can see queries with especially long duration
# slow_query_log                = 1
# slow_query_log_file   = /var/log/mysql/mysql-slow.log
# long_query_time = 2
# log-queries-not-using-indexes
#
# The following can be used as easy to replay backup logs or for replication.
# note: if you are setting up a replication slave, see README.Debian about
#       other settings you may need to change.
# server-id             = 1
# log_bin                       = /var/log/mysql/mysql-bin.log
# binlog_expire_logs_seconds    = 2592000
max_binlog_size   = 100M
#skip-grant-tables
# binlog_do_db          = include_database_name
# binlog_ignore_db      = include_database_name
```

> **查看mysql版本**

```bash
mysql --version
mysql  Ver 8.0.25-0ubuntu0.20.04.1 for Linux on x86_64 ((Ubuntu))
```

> **MySQL基本命令**

```bash
## 启动mysql服务
service mysql start

## 停止mysql服务
service mysql stop

##查看服务的状态
systemctl  status mysql
## 查看数据库
mysql> show databases;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| konglc_test        |
+--------------------+
2 rows in set (0.00 sec)

## 查看某个数据库下的表
mysql> show tables from konglc_test;
+-----------------------+
| Tables_in_konglc_test |
+-----------------------+
| k_log                 |
| logs                  |
| tf_f_acct             |
| tf_f_group            |
| tf_f_user             |
+-----------------------+
5 rows in set (0.01 sec)

##  切换数据库
mysql> use konglc_test;
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed

## 查看当前的mysql客户端进程
netstat -anp|grep 3306
tcp        0      0 192.168.163.132:47426   192.168.163.132:3306    ESTABLISHED 4072/mysql 


## 查看当前数据库
mysql> select database();
+-------------+
| database()  |
+-------------+
| konglc_test |
+-------------+

## 查看表结构
mysql> desc tf_f_user;
+----------+-------------+------+-----+---------+----------------+
| Field    | Type        | Null | Key | Default | Extra          |
+----------+-------------+------+-----+---------+----------------+
| id       | int         | NO   | PRI | NULL    | auto_increment |
| username | varchar(20) | NO   | UNI | NULL    |                |
| password | varchar(20) | NO   |     | NULL    |                |
| age      | int         | YES  |     | NULL    |                |
| phone    | varchar(20) | YES  |     | NULL    |                |
| email    | varchar(30) | YES  |     | NULL    |                |
| group_id | int         | YES  | MUL | NULL    |                |
+----------+-------------+------+-----+---------+----------------+
## 查看数据的创建信息
mysql> show create database konglc_test;

## 查看字符集
mysql> show variables like 'CHARACTER%';
+--------------------------+----------------------------+
| Variable_name            | Value                      |
+--------------------------+----------------------------+
| character_set_client     | utf8mb3                    |
| character_set_connection | utf8mb3                    |
| character_set_database   | utf8mb3                    |
| character_set_filesystem | binary                     |
| character_set_results    | utf8mb3                    |
| character_set_server     | utf8mb3                    |
| character_set_system     | utf8mb3                    |
| character_sets_dir       | /usr/share/mysql/charsets/ |
+--------------------------+----------------------------+

## 创建数据库
creat database choose

## 查看表的创建信息
mysql> show create table tf_f_acct;
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Table     | Create Table                                                                                                                                                                     |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| tf_f_acct | CREATE TABLE `tf_f_acct` (
  `id` int NOT NULL,
  `user_name` varchar(20) DEFAULT NULL,
  `money` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 |
+-----------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set (0.00 sec)


### 查看
mysql lc_konglc@192.168.10.132:konglc_base> show status like 'Threads%';                       
Threads_cached  : 
Threads_running : 	激活的连接数
Threads_connected : 打开的连接数
+-------------------+-------+
| Variable_name     | Value |
+-------------------+-------+
| Threads_cached    | 1     |
| Threads_connected | 4     |
| Threads_created   | 5     |
| Threads_running   | 2     |
+-------------------+-------+
```



> **MySQL常见的函数**

```mysql
-- 返回子串第一次出现的索引,如果找不到则返回0
select instr('konglingchao','chao') as result;--9
select instr('konglingchao','lubo') as result;--0
-- 取出字符串两边的空格
select trim('     konglingchao     ') as result;

-- 日期相关的函数
select now() as current_datetime;
select curdate() ;

select curtime();
select year(now()) as yy;

select month(now()) as mm;
select day(now()) as dd;

select year('1996-08-16');
select month('1996-08-16');

select hour(now());
select minute(now());

select second(now());

-- 当前时间戳
select current_timestamp();
select date_format(current_timestamp(),'%Y%m%d%H%i%s');

-- 当前时间
select current_time();

linux命令:
konglc@konglc-virtual-machine:~$ date +%Y-%m-%d
2021-06-29
konglc@konglc-virtual-machine:~$ date +%F
2021-06-29
str_to_date函数

格式说明:
%Y 4位的年份
%y 2位的年份  
%m (01 02 03)
%c (1 2 3 4)
%d (01 02 )
%H (24小时制)
%h (12小时制)
%i (分钟)
%s (秒)

--将字符串转换成日期
select str_to_date('2021-03-15 23:59:59' ,'%Y-%m-%d  %H:%i:%s');
select now();

--将日期转换成字符串
select date_format(now(),'%Y%m%d%H%i%s');

select version();
select user();
select database();

--当前时间戳
select current_timestamp();

--流程控制函数
-- if 函数 if else的效果
select if(1=1,'I like you ,but just like you',10);
-- case 函数 类似switch() case {}
select 
	case age 
	when 18 then  'you are too young'
	when 19 then 'you are a beauty'
	else  'you are a adult'
	end as descriptions
from tf_f_user;

-- case 函数 类似switch() case {}
/*
case 要判断的字段或表达式
when 常量1 then 要显示的值1 或语句1 
when 常量2 then 要显示的值2 或语句2 
when 常量3 then 要显示的值2 或语句3 
else 要显示的值n或语句n
*/
select 
	case age 
	when 18 then  'you are too young'
	when 19 then 'you are a beauty'
	else  'you are a adult'
	end as descriptions
from tf_f_user;

-- case函数 类似于多重if
/*
case 
when con1 then result1
when con2 then result2
when con3 then result3
else result4
end
*/
select  age, 
case 
when age>18 then 'you are a adult'
when age=18 then 'you are a favariote girl'
else 'you should study every day'
end from tf_f_user;


select lpad('konglc',10,'*') ;
select rpad('lubo',10,'#');

--插入多行数据
 insert into student
 values('03','konglc'),('04','konglc'),('06','konglc');
 
 -- union all 没有排重功能
 insert into student
  select '01','konglc'
  union all
  select '01','konglc';
 
 -- union 可以排重
 insert into student
  select '01','konglc'
  union 
  select '01','konglc';  
```



第 1 章 mysql数据库基本操作`DDL`
===



> **建表**

---

```sql
-- 显示当前数据库
show databases;
-- 创建数据库
create database mydb1;
-- 不存在则创建数据库
create database if not exists konglc_base;
-- 选择使用哪个数据库
use mydb1;
-- 删除数据库 
drop database mydb1;
drop database if exists mydb1;
-- 显示变量
show variables where variable_name like '%character_set_results%';

## 查看表的状态
show table status from konglc_test(database) where name = "t_acct"(table name);
show table status from konglc_test where name = "t_acct";
```



---

```sql
drop table if EXISTS student;
create table if not exists student(
	sid int,
	sname varchar(20),
	gender char(1),
	birth date,
	address varchar(200),
	score double
);
```

​		使用`navicat`连接数据库时出现 1521错误 

​		解决办法 登录mysql客户端 执行

```sql
ALTER USER 'lc_konglc'@'%' IDENTIFIED WITH mysql_native_password BY 'lc_konglc';
```

> **修改表操作**

```sql
ALTER TABLE 表名 ADD 【COLUMN】 字段名 字段类型 【FIRST|AFTER 字段名】;
```

```sql
create table if not exists  dept(
-- int类型，自增
deptno int(2) auto_increment,
dname varchar(14),
loc varchar(13),
-- 主键
primary key (deptno)
);

desc dept;
-- 添加列
alter table dept add  ddesc varchar(200) after dname;
-- 修改列的数据类型
alter table dept modify loc int(8);
-- 重命名列
alter table dept change loc loc_1 decimal(5,2);
-- 删除列
alter table dept drop ddesc;

-- 重命名
create table dept_ as select * from dept where 1 > 2;
rename table dept_ to dept_1;
desc dept_2;
alter table dept_1 rename to dept_2;
```



> **mysql导出数据**

```sql
 -- mysql导出数据 
 
 -- -d 表示值导出表结构 
 mysqldump -u lc_konglc -h 192.168.10.132 -P 12666 -plc_konglc -B konglc_base -d > konglc_base.sql
 
-- 导出某个表
mysqldump -d -u lc_konglc -h 192.168.10.132 -P 12666 -plc_konglc konglc_base t_acct

-- 导出表结构及表数据
mysqldump  -u lc_konglc -h 192.168.10.132 -P 12666 -plc_konglc konglc_base tbl_employee > konglc_base.tbl_employee.sql

-- 表数据入库
source /home/chaochao/chaochao/mysql/konglc_base.tbl_employee.sql

-- mysql数据库事件
check_point ENGINE=MDB
```



第 2 章mysql 约束详解
===

1 非空约束
---

限定某个字段/某列的值不允许为空

​	关键字 **`not null`**

> **特点:*

默认，所有的类型的值都可以是NULL，包括INT、FLOAT等数据类型
非空约束只能出现在表对象的列上，只能某个列单独限定非空，不能组合非空
一个表可以有很多列都分别限定了非空
空字符串''不等于NULL，0也不等于NULL

> **添加非空约束**

​	建表时

```sql
CREATE TABLE 表名称(
字段名 数据类型,
字段名 数据类型 NOT NULL,
字段名 数据类型 NOT NULL
);

-- 添加非空约束
alter table t_course modify c_description   varchar(200) not null; 
```



2 唯一约束
---

```sql
drop table  if exists t_course;
create table if not exists t_course(
	c_id int unique,
	c_name varchar(100) unique,
	c_description varchar(200)
);

desc t_course;
-- 
insert into t_course(c_id,c_name,c_description) values(1,'konglc','lingchao');
-- 收到非空约束限制 无法插入
insert into t_course(c_id,c_name,c_description) values(1,'konglc','Yuqi');
-- 单独指定 每个列都必须是唯一的
insert into t_course(c_id,c_name,c_description) values(1,'chaochao','Yuqi');
-- 插入成功
insert into t_course(c_id,c_name,c_description) values(2,'chaochao','Yuqi');

alter table t_course modify c_id  int unique;

-- 添加唯一约束
alter table t_course add constraint uk_id_name unique(c_id,c_name);

create table if not exists _user(
u_id int not null,
u_name varchar(25),
u_password varchar(16),
-- 使用表级约束语法 表示用户名密码组合不能重复
constraint uk_name_pwd unique(u_name,u_password)
);

-- 3条数据均插入成功
insert into _user(u_id,u_name,u_password) values
(1,'konglingchao','123456'),
(2,'Yuyi','abc'),
(3,'Yuqi','abc');
-- 插入数据不成功 (违反组合唯一约束)
insert into _user(u_id,u_name,u_password) values
(1001,'Yuqi','abc');

-- 建表后添加唯一约束
alter table tableName add unique key(字段列表);

alter table dept add unique key(dname);
desc dept;

```



> **关于复合唯一约束**

```sql
create table if not exists tableName(
	cloumn1 field_type,
    cloumn2 field_type,
    cloumn3 field_type,
    unique key(cloumn1,cloumn3)-- 字段列表中写的是多个字段名 多个字段名用逗号分隔 表示复合唯一 即多个字段的组合是唯一的
);

-- 添加唯一性约束的列上也会自动创建唯一索引。
-- 删除唯一约束只能通过删除唯一索引的方式删除。
-- 删除时需要指定唯一索引名，唯一索引名就和唯一约束名一样。
-- 如果创建唯一约束时未指定名称，如果是单列，就默认和列名相同；如果是组合列，那么默认和()
-- 中排在第一个的列名相同。也可以自定义唯一性约束名
-- 查看表索引
show index from tableName;
drop table if exists t_student;
create table if not exists t_student(
	s_id int,
	s_name varchar(20),
	s_tel char(11) unique key,
	s_car_id char(18) unique  key
);

drop table if exists t_course;
create table if not exists t_course(
	c_id int,
	s_id int,
	s_score int,
	unique key(c_id,s_id)
);

-- 删除唯一索引 只能通过删除唯一约束
```

3 主键约束
---

> **建表时 指定主键约束**

```sql
create table if not exists tableName(
	字段1 字段类型
    字段2 字段类型
    字段3 字段类型
    [constraint 约束名] primary key(字段名)
);
```



```sql
--  建表时指定唯一约束
create table if not exists temp(
	id int primary key,
	name varchar(100) not null
);
alter table temp change name  t_name varchar(100) not null;
desc temp;

insert into temp(id,t_name) values
(1,'konglc'),
(2,'chaochao'),
(1001,'yangyuqi');

-- 一个表不能建立两个主键
create table if not exists t_temp(
	t_id int primary key,
	t_name varchar(200) primary key
);
-- mysql lc_konglc@192.168.10.132:konglc_base> create table if not exists t_temp( t_id int primary key, t_name varchar(200) primary key);                                                                           
-- (1068, 'Multiple primary key defined')

-- 列级约束
create table if not exists temp_1(
	t_id int  primary key auto_increment,
	t_name varchar(20) 
);
-- mysql的主键名称总是 PRIMARY
show index from temp_1;

--  表级约束
create table if not exists temp_2 (
	t_id int not null auto_increment,
	t_name varchar(20), 
	t_password varchar(15),
	constraint pk_temp_2_id primary key(t_id) 
);
-- 建表之后添加约束
alter table temp_2 add primary key(t_name,t_password);

show index from temp_2;
-- 关于复合主键
drop table if exists tableName;
create table if not exists tableName(
	字段1 字段1类型,
	字段2 字段2类型,
	字段3 字段3类型,
	字段4 字段4类型,
	primary key(字段名1,字段名2)
);
-- example :
drop table if  exists t_student;
create table if not exists t_student(
	s_id int primary key,
	s_name varchar(20) not null
);

drop table if exists t_course;
create table if not exists t_course(
	c_id int primary key,
	c_name varchar(20) not null
);

drop table if exists stu_course;
create table if not exists stu_course(
	s_id int,
	c_id int,
	score int,
	primary key(s_id,c_id)
);

desc t_student; 
insert into t_student(s_id,s_name) values
(1001,'konglc'),
(1002,'yangyuqi');

insert into t_course(c_id,c_name) values
(2001,'mysql'),
(2002,'java'),
(2003,'redis'),
(2004,'springboot'),
(2005,'mybatis');

insert into stu_course(s_id,c_id,score) values
(1001,2002,98),
(1001,2001,88),
(1001,2004,78),
(1002,2003,60),
(1002,2005,90);

select a.s_id,a.s_name,c.c_name,b.score from t_student a left join stu_course b on(a.s_id=b.s_id) left join t_course c on(c.c_id=b.c_id);
```



5 自增列 auto_increment
---

> **简述**

**某个字段的值自增**

> **特点和要求**

1. 一个表最多只能有一个自增长列
2. 当需要产生唯一标识符或顺序值时,可设置自增长
3. 自增长约束的列必须是键列(主键列和唯一键列)
4. 自增约束列的类型必须是整数类型
5. 如果自增列指定了0和null 会在当前最大值的基础上自增 如果自增列手动指定了具体的值 直接赋值为具体值

```sql
-- 如何指定自增约束
create table if not exists tableName(
	字段名 数据类型 primary key auto_increment,
	字段名 数据类型 unique key not null,
	字段名 数据类型 unique key,
	字段名 数据类型 not null,
	字段名 数据类型 not null default 'default value'
);

create table if not exists tableName(
	字段名 数据类型 default 'default value',
	字段名 数据类型 unique key auto_increment,
	字段名 数据类型 not null default 'default value',
	primary key(字段名)
);

show tables like '%employee%';

drop table if exists employee;
create table if not exists employee (
	e_id int primary key auto_increment,
	e_name varchar(20)
) auto_increment=1001;-- 指定自增的初始值

insert into employee(e_name) values
('konglc'),
('YuQi');

-- 查看自增主键的值
show variables like '%auto_increment%'
show create table employee;
-- 建表之后添加自增长约束
drop table if exists employee_1;
create table if not exists employee_1(
	e_id int primary key,
	e_name varchar(20)
);

--  修改字段为自增
alter table tableName modify columnName dataType auto_increment;
alter table employee_1 modify  e_id  int auto_increment;
alter table tableName modify columnName dataType; ## 去掉auto_increment 相当于删除自增
```



6 foreign key 约束
---

**特点** :从表的外键列必须引用参考主表的主键列或唯一约束列 因为被依赖或被参考的值必须是唯一的



第 3 章 mysql 索引
===



3.1 索引的创建
---

```sql
-- 索引的分类
/**
1 唯一索引 
	由unique参数可设置索引为唯一性索引,限制该索引的值必须是唯一的,但允许有空值
2 主键索引
	就是一种特殊的唯一性索引,在唯一索引的基础上增加了不唯一约束 也就是not null + unique
	一张表里最多只用一个主键索引
3 普通索引 
	在创建时 不加任何限制条件 只是用于提高查询效率 这类索引可以创建在任何数据类型的列上
	其值是否非空或唯一,要由字段本身的完整性和约束条件决定,建立索引后 可以通过索引进行查
	询
4  全文索引
	 全文索引是目前搜索引擎中使用的一种关键技术 它能够利用(分词技术)等多种算法智能分析出
	 文本文字中关键词的频率和重要性 然后按照一定的算法规则智能的筛选出我们想要的结果 全
	 文索引非常适合大型数据库集 对于小的数据集 它的用处比较小
	使用参数fulltext可以设置索引为全文索引,在定义索引的列上支持值的全文查找 允许在这些索引列中
	允许这些列插入重复值和空值
5  单列索引
	在表中的单个字段上创建索引,单列索引只能根据该字段进行索引,单列索引可以是普通索引 也可以是唯一性索引
	还可以是去全文索引 只要保证该索引值对应一个字段即可
6 多列索引(组合 联合)
	多列索引是在表的多个字段上创建一个索引 该索引指向创建时对应的多个字段,可以通过这个几个字段进行查询,但是
	只有这些查询条件中使用了这些字段中的第一个字段时才会被使用,使用组合索引时 遵循最左前缀原则
7 空间索引	
	不同存储引擎支持的索引是不一样的
		InnoDB : 支持B-Tree Full-text 不支持hash索引
		MyISAM 支持B-Tree Full-text 不支持hash索引	
*/
/**
	创建索引		
*/
-- 1 创建表的时候创建索引
-- 使用create table 创建表时 除了可以定义列的数据类型外 还可以定义主键约束 外键约束或者唯一性约束
-- 但不论创建哪种约束,在定义约束的同时相当于在指定的列上创建了一个索引
drop table if exists dept;
create table if not exists dept(
	dept_id int primary key auto_increment,
	dept_name varchar(20)
);

show  create table dept;
show table status like 'dept';
show index from dept;

-- 有主键约束 唯一约束的字段 外键约束的字段上都会添加索引
drop table if exists emp;
create table if not exists emp(
	emp_id int primary key auto_increment,
	emp_name varchar(20) unique,
	dept_id int,
	--  添加外键约束
	constraint emp_dept_id_fk foreign key(dept_id) references dept(dept_id)
);
show index from emp;

## 显式方式创建索引
## 创建索引的格式
	create table table_name [col_name data_type] [unique|fulltext|spatial|index|key] [index_name] [col_name length]) [asc|desc]
	-- unique fulltext spatial 为可选参数 分别表示唯一索引 全文索引和空间索引
	-- index key为同义词 两者的作用相同 用来指定创建索引;
	-- index_name 是索引名称 为可选参数 如果不指定 如果不指定mysql默认col_name为索引名
	-- col_name 为创建索引的字段列 该列必须从数据表中定义的多个列中选择
	-- length 为可选参数 表示索引长度 只用字符串类型的字段才能指定索引长度
	-- asc或desc指定升序或者降序的索引值存储
	
 -- 1 创建唯一索引
 drop table if exists book;
 create table if not exists book(
	book_id int,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year,
	# 声明有索引的字段,在添加数据时 要保证唯一性 但是可以添加null值
	unique index uk_idx_bname(book_name)
 ); 
 
 -- 自增列必须是主键列或者是唯一列
 alter table book modify book_id int primary key auto_increment;
 show index from book;
 insert into book(book_name,authors,info,year_publication) values
 ('MySql高级','康师傅','适合有数据库开发经验的人员学习','2022');

-- 2 主键索引
-- 通过定义主键约束的方式定义主键索引
drop table if  exists book2;
create table if not exists book2(
	book_id int primary key,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year
) auto_increment=1001;

alter table book2 modify book_id int primary key;
show index from book2;

# 通过删除注解约束的方式删除主键的索引
alter table book2 drop primary key;

-- 3 创建单列索引

drop table if exists book3;
create table if not exists book3(
	book_id int ,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year,
	-- 单列索引
	unique index idx_bname(book_name)
) auto_increment=1001;

show index from book3;

-- 4 创建联合索引
drop table if exists book4;
create table if not exists book4(
	book_id int ,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year,
	-- 单列索引
	unique index idx_bid_bname(book_id,book_name,authors)
) auto_increment=1001;

show index from book4;
explain select * from book4 where book_id = 1001 and book_name = 'mysql';-- 使用到索引 最左前缀原则
explain select * from book4 where   book_name = 'mysql'; -- 没有使用到索引


-- 5 创建全文索引
drop table if exists book5;
create table if not exists book5(
	book_id int primary key auto_increment,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year,
	-- 单列索引
	fulltext index fullidx_bid_bname(info)
) auto_increment=1001;

show index from book5;

drop table if exists article;
create table if not exists article(
	id int unsigned primary key auto_increment,
	title varchar(200),
	body text,
	fulltext index index_article_title_body(title,body)
);

show index from article;

-- 全文索引用 match + agaist方式查询
-- 6 表创建完成之后添加索引
drop table if exists book6;
create table if not exists book6(
	book_id int,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year
) auto_increment=1001;

show index from book6;

alter table book6 add index idx_cmt(comment);
alter table book6 add unique index uk_idx_bname(book_name);
alter table book6 add index book_id_name_info(book_id,book_name,info);

drop table if exists book7;
create table if not exists book7(
	book_id int,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year
) auto_increment=1001;

-- 创建索引
create index idx_cmt on book7(book_id);
-- 删除索引
alter table book7 drop index idx_cmt;

show index from book7;

-- 创建唯一索引
alter table book7 drop index uk_idx_bname;
create unique index book_id_name_info on book7(book_id,book_name,info);
```



3.2 mysql 索引的删除
---

```mysql
-- 使用alter table 删除索引
alter table table_name drop index index_name;

-- 使用drop语句删除索引
drop index indexName on tableName;

-- 语句执行完毕之后使用查看是否删除完成
show index from tableName;

-- 删除列 索引同时也会被删除
alter table book7 drop column book_name;

-- 删除表中的列时 如果要删除的列为索引的组成部分 则该列也会从索引中删除 如果组成索引的索引列都被删除 则整个索引将被删除
```



3.3 MySql8.0 的新特性
---

支持降序索引

MySql8.0之前的版本依然是升序索引,使用时进行反向扫描,这大大降低了数据库的效率

```sql
delimiter //
create procedure ts_insert()
begin
	declare i int default 1;
	while i < 800 do
		insert into tsl select rand()*8000,rand()*8000;
		set i = i + 1;
	end while;
	commit;
end //
delimiter;
call ts_insert();
select * from tsl;

-- 查看执行计划
explain select * from tsl order by a,b desc limit 5;
```

> **隐藏索引**

从mysql8.xxx开始支持隐藏索引(invisiable idnexes) 只需要将待删除的索引设置为隐藏索引,使用查询优化器就不会再使用这个索引(即使使用 force index(强制使用索引) 优化器也不会使用该索引) 确认将索引设置为隐藏索引后系统不受任何影响 就可以彻底删除索引 这种通过先索引设置为隐藏列,在删除索引的方式就是软删除

主键不能设置为隐藏索引,当表中没有显式主键时,表中第一个唯一非空索引会成为隐式主键 也不能设置隐藏索引



索引默认是可见的 在使用create table create index 或者alter table 等语句时 可以通过visiable 

```sql
drop table if exists book8;
create table if not exists book8(
	book_id int,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year,
	## 创建不可见索引
	index index_book_name(comment) invisible
) auto_increment=1001;
show index from book8;

```

```sql
-- 2 隐藏索引
drop table if exists book8;
create table if not exists book8(
	book_id int,
	book_name varchar(100),
	authors varchar(100),
	info varchar(100),
	comment varchar(100),
	year_publication year,
	## 创建不可见索引
	index index_book_name(comment) invisible
) auto_increment=1001;
show index from book8;


-- 创建表以后
alter table book8  add unique index uk_index_info(info) invisible;

drop index uk_index_info on book8;
drop index index_book_name on book8;

drop index index_year_pub on book8;
create index index_year_pub on book8(info) invisible;

show index from book8;

explain select * from book8 where info = 'Yuqi';

-- 修改索引的可见性
alter table book8 alter index index_year_pub visible;
```

```tex
当索引被隐藏时 它的内容仍然是和正常索引一样实时更新 如果索引需要长期被隐藏 那么可以将其删除 因为索引的存在会影响插入 更新和删除性能
```

​		**是隐藏索引对优化器可见**

```sql
select @@optimizer_switch \G
-- 修改 隐藏索引为可见
set session optimizer_switch='use_invisible_indexes=on';
```

![image-20220221004448725](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220221004448725.png)

```sql
use_invisible_indexes=off

show index from book8;
```



3.4 索引的设计原则
---

```sql
#04-索引的设计原则
select floor(rand()*52;
#1. 数据的准备

#1.创建学生表和课程表
drop table if exists student_info;
create table if not exists `student_info` (
 `id` int(11) auto_increment,
 `student_id` int not null ,
 `name` varchar(20) default null,
 `course_id` int not null ,
 `class_id` int(11) default null,
 `create_time` datetime default current_timestamp on update current_timestamp,
 primary key (`id`)
) engine=innodb auto_increment=1 default charset=utf8;

drop table if exists course;
create table if not exists `course` (
`id` int(11) not null auto_increment,
`course_id` int not null ,
`course_name` varchar(40) default null,
primary key (`id`)
) engine=innodb auto_increment=1 default charset=utf8;


#函数1：创建随机产生字符串函数
delimiter //
create function rand_string(n int) 
	returns varchar(255) #该函数会返回一个字符串
begin 
	declare chars_str varchar(100) default 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ';
	declare return_str varchar(255) default '';
	declare i int default 0;
	while i < n do 
		set return_str =concat(return_str,substring(chars_str,floor(1+rand()*52),1));
		set i = i + 1;
	end while;
    return return_str;
end //
delimiter ;

select @@log_bin_trust_function_creators;

set global log_bin_trust_function_creators = 1;
select rand_string(10);

#函数2：创建随机数函数
delimiter //
create function rand_num (from_num int ,to_num int) returns int(11)
begin   
declare i int default 0;  
set i = floor(from_num +rand()*(to_num - from_num+1))   ;
return i;  
end //
delimiter ;

# 存储过程1：创建插入课程表存储过程
delimiter //
create procedure  insert_course( max_num int )
begin  
declare i int default 0;   
 set autocommit = 0;    #设置手动提交事务
 repeat  #循环
 set i = i + 1;  #赋值
 insert into course (course_id, course_name ) values (rand_num(10000,10100),rand_string(6));  
 until i = max_num  
 end repeat;  
 commit;  #提交事务
end //
delimiter ;


# 存储过程2：创建插入学生信息表存储过程
delimiter //
create procedure  insert_stu( max_num int )
begin  
declare i int default 0;   
 set autocommit = 0;    #设置手动提交事务
 repeat  #循环
 set i = i + 1;  #赋值
 insert into student_info (course_id, class_id ,student_id ,name ) values (rand_num(10000,10100),rand_num(10000,10200),rand_num(1,200000),rand_string(6));  
 until i = max_num  
 end repeat;  
 commit;  #提交事务
end //
delimiter ;

#调用存储过程：
call insert_course(100);

select count(*) from course;

call insert_stu(1000000);

select count(*) from student_info;

#2. 哪些情况适合创建索引
#① 字段的数值有唯一性的限制
#② 频繁作为 WHERE 查询条件的字段
# 业务上具有唯一特性的字段 即使是组合字段 也必须创建成唯一索引
#查看当前stduent_info表中的索引
show index from student_info;
desc student_info;
#student_id字段上没有索引的：
select course_id, class_id, name, create_time, student_id 
from student_info
where student_id = 123110; #0.477ms

#给student_id字段添加索引
alter table student_info add index idx_sid(student_id);

#student_id字段上有索引的：
select course_id, class_id, name, create_time, student_id from student_info where student_id = 123110; #1ms

#③ 经常 GROUP BY 和 ORDER BY 的列
# 索引就是让数据按照某种顺序进行存储或检索,因此当我们使用group by 对数据进行分组查询时,或者
# 使用order by 对数据进行排序的时候,就需要对分组或者排序的字段进行索引。如果待排序的列有多个
# 那么可以在这些列上建立组合索引

#student_id字段上有索引的：
select student_id, count(*) as num from student_info group by student_id limit 100; #1ms

#删除idx_sid索引
drop index idx_sid on student_info;

#student_id字段上没有索引的：
select student_id, count(*) as num from student_info group by student_id limit 100; #5.37s

#再测试：
show index from student_info;

#添加单列索引
alter table student_info add index idx_sid(student_id);

alter table student_info add index idx_cre_time(create_time);

select student_id, count(*) as num from student_info group by student_id order by create_time desc limit 100;  #7.302s

#修改sql_mode

select @@sql_mode;

set @@sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

#添加联合索引
drop index idx_sid on student_info;
drop index idx_cre_time on student_info;
drop index idx_sid_cre_time on student_info;
alter table student_info add index idx_sid_cre_time(student_id,create_time desc);
-- 要把group by中的字段写在前面 把 order by 中的字段写在后面
select student_id, count(*) as num from student_info group by student_id order by create_time desc limit 100;  #0.546s
explain select student_id, count(*) as num from student_info group by student_id order by create_time desc limit 100;
#再进一步：
drop index idx_cre_time_sid on student_info;
alter table student_info add index idx_cre_time_sid(create_time desc,student_id);
show index from student_info;
drop index idx_sid_cre_time on student_info;

select student_id, count(*) as num from student_info group by student_id order by create_time desc limit 100;  #6.17s
explain select student_id, count(*) as num from student_info group by student_id order by create_time desc limit 100;  #6.17s


#④ UPDATE、DELETE 的 WHERE 条件列
show index from student_info;

update student_info set student_id = 10002 where name = '462eed7ac6e791292a79';  #4.865s

#添加索引
alter table student_info add index idx_name(name);

update student_info set student_id = 10001 where name = '462eed7ac6e791292a79'; #0.001s

# ⑤ DISTINCT 字段需要创建索引
select distinct(student_id) from student_info;
# ⑥ #### 多表 JOIN 连接操作时，创建索引注意事项

#首先，`连接表的数量尽量不要超过 3 张`，因为每增加一张表就相当于增加了一次嵌套的循环，数量级增长会非常快，严重影响查询的效率。

#其次，`对 WHERE 条件创建索引`，因为 WHERE 才是对数据条件的过滤。如果在数据量非常大的情况下，没有 WHERE 条件过滤是非常可怕的。

#最后，`对用于连接的字段创建索引`，并且该字段在多张表中的`类型必须一致`。比如 course_id 在 student_info 表和 course 表中都为 int(11) 类型，
#而不能一个为 int 另一个为 varchar 类型。使用函数索引失效


select s.course_id, name, s.student_id, c.course_name 
from student_info s join course c
on s.course_id = c.course_id
where name = 'wkJOTb'; #0.001s

drop index idx_name on student_info;


select s.course_id, name, s.student_id, c.course_name from student_info s join course c on s.course_id = c.course_id where name = 'wkJOTb'; #0.227s


#⑦使用列的类型小的创建索引
/*
	这里所说的类型大小指的是该类型表示的数据范围的大小
	我们在定义表结构的时候要显式的指定列的类型,以整数类型为例,有tinyint mediumint int bigint 
	他们占有的存储空间一次递增,能表示的整数范围当然也是一次递增,我们想要对某个列建索
	引的话.在表示的整数范围允许的情况下,尽量让索引列使用较小的类型,比如我们能使用int 就
	不要用bigint 能使用mediumint 就不要使用int
	这是因为:
		数据类型越小 在查询时进行的比较操作越快
		数据类型越小 索引占用的存储空间就越少,在一个数据也内就可以放更多的记录,从而
		减少磁盘IO带来的性能损耗,也就意味着可以把更多的数据页缓存在内存中,从而加快
		读写效率
		
	这个建议对表的主键来说更加适用 因为不仅是聚簇索引中会存储主键值,其他所有的二级索引的节点
	都会存储一份记录主键的值 如果主键适用更小的数据类型,也就意味着节省更多的存储空间和更高效的IO
	
*/

#⑧使用字符串前缀创建索引
	/*
		B+树索引中的记录需要把该列的完整字符串存储起来 更费时. 而且字符串越长,在索引中占用的存储空间越大
		如果B+树索引中索引列存储的字符串很长,那在做字符串比较时会占用更多的时间
		我们可以通过截取字符串前面的一部分内容来建立索引,这个就叫前缀索引,这样在查询记录时 虽然不能精确的
		定位到记录的位置,但是能定位到相应前缀所在的位置,然后根据前缀相同的记录的主键值回表查询完整字符串
		值,既节约空间又节省了字符串的比较时间,还能大体解决排序问题
	*/
create table if not exists shop(
	address varchar(120) not null
);
create index inx_addr on shop(address);
show index from shop;

-- 字段在全部数据中的选择性
select  count(distinct address)/count(1) from shop;-- 越接近1区分度越好
-- ***在varchar字段上建立索引时,必须指定索引的长度,没必要对全字段建立索引,根据实际文本区分度决定索引长度
-- 索引的长度和区分度是一对矛盾体,一般对字符串类型数据,长度为20 的索引,区分度会达到90%以上,可以使用
-- count(distinct left(列名,索引长度))/count(*)的区分度来确定
-- 取前4个字符
select left('konglingchao',4) from dual;
-- 
#⑨ 区分度高(散列性高)的列适合作为索引
-- 列的基数指的是某一列中不重复数据的个数,在记录行数一定的情况下,该列的基数越大,该列中的值月分散,列的基数越小,该列中的值越集中
-- 这个列的基数指标非常重要,直接影响我们是否能有效的利用索引 最好为基数大的列建立索引,为基数太小的列建立索引效果可能不好
-- 可以使用公式 select count(distinct a)/count(*) from t1计算区分度 一般超过33%/就算是比较好的索引了

#⑩ 使用最频繁的列放到联合索引的左侧
select * from student_info where student_id = 10013 and course_id = 100;

#补充：在多个字段都要创建索引的情况下，联合索引优于单值索引
## 建议单表的数量不要超过6个
	-- 每个索引都会占有磁盘空间,索引越多,需要的磁盘空间就越大
	-- 索引会影响 insert delete update 等语句的性能,因为表中的数据更改的同时 索引也会进行调整和更新 会造成负担
	-- 优化器在选择如何优化查询时,会根据统一信息,对每一个可以用到的索引进行评估,以生产一个最好的执行计划
	-- 如果同时有多个索引都可以用于查询,会增加MySQL优化器生成执行计划时间,降低查询性能
# 3. 哪些情况不适合创建索引
# ① 在where中使用不到的字段，不要设置索引
	where 条件(包括 group by order by )
# ② 数据量小的表最好不要使用索引

# ③ 有大量重复数据的列上不要建立索引
#结论：当数据重复度大，比如`高于 10% `的时候，也不需要对这个字段使用索引。

#④ 避免对经常更新的表创建过多的索引

#⑤ 不建议用无序的值作为索引

# ⑥ 删除不再使用或者很少使用的索引

# ⑦ 不要定义冗余或重复的索引
create table if not exists person_info(
	id int unsigned not null auto_increment,
	name varchar(100) not null,
	birthday date not null,
	phone_number char(11) not null,
	country varchar(100) not null,
	primary key(id),
	key index_name_birthday_phone_number(name(10),birthday,phone_number)
	-- 冗余索引
	-- key index_name(name(10))
);
```

第 4 章 性能分析工具的使用
===

在数据库调优中,我们的目标就是响应时间更快,吞吐量更大,利用宏观的监控工具和微观的日志分析可以帮我们快速找到调优的思路和方式

4.1 数据库服务器的优化步骤
---



4.2 查看系统性能参数
---

在mysql中可以使用`show status`语句查看一些mysql数据库服务器的性能参数,执行频率

> **show status的语法如下**

```sql
show [global session] status like '参数';
-- 查看表的状态
show table status from konglc_base where name='student_info';
-- 查看最后一次查询来自多少个数据页
 show status like 'last_query_cost';
 -- 查看慢查询日志
 mysql的慢查询日志,用来记录mysql中相应时间超过阈值的语句,具体指运行时间超过long_query_time值的sql,则会被记录到慢查询日志中,long_query_time的默认值是10,意思是运行10s以上的语句(不含10s),认为是超出了我们最大的忍耐时间;
 默认情况下,mysql默认没有开启慢查询日志,需要我们手动来设置这个参数,如果不是调优的话,一般不建议调整该参数
 慢查询日志会将日志写入文件
 
 -- 开启慢查询日志参数

 ## 开启慢查询日志
slow_query_log    = 1 
## 慢查询日志位置
slow_query_log_file = /var/log/mysql/mysql-slow.log
## 慢查询时间
long_query_time = 2 

## 查看慢查询日志
show variables like '%slow_query_log';

##是否开启慢查询
set global slow_query_log=1; 
## 慢查询日志文件
slow_query_log_file
```



```shell
show variables like '%slow_query_log%'                 
+---------------------+-------------------------------+
| Variable_name       | Value                         |
+---------------------+-------------------------------+
| slow_query_log      | ON                            |
| slow_query_log_file | /var/log/mysql/mysql-slow.log |
+---------------------+-------------------------------+
```



```shell
## 查看慢查询的时间
 show variables like '%long_query_time%';
+-----------------+----------+
| Variable_name   | Value    |
+-----------------+----------+
| long_query_time | 2.000000 |
+-----------------+----------+
```



```shell
## 查看慢查询的次数
show global status like '%Slow_queries%';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| Slow_queries  | 8     |
+---------------+-------+
```



```shell
## 查询扫描过的最小的记录数
show variables like 'min%' ;
+------------------------+-------+
| Variable_name          | Value |
+------------------------+-------+
| min_examined_row_limit | 0     |
+------------------------+-------+
```



```sql
 ## 删除外键
 alter table student drop foreign key FK_student_class_r;
 
 -- 创建存储过程
delimiter //
create  procedure insert_stu1(max_num int)
begin
	declare i int default 0;
	## 设置手动提交事务
	set autocommit = 0;
	set i = i+1;
	repeat
		insert into student(class_id,student_name,student_age) values
		(rand_num(10,1000),rand_string(6),rand_num(0,100));
		until i = max_num
	end repeat;
	commit;
end //
delimiter ;

-- 重建存储过程
drop procedure if exists `insert_stu1`$$

create definer=`lc_konglc`@`%` procedure `insert_stu1`(max_num int)
begin
	declare i int default 0;
	## 设置手动提交事务
	set autocommit = 0;
	set i = i+1;
	repeat
		insert into stu(class_id,student_name,student_age) values
		(rand_num(10,1000),rand_string(6),rand_num(0,100));
		until i = max_num
	end repeat;
	commit;
end$$

delimiter ;
```



> **慢查询日志分析工具**

```shell
## 在生产环境中 如果要手工分析日志 查找 分析sql 显然是一个体力活 mysql提供了日志分析工具 mysqldumpslow
mysqldumpslow 

选项 : 
-s ORDER     what to sort by (al, at, ar, c, l, r, t), 'at' is default
                al: average lock time
                ar: average rows sent
                at: average query time
                 c: count
                 l: lock time
                 r: rows sent
                 t: query time 
 -t NUM       just show the top n queries
 
mysqldumpslow -s t -t 5  /var/log/mysql/mysql-slow.log
mysqldumpslow  /var/log/mysql/mysql-slow.log 

mysqldumpslow -a -s t -t 5 /var/log/mysql/mysql-slow.log
```



![image-20220224141224208](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220224141224208.png)

![image-20220224141359568](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220224141359568.png)



```sql
## 查看sql的执行成本
show profile是mysql提供的可以用来分析当前会话中的sql都做了什么 执行的资源消耗情况的工具,可以用于sql调优的测量,默认情况下处于关闭状态,并保存最近15次的运行结果
show variables like 'profiling';

set profiling=1; 
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| profiling     | OFF   |
+---------------+-------+


mysql lc_konglc@192.168.10.132:konglc_base> show profiles;
+----------+------------+-----------------------------------------------+
| Query_ID | Duration   | Query                                         |
+----------+------------+-----------------------------------------------+
| 1        | 0.0001405  | SHOW WARNINGS                                 |
| 2        | 0.00131125 | show variables like 'profiling'               |
| 3        | 1.190332   | select * from stu where student_name='fqovkO' |
| 4        | 0.0003975  | select * from stu limit 10                    |
| 5        | 1.177566   | select * from stu where student_name='zWkmEm' |
+----------+------------+-----------------------------------------------+
5 rows in set
Time: 0.011s

mysql lc_konglc@192.168.10.132:konglc_base> show profile cpu,block io for query 3;
```



![image-20220224143029877](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220224143029877.png)

> **日常开发需注意的结论**

`converting heap to myisam`查询结果 太大 内存不够 数据往磁盘上搬了

`creating tmp table` 创建临时表 先拷贝数据到临时表 用完之后再删除临时表

`copying to temp table on disk` 把内存中临时表复制到磁盘上

`lock` 

如果`show profile`诊断结果中出现以上结果中的任何一条,则sql需要优化

`show profile`命令将被弃用,我们可以从information_schema中的profile数据表进行查看



4.3 分析查询语句 `explain`
---

### 1 概述

​	定位了查询慢的`SQL`之后,我们就可以使用`explain`或`describe`工具针对性的分析查询语句

> **能做什么**

- 表的读取顺序
- 数据读取操作的操作类型
- 哪些索引可以使用
- 哪些索引实际被使用
- 表之间的引用
- 每张表有多少行被优化器查询

版本情况

​	mysql5.6.3以后就可以使用 `explain select update delete`



### 2 基本的语法

```sql
explain select select_options;
```

explain输出的各个列的作用如下

| 列名            | 描述                              |
| ------------- | :------------------------------ |
| id            | 在一个大的查询语句中每个select关键字都对应一个唯一的id |
| select_type   | select 关键字对应的那个查询               |
| table         | 表名                              |
| partition     | 匹配的分区信息                         |
| type          | 针对单表的访问方法                       |
| possible_keys | 可能用到的索引                         |
| key           | 实际使用的索引                         |
| key_len       | 实际使用的索引长度                       |
| ref           | 当使用索引列等值查询时,与索引列进行等值匹配的对象信息     |
| rows          | 预估需要读取的记录条数                     |
| filtered      | 某个表经过搜索条件过滤后剩余记录条数的百分比          |
| extra         | 一些额外的信息                         |



### 3 数据准备

```sql
/*EXPLAIN SELECT * FROM student_info;
SELECT * FROM student_info LIMIT 10;
DESCRIBE DELETE FROM student_info WHERE id = 2;
#
*/

#创建表
drop table if exists s1;
create table if not exists s1 (
    id int auto_increment,
    key1 varchar(100),
    key2 int,
    key3 varchar(100),
    key_part1 varchar(100),
    key_part2 varchar(100),
    key_part3 varchar(100),
    common_field varchar(100),
    primary key (id),
    index idx_key1 (key1),
    unique index idx_key2 (key2),
    index idx_key3 (key3),
    index idx_key_part(key_part1, key_part2, key_part3)
) engine=innodb charset=utf8 auto_increment=1001;

drop table if exists s2;
create table if not exists s2 (
    id int auto_increment,
    key1 varchar(100),
    key2 int,
    key3 varchar(100),
    key_part1 varchar(100),
    key_part2 varchar(100),
    key_part3 varchar(100),
    common_field varchar(100),
    primary key (id),
    index idx_key1 (key1),
    unique index idx_key2 (key2),
    index idx_key3 (key3),
    index idx_key_part(key_part1, key_part2, key_part3)
) engine=innodb charset=utf8 auto_increment=1001;

show create table s1;
show create table s2;

#创建存储函数：
delimiter //
create function rand_string1(n int) 
	returns varchar(255) #该函数会返回一个字符串
begin 
	declare chars_str varchar(100) default 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ';
	declare return_str varchar(255) default '';
	declare i int default 0;
	while i < n do
		set return_str =concat(return_str,substring(chars_str,floor(1+rand()*52),1));
		set i = i + 1;
	end while;
	return return_str;
end //
delimiter ;

set global log_bin_trust_function_creators=1; 

#创建存储过程：
delimiter //
create procedure insert_s1 (in min_num int (10),in max_num int (10))
begin
	declare i int default 0;
	set autocommit = 0;
	repeat
	set i = i + 1;
	insert into s1 values(
    (min_num + i),
    rand_string1(6),
    (min_num + 30 * i + 5),
    rand_string1(6),
    rand_string1(10),
    rand_string1(5),
    rand_string1(10),
    rand_string1(10));
	until i = max_num
	end repeat;
	commit;
end //
delimiter ;


delimiter //
create procedure insert_s2 (in min_num int (10),in max_num int (10))
begin
	declare i int default 0;
	set autocommit = 0;
	repeat
	set i = i + 1;
	insert into s2 values(
        (min_num + i),
		rand_string1(6),
		(min_num + 30 * i + 5),
		rand_string1(6),
		rand_string1(10),
		rand_string1(5),
		rand_string1(10),
		rand_string1(10));
	until i = max_num
	end repeat;
	commit;
end //
delimiter ;

#调用存储过程
call insert_s1(10001,10000);

call insert_s2(10001,10000);

select count(*) from s1;

select count(*) from s2;
```



### 4  explain的各个关键字

```mysql
#1. table：表名
#查询的每一行记录都对应着一个单表
explain select * from s1;

#s1:驱动表  s2:被驱动表
explain select * from s1 inner join s2;

#2. id：在一个大的查询语句中每个SELECT关键字都对应一个唯一的id
 select * from s1 where key1 = 'a';

 select * from s1 inner join s2
 on s1.key1 = s2.key1
 where s1.common_field = 'a';

 select * from s1 
 where key1 in (select key3 from s2);

 select * from s1 union select * from s2;
 explain select * from s1 where key1 = 'a';
 
explain select * from s1 inner join s2;
 
explain select * from s1 where key1 in (select key1 from s2) or key3 = 'a';
 
######查询优化器可能对涉及子查询的查询语句进行重写,转变为多表查询的操作########
explain select * from s1 where key1 in (select key2 from s2 where common_field = 'a');
 
#Union去重
explain select * from s1 union select * from s2;
 
/**
	小结
		如果id相同,可以认为是一组 从上往下执行
		在所有组中 id值越大 优先级越高 越先执行
		关注点 : id 号每个号码表示一趟独立的查询 一个sql查询趟数越少越好
*/ 
 
 #3. select_type：SELECT关键字对应的那个查询的类型,确定小查询在整个大查询中扮演了一个什么角色
/*	 一条大的查询语句里面可以包含若干个select关键字,每个select关键字代表着一个小的查询,而每个select
	关键字的from子句中都可以包含若干张表(这些表用来做连接查询) 每一张表对应着执行计划输出中的1条
	记录,对于同一个select关键字中的表来说,他们的id是相同的
	mysql为每一个select关键字代表的小查询都定义了一个称之为select_type的属性,意思是只要我们知道了某
	个小查询的select_type属性,就知道了这个小查询在整个大查询中扮演着什么角色
	select_type的取值 : 
			SIMPLE
			PRIMARY
			UNION
			SUBQUERY
			DEPENDENT SUBQUERY
*/
 # 查询语句中不包含`UNION`或者子查询的查询都算作是`SIMPLE`类型
 explain select * from s1;
 
 #连接查询也算是`SIMPLE`类型
 explain select * from s1 inner join s2;
 

 #对于包含`UNION`或者`UNION ALL`或者子查询的大查询来说，它是由几个小查询组成的，其中最左边的那个
 #查询的`select_type`值就是`PRIMARY`
 
 
 #对于包含`UNION`或者`UNION ALL`的大查询来说，它是由几个小查询组成的，其中除了最左边的那个小查询
 #以外，其余的小查询的`select_type`值就是`UNION`
 
 #`MySQL`选择使用临时表来完成`UNION`查询的去重工作，针对该临时表的查询的`select_type`就是
 #`UNION RESULT`
 explain select * from s1 union select * from s2;
 
 explain select * from s1 union all select * from s2;
 
 #子查询：
 #如果包含子查询的查询语句不能够转为对应的`semi-join`的形式，并且该子查询是不相关子查询。
 #该子查询的第一个`SELECT`关键字代表的那个查询的`select_type`就是`SUBQUERY`
 explain select * from s1 where key1 in (select key1 from s2) or key3 = 'a';
 
 
 #如果包含子查询的查询语句不能够转为对应的`semi-join`的形式，并且该子查询是相关子查询，
 #则该子查询的第一个`SELECT`关键字代表的那个查询的`select_type`就是`DEPENDENT SUBQUERY`
 explain select * from s1 
 where key1 in (select key1 from s2 where s1.key2 = s2.key2) or key3 = 'a';
 #注意的是，select_type为`DEPENDENT SUBQUERY`的查询可能会被执行多次。
 
 
 #在包含`UNION`或者`UNION ALL`的大查询中，如果各个小查询都依赖于外层查询的话，那除了
 #最左边的那个小查询之外，其余的小查询的`select_type`的值就是`DEPENDENT UNION`。
 explain select * from s1 
 where key1 in (select key1 from s2 where key1 = 'a' union select key1 from s1 where key1 = 'b');
 
 
 #对于包含`派生表`的查询，该派生表对应的子查询的`select_type`就是`DERIVED`
 explain select * 
 from (select key1, count(*) as c from s1 group by key1) as derived_s1 where c > 1;
 
 
 #当查询优化器在执行包含子查询的语句时,选择将子查询物化之后与外层查询进行连接查询时，
 #该子查询对应的`select_type`属性就是`MATERIALIZED`
 explain select * from s1 where key1 in (select key1 from s2); #子查询被转为了物化表
 
 
 
 # 4. partition(略)：匹配的分区信息
 
 # 5. type：针对单表的访问方法
 /*
	执行计划的一条记录就代表着mysql对某个表的执行查询计划的访问方法 又称访问类型 
	其中type列就表明这个访问方法是啥,是一个较为重要的指标 比如看到type列值的是ref,表
	明mysql即将使用ref方法执行对s1表的查询
	
	完整的访问方法如下:
		system	const	eq_ref	ref	fulltext	ref_or_null	index_merge	
		unique_subquery	index_subquery	range	index 	all
	详细解释
		
 */
 #当表中`只有一条记录`并且该表使用的存储引擎的统计数据是精确的，比如MyISAM、Memory，
 #那么对该表的访问方法就是`system`。
 create table t(i int) engine=myisam;
 insert into t values(1);
 
 explain select * from t;
 
 #换成InnoDB
 create table tt(i int) engine=innodb;
 insert into tt values(1);
 explain select * from tt;
 
 
 #当我们根据主键或者唯一二级索引列与常数进行等值匹配时，对单表的访问方法就是`const`
 explain select * from s1 where id = 10005;
 
explain select * from s1 where key2 = 10066;
explain select  * from s1 where key3='TJBOql' -- type ref
explain select  * from s1 where key3=100 -- type all 隐式的使用到了函数 就使用不上索引

 #在连接查询时，如果被驱动表是通过主键或者唯一二级索引列等值匹配的方式进行访问的
 #（如果该主键或者唯一二级索引是联合索引的话，所有的索引列都必须进行等值比较），则
 #对该被驱动表的访问方法就是`eq_ref`
 explain select * from s1 inner join s2 on s1.id = s2.id;
  
 #当通过普通的二级索引列与常量进行等值匹配时来查询某个表，那么对该表的访问方法就可能是`ref`
 explain select * from s1 where key1 = 'a';
 show index from s1;
 
 
 #当对普通二级索引进行等值匹配查询，该索引列的值也可以是`NULL`值时，那么对该表的访问方法
 #就可能是`ref_or_null`
 explain select * from s1 where key1 = 'a' or key1 is null;
 
 #单表访问方法时在某些场景下可以使用`Intersection`、`Union`、
 #`Sort-Union`这三种索引合并的方式来执行查询
 explain select * from s1 where key1 = 'a' or key3 = 'a';
 
 
 #`unique_subquery`是针对在一些包含`IN`子查询的查询语句中，如果查询优化器决定将`IN`子查询
 #转换为`EXISTS`子查询，而且子查询可以使用到主键进行等值匹配的话，那么该子查询执行计划的`type`
 #列的值就是`unique_subquery`
 explain select * from s1 
 where key2 in (select id from s2 where s1.key1 = s2.key1) or key3 = 'a';
 
 
 #如果使用索引获取某些`范围区间`的记录，那么就可能使用到`range`访问方法
 explain select * from s1 where key1 in ('a', 'b', 'c');
 
 #同上
 explain select * from s1 where key1 > 'a' and key1 < 'b';
 
 #当我们可以使用索引覆盖，但需要扫描全部的索引记录时，该表的访问方法就是`index`
 explain select key_part2 from s1 where key_part3 = 'a';
 
 
 #最熟悉的全表扫描
 explain select * from s1;
 /*
	小结 :
		结果值从好到坏依次是 system > const  > eq_ref > ref > fulltext > ref_or_null > index_merge > unique_subquery > 
			index_subquery > range > index > all
			sql性能优化的目标 至少要达到range级别 要求是ref级别 最好是const
 */
 
 #6. possible_keys和key：可能用到的索引 和  实际上使用的索引
 
 explain select * from s1 where key1 > 'z' and key3 = 'a';-- key3 列使用到了索引
 explain select * from s1 where key1 > 'z' or key3 = 'a'; -- key3 和key1列使用到了索引


 
#7.  key_len：实际使用到的索引长度(即：字节数)
# 帮你检查`是否充分的利用上了索引`，`值越大越好`,主要针对于联合索引，有一定的参考意义。
 explain select * from s1 where id = 10005;

 explain select * from s1 where key2 = 10126;

 explain select * from s1 where key1 = 'a';


## 下面的才有参考意义
 explain select * from s1 where key_part1 = 'a';

 explain select * from s1 where key_part1 = 'a' and key_part2 = 'b';

 explain select * from s1 where key_part1 = 'a' and key_part2 = 'b' and key_part3 = 'c';
 
 ## 没有使用到索引
 explain select * from s1 where key_part3 = 'a';
 
#练习：
#varchar(10)变长字段且允许NULL  = 10 * ( character set：utf8=3,gbk=2,latin1=1)+1(NULL)+2(变长字段)

#varchar(10)变长字段且不允许NULL = 10 * ( character set：utf8=3,gbk=2,latin1=1)+2(变长字段)

#char(10)固定字段且允许NULL    = 10 * ( character set：utf8=3,gbk=2,latin1=1)+1(NULL)

#char(10)固定字段且不允许NULL  = 10 * ( character set：utf8=3,gbk=2,latin1=1)
 
 
 
 # 8. ref：当使用索引列等值查询时，与索引列进行等值匹配的对象信息。
 #比如只是一个常数或者是某个列。
 
 explain select * from s1 where key1 = 'a';
 
 
 explain select * from s1 inner join s2 on s1.id = s2.id;
 
 explain select * from s1 inner join s2 on s2.key1 = upper(s1.key1);
 
 
 # 9. rows：预估的需要读取的记录条数
 # `值越小越好`
 explain select * from s1 where key1 > 'z';
 
 # 10. filtered: 某个表经过搜索条件过滤后剩余记录条数的百分比
 
 #如果使用的是索引执行的单表扫描，那么计算时需要估计出满足除使用
 #到对应索引的搜索条件外的其他搜索条件的记录有多少条。
 explain select * from s1 where key1 > 'z' and common_field = 'a'; -- 预估只有10%的数据满足要求
 explain select * from s1 where key1 > 'z' ; -- 预估100%的数据满足要求
 
 #对于单表查询来说，这个filtered列的值没什么意义，我们`更关注在连接查询
 #中驱动表对应的执行计划记录的filtered值`，它决定了被驱动表要执行的次数(即：rows * filtered)
 explain select * from s1 inner join s2 on s1.key1 = s2.key1 where s1.common_field = 'a';
 select count(*) from s1 inner join s2 on s1.key1 = s2.key1 where s1.common_field = 'a';
 
 
 #11. Extra:一些额外的信息
 #更准确的理解MySQL到底将如何执行给定的查询语句
 
 
 #当查询语句的没有`FROM`子句时将会提示该额外信息
 explain select 1;
 
 
 #查询语句的`WHERE`子句永远为`FALSE`时将会提示该额外信息
 explain select * from s1 where 1 != 1;
 
 
 #当我们使用全表扫描来执行对某个表的查询，并且该语句的`WHERE`
 #子句中有针对该表的搜索条件时，在`Extra`列中会提示上述额外信息。
 explain select * from s1 where common_field = 'a';
 
 
 #当使用索引访问来执行对某个表的查询，并且该语句的`WHERE`子句中
 #有除了该索引包含的列之外的其他搜索条件时，在`Extra`列中也会提示上述额外信息。
 explain select * from s1 where key1 = 'a' and common_field = 'a';
 
 #当查询列表处有`MIN`或者`MAX`聚合函数，但是并没有符合`WHERE`子句中
 #的搜索条件的记录时，将会提示该额外信息
 explain select min(key1) from s1 where key1 = 'nUKQaE'; #nUKQaE 是 s1表中key1字段真实存在的数据
 
 select * from s1 limit 10;
 
 #当我们的查询列表以及搜索条件中只包含属于某个索引的列，也就是在可以
 #使用覆盖索引的情况下，在`Extra`列将会提示该额外信息。比方说下边这个查询中只
 #需要用到`idx_key1`而不需要回表操作：
 explain select key1 from s1 where key1 = 'a';
 explain select * from s1 where key1 = 'a'; -- 会进行回表操作
 
 #有些搜索条件中虽然出现了索引列，但却不能使用到索引
 #看课件理解索引条件下推
 explain select * from s1 where key1 > 'z' and key1 like '%a';
 
 #在连接查询执行过程中，当被驱动表不能有效的利用索引加快访问速度，MySQL一般会为
 #其分配一块名叫`join buffer`的内存块来加快查询速度，也就是我们所讲的`基于块的嵌套循环算法`
 #见课件说明
 explain select * from s1 inner join s2 on s1.common_field = s2.common_field;
 
 #当我们使用左（外）连接时，如果`WHERE`子句中包含要求被驱动表的某个列等于`NULL`值的搜索条件，
 #而且那个列又是不允许存储`NULL`值的，那么在该表的执行计划的Extra列就会提示`Not exists`额外信息
 explain select * from s1 left join s2 on s1.key1 = s2.key1 where s2.id is null;
 
 #如果执行计划的`Extra`列出现了`Using intersect(...)`提示，说明准备使用`Intersect`索引
 #合并的方式执行查询，括号中的`...`表示需要进行索引合并的索引名称；
 #如果出现了`Using union(...)`提示，说明准备使用`Union`索引合并的方式执行查询；
 #出现了`Using sort_union(...)`提示，说明准备使用`Sort-Union`索引合并的方式执行查询。
 explain select * from s1 where key1 = 'a' or key3 = 'a';
 
 
 #当我们的`LIMIT`子句的参数为`0`时，表示压根儿不打算从表中读出任何记录，将会提示该额外信息
 explain select * from s1 limit 0;
 
 
 #有一些情况下对结果集中的记录进行排序是可以使用到索引的。
 #比如：
 explain select * from s1 where id > 1000 order by key1 limit 10;
 
 select * from s1 where id > 1000 order by key1 limit 10;
 #很多情况下排序操作无法使用到索引，只能在内存中（记录较少的时候）或者磁盘中（记录较多的时候）
 #进行排序，MySQL把这种在内存中或者磁盘上进行排序的方式统称为文件排序（英文名：`filesort`）。
 
 #如果某个查询需要使用文件排序的方式执行查询，就会在执行计划的`Extra`列中显示`Using filesort`提示
 explain select * from s1 order by common_field limit 10;
 
 #在许多查询的执行过程中，MySQL可能会借助临时表来完成一些功能，比如去重、排序之类的，比如我们
 #在执行许多包含`DISTINCT`、`GROUP BY`、`UNION`等子句的查询过程中，如果不能有效利用索引来完成
 #查询，MySQL很有可能寻求通过建立内部的临时表来执行查询。如果查询中使用到了内部的临时表，在执行
 #计划的`Extra`列将会显示`Using temporary`提示
 explain select distinct common_field from s1;
 
 #EXPLAIN SELECT DISTINCT key1 FROM s1;
 
 #同上。
 explain select common_field, count(*) as amount from s1 group by common_field;
 
 #执行计划中出现`Using temporary`并不是一个好的征兆，因为建立与维护临时表要付出很大成本的，所以
 #我们`最好能使用索引来替代掉使用临时表`。比如：扫描指定的索引idx_key1即可
 explain select key1, count(*) as amount from s1 group by key1;
 
#json格式的explain
explain format=json select * from s1 inner join s2 on s1.key1 = s2.key2 
where s1.common_field = 'a';
/*
	explain不考虑各种cache
	explain不显示mysql在执行查询时所作的优化操作
	explain不会告诉你关于触发器,存储过程的信息或用户自定义的函数对查询的影响情况
	explain部分统计信息是估算的,并非精确值
*/
```



### 5 explain的进一步使用

#### 	5.1 explain的四种输出格式

- 传统格式
- json格式
- tree格式
- 可视化输出

```mysql
## json格式
explain format=json select/update/delete
```



第 5 章 索引优化和查询优化
===

> **都有哪些维度可以进行数据库调优** 

简言之:

- 索引失效 没有充分利用到索引-- 建立索引
- 关联查询太多 `join` (设计缺陷 或不得已的需求) -- **SQL**优化
- 服务器调优及各个参数设置(缓冲 线程数) --调整 my.cnf
- 数据过多 -- 分库分表

关于数据库调优的知识点非常分散,不同的 DBMS,不同的公司,不同的职位,不同的项目遇到的问题都不尽相同

虽然SQL优化的技术很多,但是大方向上可以分成 **物理查询优化**和 **逻辑查询优化**两种

物理查询优化是通过 **索引**和 **表连接方式**等技术来进行优化,这里重点需要掌握索引的使用

逻辑查询优化就是通过 **SQL**等价变换提升查询效率,直白一点说就是,换一种查询写法执行效率可能更高



5.1 数据准备
---

```mysql
#1. 数据准备
#建表
drop table if exists class;
create table if not exists`class` (
 `id` int(11) not null auto_increment,
 `className` varchar(30) default null,
 `address` varchar(40) default null,
 `monitor` int null ,
 primary key (`id`)
) engine=innodb auto_increment=1001 default charset=utf8;
 
drop table if exists student;
create table if not exists `student` (
 `id` int(11) not null auto_increment,
 `stuno` int not null ,
 `name` varchar(20) default null,
 `age` int(3) default null,
 `classId` int(11) default null,
 primary key (`id`)
 #CONSTRAINT `fk_class_id` FOREIGN KEY (`classId`) REFERENCES `t_class` (`id`)
) engine=innodb auto_increment=1001 default charset=utf8;

set global log_bin_trust_function_creators=1; 

 #随机产生字符串
delimiter //
create function rand_string(n int) returns varchar(255)
begin    
    declare chars_str varchar(100) default 'abcdefghijklmnopqrstuvwxyzABCDEFJHIJKLMNOPQRSTUVWXYZ';
    declare return_str varchar(255) default '';
    declare i int default 0;
    while i < n do  
        set return_str =concat(return_str,substring(chars_str,floor(1+rand()*52),1));  
        set i = i + 1;
    end while;
    return return_str;
end //
delimiter ;

#用于随机产生多少到多少的编号
delimiter //
create function  rand_num (from_num int ,to_num int) returns int(11)
begin   
    declare i int default 0;  
    set i = floor(from_num +rand()*(to_num - from_num+1))   ;
    return i;  
end //
delimiter ;

#创建往stu表中插入数据的存储过程
delimiter //
create procedure  insert_stu(  start int ,  max_num int )
begin  
declare i int default 0;   
     set autocommit = 0;    #设置手动提交事务
     repeat  #循环
     set i = i + 1;  #赋值
     insert into student (stuno, name ,age ,classId ) values ((start+i),rand_string(6),rand_num(1,50),rand_num(1,1000));  
     until i = max_num  
     end repeat;  
     commit;  #提交事务
end //
delimiter ;


#执行存储过程，往class表添加随机数据
delimiter //
create procedure `insert_class`(  max_num int )
begin  
declare i int default 0;   
     set autocommit = 0;    
     repeat  
     set i = i + 1;  
     insert into class ( classname,address,monitor ) values (rand_string(8),rand_string(10),rand_num(1,100000));  
     until i = max_num  
     end repeat;  
     commit; 
end //
delimiter ;

#执行存储过程，往class表添加1万条数据  
call insert_class(10000);

#执行存储过程，往stu表添加50万条数据  
call insert_stu(100000,500000);

select count(*) from class;

select count(*) from student;


delimiter //
create  procedure `proc_drop_index`(dbname varchar(200),tablename varchar(200))
begin
       declare done int default 0;
       declare ct int default 0;
       declare _index varchar(200) default '';
       declare _cur cursor for  select   index_name   from information_schema.STATISTICS   where table_schema=dbname and table_name=tablename and seq_in_index=1 and    index_name <>'PRIMARY'  ;
#每个游标必须使用不同的declare continue handler for not found set done=1来控制游标的结束
       declare  continue handler for not found set done=2 ;      
#若没有数据返回,程序继续,并将变量done设为2
        open _cur;
        fetch _cur into _index;
        while  _index<>'' do 
               set @str = concat("drop index " , _index , " on " , tablename ); 
               prepare sql_str from @str ;
               execute  sql_str;
               deallocate prepare sql_str;
               set _index=''; 
               fetch _cur into _index; 
        end while;
   close _cur;
end //
delimiter ;
```



5.2 索引失效的案例
---

mysql中提高性能的一个最有效的方式是对数据 **设计合理的索引** 索引提供了高效访问数据的方法,并且加快查询速度,因此索引对查询速度有这至关重要的影响

- 使用索引可以快速定位表中的某条记录,从而提高数据库的查询速度,提高数据库的性能

- 如果查询没有使用索引,查询语句就会扫描表中的所有记录 在数据量大的情况下,这样查询速度会很慢

  大多数情况下都默认采用B+树构建索引 只是空间列类型的索引使用R-树 并且 MEMORY表还支持hash索引

  其实 用不用索引 最终都是查询优化器说了算,优化器是基于开销的优化器

  基于开销(`Cost-Base-Optimizer`),它不是基于规则(`Rule-Based-Optimizer`),也不是基于语义.怎样开销小就怎样来

  另外 `SQL`语句是否使用索引,跟**数据库版本 数据量 数据选择度**都有关系

```mysql
# 06-索引优化与查询优化
#2. 索引失效案例
#1) 全值匹配我最爱
explain select sql_no_cache * from student where age=30; -- 无索引 全表扫描
explain select sql_no_cache * from student where age=30 and classId=4;
explain select sql_no_cache * from student where age=30 and classId=4 and name = 'abcd';
select sql_no_cache * from student where age=30 and classId=4 and name = 'abcd';

select sql_no_cache * from student where age=30 and classId=4 and name = 'abcd';
select sql_no_cache * from student where age=30;

create index idx_age on student(age);

create index idx_age_classid on student(age,classId);

create index idx_age_classid_name on student(age,classId,name);

#2) 最佳左前缀法则
## 在mysql建立联合索引时遵守最佳最前缀匹配原则,即最左的优先,在检索数据时 从数据的最左边开始匹配
explain select sql_no_cache * from student where student.age=30 and student.name = 'abcd' ;

## 没有使用到索引
explain select sql_no_cache * from student where student.classid=1 and student.name = 'abcd';
 
 ## 使用到了索引
explain select sql_no_cache * from student where classid=4 and student.age=30 and student.name = 'abcd'; 

drop index idx_age on student;
drop index idx_age_classid on student;

## 只使用到了age
explain select sql_no_cache * from student where student.age=30 and student.name = 'abcd'; 
--  MySQL可以为多个字段创建索引,一个索引可以包括16个字段 对于多列索引,过滤条件要使用索引必须按照索引建立时的顺序
-- 依次满足,一旦跳过某个字段,索引后面的字段都无法被使用 如果查询条件中没有使用这些字段中的第一个字段,多列(联合)索
-- 引不会被使用 索引文件具有B-Tree最左前缀匹配特性,如果左边的值未确定,那么无法使用此索引

#3) 主键插入顺序
/*
	对于一个使用InnoDB存储引擎的表来说,在我们没有显式的创建索引时,表中的数据实际上都是存储在 聚簇索引的叶子节点上
	而记录又是存储在数据页中的,数据页和记录页又是按照记录主键值从小到大的顺序进行排序,所以如果我们插入的记录的主键
	是依次增大的话,那么我们插满一个数据页就继续往下一个数据页继续插 而如果插入的主键值忽大忽小的话 就比较麻烦了,假设
	某个数据页存储的记录已经满了,如果在往数据页里面插入数据,就需要把当前页面分裂成两个页面,把本页中的一些记录移动到
	新创建的页中 页面分离和记录移位意味着什么?意味着性能损耗 所以我们想要避免这样无谓的性能损耗,最好让插入的主键值
	依次递增,这样就不会发生性能损耗了 所以我们建议让主键具有auto_increment,让存储引擎为表生产主键,而不是我们手工插入
*/

#4)计算、函数、类型转换(自动或手动)导致索引失效

#此语句比下一条要好！（能够使用上索引）
explain select sql_no_cache * from student where student.name like 'abc_%';

## 没有使用到索引
explain select sql_no_cache * from student where left(student.name,3) = 'abc'; 
create index idx_name on student(name);

#
create index idx_sno on student(stuno);
## 未使用到索引
explain select sql_no_cache id, stuno, name from student where stuno+1 = 900001;
## 使用到了索引
explain select sql_no_cache id, stuno, name from student where stuno = 900000;


explain select id, stuno, name from student where substring(name, 1,3)='abc';

#5)类型转换导致索引失效
show index from student;
## 没有使用到索引  name是varchar类型
explain select sql_no_cache * from student where name = 123; 

## 使用到了索引
explain select sql_no_cache * from student where name = '123'; 


#6)范围条件右边的列索引失效
## 创建索引时务必把涉及到范围的字段写在最后
show index from student;
## 删除所有的索引
call proc_drop_index('chaoDb','student');

create index idx_age_classId_name on student(age,classId,name);

## 索引的长度为10个字节 name没有用上 age占5个字节 class_id占5个字节
explain select sql_no_cache * from student where student.age=30 and student.classId>20 and student.name = 'abc' ; 

explain select sql_no_cache * from student where student.age=30 and student.name = 'abc' and student.classId>20; 

create index idx_age_name_cid on student(age,name,classId);

#7)不等于(!= 或者<>)索引失效
create index idx_name on student(name);

explain select sql_no_cache * from student where student.name <> 'abc' ;

explain select sql_no_cache * from student where student.name != 'abc' ;


#8）is null可以使用索引，is not null无法使用索引
explain select sql_no_cache * from student where age is null; 

explain select sql_no_cache * from student where age is not null; 
/*
	结论 : 最好在设计数据库表的时候就将字段设置为not null约束,比如可以将int类型的字段 默认设置为0
	将字符类型的默认值设置为空字符串 ('')
	在查询时使用not like也无法使用索引 导致全表扫描
*/

#9)like以通配符%开头索引失效
## 页面搜索严禁全模糊或者左模糊 如果需要请走搜索引擎来解决
## 
explain select sql_no_cache * from student where name like 'ab%'; 

explain select sql_no_cache * from student where name like '%ab%';

#10)OR 前后存在非索引的列，索引失效
show index from student;

call proc_drop_index('chaoDb','student');

create index idx_age on student(age);

explain select sql_no_cache * from student where age = 10 or classid = 100;

create index idx_cid on student(classid);

# 11) 数据库和表的字符集统一使用utf8mb4
/*
	一般性建议
		1 对于单列索引,尽量选择针对当前query过滤性更好的索引
		2 在选择组合索引的时候,当前query中过滤性最好的字段在索引字段顺序中 位置越靠前越好
		3 在选择组合索引的时候,尽量选择包含当前query中的where子句中更多字段索引
		4 在选择组合索引的时候,如果某个字段可能出现范围查询时,尽量把这个字段放在索引次序的最后面
		总之 在咱们书写sql语句时,尽量避免造成索引失效的情况
*/
```



5.3 关联查询优化
---

```mysql
-- 数据准备
#3. 关联查询优化
# 情况1：左外连接
#分类
create table if not exists `type_` (
`id` int(10) unsigned not null auto_increment,
`card` int(10) unsigned not null,
primary key (`id`)
);

#图书
create table if not exists `book` (
`bookid` int(10) unsigned not null auto_increment,
`card` int(10) unsigned not null,
primary key (`bookid`)
);

select * from type_;
#向分类表中添加20条记录
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
insert into type_(card) values(floor(1 + (rand() * 20)));
commit;
#向图书表中添加20条记录
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));
insert into book(card) values(floor(1 + (rand() * 20)));

explain select sql_no_cache * from `type_` left join book on type_.card = book.card;

#添加索引
create index y on book(card);
-- type_ 
explain select sql_no_cache * from `type_` left join book on type_.card = book.card;

create index x on `type_`(card);

explain select sql_no_cache * from `type_` left join book on type_.card = book.card;

drop index y on book;

explain select sql_no_cache * from `type_` left join book on type_.card = book.card;

# 情况2：内连接
drop index x on `type_`;
show index from type_;
show index from book;

explain select sql_no_cache * from `type_` inner join book on type_.card = book.card;
select sql_no_cache * from `type_` inner join book on type_.card = book.card;
#添加索引
create index y on book(card);

explain select sql_no_cache * from `type_` inner join book on type_.card = book.card;

create index x on `type_`(card);

#结论：对于内连接来说，查询优化器可以决定谁作为驱动表，谁作为被驱动表出现的
explain select sql_no_cache * from `type_` inner join book on type_.card = book.card;

#删除索引
drop index y on book;
#结论：对于内连接来讲，如果表的连接条件中只能有一个字段有索引，则有索引的字段所在的表会被作为被驱动表出现。
explain select sql_no_cache * from `type_` inner join book on type_.card = book.card;

create index y on book(card);
explain select sql_no_cache * from `type_` inner join book on type_.card = book.card;

#向type_表中添加数据（20条数据）
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));
insert into `type_`(card) values(floor(1 + (rand() * 20)));

#结论：对于内连接来说，在两个表的连接条件都存在索引的情况下，会选择小表作为驱动表。“小表驱动大表”
explain select sql_no_cache * from `type_` inner join book on type_.card = book.card;
```



5.4 join的原理
---

​	join 方式连接多个表,本质就是各个表之间数据的循环匹配 如果关联表的数据量很大,则关联的执行时间会非常长

#### 	5.4.1 **驱动表和被驱动表**

​	驱动表就是主表,被驱动表就是从表,非驱动表 

​	两个**join**的表,有索引的表作为被驱动表

```mysql
-- 对于内连接来说
select * from A join B
A一定是驱动表 不一定 优化器会根据你的查询做优化 决定先查询哪张表 先查询的那张表就是驱动表 反之就是被驱动表 通过explain关键字可以查询

-- 对于外连接来说
select * from A left join B on
通常 大家会认为A就是驱动表 B就是被驱动表 但也未必 测试如下
```



#### 5.4.2 Simple Nested-Loop Join(简单循环嵌套连接)(SNLJ)

算法相当简单,从A表中取出一条数据1,遍历B表,将匹配到的数据放到result,以此类推,驱动表A中的每一条记录与被驱动表B的记录进行判断

可以看到  这种方式的效率是非常低的 上述表A 100条数据 表B1000条数据,则A*B=10万次



#### 5.4.3 Index Nested-Loop-Join(索引嵌套循环连接)

`index Nested-Loop-Join`其优化的思路主要是为了 **减少内层表匹配的次数** 所以要求被驱动表上 **有索引** 才行 通过外层匹配条件直接与内层表索引进行匹配 避免和内存表的每条记录进行比较,这样极大的减少了对内层表的匹配次数

驱动表中每条记录通过被驱动表的索引进行访问,因为索引查询的成本是比较固定的 因此mysql的优化器都倾向于使用记录数少的表作为驱动表(外表)



> **简单循环嵌套和索引循环嵌套对比**

| 开销统计       | 简单循环嵌套连接 | 索引循环嵌套连接                |
| ---------- | -------- | ----------------------- |
| 外表扫描的次数    | `1`      | `1`                     |
| 内表扫描的次数    | `A`      | `0`                     |
| 读取记录数      | `A +B*A` | `A+B(match)`            |
| `join`比较次数 | `B*A`    | `A*index(Height)`       |
| 回表读取记录次数   | `0`      | `B(match)(if possible)` |

如果被驱动表加索引 效率是非常高的,但是如果索引不是主键索引,还会进行一次回表操作 相比被驱动表的索引是主键索引,效率会更高



#### 5.4.4 Block Nested-Loop-Join (块循环连接)

如果存在索引,那么使用idex的方式进行join,如果join的列没有索引 被驱动表要扫描的次数太多了.每次访问被驱动表 其表中的记录都会被加载到内存 然后再从驱动表中去一条与其匹配 匹配结束后清除内存,然后再从驱动表中加载一条记录,然后把被驱动表中的数据加载到内存匹配 这样周而复始,大大增加了IO的次数 为了减少被驱动表IO的次数 就出现了 **Block Nested Loop Join**的方式

不再是逐条获取驱动表中的数据,而是一块一块的获取 引入了 `join buffer` 缓冲区,将驱动表相关的部分数据列(大小受join buffer的限制 )缓冲到 `join buffer`中,然后全表扫描被驱动表,将驱动表的每一条记录一次性和 `join buffer`中的所有驱动表的记录进行匹配 (内存中操作) 将简单循环嵌套中的多次比较合并成一次,降低了被驱动表的访问频率



> **相关参数**

```mysql
-- block_nested_loop=on 默认是开启的
show variables like '%optimizer_switch%';
-- 驱动表能不能一次加载完 要看join buffer能不能存储所有的数据 默认情况下 join_buffer_size=256k
-- join_buffer_size的最大值在32位系统中可申请4G 而在64位操作系统下可以申请大于4G的join buffer空间
-- (64位的Windows系统除外 其最大值会被截断为4G 并发出告警)
show variables like '%join_buffer%';
show variables like '%block_nested_loop%' 
```

#### 5.4.5 join 小结

1 **整体效率** **INLJ > BNLJ > SNLJ**

2 永远用小结果集驱动大结果集(其本质就是减少外层循环的数量)(大小的度量单位指的是 表行数 * 每行大小)

```mysql
## straight_join 明确指定 t1作为驱动表 t2作为被驱动表
select t1.b,t2.* from t1 straight_join t2 on (t1.b = t2.b) where t2.id < 100;
## straight_join 明确指定 t2作为驱动表 t1作为被驱动表
select t1.b,t2.* from t2 straight_join t1 on (t1.b = t2.b) where t2.id < 100;
```

3 为被驱动表匹配的条件增加索引(减少内层表循环匹配的次数) 

4 增大 join buffer size 大小(一次性缓存的数据越多 那么内层表扫描次数就越少)

5 减少驱动表不必要的字段(字段越少 join buffer缓存的数据越多)



5.8 优先考虑覆盖索引
---

> **什么是覆盖索引**	

​		**理解方式1 : ** 索引是高效找到一个行的方法,但一般数据库也能使用索引找到一列数据,因此它不必读取整个行,毕竟索引的叶子节点存储了他们索引的数据,当能通过索引就可以得到想要的数据,那就需要读取整个行了 **一个索引包含了满足查询结果的数据就叫做覆盖索引**

​		**理解方式2** 非聚簇复合索引的一种形式 它包括在查询里的 **select join**和 **where**子用到的所有列 即索引的字段正好是 **覆盖查询条件中所涉及的字段**

简单的说 : **覆盖索引就是** 索引 + 主键包含 `select 到 from`之间查询

> **覆盖索引的利弊**

​		**好处 : **

​				1 **避免Innodb**表进行索引的二次查询(回表)

​				`innodb`是以聚簇索引的方式来存储的,对于 `Innodb`来说,二级索引在叶子节点中所保存的是行的主键信息,如果是用二级索引查询数据,在		找到相应的键值后,还需要通过主键进行二次查询才能获取我们真实所需要的数据

​				在覆盖索引中,二级索引的键值可以获取所要的数据,避免了对主键的二次查询,减少**IO**操作,提升了查询效率

​				2 可以把 **随机IO**变成 **顺序IO**

​					由于覆盖索引是按键值的顺序存储的,对于 **IO**密集型的查找来说,对比随机 `IO`从磁盘中读取每一行数据的 **IO**要少的多,因此利用覆盖索		引在访问时也可以把磁盘随机读取的 **IO**转变为索引查找的顺序 **IO**

​				**由于覆盖索引可以减少树的搜索次数,显著提升查询性能 所以覆盖索引是一个常用的性能优化手段**`

​		**坏处 : **

​		`索引字段的维护`总是有代价的 因此建立冗余索引来支持覆盖索引时就需要权衡考虑了 这是业务 **DBA** 或者成为业务数据架构师的工作



5.9  索引下推
---

**使用前后对比**

​	**Index Condition PushDown(ICP)**是 **MySQL5.6**中的新特性,是一种存在索引引擎层使用的索引过滤数据的优化方式

- 如果没有 **ICP** ,存储引擎会遍历索引以定位基表中的行,并将它们返回给 **MySQL**服务器,由于 **MySQL**服务器会把这部分 `where`后面的条件是否保留行
- 启用 **ICP**后,如果部分 `where`条件可以仅使用索引中的列进行筛选,则 `mysql`服务器会把这部分 `where`条件放到存储引擎筛选 然后存储引擎通过使用索引条目来筛选数据,并且只有在满则这一条件时才会从表中读取行
- 好处 : **ICP**可以减少存储引擎必须访问基表的次数和 **MySQL**服务器必须访问存储引擎的次数
- 但是, **ICP**的 `加速效果`取决于在存储引擎内通过 **ICP**筛选掉的数据比例

**ICP**的开启和关闭

- 默认情况下,启用索引条件下推,可以通过设置系统变量 `optimizer_switch`控制

  `index_condition_pushdown`

```sql
## 打开索引下推 在explain中 的信息 Using index condition
explain select * from s1 where key1 > 'z' and key1 like '%a';
## 开启索引下推
set optimizer_switch='index_condition_pushdown=on';
## 关闭索引下推
set optimizer_switch='index_condition_pushdown=off';
```



```mysql
#7. 索引条件下推(ICP)
#举例1：
use atguigudb1;

explain select * from s1 where key1 > 'z' and key1 like '%a';

#举例2：
create table `people` (
  `id` int not null auto_increment,
  `zipcode` varchar(20) collate utf8_bin default null,
  `firstname` varchar(20) collate utf8_bin default null,
  `lastname` varchar(20) collate utf8_bin default null,
  `address` varchar(50) collate utf8_bin default null,
  primary key (`id`),
  key `zip_last_first` (`zipcode`,`lastname`,`firstname`)
) engine=innodb auto_increment=5 default charset=utf8mb3 collate=utf8_bin;

insert into `people` values 
('1', '000001', '三', '张', '北京市'), 
('2', '000002', '四', '李', '南京市'), 
('3', '000003', '五', '王', '上海市'), 
('4', '000001', '六', '赵', '天津市');

explain select * from people
where zipcode='000001'
and lastname like '%张%'
and address like '%北京市%';

explain select * from people
where zipcode='000001'
and lastname like '张%'
and firstname like '三%';

set optimizer_switch = 'index_condition_pushdown=on';

#创建存储过程，向people表中添加1000000条数据，测试ICP开启和关闭状态下的性能
delimiter //
create procedure  insert_people( max_num int )
begin  
declare i int default 0;   
 set autocommit = 0;    
 repeat  
 set i = i + 1;  
 insert into people ( zipcode,firstname,lastname,address ) values ('000001', '六', '赵', '天津市');  
 until i = max_num  
 end repeat;  
 commit; 
end //

delimiter ;

call insert_people(1000000);
select count(*) from people;
set profiling=1; 
select * from people where zipcode='000001' and lastname like '%张%'; -- execute time 0.301

#### 不使用索引条件下推
select /*+ no_icp(people)*/ * from people where zipcode='000001' and lastname like '%张%'; -- execute time 3.84

show profiles;
```



![](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220227012042869.png)

---

**使用索引条件下推和不使用索引条件下推结果对比**

![image-20220227013012658](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220227013012658.png)

**使用索引条件下推的条件**

1. 如果表的访问类型为 `range ref eq_ref`和 `ref_or_null`可以使用`ICP`
2. **ICP**可用于 **Innodb**和 **MyISAM**表 包括分区表
3. 对于 **Innodb**表,**ICP**仅用于二级索引 **ICP**的目标是减少全行读取次数,从而减少 **IO**操作
4. 当 **SQL**使用覆盖索引,不支持 **ICP** 因为这种情况下使用 **ICP**不会减少 **IO**
5. 相关子查询的条件不能使用  **ICP**



5.10 其他优化策略
---



### 	5.10.1 exists 和 in的区分

> 问题
>
> ​	不太理解哪种情况下应该使用exits,哪种情况下应该使用in 选择的标准是看能否使用表的索引吗?
>
> 回答 
>
> ​	索引是个前提 选择与否还要看表的大小 可以将选择的标准理解为 **小表驱动大表**, 在这种方式下效率是最高的



> 比如下面的例子

```mysql
select * from a where cc in (select cc from b);
select * from a where exists(select 1 from b where b.cc = a.cc);
```



### 5.10.2 count(*)与count(具体字段)的效率

> 问 : 在 MySQL统计数据表的行数,可以使用三种方式 `select count(*)  select count(1) select count(具体字段)` 使用这三者的查询效率是怎样的
>
> 答  :
>
> 前提 如果你要统计的是某个字段的非空数据的行数,则另当别论,毕竟比较执行效率的前提是结果一样才可以
>
> 环节 1 : `count(1)`和 `count(*)` 都是对所有结果进行`count` `count(*)`和 `count(1)`本质上并没有区别(二者执行时间可能略有差别,不过你还是可以把他俩的执行效率看成是相等的) 如果有 `where`子句,则是对所有符合筛选条件的数据进行统计;如果没有 `where`子句,则是对数据表的行数进行统计
>
> 环节2 : 如果是 **MyISAM**存储引擎,统计数据的行数只需要 `O(1)`的复杂度,这是因为每张 **MyISAM**数据表都有一个 meta信息存储了 `row_count`值,而一致性则有表级锁来保证
>
> 环节3  在 **InnoDB**存储引擎中,如果采用 `count(具体字段)`来统计数据行数,要尽量采用二级索引,因为主键采用的索引是聚簇索引,聚簇索引包含的信息多,明显会大于二级索引(非聚簇索引) 对于 `count(*)`和 `count(1)`来说,他们不需要查找具体的行,只是统计计数,系统会自动采用占用空间更小的二级索引来统计
>
> 如果有多个二级索引 会使用 `key_len`小的索引进行扫描 当没有二级索引的时候,才会采用主键索引来统计 



### 5.10.3 关于 SELECT(*)

> 在表的查询中,建议明确字段 推荐使用 select<字段列表>进行查询
>
> 原因 :
>
> (1) 在 MySQL解析的过程中,会通过 **查询数据字典** 将 *****按序转换成所有的列名 这回大大消耗资源和时间
>
> (2) 无法使用 **覆盖索引**



### 5.10.4  limit对查询优化的影响

针对的是会全表扫描的 **SQL**语句,如果你可以确定结果集只有一条,那么加上 `limit 1`的时候,当找到一条结果的时候就不会继续扫描了 这样会加快查询速度

如果数据表已经对字段建立了唯一索引,那么可以通过索引进行查询,不会全表扫描的话,就不需要加上 `limit 1`了



### 5.10.5 多使用 commit

只要有可能在程序中多使用 `commit`

> **commit**所释放的资源:
>
> ​	回滚字段上用于恢复的信息
>
> ​	被程序语句获得的锁
>
> ​	redo/undo log buffer中的空间
>
> ​	管理上述三种资源的内部花费



5.11 淘宝数据库主键是如何设计的
---

聊一个实际的问题,淘宝的数据库 主键是如何设计的?

某些错的离谱的答案还在网上年复一年的流传着,甚至还成为了所谓的 **MySQL**军规,其中一个明显的错误就是关于 **MySQL**的主键设计

大部分的人的回答是如此的自信,用8字节的 `bigint`做主键,而不用 `int` **错**

这样的回答 只是站在了数据库这一层,从没有从 **业务的角度**思考主键,主键就是一个自增 `id` 站在 2022年 公司项目割接的档口,用自增做主键,在架构设计上可能 **连及格都拿不到**

> **自增id的问题**

自增 id 做主键 简单易懂,几乎所有数据库都支持自增类型,只是实现各自有所不同而已,自增id除了简单,其他都是缺点,总体来看存在以下几方面的问题

**1.可靠性不高**

​	存在自增id回溯的问题 这个问题在`MySQL8.0`才修复

**2 . 安全性不高**

对外暴露的接口可以非常容易猜测对应的信息 比如 `/user/1`这样的接口,可以非常容易的猜测用户的id为多少,也可以非常容易的通过接口进行数据的爬取

**3 性能差**

自增id 性能较差,需要在数据库服务端生成

**4 交互多**

业务还需要执行一次类似 `last_inset_id()`的函数才能知道刚才插入的自增值,这需要多一次网络交互,在海量并发的系统中 多一条 `SQL`,就多一次性能上的开销

**5 局部唯一性**

最重要的一点 自增id 是局部唯一的,只在当前数据库实例中唯一,而不是全局唯一 在任意服务器之间都是唯一的 对于目前分布式系统来说 这简直就是噩梦



> **业务字段做主键**

为了唯一的标识一个会员的信息,需要为 **会员信息表**设置一个主键,怎么为这个表设置主键,才能到达我们的理性目标呢 这里我们考虑业务字段做主键



**尽量不要用跟业务有关的字段主键 毕竟作为项目设计的技术人员,我们谁也无法预测在项目的整个生命周期中,哪个业务字段会因为项目的需求而又重复 或者重用之类的情况出现**

>**经验**
>
>刚开始使用  **MySQL**,很多人容易犯的错误就是喜欢用业务字段做主键,想当然的认为了解业务需求,但实际情况往往出乎意料
>
>而更改主键设置的成本非常高

> **淘宝的主键设计**

```text
订单id = 时间 + 去重字段 +用户id后6位尾号
```

> **推荐的主键设计**

**非核心业务** 对应表的自增id  如告警 日志 监控等信息

**核心业务 ** 主键设计至少应该 全局唯一且是单调递增的 全局唯一保证各个系统之间都是唯一的,单调递增是希望插入时不影响数据库的性能

推荐一种最简单的主键设计 **UUID**

**UUID的特点**:

全局唯一 占用36个字节,数据无序 插入性能差



第 6 章 事务的基础知识
===



1 数据库事务的概述
---

---

​	事务是数据库区别于文件系统的重要特性之一,当我们有了事务,就会让数据库始终保持**一致性**,同时我们还能通过事务的机制**恢复到某个时间点**

​	这样既可以保证已提交到数据库的修改不会因为系统的崩溃而丢失

> **存储引擎的支持情况**

`show engines`查看当前 MySQL支持的存储引擎都有哪些,以及这些存储引擎是否支持事务

![image-20220301192255196](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220301192255196.png)

在`MySQL`中 只有 `InnoDB`是支持事务的

> **基本概念**



**事务 : ** 一组逻辑操作单元,使数据从一种状态变成另一种状态

**事务的处理原则 : ** 保证所有事务都作为 `一个工作单元`来执行,即使出现了故障,都不能改变这种执行方式 当一个事务中执行多个操作时,要么所有事务都被提交(`commit`),那么修改就永久的保存下来,要么数据库管理系统将 `放弃` 所有的 `修改` 将事务回滚(`rollback`)到最初的状态



```mysql
update account t set t.money=t.money-100 where t.acct_id = 1001;
update account t set t.money=t.money+100 where t.acct_id = 1002;
commit;
```



> **事务的ACID特性**



**原子性(atomicity) **

​	原子性是指事务是一个不可分割的工作单位,要么全部提交,要么全部失败 也就是不存在中间状态



**一致性(consistency)**

​	根据定义,一致性是指事务执行前后,数据从一个 `合法性状态`变换到另一个 `合法性状态`,这种状态是语义上的,而不是语法上的,根据体的业务有关

​	那么什么是合法的数据状态呢? 满足 `预定的约束条件`的状态就叫合法的状态,通俗一点来讲,这个状态是由你自己来定义的(比如满足现实状态中的约束) 满足这个状态 数据就是一致的,不满足这个状态,数据就是不一致 如果事务中的某个操作失败了,系统就会自动撤销当前正在执行的事务,返回到事务操作之前的状态



**隔离性(isolation)**

​	事务的隔离性是指一个事务的执行 `不能被其他事务干扰` ,即一个事务内部的操作及使用的数据对并发的其它事务是隔离的,并发执行的各个事务之间不能互相干扰

​	

**永久性(durability)**	

​	持久性是指一个事务一旦提交,他对数据库中数据的改变就是 `永久性的` 接下来的其它操作和数据库故障不应该对其有任何影响

​	持久性是通过事务日志来保证的 日志包括了 `重做日志`和 `回滚日志` 当我们通过事务对数据进行修改的时候,首先会将数据库的变化信息记录到重做日志中,然后在对数据库中的行进行对应的修改 这样做的好处是,即使数据库系统崩溃,数据库重启后也能找到没有更新到数据库系统中的重做日志,重新执行,从而使事务具有持久性

> ​	**总结 : **
>
> ​	ACID是事务的四大特性 原子性是基础 隔离性是手段,一致性是约束条件,而持久性是我们的目的
>
> 数据库事务,其实是数据库设计者为了方便起见,把需要保证 `原子性` `隔离性` `一致性` `持久性`的一个或多个数据库操作称为一个事务



> **事务的状态**

我们现在知道 事务 是一个抽象的概念,它对应着一个或多个数据库操作 **MySQL**根据这些操作执行的不同阶段 把事务大致分为几个状态

- 活动的(active)

事务对应的数据库操作正在执行过程中,我们就说该事务处在活动的状态

- 部分提交的(partially commited)

当事务中的最后一个操作执行完成,但是由于操作都在内存中执行,所造成的影响并没有刷新到磁盘,我就说该事务处在 `部分提交的状态`

- 失败的(failed)

当事务处在 `活动的`或 `部分提交的状态`时,可能遇到了某些错误(数据库自身的错误 操作系统错误或者直接断电)而无法继续执行,或者人为的停止当前事务的执行,我们就说该事务处在失败的状态

- 终止的(aborted)

如果事务执行了一部分而变为失败的状态,那么就需要把要修改的事务中的操作还原成事务执行前的状态,换句话说就是要撤销失败事务对当前数据造成的影响 我们把这个撤销的过程称为回滚 当回滚执行完毕时,也就是事务恢复到了执行事务之前的状态,我们就说该事务处在了终止 的状态

- 提交的(commited)

当一个处在部分提交的事务将修改过的数据 `同步到磁盘上之后` 我们就说该事务处在了 `提交的状态`



只有当事务处于 `终止的`或者是 `提交的`状态时 一个事务的生命周期算是结束了



2 如何使用事务
---

使用事务有两种方式 分别是 **隐式事务**和 **显式事务**



>  **显式事务**



步骤一 : `start transaction`或者是 `begin` 作用是显式的开启一个事务

```mysql
begin;
# 或者
start transaction;
```

`satrt transaction`语句相较于 `begin`特别之处在于 后边跟随几个 `修饰符`

- `read only` 标识当前事务是一个只读事务,也就是属于该事务的数据库操作只能读取数据 而不能修改数据
- `read write` : 标识当前事务是一个 `读写事务` 也就是属于该事务的数据库操作既可以读取数据,也可以修改数据
- `with consistent snapshot` 启动一致性读

> 只读事务只是不允许修改那些其他事务也能访问的表中的数据们 对于临时表来说(我们使用 
>
> create temparary table 创建的表,由于他们只在当前会话中可见,所以只读事务也可以对临时表进行增 删 改 操作
>
> )

```mysql
start transaction read only; ## 开启一个只读事务
```



```mysql
start transaction read only,with consistent snapshot;## 开启只读事务和一致性读
```



步骤2 : 一致性的事务操作(`DML`) 不含 `DDL`

步骤3 : 提交事务或者终止事务(即回滚事务)

```mysql
## 提交事务 当事务提交后,对数据库的修改是永久性的
commit;
```



```mysql
## 回滚事务 即撤销当前正在进行所有没有提交的修改
rollback;
## 将事务回滚到某个保存点
rollback to [savepoint];
```



其中关于 `savepoint`的相关操作有

```mysql
## 在事务中创建保存点 方便后续针对保存点进行回滚 一个事务可以存在多个保存点
savepoint 保存点名称
```



```mysql
## 删除某个保存点
release savepoint 保存点名称
```



> **隐式事务**

**MySQL**中有一个系统变量 `autocommit`

```mysql
## MySQL默认是自动提交事务的
show variables like 'autocommit';

## 如何关闭自动提交 
set autocommit=false; ## 针对 DML操作是有效的 对DDL而言是无效的

## 方式2 我们在 设置autocommit为true的情况下 使用start transaction 或者 begin开启事务,那么DML操作就不会自动提交数据
start transaction;

## 
start transaction;
insert into article(title,body) values('俄罗斯乌克兰冲突加剧','3月2日清晨，基辅再次响起防空警报。各方当前密切关注乌克兰与俄罗斯准备的新一轮谈判');
commit;
```

> **隐式提交数据的情况**

- 数据定义语言(Data Define language)

数据库对象 指的就是 `数据表` `表` `视图` `存储过程` 等结构 当我们使用 `create ` `alter` `drop`等语句去修改数据库对象时,就会隐式的提交前面的数据所属于的事务

```mysql
begin;
select .... ### 事务中的一条语句
update ..... ### 事务中的一条语句
...... 其他语句
create table .... ## 此语句会提交前面语句所属于的事务
```



- 隐式使用或修改 `MySQL`数据库中的表

当我们使用 `alter user ` `create user` `drop user` `grant user` `rename user` `revoke` `set password`等语句时,也会隐式的提交前边语句所属于的事务

- 事务控制或关于锁定的语句
  - 当我们在一个事务还没有提交或者回滚时又使用 `start transaction`或者是 `begin`语句开启了一个事务时,会 `隐式的提交上一个事务`

```mysql
begin;
select ..... ## 事务中的一个语句
update .... ## 事务中的一个语句
begin; ## 此语句会隐式的提交前语句所属于的事务
```



- 当前的 `autocommit`系统变量的值为 `off`,我们手动把它调为 `on`时,也会隐式提交前面语句所属于的事务
- 使用 `lock tables` `unlock tables`等关于锁定的语句也会 `隐式的提交`前边语句所属于的事务
- 加载数据的语句
  - 使用 `load data`语句批量往数据库中导入数据时,也会 `隐式提交`前边语句所属于的事务
- 关于 `MySQL`复制的一些语句
  - 使用 `start slave` `stop slave` `reset slave` `change master to `等语句时会 `隐式的提交`前面的语句所属于的事务
- 其他的一些语句



> **案列分析**

```mysql
create table user3(name varchar(15) primary key);

select * from user3;

begin;
insert into user3 values('张三'); #此时不会自动提交数据
commit;

begin; #开启一个新的事务
insert into user3 values('李四'); #此时不会自动提交数据
insert into user3 values('李四'); #受主键的影响，不能添加成功
rollback;

select * from user3;

#情况2：
truncate table user3;  #DDL操作会自动提交数据，不受autocommit变量的影响。

select * from user3;

begin;
insert into user3 values('张三'); #此时不会自动提交数据
commit;

insert into user3 values('李四');# 默认情况下(即autocommit为true)，DML操作也会自动提交数据。
insert into user3 values('李四'); #事务的失败的状态

rollback;

select * from user3;


#情况3：
truncate table user3;

select * from user3;

select @@completion_type;

set @@completion_type = 1;

begin;
insert into user3 values('张三'); 
commit;


select * from user3;

insert into user3 values('李四');
insert into user3 values('李四'); 

rollback;


select * from user3;

#举例2：体会INNODB 和 MyISAM

create table test1(i int) engine = innodb;

create table test2(i int) engine = myisam;

#针对于innodb表
begin
insert into test1 values (1);
rollback;

select * from test1;


#针对于myisam表:不支持事务
begin
insert into test2 values (1);
rollback;

select * from test2;


#举例3：体会savepoint

create table user3(name varchar(15),balance decimal(10,2));

begin
insert into user3(name,balance) values('张三',1000);
commit;

select * from user3;


begin;
update user3 set balance = balance - 100 where name = '张三';

update user3 set balance = balance - 100 where name = '张三';

savepoint s1;#设置保存点

update user3 set balance = balance + 1 where name = '张三';

rollback to s1; #回滚到保存点


select * from user3;

rollback; #回滚操作

select * from user3;
```



3 事务的隔离级别
---

MySQL是一个 `客户端/服务器`架构的软件,对于同一个服务器来说,可以有若干个客户端与之连接,每个客户端和服务器连接上之后,就可以称之为一个会话 `session` 每个客户端都可以在自己的会话中向服务器发出请求语句,一个请求语句可能是某个事物的一部分,也就是说对于服务器来说可能同时处理多个事务 事务有隔离的特性 理论上某个事务 `对某个数据进行访问时`,其他的事务应该进行排队,当该事务提交以后,其它事务才可以访问这个数据,但是这样对性能的影响太大,我们既想保持事务的隔离性,又想让服务器在处理访问同一数据的多个事务时性能尽量高些,那就看二者如何权衡取舍了



### 3.1 数据准备

```mysql
-- 创建表
drop table if exists student;
create table if not exists student(
	studentno varchar(100),
	name varchar(20),
	class varchar(20),
	primary key(studentno)
)engine=innodb charset=utf8;

insert into student(studentno,name,class) values (150103030025,'小琪','电力电子技术1班');
```



### 3.2  数据的并发问题

针对事务的隔离性和并发性,怎么做取舍呢? 先看一下服务相同数据的事务 `在不保证串行执行`(也就是执行完一个再执行另一个)的情况下可能会出现的问题



**1 . 脏写(Dirty Write)**

对两个事务 `session A` `session B`  如果事务 `session A` 修改了另一个未提交事务 `session B`修改过的数据,那就意味着发生了脏写



**2. 脏读 (Dirty Read)**

对于两个事务 `session A` `session B`  `session A`读取了已经被 `session B` `更新` 但还`没有被提交`的字段 之后若 `session B`

回滚 `session A`读取的内容就是 `临时且无效的`



**3 . 不可重复读 (Non-Repeatable Read)**

对两个事务 `session A` `session B`  如果事务 `session A` 读取了一个字段 然后 `session B`更新了这个字段 ,之后 `session A`再次读取同一个字段, `值就不同了` 那就意味着发生了不可重复读



**4. 幻读(Phantom)**

对于两个事务 `session A` `session B` `session A`从一个表中读取了一个字段 然后 `session B`在该表中插入了一些新的行 之后 如果 

`session A`再次读取同一个表,就会多出几行,那就意味着发生了幻读

`删除数据`不算幻读



### 3.3 SQL 中四种隔离级别

> **我们给上面出现的四个问题按照严重性排序**
>
> 脏写 > 脏读 > 不可重复读 > 幻读



我们愿意舍弃一部分隔离性来换取一部分性能就在这里体现 : 设立一些隔离级别 隔离级别越低 并发问题发生的就越多 

`SQL`标准中设立了4个隔离级别

- `read uncommited` 读未提交 ,在该隔离级别,所有的事务都可以看到其他未提交事务的执行结果 不能避免 `脏读` `不可重复读` `幻读`  
- `read commited` 读已提交 它满足了隔离的简单定义: 一个事务只能看见已经提交事务所做出的改变 这是大多数数据库系统的默认隔离级别(但不是mysql默认的) 可以避免脏读,但不可重复读 幻读的问题仍然存在
- `repeatable read` 可重复读,事务A在读到一条数据之后,此时事务B对该数据进行了修改并提交,那么事务A再读该数据时,读到的还是原来的内容 可以避免脏读 不可重复读,但幻读问题仍然存在 这是 MySQL的默认隔离级别
- `serializable` 可串行化,确保一个事务可以从一个表中读取相同 的行 在这个事务持续期间,禁止其它事务对该表执行 插入 更新和删除操作 所有的并发问题都可以避免,但性能十分低下,能避免脏读,不可重复读和幻读

以上4中隔离级别都可以解决脏写的问题

不同的隔离级别有不同的现象,并有不同的锁和并发机制,隔离级别越高,数据库的并发性能就越差



### 3.4 MySQL的事务隔离级别

```mysql
mysql lc_konglc@192.168.10.132:chaoDb> show variables like 'transaction_isolation';
+-----------------------+-----------------+
| Variable_name         | Value           |
+-----------------------+-----------------+
| transaction_isolation | REPEATABLE-READ |
+-----------------------+-----------------+

mysql lc_konglc@192.168.10.132:chaoDb> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| REPEATABLE-READ         |
+-------------------------+
```



### 3.5 如何设置事务的隔离级别

```mysql
set [global session] transaction isolation level 隔离级别;
## 隔离级别
read uncommitted;
read committed;
repeatable read;
serializable;

或者
set [global session] transaction_isolation='隔离级别';
其中隔离级别
## 隔离级别
read uncommitted;
read committed;
repeatable read;
serializable;
```



关于使用 `global` 和 `session`的影响

- 使用 `global`关键字(在全局范围内影响)

  ```mysql
  set global transaction isolation level read uncommitted;
  ## 或者
  set global transaction_isolation = 'read committed';

  ## 当前已经存在的会话无效
  ## 只对执行完该语句之后的会话生效
  ```

- 使用 `session`关键字

  ```mysql
  set session transaction isolation level read uncommitted;
  ## 或者
  set session transaction_isolation = 'read committed';

  ## 对当前会话后续的所有事务有效
  ## 如果在事务之间执行,则对后续的事务无效
  ## 该语句可以在已经开启的事务中间执行,但不会影响当前正在执行的事务
  ```

如果在服务器启动时 想改变事务的隔离级别,可以修改启动参数 `transaction_isolation`的值,比如在服务器启动时指定 `transaction_isolation=serializable`,事务的默认隔离级别就从原来的 `repeatable read`变为 `serializable`



### 3. 6 MySQL的隔离级别举例

```mysql
mysql lc_konglc@192.168.10.132:chaoDb> select @@transaction_isolation;
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| REPEATABLE-READ         |
+-------------------------+
1 row in set
Time: 0.009s
mysql lc_konglc@192.168.10.132:chaoDb> set global transaction_isolation='read-committed';
Query OK, 0 rows affected
Time: 0.075s
mysql lc_konglc@192.168.10.132:chaoDb> select @@transaction_isolation;                               ## 当前会话的级别依旧是 REPEATABLE-READ                                                               
+-------------------------+
| @@transaction_isolation |
+-------------------------+
| REPEATABLE-READ         |
+-------------------------+
```



第 7 章 MySQL事务日志
===

事务有4种特性 : 原子性 一致性 隔离性 持久性 那么事务的四种特性到底是基于什么机制实现的呢

- 事务的隔离由 `锁机制`实现

- 而事务的原子性 一致性 和 持久性是由事务的 `redo`日志和 `undo`日志来保证
  - `redo log`称为 `重做日志` 提供再写入操作,恢复提交事务修改的页操作,用来保证事务的持久性
  - `undo log`称为 `回滚日志` 回滚某个记到莫个特定版本,用来保证事务的一致性,原子性

有的 `DBA`可能会认为 `undo` 是 `redo`的逆过程,其实不然 ,`redo`和 `undo`都可以视为一种恢复操作,但是

- redo log : 是存储引擎层(innodb)生成的日志,记录是 `物理级别上的`页修改操作 比如页号xxx,偏移量yyyy 写入了 zzz数据,主要为了保证数据的可靠性
- undo log : 是存储引擎层(innodb)生成的日志,记录的是 `逻辑操作`的日志,比如某一行语句进行了 `insert`操作,那么 `undo log `就记录一条与之相反的 `delete`操作 主要用于 `事务的回滚`(undo log 记录的是每个操作的逆操作) 和 `一致性非锁定读`(undo log回滚行记录到某种特定的版本 -- MVCC,即多版本并发控制)



7.1 redo日志
---

`innoDB`存储引擎是以 `页为单位`来管理存储空间的,在真正访问页面之前,需要把在磁盘上的页缓存到内存中的 `Buffer pool`之后才可以访问,所有的变更都必须变更缓冲池中的数据,然后缓冲池中的 `脏页`会以一定的频率被刷入到 `磁盘`(check point机制),通过缓冲池来优化 `cpu` 和磁盘之间的鸿沟 这样就可以保证整体的性能不会下降太快



### 7.1.1 为什么需要 `redo`日志

一方面,缓冲池可以帮助我们消除 `CPU`和磁盘之间的鸿沟,`check point` 机制可以保证数据的最终落盘,然而由于 `check point`并不是每次触发的时候就变更的,而是 `master`线程隔一段时间去处理的 所以最坏的情况就是事务提交后,刚写完缓冲池,数据库宕机了,那么数据就是丢失的,无法恢复的；

另一方面,事务包含 `持久性的特性`,就是说对于一个已经提交的事务,在事务提交后,即使事务发生了崩溃,这个事务对数据所作的更改也不能丢失

那么如何保证这个持久性呢 `一个简单的做法` 在事务提交完成之前把该事务修改的所有页面都刷新到磁盘,但是这个简单粗暴的做法有些问题:

- 修改量与刷新磁盘工作量严重不成比例

有时候,我们仅仅修改了某个页面的某个字节,但是我们知道在 `innoDB`中是以页为单位进行磁盘IO的,也就是说,我们在该事务提交时不得不将一个完整的页面从内存中刷新到磁盘,我们又知道一个页面默认是 `16kB`大小,只修改一个字节就刷新 `16kB`到磁盘,显然是小题大做了

- 随机 IO刷新比较慢

一个事务可能包含的很多语句,即使是一条语句也可能修改很多页面,假如事务修改的这些页面可能并不相邻 这就意味着将某个事务修改的

`buffer pool`中的页面 `刷新到磁盘中`,需要进行很多的随机 IO,随机IO比顺序IO要慢,尤其对于传统的机械硬盘来说



另一个解决思路 : 我们只是想让已经提交的事务对数据库中的数据所作的修改是永久性的,即使后来系统崩溃,在重启之后也能把这种修改恢复出来,所以,其实我们没有必要在每次事务提交时就把该事务在内存总修改过的全部页面刷新到磁盘,只需要把哪些东西记录一下就好了 

`Innodb`引擎的事务采用了 `WAL(Write Ahead Logging)`技术,这种技术的思想就是先写日志,在写磁盘,只有日志写入成功,才算事务提交成功,这里的日志就是 `redo`日志 当发生宕机且数据未写入到磁盘的时候,可以通过 `redo log`来恢复,保证 `ACID`中的D,这就是 `redo log`的作用



### 7.1.2 redo 日志的好处 特点

**好处**

- redo日志降低了刷盘频率
- redo日志占用空间非常小

存储表空间 ID,页号,偏移量以及所需要更新的值,所需的空间是很小的,刷盘快

**特点**

- redo日志是顺序写入磁盘的

在执行事务的过程中,每执行一条语句,就可能产生若干条 redo日志,这些日志是按 `产生的顺序写入磁盘的`,也就是顺序IO,效率比随机IO快

- 事务执行过程中 redo 不断记录

redo log 和 bin log的区别,redo log是`存储引擎层`产生的,而 `bin log`是数据库层产生的,假设一个事务,对表进行一个 10万行的插入,在这个过程中,一直不断的顺序往 redo log 顺序记录,而 bin log 不会记录,直到这个事务提交,才会一次写到 bin log 文件中



### 7.1.3 redo的组成

redo日志可以简单的分为 :

- 重做日志的缓冲(redo log buffer),保存在内存中,它是易失的

在服务器启动的时候就向操作系统申请了一大片称之为 `redo log buffer`的连续存储空间,翻译成中文就是redo日志缓冲区,这片连续的存储空间被划分为若干个连续的 `redo log block` 一个 `redo log block`占用 `512字节的`大小

> 参数设置 : innodb_log_buffer_size
>
> redo log buffer的大小默认是16M 最大是 4096M,最小是1M

```mysql
 show variables like '%innodb_log_buffer_size%'                                                       
+------------------------+----------+
| Variable_name          | Value    |
+------------------------+----------+
| innodb_log_buffer_size | 16777216 |
+------------------------+----------+
select 16777216/1024/1024 from dual;--16M
```



- 重做日志文件(redo log file) 保存在硬盘中 是持久的

```shell
-- /var/lib/mysql

ib_logfile0 
ib_logfile1
## 上面这2个文件就是 redo log 重做日志文件
## 两个文件的大小是一样的
```

![image-20220304235748468](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220304235748468.png)



### 7.1.4 redo log的整体的流程

以一个事务的更新为例,redo log 的大致流程如下:

![image-20220305000055086](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220305000055086.png)

第 1 步  : 先将原始数据从磁盘读入到内存中来,修改数据的内存拷贝 

第 2 步 : 生成一条重做日志并写入到 redo log buffer,记录的是数据被修改之后的值

第 3 步 : 当事务 `commit` 时,将 redo log buffer 中的内容刷新到 redo log file  对 redo log buffer 采用追加写的方式

第 4 步 :  定期将内存中修改的数据刷新到磁盘

> Write Ahead log (预先日志优化) 在持久化一个数据之前,会将内存中的相应的日志进行持久化



### 7.1.5 redo log 的刷盘策略

redo log 写入并不是直接写入磁盘,innodb会在redo log的时候先写 redo log buffer,之后以一定的频率刷新到真正的 redo log file 中,这里的一定频率怎么看待呢 这就是我们要说的刷盘策略

![image-20220305001255796](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220305001255796.png)

注意 redo log buffer 刷盘到 redo log file 的过程并不是真正的刷新到磁盘中去,只是刷入到文件系统缓存(page cache)中去(这是现代操作系统为了提高文件系统写入效率所作的一个优化),真正的写入会交给系统自己来决定(比如 page cache足够大了) 那么对于 innodb来说就存在一个问题,如果交给系统来同步 同样 如果系统宕机,那么数据也丢失了(虽然整个系统宕机的概率还是比较小的)

针对这种情况 innodb给出了 `innodb_flush_log_at_trx_commit`参数,该参数控制 `commit`提交事务时,如何将 `redo log buffer`中的日志刷新到 `redo log file` 它支持三种策略

- **设置为0** :  表示每次事务提交时 不进行刷盘操作 (系统默认 master thread 每隔1s进行一次重做日志的同步)

- **设置为1** :  表示每次提交事务时 都将进行同步 刷盘操作(默认值)

- **设置为2** :  表示每次提交事务时都 只把 redo log buffer 的内容写入到 page cache,不进行同步,由 os 自己决定什么时候同步到磁盘文件

  ```mysql
   show variables like 'innodb_flush_log_at_trx_commit';
  +--------------------------------+-------+
  | Variable_name                  | Value |
  +--------------------------------+-------+
  | innodb_flush_log_at_trx_commit | 1     |
  +--------------------------------+-------+
  ```



另外, `InnoDB`存储引擎有一个后台线程,每隔 1 s,就会把 `redo log buffer`中的内容写入到文件系统缓存( `page cache  `),然后调用刷盘操作

![image-20220305003221024](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220305003221024.png)

也就是说 一个没有提交事务的 `redo log `记录,也可能会刷盘,因为在事务执行过程中 redo log 记录会写入 `redo log buffer`中,这些 `redo log`记录会被后台线程刷盘



### 7.1.6 不同的刷盘策略演示

```mysql
innodb_flush_log_at_trx_commit=1
```



![image-20220305143551629](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220305143551629.png)

---

> 小结 :
>
> innodb_flush_log_at_trx_commit=1
>
> 为1时,只要事务提交成功 redo log 记录就一定在磁盘里,不会有任何数据丢失
>
> 如果事务执行期间mysql挂了或宕机,这部分日志就丢了,但是事务并没有提交,所以日志丢了,也不会有损失,可以保证ACID的D,数据绝对不会丢失,但效率是最差的
>
> 建议使用默认值,虽然操作系统宕机的概率小于数据宕机的概率,但是一般既然使用了事务,那么数据的安全相对来说,更重要一些



```mysql
innodb_flush_log_at_trx_commit=2
```



> **innodb_flush_log_at_trx_commit=2**时,只要事务提交成功,redo log buffer 中的内容只写入到文件系统缓存(page cache)
>
> 如果仅仅只是mysql挂了不会有任何数据丢失,但是操作系统宕机可能会有1s的数据丢失,这种情况下无法满则 ACID中的D,但是2肯定是效率最高的



```mysql
innodb_flush_log_at_trx_commit=0
```

```sql
delimiter//
create procedure p_load(count int unsigned)
begin
declare s int unsigned default 1;
declare c char(80) default repeat('a',80);
while s<=count do
insert into test_load select null,c;
commit;
set s=s+1;
end while;
end //
delimiter;


```

7.1.7 写入 `redo_log_buffer`的过程
---

### 1 补充概念`Min-Transaction`

MySQL把底层页面中的一次原子访问的过程称之为一个 `Mini-Transaction`  简称 `mtr` 比如向某个索引对应的 B+树中插入一条记录的过程就是 一个 `Mini-Transaction` 一个所谓的 `mtr`包含一组 `redo`日志  在崩溃时 恢复 这一组 `redo`日志作为一个不可分割的整体 

一个事务可以包含若干条语句,每一条其实就是由若干个 `mtr`组成 每一个 `mtr`又可以包含若干条 `redo`日志

简而言之就是 事务 包含语句 语句包含 mtr mtr又包含 redo



### 2 redo日志写入 log buffer

向 `log buffer`写入redo日志的过程是顺序的,也就是先往前边的 block中写 当该block的空闲空间用完之后再往下一个 block中 写  当我们想往 log buffer中 写入 redo日志时 第一个遇到的问题就是应该写在哪个 block的哪个偏移量处 所以 INNODBD的提供者特意提供了一个称之为 `buf_free`的全局变量 该变量指明后续写入的 redo日志应该写入到 log buffer中的那个位置



7.1.8 redo log file
---

**相关参数设置**

`innodb_log_group_home_dir` 指定 redo log文件组所在的路径 默认值是 `./`  表示在数据库的数据目录下

mysql默认数据目录是 `/var/lib/mysql`下默认有2个名为 `ib_logfile0` `ib_logfile1`  log buffer中的日志默认情况下就是刷新到这2个磁盘文件中  此 redo日志的文件位置还可以修改 

`innodb_log_files_in_group` : 指明 redo log file的个数 命名方式如 :  `ib_logfile0`  `ib_logfile1` 默认2个最大100个

`innodb_flush_log_at_trx_commit` 控制  redo log刷新到磁盘的策略 默认为1 

`innodb_log_file_size` 单个 redo log文件设置大小  默认值为48M 最大值为512G  注意最大指的是整个 redo log 系列文件之和 即 (

`innodb_log_files_in_group*inndb_log_file_size` )

```sql
-- redo log 文件组的位置
show variables like 'innodb_log_group_home_dir';
-- redo log file 的个数
show variables like 'innodb_log_files_in_group';
-- 查看日志文件的大小
show variables like 'innodb_log_file_size'; 
```

可以根据业务大小修改其大小 以便容纳较大的事务 编辑 `mysqld.cnf`

**日志文件组**

从上边的描述中可以看到 ,磁盘上的 redo日志文件不止一个 而是以一个日志文件组的形式存在的 这些文件以 `ib_logfile[数字]`(数字可以是 0 1 2 3 ....)的形式进行命名 每个redo日志文件的大小是一样的 

再将 redo日志写入到日志文件组是,是从 `ib_logfile0`开始写 如果 `ib_logfile0`写满了 就接着写 `ib_logfile1` 同理 如果 `ib_logfile1`写满了就去写 `ib_logfile2`,以此类推 如果写到最后一个文件怎么办 那就重新转到 `ib_lofile0`继续写



总共  redo日志文件的大小就是 `innodb_log_file_size *   innodb_log_files_in_group`

采用循环写入的方式向redo日志文件组里写数据的话 会导致后写入的 redo日志覆盖掉前边写的redo 日志 当然,所以 innodb的设计者提供了 `checkpoint`的概念



**checkpoint**

在整个日志文件组中还有两个重要的属性 分别是 `write pos` `checkpoint`

- `write pos` : 当前记录的位置 一边写  一边后移
- `checkpoint` : 是当前要擦除的位置 也是往后推移



每次刷盘 redo log记录到日志文件组中 write pos位置就会后移更新 每次 mysql加载日志文件组恢复数据时,会清空加载过的 redo log记录并把 checkpoint后移更新 write pos 和 checkpoint之间还空着的部分可以用来写入新的 redo log记录



如果 write pos追上 checkpoint 表示日志文件组满了 这个时候不能再写入新的 redo log MYSQL得停下来 清空一些记录 把checkpoint推进一下



7.2 undo 日志
---

redo log 是事务持久性的保证,undo log 是事务原子性的保证.在事务中更新数据的前置操作其实是要先写入undo log



### 7.2.1 如何理解 undo 日志

事务需要保证原子性,也就是事务中的操作要么全部完成 要么什么也不做 但有时候事务执行到一半会出现一些情况 比如:

- 情况1 : 事务执行的过程中可能遇到各种错误,比如 `服务器本身的错误` `操作系统错误` 甚至突然断电导致的错误
- 情况2 : 程序员可以在事务执行过程中手动输入 `rollback`语句结束当前事务的执行

以上情况的出现,我们需要把数据改回原先的的样子,这个过程就称之为回滚,这样就可以造成一个假象 这个事务看起来什么都没有做.所以符合原子性要求

每当我们要对一条记录做改动时(这里的改动可以指 `insert` `delete` `update`) 都需要留一手,把回滚时所需的东西记录下来 比如:

- 你 插入一条记录时,只要把这条记录的主键值记录下来,之后回滚的时候 只需要把这个主键值对应的记录删除就好了(对于每个insert innodb 存储引擎都会完成一个 delete)
- 你删除了一条记录,至少要把这条记录中的内容都保存下来这样之后回滚的时候,只需要把这个主键值对应的记录插入到表中就好了 (对于每一个delete 操作 innodb存储引擎会执行一个insert)
- 你修改了一条记录,至少要把删除记录之前的旧值都记录下来,这样再把这条记录更新为旧值就好了(对于每一个update innodb 会执行一个相反的 update 将修改前的行放回去)



MySQL把这些为了回滚而记录的这些内容称之为`撤销日志`或者是`回滚日志`(即 `undo log`) 注意 由于查询操作(`select`)并不会修改任何用户记录,所以在查询操作执行时 并需要记录相应的 undo 日志



### 7.2.2  undo 日志的作用

- **作用 1 回滚数据**:



​	用户对 undo日志可能有误解 undo用于将数据库物理的恢复到执行语句或事物之前的样子,但事实并非如此

undo是逻辑日志,因此只是将数据逻辑的恢复到原来的样子 所有的修改都被逻辑的取消了,但是数据结构和也本身在回滚之后可能大不相同

​	这是因为多用户并发系统中,可能会有数十 数百 甚至数千个并发事务 数据库的主要任务就是协调对数据记录的并发访问 比如 一个事务在修改当前页中的某几条记录,同时还有别的事务再对同一个页中的另几条记录进行修改,因此不能将一个页回到事务开始时的样子,因为这会影响其他事务正在进行的工作

- **作用2 MVCC**

undo 的另一个作用是 `MVCC`,即在 `Innodb`存储引擎中 `MVCC`的实现是通过undo来完成的 当用户读取一行记录时,若该记录已经被其它事务占用,当前事务可以通过 undo读取之前的行版本信息,以此实现非锁定读取



### 7.2.3 undo 的存储结构

- 回滚段和undo页

InnoDB对undo log采取段的方式,也就是回滚段 `(rollback segment)`每个回滚段记录了1024个 `undo log segment` 而在每个 `undo segment`段中   进行 undo页 的申请

在 `InnoDB1.1`版本之前(不包括1.1版本) 只有一个 rollback segment 因此支持同时在线的事务的个数为 1024个 虽然对绝大多数的应用来说都已经足够 

从1.1版本开始 InnoDB支持最大128个 `rollback segment` 故其支持同时在线的事务个数 `128*1024`

```sql
mysql> show variables like '%undo%';
+--------------------------+------------+
| Variable_name            | Value      |
+--------------------------+------------+
| innodb_max_undo_log_size | 1073741824 |
| innodb_undo_directory    | ./         |
| innodb_undo_log_encrypt  | OFF        |
| innodb_undo_log_truncate | ON         |
| innodb_undo_tablespaces  | 2          |
+--------------------------+------------+
```



虽然InnoDB1.1支持128个 `rollback segment` 但是这些 `rollback segment`都存储在共享表空间ibdata中 从 InnoDB1.2版本开始,可以通过参数对`rollback segment`做进一步的设置,这些参数包括:

`innodb_undo_dicretory` 设置 `rollback segment`所在的路径

`innodb_undo_logs`设置 `rollback segment`的个数 默认值是128

`innodb_undo_tablespaces` 设置构成 `rollback segment`文件的数量 这样 `rollback segment`可以较为平均的分布在多个文件中

undo log 的参数一般很少改动

TPS : 每秒处理事务的数量

- 回滚段和事务

每个事务都会使用一个回滚段,一个回滚段在同一个时刻可能会服务于多个事务

当一个事务开始的时候,会指定一个回滚段,在事务进行的过程中,当数据被修改时,原始的数据会被复制到回滚段

在回滚段中,事务会不断填充盘区,直到事务结束或所有的表空间都被用完 如果当前得盘区不够用,事务会在一个段中请求扩展下一个盘区,如果所有已分配盘区都被用完,事务会覆盖最初的盘区或者回滚段允许的情况下扩展新的盘区来使用

回滚段存在于undo表空间中,在数据库中,可以存在多个undo表空间,但同一时刻只能存在一个undo表空间

```mysql
show variables like 'innodb_undo_tablespaces';
+-------------------------+-------+
| Variable_name           | Value |
+-------------------------+-------+
| innodb_undo_tablespaces | 2     |
+-------------------------+-------+
# undo  log 的数量最少为2 undo log的truncate 操作由purge线程发起  在truncate 某个undo log表空间的过程中,保证有一个可用的 undo log 可用
```

当事务提交时,InnoDB存储引擎会做以下两件事情

将undo log 放入到列表中,以供之后的 `purge`操作

判断 `undo log`所在的页是否可重用,如果可以分配给下一个事务用

- 回滚段中的数据分类

1. 未提交的回滚数据(uncommited undo information) 该数据所关联的事务并未提交,用于实现读写一致性.所以该数据不能被其他数据覆盖
2. 已经提交但并未过期的回滚数据(commited undo information) : 该数据关联的事务已经提交,但是仍然受到 `undo retention`参数保持时间的影响
3. 事务已经提交并过期的数据(expired undo information) 事务已经提交 而且数据保存时间已经超过了 `undo retention`参数指定的时间 属于已经过期的数据,当回滚段满了之后,会优先覆盖 事务已经提交过并未过期的数据

事务提交后,并不能马上删除 undo log 及undo log所在的页 这是因为可能其他事务还需要通过 undo log来得到记录之前的版本 故事务提交时将 undo log 放入到一个链表中, 是否可以最终删除undo log 以及undo log所在的页由purge线程来判断



### 7.2.4 undo 的类型

在 innodb存储引擎中 undo log 分为:

- `insert undo log`

`insert undo log`是指在 `insert`操作中产生的undo log 因为 `insert`操作的记录只对事务本身可见,对其它事务不可见(这是事务隔离性的要求) 故该 undo log 可以在事务提交后直接删除,不需要进行 `purge`操作

- `update undo log` 

update undo log 记录是对 delete 和 update 产生的 undo log  该undo log 可能需要提供 `mvcc`机制,因此不能在事务提交时就进行删除 提交时放入到 undo log链表,等待 purge线程进行最后的删除



### 7.2.5 undo log的生命周期

1 简要生成过程

以下是 undo + redo事务的简化过程

假设有2个数值 分别为A=1和B=2然后将A修改为3 B修改为4

```sql
1 start transaction;
2 记录A=1到 undo log
3 update A=3
4 记录A=3到redo日志
5 记录B=2到undo日志
6 update B=2
7 记录B=4到redo log
8 将 redo log刷新到磁盘
9 commit;
```



在 1 ~ 8步骤的任意位置系统宕机,事务未提交 该事务就不会对磁盘上的数据有任何影响

如果 在 8-9之间宕机 恢复之后也可以进行回滚 也可以选择继续完成事务的提交 因为此时 redo log 已经持久化 

如果在 9 之后宕机 内存映射中变更的数据还来不及刷回磁盘 那么系统恢复之后,可以根据redo log把数据刷回到磁盘



2 详细生成过程

对于 InnoDB存储引擎来说  每个行记录除了记录本身的数据之外,还有几个隐藏列:

- `DB_ROW_ID`如果没有为表显式的定义主键 并且表中也没有定义唯一索引,那么 InnoDB会自动为表添加一个 row_id的隐藏列作为主键
- `DB_TRX_ID`  每个事务都会分配一个事务id 当对某条记录发生变更时,会将这个事务的事务id 写入 `trx_id`中
- `DB_ROLL_PTR`回滚指针 本质上就是指向 `undo log`的指针



当我们执行 `insert`时 

```sql
begin;
insert into  user(name) values('chaochao');
```

插入的数据都会生成一条 insert undo log 并且数据回滚指针指向它  undo log会记录 undo  log的序号 插入主键的列和值 那么在进行rollback的时候 通过主键直接把它对应的数据删除即可



当我们执行 `update`语句时:

对于更新操作会产生 update  undo log 并且会分更新主键和不更新主键的,假设现在执行 :

```sql
update user set name = 'chaochao' where id=1;
```

这时会把老的记录写入新的 undo log 然后回滚指针指向新的 undo log  它的 undo no 是1 并且新的 undo log会指向老的undo log (undo no)



假设现在执行

```sql
update user set id=2 where id=1;
```

对于更新主键的操作,会先把原来的数据的 `deletemark`标识打开 这时并没有真正的删除数据 真正的删除数据会交给清理线程去判断,然后在后面插入一条新的记录 新的数据也会产生 undo  log ,并且 undo log的序号会递增



可以发现每次对数据的变更都会产生一个 undo log 当一条记录被变更多次时 那么就会产生多条 undo log undo log记录的是变更前的日志 并且每个  undo log的序号是递增的 那么当回滚的时候,按照序号依次向前 就可以找到我们的原始数据了



3 undo log是如何回滚的 

以上面的例子来说 假设执行rollback操作 那么对应的流程应该就是这样的

 1 .通过 undo no = 3 的日志把id=2的数据删除

 2  通过 undo no  = 2 的日志把 id=1的数据删除

 3 通过 undo no = 1 的日志 把id=1的数据的name还原

  4 通过 undo no = 0 的日志把id=1的数据删除



4 undo log的删除

针对 insert undo log 

因为insert操作的记录 只对事务本身可见 因此不能在事务提交时就进行删除 提交时放入 undo log链表 等待 purge线程进行最后的删除

>补充 : 
>
>purge 的两个主要作用是 清理 undo 页 清除 page里面带有 delete_bit标识的数据行 在InnoDB中 事务中的delete操作实际上并不是真正的删掉数据行,而是一种 delete mark操作 在记录上标识 delete_bit 而不是删除记录 是一种假删除,只是做了一个标记而已,真正的删除工作需要后台的 purge线程去完成



undo log是逻辑日志 对事务回滚时 只是将数据库逻辑的恢复到原来的样子

redo log是物理日志 记录的是数据页的物理变化 undo log不是 redo log的逆过程



第 8 章 其他数据库日志
===

除了发现错误,日志在数据复制,数据恢复,操作审计,以及在确保数据的永久性和一致性等方面,都有着不可替代的作用

千万不要小看日志,很多看似奇怪的问题,答案往往就藏在日志里,很多情况下,只有查看日志,才能发现问题的原因,真正解决问题,所以一定要学会看日志,养成检查日志的习惯,对于提升你的数据库应用开发能力至关重要



8.1 MySQL支持的日志
---



### 8.1.1 日志的类型

mysql有不同类型的日志文件,用来存储不同类型的日志,分为 `二进制日志` `错误日志` `通用查询日志` `慢查询日志` 这也是常用的4种,mysql8又新增两种常用的日志 `中继日志` 和 `数据定义语句日志` 使用这些日志文件,可以查看mysql内部发生的事情

**这6类日志分为**

- 慢查询日志 : 记录所有查询时间超过 `long_query_time`的所有查询,方便我们对查询进行优化
- 通用查询日志 : 记录所有的连接起始时间和终止时间,以及连接发送给服务器的所有的指令 对我们恢复原操作的实际场景,发现问题,甚至对数据库操作的审计都有很大的帮助
- 错误日志 : 记录mysql 服务器启动 运行 或停止mysql服务出现的问题,方便我们了解服务器的状态,从而对服务器进行维护
- 二进制日志 : 记录所有更改数据的语句,可以用于主从复制之期的数据同步,以及数据库遇到故障时的无损失恢复
- 中继日志 : 用于主从服务器架构中,从服务器用来存放主服务器二进制内容的一个中间文件 从服务器通过读取中继日志的内容,来同步主服务器上的操作
- 数据定义语句日志 : 记录数据定义语句执行的元数据操作



### 8.1.2 慢查询日志 (slow query log)



### 8.1.3 通用查询日志 (general query log)

​	通用查询日志用来记录用户的所有操作,包括启动和关闭mysql服务,所有用户连接的开始时间和截止时间,发给 mysql数据库服务器的所有SQL指令,当我们的数据库发生异常时,查看通用查询日志,还原操作时的具体场景



**查看状态**

```mysql
show variables like '%general%';
+------------------+--------------------------+
| Variable_name    | Value                    |
+------------------+--------------------------+
| general_log      | ON                       |
| general_log_file | /var/log/mysql/query.log |
+------------------+--------------------------+
```



**停止日志**

方式1  : 永久性方式,修改配置文件 `/etc/mysql/mysql.conf.d/mysqld.cnf`

```mysql
## 
## 查询日志
general_log_file        = /var/log/mysql/query.log
## 开启查询日志
general_log             = 1 
```



方式2 : 临时方式:

```mysql
set global general_log=
```



第 9 章 锁
===

事务的隔离性由锁来实现



1 概述
---

**锁** 是计算机协调多个进程或线程 并发访问某一资源的机制,在程序开发中会存在多线程同步的问题,当多个线程并发访问某个数据的时候,尤其是针一些敏感的数据(如订单 金额),我们就需要这个数据在任何时刻最多只有一个线程在访问,保证数据的 **完整性和一致性** 在开发过程中加锁是为了保证数据的一致性,这个思想在数据库领域中同样重要



在数据库中,除传统的计算机资源(如 **CPU RAM I/O**)的争用以外,为了保证数据的一致性,需要对 **并发操作进行控制** 因此产生了锁 同时锁机制也为实现 **MySQL**的各个隔离级别提供了保证 **锁冲突**也是影响数据库 **并发访问性能**的一个重要因素 所以锁对数据库而言 尤其重要,也更加复杂



2 MySQL并发事务访问相同的记录
---

并发事务事务访问相同的事务大致可以划分为以下三种 : 

### 2.1 读-读情况

`读-读`情况 即并发事务相继读取相同的记录 读取操作本身不会对记录有任何影响,并不会引起什么问题,所以允许这种情况发生



### 2.2 写-写情况

`写-写`情况 即并发事务相继对相同的记录做出改动

在这种情况下会发生脏写的问题,任何一种隔离级别都不允许这种问题发生 所以在多个未提交事务相继对一条记录做出改动时,需要他们排队执行,这个排队的过程其实是通过锁来实现的 这个所谓的锁其实是 **一个内存中的结构** 在事务执行前 本来是没有锁的 也就是说一开始是没有 `锁结构`和记录进行关联的

当一个事务想对这条记录做改动时,首先会看看内存中有没有和这条记录关联的 `锁结构` 当没有的时候就会在内存中生成一个 `锁结构`与之关联 比如 : 事务 `T1`要对这条记录做改动,就需要生成一个 `锁结构`与之关联 : 

![image-20220319124304407](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220319124304407.png)

在锁结构中有很多的信息,为了简化理解,只是把两个比较重要的属性拿了出来

`trx`信息 : 代表这个锁结构是哪个事务生成的

`is_waiting` : 代表当前事务是否在等待



当事务 **T1**改动了这条记录以后,就生成了一个锁结构和这个事务管关联,因为之前没有别的事务为这条记录加锁 所以 `is_wating`属性就是 `false` 我们就把这个场景称之为获取锁成功 或者是加锁成功,然后就可以继续执行操作了



在事务 `T1`提交之后,另外一个事务 `T2`也对该条记录做改动 那么先看看有没有 `锁结构`和这条记录关联,发现一个 `锁结构`与之关联之后,然后也生成了一个 `锁结构`与这条记录关联 不不过 锁结构的 `is_waiting`属性为 `true` 表示当前事务需要等待 我们把这个场景称之为获取锁失败 或加锁失败 

![未命名文件](C:\Users\ASUS\Downloads\未命名文件.png)

在事务`T1`提交以后,就会把该事务生成的锁结构释放掉 然后看看别的事务还有没有再等待获取锁 发现事务 `T2`还在等待获取锁 所以事务 `T2`对应的锁结构的 `is_waiting`属性为 `false` 然后把该事务对应的线程唤醒 让他继续执行 此时事务 `T2`就算获取到锁了



> **小结**

- 不加锁

意思就是不需要在内存中生成对应的锁结构,可以直接执行

- 获取锁成功 或者加锁成功

意思就是在内存中生成了对应的锁结构 而且索结构的 `is_wating`为 `false` 也就是事务可以继续执行操作

- 获取锁失败 或者加锁失败 或者没有获取到锁

意思就是在内存中生成了对应的锁结构,不过 锁结构的 `is_waiting`为 `true` 也就是事务需要等待 不可以继续执行操作



### 2.3  读-写 写-读情况

`读-写` `写-读` 即一个事务进行读取操作 另一个事务进行写操作 这种情况下可能发生 `脏读 ` `不可重复读` `幻读`的问题

各个数据库厂商对 `SQL`标准的支持都不一样 比如MySQL 的`repeatable read`隔离级别上就已经解决了幻读的问题



### 2.4 并发问题的解决方案

怎么 解决 `脏读` `不可重复读` `幻读`这些问题 其实有两种可选的解决方案:

- **方案1 读操作利用多版本并发控制(MVCC) 写操作进行加锁**

所谓的 `MVCC` 就是生成一个 `readView` 通过 `readView`找到符合条件记录的版本(历史版本由 `undo`日志构建) 查询语句只能读到在生成 `readView`之前 `已提交事务所在的更改` 在生成 `readView`之前未提交的事务或者之后才开启的事务所在的更改是看不到的 而 `写操作`肯定是针对最新版本的记录 读记录的历史版本和改动记录最新版本本身并不冲突 也就是使用 `MVCC` 读写操作并不冲突

> **普通的select语句在 read commited 和 repeatabel read隔离级别下会使用到MVCC读取记录**
>
> **在 read committed隔离级别下 一个事务在执行过程中每次执行select操作都会生成一个 readView readView的存在本省就保证了 事务不可以读取到未提交事务所作的更改 也就是避免了脏读的现象 **
>
> **在 repeatable read 隔离级别下 一个事务在执行过程中 只有第一次执行select操作才会生成一个 readView 之后的select 操作都会复用这个readView 这样就避免了不可重复读和幻读的问题**



- **方案2 读写操作都采用加锁的方式**

如果我们一些业务场景不允许读取记录的就版本 而是每次斗都去读取记录的最新版本 比如在银行存款的事务中,你需要先把帐户的余额读取出来,然后将其加上本次款的数额,最后在写到数据库中 在将帐户余额读取出来之后,就不想让别的用户访问该余额,直到本次存款事务执行完成,其他事务才可以访问帐户的余额 这样在读取记录的时候就需要对其进行加锁操作 这样也就意味着读操作和写操作 也像 `写-写`操作那样排队执行

`脏读`的产生是因为当前事务读取到了另一个未提交事务写的一条记录 如果另一个事务在写记录的时候就给这条记录加锁,那么当前事务就无法继续读取该记录了 所以也就不会有脏读问题的产生了



`不可重复读`的产生是因为当前事务先读取一条记录 另外一个事务对该记录进行了改动之后并提交 当事务再次读取时会获取到不同 的值 如果当前事务读取该记录时就会给该记录加锁,那么另一个事务就无法修改该记录,自然也不会发生不可重复读了



**幻读**问题的产生是因为当前事务读取了一个范围的记录,然后另一个事务向该范围内插入了新的记录,当前事务再次读取该范围内的数据时发现了新插入的新记录 采用加锁的方式解决幻读的问题就有一些麻烦,因为当前事务在第一次读取记录时幻影记录并不存在,所以读取的时候加锁就有点尴尬(因为你并不知道给谁加锁)

> **小结**

采用 `MVCC`方式的话 `读-写`操作彼此并不冲突 性能更佳

采用加锁方式的话 读写操作彼此需要排队执行 影响性能

一般情况下我们当然愿意采用 `MVCC``来解决` `读-写`操作并发执行的问题 但是业务在某些特殊情况下,要求必须采用加锁的方式执行



3 锁的不同角度分类
---

### 3.1 从数据操作类型划分 读锁 写锁

对数据库中的 并发事务的 `读-读`情况并不会引起什么问题 对于 `读-读` `读-写` `写-读`这些情况可能会引起一些问题 需要使用 `MVCC`或者加锁的方式来解决他们 在使用**加锁**的方式解决问题时,由于又要允许 `读-读`情况不受影响 又要使 `写-写` `读-写` `写-读`的情况相互阻塞 所以MySQL实现一个由两种类型的锁组成的锁系统来解决 这两种类型的锁通常被称为 **共享锁(Shared lock Slock)**和 **排他锁(Exlusive lock XLock)**也叫 **读锁(read lock)**和 **写锁(write lock)**

- **读锁 : ** 也称为 **共享锁** 英文用 `S` 表示 针对同一份数据,多个事务的读操作可以同时进行而不会互相影响,相互不阻塞
- **写锁 :  ** 也称为 **排他锁**   英文用 `X`表示 当前写操作没有完成前,它会阻塞其他写锁和读锁 这样就能确保在给定的时间里,只有一个事务能执行写入 并防止其它用户读取正在写入的同一资源



**需要注意的是对于 InnoDB存储引擎来说 读锁和写锁可以加在表上 也可以加载行上**



#### 1 锁定读

在采用加锁的方式解决  `脏读` `不可重复读` `幻读` 这些问题时 读取一条记录时 需要获取该记录的 `S`锁 其实是不严谨的,有时候在获取记录是就要获取记录 的`X`锁 来进制别的事务读写该记录  为此 MySQL提供了两种比较特殊的 `select`语句

- 对于读记录加 `S` 锁 


```mysql
select .... lock in share mode;
## 或 
select .... for share;
```



在普通的 `select`语句后面加 `lock in share mode`,如果当前事务执行了该语句,那么它会为读取到了记录 加 `S`锁 这样允许别的事务继续获取

**行级读写锁 : ** 如果事务T1已经获得了某个行的读锁,那么此时另外的一个事务T2是可以去获得这个行的读锁的,因为读操作并没有改变行的数据,但是如果某个事务T3想要获得某个行的写锁,则它必须等待事务 T1 T2释放了行上的读锁才行

- 对读取的记录加 `X`锁

```sql
select ... for update;
```



在普通的 `select`语句后面加 `for update ` ,如果当前事务执行了该语句,那么他会为读取到的记录加 `X`锁,这样既不允许别的事务获取这些记录的 `S`锁(比方说别的事务使用 `select ... lock in share mode `语句来读取这些记录) 也不允许获取这些记录的 `X`锁(比如使用 `select ... for update`语句来读取这些记录,或者直接修改这些记录) 如果别的记录想要获取这些记录的 `S`锁 或者 `X`锁,那么它们会阻塞,直到其它事务提交后将这些记录上的 `X`锁释放

```sql
## session1 
begin; -- 开启事务
-- 开启S锁
select * from t_acct lock in share mode;

## session2 
begin;
select * from t_acct lock in share mode;

## 以上2个会话不会出现阻塞的情况
## session1 其它的事务正常查询没有任何的问题
-- 开启事务
begin;
-- 开启X锁(排他锁)
select * from t_acct for update;
commit;

## session2 session1 的事务没有提交 查询会阻塞
begin;
-- 开启X锁
select * from t_acct for update;
commit;
```



**MySQL8.0新特性**

在 5.7之前的版本 `select ... for update` 如果获取不到锁会一直等待,直到 `innodb_lock_wait_timeout`超时 在8.0版本中 `select ... for update select ... for share  `添加 `nowait` `skip locked`语法 跳过等待,或者跳过锁定

- 通过添加 `nowait` `skip locked`语法,能够立即返回,如果查询的行已经加锁
  - 那么 `nowait`会立即报错返回
  - 而`skip locked `也会立即返回,只是返回的结果中不包含被锁定的行

```sql
-- nowait session1
begin;
select * from t_acct for update; 
commit;

-- session1
select * from t_acct for update skip locked;  
```



![image-20220321230200472](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220321230200472.png)

只返回没有被锁定的行

![image-20220321230121643](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220321230121643.png)

#### 2 写操作

平常我们用到的写操作无非是 `delete`  `update` `insert`这三种

- delete

对于一条记录做 `delete`操作的过程其实是现在 `B+`树中定位到这条记录的位置,然后获取这条记录的 `X锁` 再执行 `delete mark`操作

我们也可以把这个定位待删除的记录在 `B+`树中位置的过程看成是一个获取 `X`锁的锁定读

- update 对一条记录做 update 操作分三种情况
  - 未修改该记录的键值,并且被更新的列占用的存储空间在修改前后未发生变化 则先在 B+树中定位到这条记录的位置,然后再获取一下记录的 `X`锁,最后在原记录的位置进行修改操作 我们也可以把这个定位待修改的记录在 `B+`树中位置的过程看成是一个获取 `X`锁的锁定读
  - 未修改该记录的键值,并且至少有一个被更新的列占用的存储空间 在修改前后发生变化 则先在 `B+`树中定位到这条记录的位置 然后获取下一条记录的X锁 将该记录彻底删除掉(就是把记录彻底移入垃圾链表) 最后再插入一条新的记录 这个定位在待修改记录在 `B+`树中位置的过程看成是一个获取 `X`锁的 `锁定读` 新插入的记录由 `insert`操作提供 隐式锁进行保护
  - 修改了记录的键值,则相当于在原记录上做 `delete`操作之后 再来一次 `insert`操作 加锁操作就需要按照 `delete` `insert`的规则进行了
- insert:

一般情况下 新插入的一条记录的操作并不加锁,通过一种称之为 `隐式锁`的结构来保护这条新插入的记录

```mysql
-- 加了排他锁
begin;
update t_acct set balance=99999 where id=1001;
commit;

-- 其它事务更新这条数据会阻塞
begin;
update t_acct set balance=8888 where id=1001; 
```



### 3.2 从数据操作的粒度划分 : 表级锁  页级锁 行锁

为了尽可能提高数据库的并发度,每次锁定数据的范围越小越好,理论上每次只锁定当前操作的数据方案会得到最大的并发度,但是管理锁是很耗资源的事情(涉及获取 检查 释放锁等操作) 因此数据库系统在 **高并发响应** 和 **系统性能** 两方面进行平衡 这样就产生了 **锁定粒度(lock granularity)**的概念



对一条记录加锁影响的也只是这条记录而已,我们就说这个锁的粒度比较细,其实一个事务也可以在表级别进行加锁,自然也就被称为 **表级锁**或 **表锁** 对一个表加锁影响整个表中的记录 这个锁的锁定粒度比较粗 **锁定粒度主要分为表级锁 行级锁 页级锁**



#### 表锁(table lock)

该锁会锁定整张表,它是 `MySQL`中最基本的锁策略 ,并不依赖于存储引擎(不管你是 `mysql` 的什么存储引擎,对于表锁的策略都是一样的) 并且表锁是开销最小的策略(因为粒度比较大)  由于表级锁会将整个表锁定 所以可以很好的避免死锁的问题 当然锁定粒度大所带来的最大的负面影响就是出现锁资源争用的概率也会最大 并发率大打折扣



- 表级锁的S锁 X锁

在对某个表进行 `delete` `insert`  `update`操作时 `Innodb`存储引擎是不会为这个表添加表级锁的S锁或者是X锁 在对某个表执行一些诸如 `alter table`  ` drop table` 这类 `DDL`语句时, 其他事务对这个表并发执行诸如 `select` `insert` `update` 的语句时会发生阻塞 同理 某个事务中对某个表执行 `select` `insert` `update` `delete` 语句时,在其他会话中对这个表执行 `DDL`语句也会发生阻塞 这个过程其实是通过在 `server`层使用一种称之为 `元数据` (英文名 : `metadata locks` 简称 `MDL` )结构来实现的



一般情况下,不会使用 `InnoDB`存储引擎提供的表级别的 `S`锁 和 `X`锁 只会在一些特殊情况下 比方说 崩溃恢复过程中用到 比如在系统变量 `autocommit=0` `indb_table_locks=1` 手动获取 `InnoDB`存储引擎提供的表t的 `S`锁 或者 `X`锁 可以这么写 :

- `lock tables t read` InnoDB存储引擎会对表t加表级别的 S锁
- `Lock tables t write` InnoDB存储引擎会对表t加表级别的 X锁



不过尽量避免在使用 `InnoDB`存储引擎的表上使用 `Lock tables`这样的手动锁表语句,他们并不会提供什么额外的保护,只是会降低并发能力而已  InnoDB的厉害之处还是实现了更细粒度的行锁  关于 InnoDB表级别的 S锁 和X锁 大家了解一下即可



```mysql
-- 查看被锁的表
show open tables where In_use > 0;
```



![image-20220324232152349](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220324232152349.png)



| 锁类型  | 自己可读 | 自己可操作其他表 | 他人可读 | 他人可写 | 自己可写 |
| ---- | ---- | -------- | ---- | ---- | ---- |
| 读锁   | 是    | 否        | 是    | 否    | 否    |
| 写锁   | 是    | 否        | 否    | 否    | 是    |



> **读锁 ** 只能自己读和别人读

```mysql
 -- 加了读锁 只能自己读和别人读
 
 -- 加读锁
 lock table mylock read; 
 
 -- 可读其他表的数据
 select * from t_acct;
 
 -- 加读锁 不可向其它表中插入数据
 insert into t_acct(id,balance) values(1,1000); 
 
 -- 在其他会话中也可读
 select * from mylock;     
 
 -- 其他表插入数据会阻塞
 insert into mylock(name) values('chaochao'); 
 
 -- 释放表 其他事务表才可以操作
 unlock tables; 
```



> **写锁** 自己可读 自己可写  他人不可读 他人不可写

```sql
-- 加写锁
lock tables mylock write;  

-- 自己可读
select * from mylock;

-- 自己可写
insert into mylock(name) values('YanShan');    
 
 -- 释放锁之后 其他人才可以读
select * from mylock;
```



- 意向锁 (intention lock)

InnoDB支持多粒度锁 ( multiple granularity locking) 它允许 **行级锁** 和 **表级锁**共存 而意向锁就是其中的一种表锁

- 意向锁 存在是为了协调 行锁和表锁的关系 支持多粒度 (表锁与行锁)的锁并存
- 意向锁是一种不与行级锁冲突的表级锁 这一点非常重要 
- 表明某个事务正在某些行持有了锁或该事务准备去持有锁



> **意向锁分为两种:**

**意向共享锁 : ** (intention shared lock IS)  事务有意向对该表中的某些行加 **共享锁** (S锁)

```sql
-- 事务要获取某些行的S锁 必须先获取表的IS锁
select * from table ... lock in share mode;
```



**意向排他锁**(intention exlusive lock IX) 事务有意向对表中的某些行 加 **排他锁**(X锁)

```sql
-- 事务要获取某些行的X锁 必须先获取表的IX锁
select column from table for update;
```



意向锁是有存储引擎自己维护的 用户无法操作意向锁  在数据行加共享 排他锁之前 InnoDB会先获取该数据行所在表的对应意向锁



**意向锁要解决的问题**

现在有两个事务,分别是T1和T2,其中 T2试图在该表级别上应用共享或排他锁,如果没有意向锁的存在 那么T2就需要去检查各个页或者行是否存在锁;如果存在意向锁,那么此时就会受到由T1控制的 **表级别意向锁的阻塞** T2在锁定该前就不必检查各个页或行锁 而只需检查表上的意向锁  简单来说就是给更大一级别的空间示意里面是否已经上过锁



在数据表的场景中 如果我们给某一行数据加上了排他锁,数据库会自动给更大一级别的空间,比如数据页或数据表加上意向锁  而告诉他人这个数据页或数据表已经有人上过排他锁了 这样 当其他人想要获取数据表排他锁的时候,只需要了解是否有人已经获取了这个数据表的意向排他锁即可

- 如果事务想要获取数据表中某些记录的共享锁 就需要在数据表上添加 意向共享锁
- 如果事务想要获得数据表中某些记录的排他锁 就需要在数据表上 添加意向排他锁



举例 : 创建表 teacher 默认隔离级别为 `repeatable-read`

```sql
 -- 查看隔离级别
 select @@transaction_isolation;   

drop  table if exists teacher_1;
create table  if not exists teacher_1(
	id int not null,
	name varchar(200) not null,
	primary key(id)
) engine=innodb;

insert into teacher_1 values
(1,'konglingchao'),
(2,'konglc'),
(3,'chaochao'),
(4,'lingchao'),
(5,'xiaochaochao'),
(6,'Mr chao');

begin;
-- 就是在该行数加了X锁 自动在表级别上加上IX锁 整个表都会锁住 其他session不能获取到锁
select * from teacher_1 where id=6 for update;

-- 在锁释放之前 其他session会阻塞
lock tables teacher_1 read; 


```





#### InnoDB中的行锁

行锁 (**row lock**) 也称为记录锁 顾名思义,就是锁住某一行记录(某条记录 row) 需要注意的是 mysql服务器层并没有实现行锁机制 **行级锁只在存储引擎层出现** 



**优点 :**  锁定粒度小 发生锁冲突概率低 可以实现的并发度高 

**缺点 :** 对于锁的开销比较大 加锁会比较慢 容易出现死锁的情况



**InnoDB**与 **MyISAM**的最大不同有两点 : 一是支持事务 (transaction) 二是采用行级锁

```sql
-- 建表
-- 建表
drop table if exists student_teacher_r;
drop table if exists student;
create table if not exists  student(
	id int,
	name varchar(50),
	class varchar(10),
	primary key(id)
) engine=innodb charset=utf8;

select * from student;

show create table student;

insert into student values
(1001,'konglingchao','电气1班'),
(1002,'chaochao','电气1班'),
(1003,'lingchao','电气2班'),
(1004,'xiaochaochao','电气3班');

begin;
insert into student values
(1020,'konglc','电气1班'),
(1040,'xiaochao','电气1班');
commit;
```



**记录锁**

记录锁也就是仅仅把一条记录锁上 官方的类型名称为 `lock_rec_not_gap` 比如我们把id为8的那条记录加一个记录锁 仅仅是锁住了id为8的记录,对周围的记录没有影响

记录锁是有X锁和S锁之分的 称为 **S型记录锁** 和 **X型记录锁**

- 当一个事务获取了一条记录的S型记录锁后,其他事务可以继续获取该记录的S型记录锁,但不可以继续获取X型记录锁

- 当一个事务获取了一条记录的X型记录锁之后,其他事务既不可以继续获取该记录的S型记录锁,也不可以继续获取X型记录锁

在 **sessionA**中 对一个行加了写锁

![image-20220326135136329](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220326135136329.png)



在 **sessionB**中不能读 也不能写

![image-20220326135231378](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220326135231378.png)



在一个事务中加了 S锁 

![image-20220326135548638](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220326135548638.png)



另一个事务可以继续获取读锁 但是不能获取写锁

![image-20220326135639667](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220326135639667.png)



**间隙锁**(Gap locks)

MySQL在 `repeatable read`隔离级别下是可以解决幻读问题的 解决方案有两种 可以使用 **MVCC**解决,也可以使用 **加锁**的方案解决  但是使用加锁的方式解决有个大问题 就是事务在执行第一次读取操作时,那些幻影记录尚不存在,我们无法给这些记录加上记录锁  InnoD提出了一种 `Gap locks`的锁  官方类型名称为 **lock_gap** 我们可以简称为  **Gap**锁 

**gap锁的提出仅仅是为了防止插入幻影记录** 虽然有共享 **Gap**锁 和 独占 **Gap**锁 这样的说法 但是他们起到的作用是相同的 而如果一条记录加了 **gap**锁 (不论是贡献gap锁  还是独占gap锁) 并不会限制其他事务对这条记录添加记录锁 或者继续加 gap锁



在一个事务中的某一记录加了读锁  另一个事务可以继续获取当前行的S锁,不能获取X锁 但是可以获取其他行的S锁和X锁

![image-20220326140311031](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220326140311031.png)



![image-20220326140514015](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220326140514015.png)



```sql
-- 事务1 
begin;
-- 加了S锁 间隙锁
select * from student where id=1039 lock in share mode;  

-- 事务2
begin;
-- 事务无法插入 阻塞等待
insert into student(id,name,class) values(1037,'Tom','1班'); 

-----------------------------------------------------------
-- 事务1
begin; 
select * from student where id=1039 for update;

-- 事务2
begin; 
-- 事务无法插入数据 阻塞等待 加了间隙锁
insert into student(id,name,class) values(1038,'Merry','2班'); 
```



```sql
mysql lc_konglc@192.168.10.132:konglc_base> select * from performance_schema.data_locks\G                                
***************************[ 1. row ]***************************
ENGINE                | INNODB
ENGINE_LOCK_ID        | 139630195745576:1718:139630125078672
ENGINE_TRANSACTION_ID | 17041485
THREAD_ID             | 58
EVENT_ID              | 32
OBJECT_SCHEMA         | konglc_base
OBJECT_NAME           | student
PARTITION_NAME        | <null>
SUBPARTITION_NAME     | <null>
INDEX_NAME            | <null>
OBJECT_INSTANCE_BEGIN | 139630125078672
LOCK_TYPE             | TABLE
LOCK_MODE             | IX
LOCK_STATUS           | GRANTED
LOCK_DATA             | <null>
***************************[ 2. row ]***************************
ENGINE                | INNODB
ENGINE_LOCK_ID        | 139630195744768:1718:139630125072688
ENGINE_TRANSACTION_ID | 421105172455424
THREAD_ID             | 54
EVENT_ID              | 61
OBJECT_SCHEMA         | konglc_base
OBJECT_NAME           | student
PARTITION_NAME        | <null>
SUBPARTITION_NAME     | <null>
INDEX_NAME            | <null>
OBJECT_INSTANCE_BEGIN | 139630125072688
LOCK_TYPE             | TABLE
LOCK_MODE             | IS
LOCK_STATUS           | GRANTED
LOCK_DATA             | <null>
***************************[ 3. row ]***************************
ENGINE                | INNODB
ENGINE_LOCK_ID        | 139630195744768:467:4:1:139630125069776
ENGINE_TRANSACTION_ID | 421105172455424
THREAD_ID             | 54
EVENT_ID              | 61
OBJECT_SCHEMA         | konglc_base
OBJECT_NAME           | student
PARTITION_NAME        | <null>
SUBPARTITION_NAME     | <null>
INDEX_NAME            | PRIMARY
OBJECT_INSTANCE_BEGIN | 139630125069776
LOCK_TYPE             | RECORD
LOCK_MODE             | S
LOCK_STATUS           | GRANTED
LOCK_DATA             | supremum pseudo-record
```



**临键锁**

**插入意向锁**



#### 页锁

页锁  就是在 页的粒度上进行锁定 锁定的数据资源比行锁要多 因为一个页中可以有多个记录 当我们使用页锁的时候.会出现数据浪费的现象

但这样的浪费最多也就是一个页上的数据行 **页锁的开销介于表锁和行锁之间 会出现死锁 锁定粒度介于表锁和行锁之间 并发度一般**



### 3.3  从对待锁的态度划分  乐观锁 悲观锁

从对待锁的态度来看锁的话 :  可将锁分成乐观锁和悲观锁 从名字也可以看出 两种锁是两种看待 **数据并发的思维方式** 需要注意的是 乐观锁和悲观锁并不是锁 而是一种锁的设计思想



每个层级锁的数量是有限的,因为锁会占用内存空间, 锁空间的大小是有限的  当某个层级的锁的数量超过这个层级的阈值时,就会进行 **锁升级**  锁升级就是利用更大粒度的锁替代更小粒度的锁 比如 **InnoDB**中  行锁升级为表锁 这样做的好处是占用的锁空间降低了 但同时数据的并发度也下降

####  1 悲观锁(pessimistic locking)

​	悲观锁是一种思想,顾名思义,就是和悲观 对数据被其他事物的修改保持保守态度 会通过数据库自身的锁机制来实现 从而保证数据操作的排他性

悲观锁总是假设最坏的情况,每次去拿数据的时候都会认为别人会修改,所以每次去拿数据都会上锁, 这样别人想拿这个数据就会阻塞 (**共享资源每次只给一个线程使用,其他线程阻塞,用完后在把资源转给其他线程**) 比如 行锁 表锁  读锁 写锁等 都是在操作之前先上锁 当其他线程想要访问数据时 ,都需要阻塞挂起 java中的 `synchronized` 和 `ReentrantLock`等独占锁 就是悲观锁的思想实现

`select ... from table for update`执行过程中所有扫描的行都会被锁上  因此在mysql用悲观锁必须确定使用了索引 而不是全表扫描,否则会把整个表锁住

#### 2 乐观锁(optimistic locking)

​	乐观锁认为对同一数据的并发操作不会总发生 属于小概率事件 不用每次都对数据上锁  但是在更新的时候会判断一下在此期间有没有人去更新数据 也就是不采用数据库自身的锁机制 而是通过程序来实现 在程序上我们采用 **版本号机制** 或者是 **CAS**机制 **乐观锁适用于多读的类型 这样可以提高吞吐量**  在 java中 `java.util.concurrent.atomic`包下原子变量类就使用了乐观锁的一种实现方式 **CAS**实现 



 **乐观锁的版本号机制**

在表中设计一个版本字段 **version** 第一次读的时候 ,会获取 **version**字段的取值 然后对数据进行更新或者删除操作 会执行 `update .... set version=version+1 where version=version` 此时如果有事务对这个数据进行了修改 修改就不会成功



**乐观锁的时间戳机制**

时间戳和版本号机制一样,也是在更新提交的时候,将当前数据的时间戳和更新之前的数据时间戳进行比较 如果两者一致则更新成功 否则就是版本冲突



注意 : 如果数据是读写分离的表 当 master表中写入的数据没有同步到 slave表中时 会造成更新一直失效的问题 此时需要强制读取 master中的数据 

#### 3 两种锁的使用场景

从这两种锁的设计思想中,总结下乐观锁和悲观锁的适用场景

 乐观锁适合读操作多的场景,相对来说写的操作比较少 它的优点在于程序实现 不存在死锁问题 不过使用场景也会相对乐观 因为它阻止不了除了程序以外的操作



悲观锁适合写操作多的场景 因为写操作具有排他性 采用悲观锁的方式 可以在数据库层面阻止其它事务对该数据库的操作权限  防止 **读-写** **写-写**冲突 

### 3.4 按加锁的方式划分 显式锁 隐式锁

#### 显式锁

​	一个事务在执行 insert操作时 如果即将插入的间隙已经被其他事务加了 gap锁 那么本次 insert操作会阻塞 并且事务会在该间隙上加上一个 插入意向锁 否则一般情况下 insert 操作是不加锁的 那么一个事务先插入了一条记录(此时并没有在内存生成与该记录关联的锁结构) 然后另一个事务:

- 立即使用 `select ... lock in share mode` 语句读取这条记录时,也就是获取这条记录的S锁 或者 使用 `select ... for update`语句读取这条记录时 也就是获取这条记录的 X锁  怎么办?

  如果允许这种情况发生,那么可能产生脏读问题

- ​

#### 隐式锁

​	

### 3.5 锁的内存结构





### 3.6 锁监控





第 10  章 多版本并发控制 
===



1 什么是MVCC
---

 MVCC(Multiversion Concurrency Control) 多版本并发控制  顾名思义 ,MVCC是通过数据行的多个版本管理来实现数据库的 **并发控制** 这项技术使得在 **InnoDB**的事务隔离级别下执行一致性读的操作有了保证,换言之,就是为了查询一些正在被事务更新的行,并且可以看到他们被更新之前的值.这样在查询的时候就不用等待另一个事务释放



MVCC没有正式的标准,在不同的DBMS中 MVCC 实现的方式可能是不同的 也不是普遍使用的 这里讲解 InnoDB中 MVCC的实现机制 (MySQL的其它存储引擎并不支持它)



2 快照读和当前读
---

MVCC在MySQL InnoDB中的实现主要是为了提高数据库的并发性能,用更好的方式去处理 **读-写冲突** 做到即使有读写冲突时,也能做到 **不加锁**  **非阻塞并发读** 而这个读指的就是快照读 而非当前读  当前读实际上是一种加锁的操作,是悲观锁的实现 而 MVCC本质是采用乐观锁的方式



### 2.1 快照读

快照读又叫一致读 读取的是快照数据 **不加锁的简单**  **select都属于快照读** 即不加锁的非阻塞读 比如这样 :

```sql
select * from player where .....
```

之所以出现快照读的情况,是基于并发性能的考虑,快照读的实现是基于 MVCC 它在很多情况下避免了加锁的操作 降低了开销



### 2.2 当前读

当前读读取的是记录的最新版本(最新数据 而不是历史版本数据) 读取时还要保证其他事务不能修改当前记录,会对读取的记录进行加锁 加锁的 `select`,或者对数据库进行增删改都会进行当前读,比如 :

```sql
## 共享锁
select * from student lock in share mode;

## 排他锁
select * from student for update;

## 排他锁
insert into student values ...

## 排他锁
delete from student where ...

## 排他锁
update student set ....
```



3 复习 
---



### 3.1 在谈隔离级别

  我们知道事务有四个隔离级别

**读未提交** --------------------------------------

**读已提交** -------------------------------------------- **脏读**

**可重复读**-------------------------------------------- **不可重复读**

**串行化** -------------------------------------------- **幻读**



在 MySQL中,默认隔离级别是可重复读 ,可以解决脏读和不可重复读的问题 如果仅从定义的角度看,它并不能解决幻读的问题 如果我们想要解决幻读问题 就需要采用串行化的方式,也就是将隔离级别提升到最高 但是这样会大幅度降低数据库事务的并发能力



MVCC 可以不采用 **锁机制** 而是通过乐观锁的方式来解决不可重复读和幻读的问题  它可以在大多数情况下替代行级锁,降低系统的开销

**读未提交** ----------------------------------(隔离线)

**读已提交** ----------------------------------- **脏读**

**可重复读** --------------------------------------------  **不可重复读和幻读**  **采用MVCC + next -key lock(临键锁)**



### 3.2 隐藏字段 Undo log 版本链

回顾一下 **Undo**日志的版本链 对于使用InnoDB存储引擎的表来说  它的聚簇索引中都包含两个必要的隐藏列

- `trx_id` 每次一个事务对某条聚簇索引记录进行改动时,都会把该事务的事务 Id 赋值给 `trx_id`隐藏列 没有主键  默认是 rowid
- `roll_pointer` 每次对某条聚簇索引记录进行改动时 都会把旧的版本写到 undo日志中,然后这个隐藏列就相当于一个指针,可以通过它来找到该记录的修改信息



比如 : 

```sql
mysql lc_konglc@192.168.10.132:konglc_base> select * from student;                                                                                                                          
+------+----------+---------+
| id   | name     | class   |
+------+----------+---------+
| 1001 | lingchao | 电气1班 |
+------+----------+---------+
1 row in set
Time: 0.009s

-- 
select * from student;

-- 
```

![未命名文件 (1)](C:\Users\ASUS\Downloads\未命名文件 (1).png)

> insert undo 只在事务回滚时启作用,当事务提交后,该类型的 undo 日志就没用了 它占用的 undo log  segment 也会被系统回收(也就是undo日志占用的undo页面链表要么被重用,要么被释放)



假设之后的两个事务 **10**  **20** 的事务对这条记录进行 **update** 操作 操作流程如下:



4  MVCC实现原理之 ReadView
---

**MVCC**的实现依赖于 **隐藏字段**  **Undo log** **Read View**



### 4.1 什么是 ReadView

在MVCC机制中,多个事务对同一个记录进行更新会产生多个历史快照,这些历史快照保存在 Undo log 历史里 如果一个事务想要查询这个记录 需要读取哪个版本的行记录呢? 这时就需要用到 **ReadView**  它帮我们解决了行的可见性问题 

**ReadView**就是事务在使用 MVCC 机制读操作时产生的读视图,当事务启动时,会生成数据库系统当前的一个快照,InnoDB为每一个事务构造了一个数组,用来记录并维护系统当前 **活跃事务**id (活跃指的是 事务启动了 但是还没有提交)



### 4.2 设计思路

使用 **Read Uncommited** 隔离级别的事务,由于可以读到未提交事务修改过的记录,所以直接读取事务的最新版本就行

使用 **Serializable**隔离级别的事务 InnoDB规定 使用加锁的方式来访问记录

使用 **Read Committed** 和 **Repeatable Read**隔离级别的事务都必须保证 **已经提交了的事务** 修改过的记录  假设另一个事务已经修改了数据 但是尚未提交 是不能直接读取最新版本的记录的 核心问题就是需要判断一下版本链中哪个版本是当前事务可见的 这是 ReadView要解决的主要问题



这个 **ReadView**主要包含4个比较重要的内容 分别如下 :

- `creator_trx_id` 创建这个 Read View 的事务id

> 说明 : 只有在对表中的记录做改动时(执行 insert  delete update 这些语句) 才会为事务分配事务id 否则在一个只读事务中的事务id值默认都为0

- `trx_ids` 表示 生成 Read View 时 当前系统中活跃的读写事务的 `事务id列表`
- `up_limit_id` 活跃事务中最小的事务id
- `low_limit_id`  表示生成 ReadView时  系统应该分配给下一个事务的id值 `low_limit_id`是系统中最大的事务id值 这里需要注意的是系统中的事务id 需要区别的是正在活跃的事务id

> 注意 : low_limit_id 并不是 trx_ids中的最大值 事务id是子增分配的 比如 :  现在有id为1 2 3 这三个事务,之后id为3的事务提交了 那么一个新的读事务在生成ReadView时,trx_ids就包括1和2 up_limit_id的值就是1 low_limit_id就是4



4.3 ReadView的规则
---

有了这个ReadView,这样在访问某条记录的时候  只需要按照下面的步骤判断记录的某个版本是否可见

- 如果被访问版本的 trx_id属性值与 readView中的 `creator_trx_id`值相同,意味着当前事务在访问着它自己修改过的记录,所以该版本可以被当前事务访问 
- 如果被访问版本的 trx_id属性值小于 ReadView中的 `up_limit_id` 值,表明生成该版本的事务在当前事务生成 ReadView前已经提交.所以该版本可以被当前事务访问
- 如果被访问版本的 trx_id属性值大于或等于 readView中的 `low_limit_id`值 表明生成该版本的事务在当前事务生成ReadView之后才开启,所以该版本不可以被当前事务访问
- 如果被访问版本的trx_od属性值在ReadView的 `up_limit_id`和 `low_limit_id`之间,那就需要判断一下 `trx_id`属性值是不是在 `trx_ids`列表中
  - 如果在,说明创建 ReadView时生成该版本的事务还是活跃的,该版本不可以被访问
  - 如果不在,说明 ReadView时生成该版本的事务已经提交,该版本可以访问



4.4 MVCC整体操作流程
---

了解了这些概念之后,我们开看一下当查询一条记录的时候系统如何通过MVCC找到它:

- 首先获取事务自己的版本号,也就是事务id
- 获取readView
- 查询得到的数据,然后与ReadView的事务版本号进行比较
- 如何不符合readView规则,就需要从Undo log中获取快照
- 最后返回符合规则的数据

如果某个版本的数据对当前事务不可见的话,那就顺着版本链找下一个版本的数据,继续按照上面的步骤判断可见性 以此类推,直到版本链中的最后一个版本,如果最后一个版本也不见的话,那么意味着该条记录对事务完全不可见,查询结果就不包含该记录



> InnoDB中 MVCC是通过  undo log + readView进行数据的读取 undo log保存了历史快照 而readView规则帮我们判断当前版本的数据是否可见 



在隔离级别为读已提交 (Read committed)时 一个事务中的 **select**查询都会重新获取一次 readView 

如表所示:

|                  事务                  |      说明      |
| :----------------------------------: | :----------: |
|                begin;                |              |
| select * from stundent where id > 1; | 获取一次ReadView |
|                  ……                  |              |
| select * from student where id > 2;  | 获取一次ReadView |
|               commit;                |              |



> 注意 : 此时同样是查询语句都会重新获取一次ReadView 这时如果ReadView不同,就可能产生不可重复读或者幻读的情况



当隔离级别为 可重复读时,就避免了不可重复读这时因为一个事务在第一次select的时候获取一次 ReadView 而后面所有的 select 都会复用这个ReadView  如下图所示:

|                事务                |      说明       |
| :------------------------------: | :-----------: |
|              begin;              |               |
| select * from user where id > 2; | 只获取一次ReadView |
|                                  | 只获取一次ReadView |
|                                  |               |
|             commit;              |               |





5 举例说明
---

假设现在 student表只有一条由事务id为 8的事务插入一条记录:

**MVCC** 只能在 `Read committed` `repeatable read`两个隔离级别下工作 接下来看一下 `read committed` `repeatable read`所谓的生成的 `ReadView`的不同时机到底不同在哪里



### 5.1 **Read Committed** 隔离级别下

**Read Committed** : 每次读取数据前都生成一个 **ReadView**

```sql
mysql lc_konglc@192.168.10.132:konglc_base> select * from student;                                                                                                                                                                      
+------+----------+---------+
| id   | name     | class   |
+------+----------+---------+
| 1001 | lingchao | 电气1班 |
+------+----------+---------+
```



现在有两个事务 id 分别为 10 20 的事务正在执行

```sql
## transaction_id : 10
begin;update student set name='chaochao' where id = 1001;update student set name='xiaochaochao' where id=1001; 
 

## transaction_id : 20
begin;
-- 更新了其他的表
```



有一个事务在 `read committed`隔离级别执行

```sql
set session transaction isolation level read committed;
## 得到的值为 lingchao
mysql lc_konglc@192.168.10.132:konglc_base> begin;select * from student where id=1001;                                                                                                                                             
Query OK, 0 rows affected
Time: 0.001s

+------+----------+---------+
| id   | name     | class   |
+------+----------+---------+
| 1001 | lingchao | 电气1班 |
+------+----------+---------+
```



这个select的执行过程如下:

- 在执行select时会生成一个ReadView ReadView的 `trx_ids`列表的内容就是 [10,20] `up_limit_id`为10 `low_limit_id`为21 `creator_trx_id`为0
- 从版本链中挑选可见的记录,从图中看出,最新版本列的name的内容是 `xiaochaochao` 该版本的 `trx_id`值为 10 在 `trx_ids`列表内,s所以不符合可见性的要求 根据roll_pointer调到下一个版本
- 下一个版本的name的内容是 chaochao 该版本的 `trx_id`值也为10,也在 `trx_ids`列表内,所以不符合要求,继续调到下一个版本
- 下一个版本的name列的内容是 `lingchao` 该版本的 `trx_id`的值是8 小于 `readView`中的 `up_limit_id`值10 所以这个版本是符合要求的 最后返回给用户的版本就是 `name`为 `lingchao` 的列



### 5.2 在  `repeatable read`隔离级别下

使用 `Repeatable-read`隔离级别的事务来说,只会在第一次执行查询语句时生成 `Read View`之后查询就不会重复生成了

比如系统里 两个事务id分别为 10 20 的事务在执行

```sql
## trx_id : 10
mysql lc_konglc@192.168.10.132:konglc_base> begin;update student set name='chaozi' where id=1;                                                                                                                                             
Query OK, 0 rows affected
Time: 0.001s

## trx_id 20
begin;
-- 更新了一些别的表的记录

```



开启事务查询该条数据

```sql
 ## 设置事务的隔离级别为可重复读
 set session transaction isolation level repeatable read; 
 begin;select * from student where id=1001;
```





第 11 章 MySQL主从复制
===



11.1 主从复制概述
---

### 1. 如何提升数据库的并发能力

​	在实际工作中,我们常常将Redis作为缓存与mysql配合使用,当有请求的时候,首先会从缓从中进行查找,如果存在就直接取出,如果不存就再访问数据库,这样就 **提升可读取的效率** 也减少了对后端数据库的访问压力, Redis缓存架构是高并架构中非常重要的一环



此外,一般应用对数据库而言,都是 **读多写少**  也就是说对数据库的读取压力比较大,有一种思路就是采用数据库集群的方案, 做 **主从架构**

进行 **读写分离**  这样同样可以提升数据库的并发能力,但并不是所有应用都需要对数据库进行主从架构的设置,毕竟架构设置本身是有成本的



如果我们的目的在于提升数据库的高并发访问效率,那么首先考虑的是如何 **优化SQL和索引** 这种方式简单有效;其次才是采用缓存策略,比如使用Redis将数据保存在内存数据库中,提升读取的效率,最后才是对数据库采用主从架构,进行读写分离



按照上面的方式进行优化,使用和维护的成本是由低到高的



### 2 主从复制的作用

主从同步设计不仅可以提高数据库的吞吐量 还有以下三个方面的作用:

​	**第1个作用 : 读写分离**  我们可以通过主从同步的方式,然后通过数据库提高数据库的并发处理能力

​	其中一个库是 **master主库** 负责写入数据,我们称之为写库

​	其他都是slave从库,负责读取数据,我们称之为读库

​	当主库进行更新的时候,会自动将数据复制到从库中,而我们在客户端读取数据的时候,会从从库进行读取

​	面对 **读多写少**的需求,采用读写分离的方式 可以实现更高的并发访问 同时还能对服务器进行负载均衡,让不同的请求按照策略均匀的发到不同的从服务器上,让读取更加顺畅 读取顺畅的另一个原因,就是减少了锁表的影响,比如我们让主库负责写,当主库出现写锁的时候,不会影响到从库 进行 select的读取

​	**第2个作用 进行数据库备份** 我们通过主从复制将主库上的数据复制到从库上,相当于是一种热备份机制,也就是在主库正常运行的情况下进行的备份,不会影响到服务



​	**第3个作用是具有高可用性 :** 数据库备份实际上是一种冗余机制,通过这种冗余机制可以换取数据库的高可用,也就是当数据库出现故障和宕机的情况下,可以切换到从服务器上,保证服务的正常运行



关于高可用性的程度,我们可以用一个指标衡量,即正常可用时间/全年时间



实际上更高的高可用性,意味着需要付出更高的成本代价,在实际中,我们需要集合业务需求和成本来进行选择



2 主从复制的原理
---

**Slave**会从 **Master**来进行数据同步

### 2.1 原理剖析

**三个线程**

**二进制日志转储线程** (Bin log dump thread) 是一个主库线程,当从库线程连接的时候,主库可以将二进制日志发送给从库,当主库读取事件的时候,会在 binlog上加锁,读取完成之后,再将锁释放掉 



**从库IO线程会连接到主库** 向主库发送请求 更新binlog  这时从库的IO线程就可以读取到二进制日志转储线程发送的 binlog更新的部分 并拷贝到本地的中继日志 (relay log)



**从库SQL线程** 会读取从库中的中继日志,并且执行日志中的事件,将从库中的数据与主库保持同步

![未命名文件 (3)](C:\Users\ASUS\Downloads\未命名文件 (3).png)

![image-20220403235636728](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220403235636728.png)

**复制三步骤**

**步骤1 :  ** **mater**将操作记录到二进制日志( `binlog`) 这些记录叫做 **二进制日志事件**(bin log evnent)

**步骤2 : ** `slave`将 `master`的 bin log evnents拷贝到它的中继日志 `relay log`

**步骤3 : ** `slave`重做日志中的事件,将改变应用到自己的数据中 **MySQL**复制是异步且串行化的,而且复制后从接入点 开始复制



**复制的问题**

复制的最大问题 :  延时问题



3 一主一从架构
---





4  同步数据一致性问题
---



5 总结
---





MySQL查看存储过和函数
===



查看存储过程和函数的状态
---



```sql
show procedure|function status like '% %'
```





语法格式 `show create procedure procedure_name \G `

```sql
show create procedure insert_class \G

Procedure            | insert_class
sql_mode             | ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION
Create Procedure     | CREATE DEFINER=`lc_konglc`@`%` PROCEDURE `insert_class`(  max_num INT )
BEGIN  
DECLARE i INT DEFAULT 0;   
 SET autocommit = 0;    
 REPEAT  
 SET i = i + 1;  
 INSERT INTO class ( classname,address,monitor ) VALUES (rand_string(8),rand_string(10),rand_num(1,100000));  
 UNTIL i = max_num  
 END REPEAT;  
 COMMIT; 
END
character_set_client | utf8mb3
collation_connection | utf8_general_ci
Database Collation   | utf8mb4_0900_ai_ci
```





```sql
delimiter  |
DROP EVENT IF EXISTS `ras`.ras_checkpoint;
CREATE EVENT IF NOT EXISTS `ras`.ras_checkpoint
ON SCHEDULE
   EVERY 1 DAY STARTS DATE_ADD(DATE_ADD(CURDATE(), INTERVAL 1 DAY), INTERVAL 2 HOUR)
ON COMPLETION PRESERVE ENABLE
DO
begin
    SELECT GET_LOCK("RAS_CHECKPOINT", 50);
    SELECT ras_CheckPoint("RasCheckPoint",1);
    SELECT RELEASE_LOCK("RAS_CHECKPOINT");
end |
delimiter ;
```



第 12 章 其他数据库日志
===



1 MySQL支持的日志
---

### 1.1  日志的类型

MySQL有不同日志文件,用来存储不同类型的日志 分为  二进制日志 错误日志  通用查询日志  慢查询日志

mysql8又新增两种支持的日志 : 中继日志 数据定义语句日志 使用这些日志文件 可以查看mysql内部发生的事情



这6类日志分为 :

**慢查询日志** : 记录所有执行时间超过 `long_query_time`的所有查询 方便我们对查询进行优化 

**通用查询日志**   : 所有所有连接的起始时间和终止时间 以及连接发送给数据库服务器的所有指令 对我们复原操作的实际场景 发现问题 甚至对数据库的审计操作都有很多的帮助

**错误日志** : 记录mysql服务启动 运行或停止 mysql服务时出现的问题 方便我们了解服务器的状态 从而对服务器进行维护

**二进制日志** 记录所有更改数据的语句 可以用于主从服务器之间的数据同步  以及服务器遇到故障时数据的无损失恢复

**中继日志** 用于主从服务器架构中 从服务器用来存放主服务器二进制内容的一个中间文件 从服务器通过读取中继日志的内容 来同主服务器上的操作

**数据定义语句日志** 记录数据定义语句执行的元数据操作

除了二进制日志外 其他日志都是文本文件 所有的日志创建于mysql数据日志中



### mysql日志的弊端

​	日志功能会降低 mysql数据库的性能 例如在查询非常频繁的mysql数据库系统中 如果开启了通用查询日志和慢查询日志 mysql数据库会花费很多的时间记录日志

​	日志会占用大量的磁盘空间 对于用户量非常大 操作非常频繁的数据库 日志文件需要的存储空间设置比数据文件需要的存储空间还要大

2   慢查询日志
---





3 通用查询日志(general query log)
---

**记录用户所有的操作**



### 查看当前状态

```sql
show  variables like '%general%';
```



```shell
mysql> show variables like '%general%'; 
+------------------+-------------------------+
| Variable_name    | Value                   |
+------------------+-------------------------+
| general_log      | OFF                     |
| general_log_file | /var/lib/mysql/chao.log |
+------------------+-------------------------+
```



### 启动日志

永久性方式

修改配置文件

```shell
[mysqld]
general_log=on
general_log_file=[path][filename]
```

临时方式

```sql
-- 开启通用查询日志
set global general_log=on;
set global general_log_file='path/filename';
```



刷新 删除日志

手动删除文件

```sql
show variables like '%general_log%';
```



4 错误日志
---

```sql
show variables like '%log_err%';
```



5 二进制日志(bin_log)
---

`bin_log`是 mysql中比较重要的日志 在日常开发中经常会遇到 

bin_log 即 binary_log 二进制日志文件 也叫多变更日志(update log) 它记录了数据库所有执行的 `DDL` 和 `DML`等数据库更新事件的语句但是不包含没有任何修改的语句(如数据库的查询语句 select show) 

它以**事件**的形式 记录并保存在 二进制文件中 通过这些信息 我们可以再现数据更新操作的全过程

> 如果想要记录所有的语句 需要使用通用查询日志



binlog主要应用场景 :

​	一是 用于  **数据恢复** 如果 mysql数据库意味停止 可以通过二进制日志文件查看用户执行了哪些操作 对数据库服务器文件做了哪些修改 然后根二进制日志文件中的记录恢复数据库服务器

​	二是 **数据复制** 由于日志的延续性和时效性  master把它的二进制日志传递给 slaves来达到 master-slave数据一致的目的

​	可以说  mysql数据库的数据备份 主备 主主 主从 都离不开 binlog 需要依靠 binlog来同步数据 保证数据的一致

### 5.1 查看默认情况

```sql
mysql> show variables like '%log_bin%';
+---------------------------------+---------------------------------+
| Variable_name                   | Value                           |
+---------------------------------+---------------------------------+
| log_bin                         | ON                              |
| log_bin_basename                | /var/log/mysql/master-bin       |
| log_bin_index                   | /var/log/mysql/master-bin.index |
| log_bin_trust_function_creators | OFF                             |
| log_bin_use_v1_row_events       | OFF                             |
| sql_log_bin                     | ON                              |
+---------------------------------+---------------------------------+
```



查看二进制文件

```sql
mysql> show binary logs;
+-------------------+-----------+-----------+
| Log_name          | File_size | Encrypted |
+-------------------+-----------+-----------+
| master-bin.041209 |       156 | No        |
| master-bin.041210 |       156 | No        |
| master-bin.041211 |       204 | No        |
| master-bin.041212 |       156 | No        |
| master-bin.041213 |       156 | No        |
| master-bin.041214 |       156 | No        |
| master-bin.041215 |       156 | No        |
| master-bin.041216 |       583 | No        |
+-------------------+-----------+-----------+
```



所有数据库的修改都会记录在 binglog中 但是  binlog是二进制文件 无法直接查看 想要更直观的观测它就需要借助 `mysqlbinlog`命令工具 指令如下 : 

```sql
mysqlbinlog  master-bin.041214
```



binlog 二进制文件恢复数据

```sql
-- 根据时间节点恢复数据
mysqlbinlog --start-datetime="2021-06-10 15:56:00" --stop-datetime="2021-06-10 15:59:00" -d [数据库名] [binlog文件]|mysql -uroot -p1234 [数据库名]

--  根据pos节点恢复数据
mysqlbinlog  --start-position=154 --stop-position=4326 -d [数据库名] [binlog文件]|mysql -uroot -p1234 [数据库名]


show binary logs;

show binlog events in 'master-bin.041217';

 mysqlbinlog  --start-position=3019 --stop-position=3675 -d konglc_test master-bin.041217|mysql -ulc_konglc -p konglc_test  
```



```shell
#!/bin/bash

###


```



```sql
select  * from  
```



```c++

```







