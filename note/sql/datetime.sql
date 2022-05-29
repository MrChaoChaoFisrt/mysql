/*
	日期和时间函数
**/
-- 1 CURDATE() ，CURRENT_DATE() 返回当前日期，只包含年、 月、日
select curdate() from dual;
select date_format(curdate(),'%Y%m%d') as scurrent_date from dual;
-- 2 CURTIME() ， CURRENT_TIME() 返回当前时间，只包含时、分、秒
select curtime() from dual;
select date_format(curtime(),'%H%i%s')from dual;
-- 3 NOW() / SYSDATE() / CURRENT_TIMESTAMP() / LOCALTIME() / LOCALTIMESTAMP()返回当前系统日期和时间
select now() from dual;
select date_format(now(),'%Y%m%d%H%i%s') from dual;
select sysdate() from dual;
select current_timestamp() from dual;
-- mysql获取本地时间
select localtime() from dual;

/*
	日期和时间戳转换函数
*/
-- UNIX_TIMESTAMP() 以UNIX时间戳的形式返回当前时间。SELECT UNIX_TIMESTAMP() ->1634348884
select unix_timestamp() from dual;
-- UNIX_TIMESTAMP(date) 将时间date以UNIX时间戳的形式返回。
select unix_timestamp('20220520') from dual;
-- FROM_UNIXTIME(timestamp) 将UNIX时间戳的时间转换为普通格式的时间
select from_unixtime(unix_timestamp()) from dual;

-- YEAR(date) / MONTH(date) / DAY(date) 返回具体的日期值
select year(curdate()) as cur_year from dual;select month(sysdate()) as cur_mon from dual;select day(localtime()) as cur_day from dual;
-- HOUR(time) / MINUTE(time) /SECOND(time)返回具体的时间值
select hour(curtime()) from dual;select minute(curtime()) from dual;select second(curtime()) from dual;


/*
计算日期和时间函数
*/
-- 返回当月最后1天
select date_format(last_day(curdate()),'%Y%m%d') from dual;


-- DATE_ADD(datetime, INTERVAL expr type)，
-- ADDDATE(date,INTERVAL expr type) 返回与给定日期时间相差INTERVAL时间段的日期时间
select date_format(date_add(curdate(),interval 12 day),'%Y%m%d') from dual;
select adddate(sysdate(),interval 10 day) from dual;
-- DATE_SUB(date,INTERVAL expr type)，
-- SUBDATE(date,INTERVAL expr type) 返回与date相差INTERVAL时间间隔的日期
select date_sub('20221010',interval 2 year) from dual; -- 2020-10-10
select subdate(current_timestamp(),interval 10 day) from dual; -- 2022-05-10 01:23:02


/*
日期的格式化和解析
*/
-- DATE_FORMAT(date,fmt) 按照字符串fmt格式化日期date值
select date_format('20220101','%Y-%m-%d') from dual;
-- TIME_FORMAT(time,fmt) 按照字符串fmt格式化时间time值
select time_format(curtime(),'%H:%i:%s') from dual;
select curtime() from dual;
-- GET_FORMAT(date_type,format_type) 返回日期字符串的显示格式
select get_format(date, 'USA');
-- STR_TO_DATE(str, fmt) 按照字符串fmt对str进行解析，解析为一个日期
select str_to_date('20140422154706','%Y%m%d%H%i%s')


