/*
聚合函数
sum() count() max() min() avg
*/
show tables;
desc employees;
desc departments;
select a.department_id,sum(a.salary)from employees a group by a.department_id;

-- 查询部门平均工资大于8000,部门最低工资,部门最高工资,部门平均工资,部门工资总和
select t.department_name,count(distinct  t.employee_id) as employee_count, max(t.salary)  
	as max_salary,min(t.salary) as min_salary,round(avg(t.salary),2) as avg_salary ,sum(t.salary) sum_salary 
from (select a.employee_id,a.salary,b.department_name from employees a left join departments b on (a.department_id = b.department_id)) t 
		group by t.department_name   having avg(t.salary)  > 8000 order by  max(t.salary) desc;

-- having 必须和 group by 一起使用 having 后面可以跟聚合函数 分组字段
select department_id,count(1) as department_count from employees  group by department_id  having count(1) > 5 order by count(1) desc;

select department_id,count(1) as department_count from employees  group by department_id  having department_id > 5 order by count(1) desc;

-- with rollup
select department_id,avg(salary)
from employees
where department_id > 80
group by department_id with rollup;		

select salary from employees with rollup;