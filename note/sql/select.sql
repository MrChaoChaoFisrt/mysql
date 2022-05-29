-- 几种查询 
select * from (select ifnull(department_name,'research_department') as department_name from departments) a where a.department_name = 'research_department';
select * from employees a where a.department_id = 190;
select e.employee_id,e.first_name,e.last_name,e.email,e.hire_date,d.department_name 
	from employees as e,departments as d 
		where e.department_id = d.department_id;

-- 左外连接
select b.employee_id,b.first_name,b.last_name,b.email,b.hire_date,a.department_id,a.department_name 
	from departments a 
		left join employees b on(a.department_id = b.department_id) where b.department_id is null order by b.employee_id desc;

-- 内连接
select 	b.employee_id,b.first_name,b.last_name,b.email,b.hire_date,a.department_id,a.department_name 
	from departments a 
		inner join employees b on (a.department_id = b.department_id);
-- 全外连接(mysql不支持全外连接)
select 	b.employee_id,b.first_name,b.last_name,b.email,b.hire_date,a.department_id,a.department_name 
	from departments a 
		full outer join employees b on (a.department_id = b.department_id);
-- 全外连接可以使用左外连接 union all 右外连接实现
select * from (select b.employee_id,b.first_name,b.last_name,b.email,b.hire_date,ifnull(b.department_id,a.department_id)  as d_department_id  ,a.department_name 
	from departments a 
		left join employees b on(a.department_id = b.department_id) 
union  
select b.employee_id,b.first_name,b.last_name,b.email,b.hire_date,ifnull(a.department_id,b.department_id) as e_department_id,a.department_id,a.department_name 
	from departments a 
		right join employees b on(a.department_id = b.department_id)) a where  a.employee_id = 202;

select a.department_id,a.department_name,ifnull(manager_id,10) from departments as a;
		
-- 子查询的表必须有别名
select * from (select a.department_id,a.department_name,ifnull(manager_id,10) as manager_id from departments as a) b where b.manager_id=10;