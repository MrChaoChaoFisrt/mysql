/*
SQL中的字符串函数
*/
-- 1 返回字符串S中的第一个字符的ASCII码值
select ascii('Chao') from dual;
-- 2 返回字符串s的字符数。作用与CHARACTER_LENGTH(s)相同
select char_length('konglingchao')  as name_char_length from dual;
-- 3 返回字符串s的字节数，和字符集有关
select length('konglingchao') as name_length from dual;
-- 4 连接s1,s2,......,sn为一个字符串
select concat('konglc','ling','chao') from dual;
-- 5 同CONCAT(s1,s2,...)函数，但是每个字符串之间要加上x
select concat_ws('#','kong','ling','chao') from dual;
-- 6 INSERT(str, idx, len,replacestr) 将字符串str从第idx位置开始,len个字符长的子串替换为字符串replacestr
select insert('konglingchao',1,8,'chaochao') from dual;
-- 7 REPLACE(str, a, b) 用字符串b替换字符串str中所有出现的字符串a
select replace('konglingchao','ling','chao') from dual;
-- 8 position(substr in str) 返回 子字符串substr在字符串str中的位置 没有则返回0
select position('chao' in 'konglingchao') from dual; -- 9 
--  9 locate(substr,str)
select locate('chao1','konglingchao') from dual; -- 9 返回substr 在 str中第一次出现的位置 没有则返回0 
-- 10 UPPER(s) 或 UCASE(s) 将字符串s的所有字母转成大写字母
select upper('konglingchao') from dual;
-- 11 LOWER(s) 或LCASE(s) 将字符串s的所有字母转成小写字母
select lower('KONGLINGCHAO') from dual;
-- 12 LEFT(str,n) 返回字符串str最左边的n个字符
select left('konglingchao',10) from dual; -- konglingch
-- RIGHT(str,n) 返回字符串str最右边的n个字符
select right('konglingchao',4) from dual; -- konglingchchao 