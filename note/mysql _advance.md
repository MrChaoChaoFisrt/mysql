1 字符集的相关操作
===

```sql
mysql root@(none):mysql> select t.`Host`,t.`User` from `user` t;                                                                                             
+-----------+------------------+
| Host      | User             |
+-----------+------------------+
| %         | lc_konglc        |
| localhost | debian-sys-maint |
| localhost | mysql.infoschema |
| localhost | mysql.session    |
| localhost | mysql.sys        |
| localhost | root             |
+-----------+------------------+
6 rows in set
```



mycli的安装

```shell
$ sudo apt-get update
$ sudo apt-get install mycli

## 重启mysql服务
systemctl restart mysql.service
show create table t_acct;
```

```sql
show variables where Variable_name like '%password%';

show variables where Variable_name like '%character%'
```

![image-20220212214158304](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220212214158304.png)

2 mysql的数据目录
===

数据库文件的存放路径

```bash
/var/lib/mysql
```

![image-20220212224241998](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220212224241998.png)

MySQL数据库服务器在启动时会到文件系统的某个目录下加载一些文件,之后在运行过程中产生的一些数据都会存储到这个目录下的某些文件中,这个目录就称为数据目录

![image-20220212224527905](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220212224527905.png)

```bash
## 系统表空间
/var/lib/mysql/ibdata1

## 独立表空间
/var/lib/mysql/mysql.ibd
```

![image-20220212230537648](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220212230537648.png)

解析ibd文件

```bash
ibd2sdi --dump-file=tbl_employee.txt tbl_employee.ibd 
```

mysql8.0 数据和表结构放在一个文件中

```sql
 create table student_myisam(
     id bigint not null auto_increment,
     name varchar(64) default null,
     age int default null, 
     sex varchar(2) default null,
     primary key(id)) engine=MYISAM AUTO_INCREMENT=0 default charset=utf8mb3;
```

```bash
## myisam的数据文件结构 数据和索引是分开来存储的 mysql8.0
-rw-r----- 1 mysql mysql      4334 2月  12 23:23 student_myisam_1002.sdi ## 存储表结构和表数据
-rw-r----- 1 mysql mysql      1024 2月  12 23:23 student_myisam.MYI ## 存储索引
-rw-r----- 1 mysql mysql         0 2月  12 23:23 student_myisam.MYD ## 存储索引
```

![image-20220212232614642](C:\Users\ASUS\AppData\Roaming\Typora\typora-user-images\image-20220212232614642.png)

3 用户与权限管理
===

mysql8.0版本密码忘记

```bash
 ## 停mysql服务
 service mysql stop
 ## 我们重新以管理员权限打开新的命令提示符窗口。
 mysqld --shared-memory --skip-grant-tables
 ##
 mysql -uroot -p
 alter user 'root'@'localhost' identified by 'newpassword';
 
```



1 用户管理
---

登录mysql服务器

```bash
mysql -h hostIp -P port -p password -u userName -Ddatabase -e 'sql statement'

mysql  -u lc_konglc -h 192.168.10.132 -P 12666 -plc_konglc -D konglc_base -e 'select * from tbl_employee limit 10'
```

创建/删除用户(root用户)
---

```sql
set global validate_password.policy=LOW;
create user 'chao' identified by 'lc_konglc';
grant all privileges on *.* to 'chao'@'%'; 
flush privileges;
-- 删除用户
drop user 'yangyuqqi';

-- 分配权限
grant all privileges on *.* to 'chao'@'%'; 

-- 修改用户密码
alter user 'yangyuqi'@'%' identified by 'konglc';
```

4  mysql的逻辑架构
===

1 逻辑架构剖析
---

![MySQL服务器端的逻辑架构说明](G:\2022\mysql\高级篇\高级篇\资料\MySQL服务器端的逻辑架构说明.png)

连接层  客户端和服务器建立连接,客户端发送SQL至服务器

服务层 对SQL进行查询处理;与数据库存储文件的方式无关

 引擎层 与数据库文件打交道 负责数据的存储和提取

存储层

2 SQL执行流程
---

mysql中的sql执行流程

1 查询缓存 

缓存中有就直接将结果返回给用户 否则就进入解析环节

缓存就是个鸡肋,命中率非常低,在mysql8中,已经取消了缓存

mysql 5.7中

```sql
## 使用查询缓存
select SQL_CACHE * from tables;
show variables like '%query_cache_type%';
```

2 解析器

词法分析 语法分析 生成语法处

3 优化器

在优化器中会确定sql语句的执行路径,比如是根据全表检索,还是根据索引检索

经过了解析器,MySQL就知道你要做什么了,在开始执行之前,还要经过优化器的处理,一条查询可以有很多中执行方式,最后都返回相同的结果,优化器的作用就是找到这其中最好的执行计划。

优化分为物理查询优化和逻辑查询优化

4 执行器

判断权限  设置了缓存还会将结果进行缓存

如果有权限就会打开表继续执行，打开表的时候，执行器就会根据表的引擎定义，调用存储引擎的API对表进行读写 存储引擎API只是抽象接口,下面还有个存储引擎层,具体实现还要看表选择的存储引擎



3 MySQL8中sql的执行原理
---

1 确认profiling是否开启

了解语句底层执行的过程

```sql
select @@profiling; 
show variables like '%profiling%';
set profiling=1;
```

```sql
mysql root@(none):atguigudb> show profiles;                                                                                                                  
+----------+------------+-------------------------+
| Query_ID | Duration   | Query                   |
+----------+------------+-------------------------+
| 1        | 7.4e-05    | SHOW WARNINGS           |
| 2        | 0.00112625 | select * from employees |
| 3        | 0.00045875 | select * from employees |
+----------+------------+-------------------------+

mysql root@(none):atguigudb> show profile;                                                                                                                   
+----------------+----------+
| Status         | Duration |
+----------------+----------+
| starting       | 0.000056 |
| query end      | 0.000010 |
| closing tables | 0.000004 |
| freeing items  | 0.000011 |
| cleaning up    | 0.000011 |
+----------------+----------+

mysql root@(none):atguigudb> show profile for query 3;                                                                                                       
+--------------------------------+----------+
| Status                         | Duration |
+--------------------------------+----------+
| starting                       | 0.000145 |
| Executing hook on transaction  | 0.000010 |
| starting                       | 0.000008 |
| checking permissions           | 0.000006 |
| Opening tables                 | 0.000033 |
| init                           | 0.000007 |
| System lock                    | 0.000008 |
| optimizing                     | 0.000005 |
| statistics                     | 0.000014 |
| preparing                      | 0.000016 |
| executing                      | 0.000134 |
| end                            | 0.000004 |
| query end                      | 0.000005 |
| waiting for handler commit     | 0.000008 |
| closing tables                 | 0.000007 |
| freeing items                  | 0.000037 |
| cleaning up                    | 0.000015 |
+--------------------------------+----------+
```

5 引擎介绍
===

5.1 InnoDB 
---

InnoDB : 具备外键支持功能的事务存储引擎

InnoDB 是mysql默认事务引擎,它被用来处理大量的短期事务,可以确保事务的完整提交(commit)和 (rollback)

除非有非常特别的原因需要使用其它的存储引擎,否则应该优先考虑 InnoDB 

InnoDB 是为处理最大量数据的性能进行设计的

对比MyISAM的存储引擎,效率要差一些 InnoDB写的效率差一些,并且会占用更多的磁盘空间以保存数据和索引

MyISAM只缓存索引,不缓存真实的数据,InnoDB不仅要缓存索引,还要缓存真正的数据,对内存要求较高,而内存大小对性能有决定性的影响

5.2 MyISAM
---

MyISAM提供了大量的特性,包括全文索引 压缩 空间函数 但MyISAM 不支持事务 行级锁 外键 有一个毫无疑问的缺陷就是 崩溃后无法安全恢复

5.5之前默认的存储引擎

优势是访问速度快,对事务完整性没有要求或者以select insert 为主的应用

针对数据统计有额外的常数存储,故而count(*)的查询效率很高

数据文件结构

表名.frm 存储表结构

表名.MYD 存储数据(mydata)

表名.MYI 存储索引(myindex)

应用场景 : 只读应用或者以读为主的业务



5.3 Archive引擎
---

仅仅支持插入和查询两种功能

适合存储大量的独立的作为历史记录的数据 拥有很高的插入速度

支持行级锁

Archive表适合日志和数据采集

5.4 Blackhole 丢弃写操作  读操作会返回空内容
---



5.5 CSV引擎 存储数据时 以逗号分隔各个数据项
---

5.6 Memory引擎
---

置于内存的表

Memory采用的逻辑介质是内存,响应速度快 但是当mysqld守护进程崩溃的时候数据会丢失 另外要求存储的数据是数据长度不变的格式

同时支持hash索引和B+树索引

数据文件和索引文件分开存储

6 索引的数据结构
===



