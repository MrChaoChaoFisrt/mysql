mysql查看锁
===

```sql
## 查询是否锁表
show open tables where In_use > 0;

## 查看MySQL所有进程 
show processlist; 
show full processlist;
 
## 杀掉指定mysql连接的进程号
kill 31; 

## 查看服务器状态
show status like '%lock%';

## 查看超时时间：
show variables like '%timeout%';
```



mysql正则表达式
---

```sql
-- 匹配以a开头
select 'abc' REGEXP '^a' as word;-- 1
-- 匹配以c结尾
SELECT 'abc' REGEXP 'c$'; -- 1
SELECT 'abc' REGEXP 'A$'; -- 0

-- .匹配任意单个字符
SELECT 'abc' regexp '.c';-- 1
SELECT 'abc' regexp '.d';-- 0
SELECT 'abc' regexp '.cd';-- 0

-- [...] 匹配任意单个括号内的字符 
select 'abc' REGEXP '[a]'; -- 1
select 'abc' REGEXP '[ab]'; -- 1
select 'abc' REGEXP '[ab]'; -- 1
select 'abc' REGEXP '[cav]'; -- 1

select INSTR('konglingchao','hao');-- 10
```

![image-20220215180031857](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220215180031857.png)





mysql 索引
===

索引的分类

索引是存储引擎用来快速查看记录的一种数据结构,按照实现的方式来分,可以分为 hash索引 和 B+树

按照功能划分

![image-20211223225900687](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211223225900687.png)

1 单列索引 - 普通索引
---

1. 单列索引

   一个索引只包含一个列 但一个表可以有多个单列索引;

2. 普通索引 MYSQL中基本索引类型,没有什么限制 允许在定义的索引的列中插入重复值和空值,纯粹为了查询数据更快一些

```sql
## 创建表的时候直接指定索引
create table if not exists student(
    s_id int primary key,
    s_name varchar(50),
    s_gengder varchar(20),
    s_age int,
    s_birth date,
    s_serial_number varchar(20),
    s_score double,
    index index_name (s_name) ## 指定索引
);

## 使用alter修改表结构 添加索引
alter table student add index index_age(s_age);

## 创建索引
create index index_score on student(s_score);

## 显示索引
select * from mysql.innodb_index_stats t where t.database_name = 'konglc_test' and t.table_name = 'student';


## 删除索引
alter table student drop index index_score;

## 显示索引
show index from student;
```

2 单列索引 - 唯一索引
---

唯一索引和前面的普通索引一样 不同点是 : 索引列的值必须唯一 但允许有空值 如果是组合索引 则列值的组合必须唯一

它有以下几种创建方式

```sql
 ## 唯一索引
 ## 1 在创建表的时候就创建索引
drop table if exists student;
create table if not exists student(
    s_id int primary key,
    s_name varchar(50),
    s_gengder varchar(20),
    s_age int,
    s_birth date,
    s_serial_number varchar(20),
    s_score double,
    unique index index_id (s_id) ## 指定索引
);

## 2 直接创建
alter table student drop index  index_id;
create unique index index_id on student(s_id);

## 3 修改表结构 添加索引
alter table student drop index index_id;
alter table student add unique index_id(s_id);

alter table student add unique  index_name(s_name);

## 显示索引
show index from student;
```

![image-20211223233650645](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211223233650645.png)

3 单列索引 - 主键索引
---

每张表一般都会有自己的主键 当我们在创建表的时 mysql会自动的在主键上建立一个索引 这就是主键索引 主键是唯一的并且不能为null,所以它是一种唯一的索引

4 组合索引 
---

​	组合索引也叫复合索引 是指我们在创建索引的时候使用多个字段

​	复合索引的使用符合最左原则

```sql
## 修改列名
alter table student change column s_gengder  s_gender varchar(20);

## 创建复合索引
create index index_comp on student(s_id,s_name,s_gender);

## 显示IO状态 (每隔10s显示一次)
iostat -c 10
```

mysql存储过程
===

什么是存储过程
---

​	从mysql5.0开始支持存储过程

​	简单的说,存储过程就是一组sql语句集 功能强大,可以实现一些比较复杂的逻辑功能,类似于java语言中的方法

​	存储过程就是数据库SQL语言层面的代码封装与重用

存储过程的特性
---

​	有输入输出参数,可以声明变量 有 if/else case while等语句,通过编写存储过程,可以实现复杂的逻辑功能

​	函数的普遍特性: 模块化 封装 代码复用

​	速度快,只有首次执行 需要经过编译和优化,后续被调用可以直接执行,省去以上步骤

```sql
delimiter 自定义的结束符号
create procedure procedure_name([in out inout]param_name,param_type...)
begin
	sql_statement;
end 自定义的结束符号
delimiter;
```

```sql
delimiter $$
create procedure p_asp_first()
begin
	select acct_name  from t_acct;
end $$ 
delimiter
-- 调用存储过程
call p_asp_first();
```

mysql操作 变量定义
---

局部变量

用户自定义 在begin/end语句块中有用

```sql
语法 声明变量 declare var_name type [default var_value]
declare nickName varchar(32) default 'konglc';
```

```sql
delimiter ;;
create procedure p_asp_proc2()
begin
	## 声明局部变量
	declare v_name varchar(20) default 'chaochao';
	## 设置局部变量的值
	set v_name = 'chengdu';
	## 输出局部变量
	select v_name;
end ;;
delimiter

call p_asp_proc2();
```

mysql操作变量定义
---

```sql
用户自定义
语法:
	@var_name
	不需要提前声明 使用即声明
	
	
```



mysql事务
===

事务基本介绍
---

事务可以用来维护数据库的完整性,保证成批的`SQL`要么全部执行,要么全部不执行

事务用来管理 `DDL` `DML` `DCL`操作 比如 `update delete insert`语句 默认是自动提交的

```sql
 ## 修改root用户密码
 alter user 'root'@localhost identified with mysql_native_password by 'klcysu2021';
```

mysql事务操作主要有以下三种

1 . 开启事务 : start transaction

​	任何一条`DML`语句(insert update delete) 执行 标志事务的开始

​	命令 begin 或 start transaction

2 提交事务 commit transaction

​	成功的结束将所有的DML语句操作历史记录和底层硬盘数据来一次同步

​	命令 : commit

3 回滚事务 rollback transaction

​	失败的结束 将所有的DML语句操作历史记录全部清空

​	命令 : rollback

```sql
## 以下设置仅对当前客户端有效
## 查看自动提交
select @@autocommit;
show variables like '%autocommit%';
set autocommit=0;## 禁止自动提交事务
set autocommit=1;## 开启自动提交

## 设置永久手动提交事务
## 配置文件  /etc/mysql/mysql.conf.d/mysqld.cnf
autocommit=0
修改完成之后 重启mysql服务
sudo service mysql restart
```

事务的特性
---

![image-20211226001245849](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211226001245849.png)

事务的隔离性
---

如果事务正在操作的数据别另外一个事务修改或删除.最后的执行结果可能无法达到预期,如果没有隔离性还会导致其它问题

![image-20211226002209471](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211226002209471.png)

​		

​	

### 事务的隔离级别

​	**读未提交(read uncommited)**

​	一个事务可以读取另一个事务未提交的数据,最低级别,任何情况都无法保证,会造成脏读

​	**读已提交(read commited)**

​	一个事务要等另外一个事务提交后才能读取数据 可避免脏读的发生 会造成不可重复读

​	**可重复读(repeatable read)**

​	在开始读取数据时(事务开启),不再允许修改操作,可避免脏读,不可重复读的发生 但是会造成幻读

​	**串行(serializable)**

​	是最高的事务级别,在该级别下,事务串行化顺序执行,可避免脏读 不可重复读与幻读,但是这种事务隔离级别效率低下比较消耗数据库性能,一般不使用

**mysql默认的隔离级别是可重复读(repeatable read)**

|            事务的隔离级别            | 脏读 | 不可重复读 | 幻读 |
| :----------------------------------: | ---- | :--------: | :--: |
|      读未提交(read uncommitted)      | 是   |     是     |  是  |
| 读已提交(read committed)(Oracle默认) | 否   |     是     |  是  |
|      可重复读(repeatable read)       | 否   |     否     |  是  |
|          串行(serializable)          | 否   |     否     |  否  |

查看隔离级别

```sql
show variables like '%isola%';
```

![image-20211226003819809](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211226003819809.png)

```sql
## 设置事务的隔离级别(仅仅针对当前会话) 这种隔离级别会引起脏读 A事务会读取到B事务未提交的数据
set session transaction isolation level read uncommitted;
## 会造成不可重复读 事务提交前后提交后读取到的数据不一致
set session transaction isolation level read committed;
## 
set session transaction isolation level repeatable read;
```

mysql参数

```tex
sync_binlog
该参数的有效值为0 、1、N：
设置为0：默认值。事务提交后，将二进制日志从缓冲写入磁盘，但是不进行刷新操作（fsync()），此时只是写入了操作系统缓冲，若操作系统宕机则会丢失部分二进制日志。
设置为1：事务提交后，将二进制文件写入磁盘并立即执行刷新操作，相当于是同步写入磁盘，不经过操作系统的缓存。
设置为N：每写N次操作系统缓冲就执行一次刷新操作。
将这个参数设为1以上的数值会提高数据库的性能，但同时会伴随数据丢失的风险。
```

mysql锁机制
===

概述
---

对数据的操作粒度分

表锁 : 操作时 会锁定整个表

行锁 : 操作时 会锁定当前操作行

从数据的操作类型分

读锁(共享锁) 针对同一份数据多个读操作可以同时进行而互不相影响

写锁(排他锁) 当操作没有完成之前 会阻断其他写锁和读锁

存储引擎
---

各种存储引擎对锁的支持情况

| 存储引擎 | 表级锁 | 行级锁 |
| -------- | ------ | ------ |
| MyISAM   | 支持   | 不支持 |
| InnoDB   | 支持   | 支持   |

mysql锁的特性可大致归纳如下

| 锁类型 | 特点                                                         |
| ------ | ------------------------------------------------------------ |
| 表级锁 | 偏向MyISAM存储引擎,开销小,加锁快 不会出现死锁 锁定粒度大 发生锁冲突的概率高 并发度低 |
| 行级锁 | 偏向InnoDB存储引擎,开销大 加锁慢 会出现死锁,会出现死锁锁定粒度最小,发生锁冲突的概率最低 并发度也最高 |
|        |                                                              |

从上述特点可见,很难笼统的说哪种锁更好 只能就具体的应用特点来说哪种锁更合适 仅从锁的角度来说 表级锁更适合以查询为主 只有少量按索引条件更新数据的应用 如 web应用

而行级锁更适用于大量按索引条件并发更新少量不同的数据 同时又有并查询的应用 如一些在线事务处理系统(OLTP)

如何加表锁

MyISAM在执行查询语句(select)前,会自动给涉及的表加读锁,在执行更新操作(update insert delete)前 会自动给涉及的表加写锁 这个过程并不需要用户干预 因此用户一般不需要直接使用lock table命令给MyIsam表显式加锁

```sql
## 加读锁
lock table table_name read;
## 加写锁
lock table table_name write;

## 加读锁
lock table t_acct_myisam read;
select * from t_acct_myisam;

## 加了读锁之后 不能写
## 报错如下 :
## ERROR 1099 (HY000): Table 't_acct_myisam' was locked with a READ lock and can't be updated
update t_acct_myisam set acct_balance=10000 where acct_id = 1;
##对该表加了锁 不能查询其他没有加读锁的表
##报错如下:
## ERROR 1100 (HY000): Table 't_acct' was not locked with LOCK TABLES
select * from t_acct;
## 还可以对其他表
lock table t_acct read;
## 加了锁之后 可以对其他表进行读
select * from t_acct;
## 解锁
unlock tables;


## 写锁 是独占锁 其他会话不能再加锁了
lock table t_acct_myisam write;
## 对当前会话来说 当前表是没有被锁住的
## 但对其他会话来说 这个表就是被锁住的
show open tables where in_use>1;

## 加了写锁之后  依然是可以读的 其他的会话是不可以查询的
select * from t_acct_myisam;
## 其它会话不能写
insert into t_acct_myisam(acct_name,acct_balance) values('紫梦',10000); 
unlock tables;
```

	InnoDB行锁

---

​	行锁的特点 偏向InnDB存储引擎 开销大 加锁慢 会出现死锁 锁定粒度最小 发生锁冲突的概率最低 并发度也最高

​	InnoDB和MyISAM的最大不同有两点 : 一是支持事务 二是采用了行锁

​	行锁模式

​	InnoDB实现了两种类型的行锁 

​	共享锁(S) 又称为读锁 共享锁就是多个事务对同一数据可以共享一把锁 都能访问到数据 但是只能读 不能修改

​	排他锁 又称为写锁 排他锁就是不能与其他锁并存 如果一个事务获取了一个数据行的排他锁 其他事务就不能获取该行的其它锁 包括共享锁和排它锁  但是获取排他锁的事务是可以对数据行进行读取和修改

​	

对于 update delete insert 语句 InnoDB会自动的给涉及的数据加排它锁

对于普通的select语句  InnoDB不会加任何锁

mysql日志
===

在任何一种数据库中,都会有各种各样的日志 记录这数据工作的方方面面,以帮助数据库管理员追踪数据库曾今发生过的各种事件,mysql也不例外



日志的分类
---

​	**错误日志**

​	**二进制日志**

​	**查询日志**

​	**慢查询日志**

错误日志
---

错误日志是mysql中最重要的日志之一 它记录了当mysqld启动和停止时 以及服务器在运行过程中发生任何严重错误时的相关信息 当数据库出现任何故障 无法使用时 可以首先查看此日志

查看错误日志位置的指令

```sql
mysql> show variables like 'log_err%';
+----------------------------+----------------------------------------+
| Variable_name              | Value                                  |
+----------------------------+----------------------------------------+
| log_error                  | /var/log/mysql/error.log               |
| log_error_services         | log_filter_internal; log_sink_internal |
| log_error_suppression_list |                                        |
| log_error_verbosity        | 2                                      |
+----------------------------+----------------------------------------+
```

二进制日志
---

二进制日志 binlog记录了所有DDL(数据库定义语言)语句 和DML(数据库操纵语言)语句 但是不包括数据查询语句此日志对于灾难时数据恢复起着极其重要的作用,mysql的主从复制就是通过该binlog实现的

```shell
## 二进制日志 日志的前缀 master-bin
log_bin                 = /var/log/mysql/master-bin.log
## 二进制日志的格式 
binlog_format=row

chaochao@chaochao:/var/log/mysql$ ls -lrt
总用量 904
-rw-r----- 1 mysql adm   755207 11月 26 08:53 error.log.5.gz
-rw-r----- 1 mysql mysql    179 12月 22 22:46 mysql-bin.000001
-rw-r----- 1 mysql mysql    179 12月 22 22:48 mysql-bin.000002
-rw-r----- 1 mysql mysql    179 12月 22 22:48 mysql-bin.000003
-rw-r----- 1 mysql mysql    179 12月 22 23:44 mysql-bin.000004
-rw-r----- 1 mysql mysql    179 12月 22 23:46 mysql-bin.000005
-rw-r----- 1 mysql mysql    192 12月 22 23:46 mysql-bin.index
```

日志的格式

​	statement : 该日志文件格式在日志中记录的都是sql语句(statement)每一条对数据进行修改的sql都会记录在日志文件中,通过mysql提供的mysqlbinlog工具 可以清晰的查看到每条语句的文本.主从复制的时候,从库会将日志解析为原文本,并在从库重新执行一次

​	row : 该日志格式在日志文件中记录的是每一行的数据变更,而不是记录sql语句 比如执行sql语句 update t_acct set acct_balance=1000  如果是statement日志格式  在日志文件中会记录一行sql文件 如果是row 由于是对全表进行更新,

也就是每一行数据都会发生变更 row格式的日志文件中会记录每一行数据的变更

​	mixed : 混合了statement和row两种格式

```sql
## 查看mysql是否开启了bin日志
mysql> show variables like 'log_bin';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| log_bin       | ON    |
+---------------+-------+
mysql> -- 查看日志的格式
mysql> show variables like 'binlog_format';
+---------------+-------+
| Variable_name | Value |
+---------------+-------+
| binlog_format | ROW   |
+---------------+-------+
1 row in set (0.00 sec)


-- 查看最新的日志
show master status;

-- 查询指定的binlog日志
show binlog events in 'master-bin.000010';
```

查询日志
---

查询日志记录了客户端所有的查询操作语句 而二进制日志不包含查询数据的sql语句

默认情况下 查询日志是未开启的 如果需要开启查询日志 需要配置如下

```sql
## 查看查询日志
mysql> show variables like '%general%';
+------------------+---------------------------+
| Variable_name    | Value                     |
+------------------+---------------------------+
| general_log      | OFF                       |
| general_log_file | /var/lib/mysql/MrChao.log |
+------------------+---------------------------+
## 查询日志是否开启
general_log 

## 查询日志的文件名
general_log_file

general_log_file        = /var/log/mysql/query.log
## 开启查询日志
general_log             = 1 


mysql> show variables like '%general%';
+------------------+--------------------------+
| Variable_name    | Value                    |
+------------------+--------------------------+
| general_log      | ON                       |
| general_log_file | /var/log/mysql/query.log |
+------------------+--------------------------+


## 查看查询日志
sudo tail -100f query.log 
/usr/sbin/mysqld, Version: 8.0.27-0ubuntu0.20.04.1 ((Ubuntu)). started with:
Tcp port: 12666  Unix socket: /var/run/mysqld/mysqld.sock
Time                 Id Command    Argument
2021-12-26T09:31:32.930721Z         8 Connect   lc_konglc@chaochao on konglc_test using SSL/TLS
2021-12-26T09:31:32.932641Z         8 Query     show databases
2021-12-26T09:31:32.936942Z         8 Query     show tables
2021-12-26T09:31:32.940322Z         8 Field List        article 
2021-12-26T09:31:32.947119Z         8 Field List        book 
2021-12-26T09:31:32.950148Z         8 Field List        class 
2021-12-26T09:31:32.952839Z         8 Field List        staffs 
2021-12-26T09:31:32.954974Z         8 Field List        student 
2021-12-26T09:31:32.956430Z         8 Field List        t_acct 
2021-12-26T09:31:32.958590Z         8 Field List        t_acct_myisam 
2021-12-26T09:31:32.959953Z         8 Field List        t_dept 
2021-12-26T09:31:32.962170Z         8 Field List        t_employee 
2021-12-26T09:31:32.962865Z         8 Field List        t_user 
2021-12-26T09:31:32.963922Z         8 Field List        tab_a 
2021-12-26T09:31:32.966283Z         8 Field List        tbl_dept 
2021-12-26T09:31:32.969355Z         8 Field List        tbl_dept_bak 
2021-12-26T09:31:32.970397Z         8 Field List        tbl_emp 
2021-12-26T09:31:32.970874Z         8 Field List        tmp_tab_float 
2021-12-26T09:31:32.971837Z         8 Field List        tmp_tint 
2021-12-26T09:31:32.972839Z         8 Query     select @@version_comment limit 1
2021-12-26T09:31:34.770546Z         8 Query     show variables like '%general%'
2021-12-26T09:32:09.714112Z         9 Connect   lc_konglc@192.168.10.133 on  using TCP/IP
2021-12-26T09:32:09.714772Z         9 Query     SET NAMES utf8mb4
2021-12-26T09:32:09.715523Z         9 Query     SELECT UNIX_TIMESTAMP()
2021-12-26T09:32:09.716147Z         9 Query     SELECT @@GLOBAL.SERVER_ID
2021-12-26T09:32:09.716678Z         9 Query     SET @master_heartbeat_period = 30000001024, @source_heartbeat_period = 30000001024
2021-12-26T09:32:09.717109Z         9 Query     SET @master_binlog_checksum = @@global.binlog_checksum, @source_binlog_checksum = @@global.binlog_checksum
2021-12-26T09:32:09.717580Z         9 Query     SELECT @source_binlog_checksum
2021-12-26T09:32:09.718007Z         9 Query     SELECT @@GLOBAL.GTID_MODE
2021-12-26T09:32:09.718375Z         9 Query     SELECT @@GLOBAL.SERVER_UUID
2021-12-26T09:32:09.718784Z         9 Query     SET @slave_uuid = 'f8c09b6f-6342-11ec-9e68-000c2943eee1', @replica_uuid = 'f8c09b6f-6342-11ec-9e68-000c2943eee1'
2021-12-26T09:32:09.719417Z         9 Binlog Dump       Log: 'master-bin.000023'  Pos: 156
2021-12-26T09:32:16.772235Z        10 Connect   lc_konglc@192.168.10.1 on konglc_test using TCP/IP
2021-12-26T09:32:16.773389Z        10 Query     SET NAMES utf8
2021-12-26T09:32:16.774898Z        10 Query     use `konglc_test`
2021-12-26T09:32:16.778704Z        10 Query     show tables
2021-12-26T09:32:27.442203Z        10 Query     select * from book LIMIT 0, 1000
```

慢查询日志
---

                ```sql
                ## 开启慢查询日志
                slow_query_log          = 1
                ## 慢查询日志位置
                slow_query_log_file     = /var/log/mysql/mysql-slow.log
                ## 慢查询时间 超过2s就算慢查询
                long_query_time = 2


​                
​                ## 查看慢查询日志的开启状态
​                show variables like 'slow_query_log';
​                ## 开启慢查询日志
​                set slow_query_log=1;
​                ## 慢查询日志文件
​                show variables like 'slow_query_log_file';
​                mysql> show variables like 'slow_%';
​                +---------------------+-------------------------------+
​                | Variable_name       | Value                         |
​                +---------------------+-------------------------------+
​                | slow_launch_time    | 2                             |
​                | slow_query_log      | ON                            |
​                | slow_query_log_file | /var/log/mysql/mysql-slow.log |
​                +---------------------+-------------------------------+
​                
​                select sleep(2);
​                ```

![image-20211226213419333](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211226213419333.png)

mysql的优化
===

在应用的开发过程中,由于初期数据量小,开发人员写sql语句时,更注重功能上的实现,但是当应用系统正式上线后,随着生产数据量的急剧增长,很多SQL语句开始逐渐显露出性能问题,对生产的影响也越来越大.此时这些有问题的sql语句就会整个系统性能的瓶颈,因此我们必须要对它们进行优化

mysql优化的方式有很多,大致我们可以从以下几点来进行优化:

​	从设计上优化

​	从查询上优化

​	从索引上优化

​	从存储上优化

	查看sql的执行频率

---

​		MySQL客户端连接成功之后,通过`show session|global status`命令可以查看服务器状态信息,通过查看状态信息可以查看对当前数据库的主要操作类型

```sql
## 查看当前会话的统计结果
show session status like 'Com_______';

## 查看数据库自上次启动至今的统计结果
show global status like 'Com_______';

## 查看针对InnoDB引擎的统计结果
show status like 'Innodb_rows_%';
```

​		![image-20211226214733779](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211226214733779.png)

​		![image-20211226214808376](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211226214808376.png)

	定位低效率执行的sql

---

​		慢查询日志

```sql
## 慢查询日志的时间
mysql> show variables like 'long_query_time';
+-----------------+----------+
| Variable_name   | Value    |
+-----------------+----------+
| long_query_time | 2.000000 |
+-----------------+----------+

## 设置慢查询日志的时间
set long_query_time = 10;

## 定位低效率执行sql
show processlist;
```

![image-20211226220221832](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211226220221832.png)

```sql
select sleep(1);
```

![image-20211226222044244](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20211226222044244.png)

```tex
info 列 : 显示当前sql
```

explain查询sql的执行计划
---

