--  内连接: 合并具有同一列的两个以上的表的行, 结果集中不包含一个表与另一个表不匹配的行
语法:
	SELECT 字段列表
	FROM A表 INNER JOIN B表
	ON 关联条件
	WHERE 等其他子句;
	
select a.user_id,a.partition_id,a.serial_number,a.remove_tag,a.destroy_date,b.serv_id,c.serv_state_code from ucr_ci1.tf_f_user  a 
        inner join ucr_ci1.tf_f_user_serv b 
              on (a.user_id = b.user_id and a.partition_id = b.partition_id)
        inner join ucr_ci1.tf_f_user_servstate c on (a.user_id = c.user_id and a.partition_id = c.partition_id)
        where a.remove_tag = '0'
        and b.main_tag = '1'
        and c.main_tag = '1'
        and c.serv_state_code = '0'
        and c.end_date > to_date('20220201','yyyymmdd');


-- 外连接: 两个表在连接过程中除了返回满足连接条件的行以外还返回左（或右）表中不满足条件的行,这种连接称为左（或右） 外连接。没有匹配的行时, 结果表中相应的列为空(NULL)。
-- 左外连接
-- 语法
	SELECT 字段列表
	FROM A表 LEFT JOIN B表
	ON 关联条件
	WHERE 等其他子句;

select *
  from (select nvl(b.remove_tag, 'no') as remove_tag,
               a.user_id,
               a.feepolicy_id
          from ucr_ci1.tf_f_user_feepolicy a, ucr_ci1.tf_f_user b
         where a.user_id = b.user_id(+)
           and a.partition_id = b.partition_id(+)) t
 where remove_tag = 'no'
   and t.user_id = 7111041730450052;

select *
  from (select nvl(b.remove_tag, 'no') as remove_tag,
               a.user_id,
               a.feepolicy_id
          from ucr_ci1.tf_f_user_feepolicy a
          left join ucr_ci1.tf_f_user b
            on (a.partition_id = b.partition_id and a.user_id = b.user_id)) t
 where remove_tag = 'no'
   and t.user_id = 7111041730450052;
   
-- 右外连接
select *
  from (select
               b.user_id,
               a.feepolicy_id,
               nvl(a.feepolicy_ins_id,0) as feepolicy_ins_id,
               a.partition_id
          from ucr_ci1.tf_f_user_feepolicy a, ucr_ci1.tf_f_user b
         where a.user_id(+) = b.user_id
           and a.partition_id(+) = b.partition_id
           and b.remove_tag = '0'
           and b.service_state_code = '0') t
 where  t.feepolicy_ins_id = 0;
 
-- 全外连接
-- 全外连接 : 满外连接的结果 = 左右表匹配的数据 + 左表没有匹配到的数据 + 右表没有匹配到的数据
select * from (select nvl(a.user_id,0) as user_id,a.serial_number,a.remove_tag,nvl(b.feepolicy_id,0) as feepolicy_id from ucr_ci1.tf_f_user a full outer join ucr_ci1.tf_f_user_feepolicy b
on (a.user_id = b.user_id and a.partition_id = b.partition_id) where a.remove_tag = '0') t 
where t.feepolicy_id = 0 or t.user_id=0;