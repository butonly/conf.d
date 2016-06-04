
ALTER TABLE yourtablename
    ADD [CONSTRAINT 外键名] FOREIGN KEY [id] (index_col_name, ...)
    REFERENCES tbl_name (index_col_name, ...)
    [ON DELETE {CASCADE | SET NULL | NO ACTION | RESTRICT}]
    [ON UPDATE {CASCADE | SET NULL | NO ACTION | RESTRICT}]
    
ALTER TABLE tbl_a
ADD CONSTRAINT FOREIGN KEY (filed1) REFERENCES tbl_b(wb_id),
ADD CONSTRAINT FOREIGN KEY (filed2) REFERENCES tbl_c(wb_id);
    
约束类型 
主键约束（Primary Key constraint） 	--：要求主键列数据唯一，并且不允许为空。  
唯一约束（Unique constraint） 		--：要求该列唯一，允许为空，但只能出现一个空值。  
检查约束（Check constraint） 		    --：某列取值范围限制，格式限制等，如有关年龄、邮箱（必须有@）的约束。  
默认约束（Default constraint） 		--：某列的默认值，如在数据库里有一项数据很多重复，可以设为默认值。  
外键约束（Foreign Key constraint） 	--：用于在两个表之间建立关系，需要指定引用主表的哪一列。  

添加约束： 
alter table tablename add constraint pk_colname primary key(colname)主建约束 
alter table tablename add constraint uq_colname unique (colname)唯一约束 
alter table tablename add constraint df_colname default('地址不详')for colname 默认约束 
alter table tablename add constraint ck_colname check(colname between 12 and 15)检查约束 
alter table tablename add constraint fk_colname foreign key(colname) references tablename(colname)外建约束 

删除约束： 
alter table tablename 
drop constraint 约束名  
创建登陆帐户/数据库用户 
   
创建登录帐户： 
exec sp_grantlogin 'windows 域名/域帐户'
创建数据库用户： 
exec sp_grantdbaccess '登陆帐户'，'数据库用户'
向数据库授权： 
grant 权限[on 表名]to 数据库用户 
以上语句可直接在企业管理器中操作 
  
企业管理器/安全性/登陆/新建登陆 
填写名称和密码 
选择数据库访问,再底下"数据库角色中允许" db_owner也打上勾 
 
默认约束使用户能够定义一个值，每当用户没有在某一列中输入值时，则将所定义的值提供给这一列。如果用户对此列没有特定的要求，可以使用默认约束来为此列输入默认值。

