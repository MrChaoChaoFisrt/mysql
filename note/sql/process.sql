/*
	流程控制函数
*/
-- IF(value,value1,value2) 如果value的值为TRUE，返回value1， 否则返回value2
select if(1 = 1,'konglingcao','chaochao') from dual;
select if(1 < 0,'konglingcao','chaochao') from dual;

-- IFNULL(value1, value2) 如果value1不为NULL，返回value1，否则返回value2
select ifnull('chao','chaochao') from dual;
select ifnull(null,'chao') from dual;
-- CASE WHEN 条件1 THEN 结果1 WHEN 条件2 THEN 结果2.... [ELSE resultn] END相当于Java的if...else if...else...
select last_name, job_id, salary,
case job_id when 'IT_PROG' then 1.10*salary
when 'ST_CLERK' then 1.15*salary
when 'SA_REP' then 1.20*salary
else salary 
end "REVISED_SALARY"
from employees;
-- CASE expr WHEN 常量值1 THEN 值1 WHEN 常量值1 THEN值1 .... [ELSE 值n] END相当于Java的switch...case...
select last_name, job_id, salary,
case job_id when 'IT_PROG'  1.10*salary
when 'ST_CLERK' then 1.15*salary
when 'SA_REP' then 1.20*salary
else salary end "REVISED_SALARY"
from employees;