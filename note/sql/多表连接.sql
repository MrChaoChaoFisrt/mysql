--  ������: �ϲ�����ͬһ�е��������ϵı����, ������в�����һ��������һ����ƥ�����
�﷨:
	SELECT �ֶ��б�
	FROM A�� INNER JOIN B��
	ON ��������
	WHERE �������Ӿ�;
	
select a.user_id,a.partition_id,a.serial_number,a.remove_tag,a.destroy_date,b.serv_id,c.serv_state_code from ucr_ci1.tf_f_user  a 
        inner join ucr_ci1.tf_f_user_serv b 
              on (a.user_id = b.user_id and a.partition_id = b.partition_id)
        inner join ucr_ci1.tf_f_user_servstate c on (a.user_id = c.user_id and a.partition_id = c.partition_id)
        where a.remove_tag = '0'
        and b.main_tag = '1'
        and c.main_tag = '1'
        and c.serv_state_code = '0'
        and c.end_date > to_date('20220201','yyyymmdd');


-- ������: �����������ӹ����г��˷����������������������⻹�����󣨻��ң����в�������������,�������ӳ�Ϊ�󣨻��ң� �����ӡ�û��ƥ�����ʱ, ���������Ӧ����Ϊ��(NULL)��
-- ��������
-- �﷨
	SELECT �ֶ��б�
	FROM A�� LEFT JOIN B��
	ON ��������
	WHERE �������Ӿ�;

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
   
-- ��������
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
 
-- ȫ������
-- ȫ������ : �������ӵĽ�� = ���ұ�ƥ������� + ���û��ƥ�䵽������ + �ұ�û��ƥ�䵽������
select * from (select nvl(a.user_id,0) as user_id,a.serial_number,a.remove_tag,nvl(b.feepolicy_id,0) as feepolicy_id from ucr_ci1.tf_f_user a full outer join ucr_ci1.tf_f_user_feepolicy b
on (a.user_id = b.user_id and a.partition_id = b.partition_id) where a.remove_tag = '0') t 
where t.feepolicy_id = 0 or t.user_id=0;