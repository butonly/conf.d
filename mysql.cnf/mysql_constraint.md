# MySQL constraint

```sql
ALTER TABLE yourtablename
    ADD [CONSTRAINT 外键名] FOREIGN KEY [id] (index_col_name, ...)
    REFERENCES tbl_name (index_col_name, ...)
    [ON DELETE {CASCADE | SET NULL | NO ACTION | RESTRICT}]
    [ON UPDATE {CASCADE | SET NULL | NO ACTION | RESTRICT}]
    
ALTER TABLE tbl_a
ADD CONSTRAINT FOREIGN KEY (filed1) REFERENCES tbl_b(wb_id),
ADD CONSTRAINT FOREIGN KEY (filed2) REFERENCES tbl_c(wb_id);
```

## 约束类型

* 主键约束（Primary Key constraint） 	--：要求主键列数据唯一，并且不允许为空。  
* 唯一约束（Unique constraint） 		--：要求该列唯一，允许为空，但只能出现一个空值。  
* 检查约束（Check constraint） 		--：某列取值范围限制，格式限制等，如有关年龄、邮箱（必须有@）的约束。  
* 默认约束（Default constraint） 		--：某列的默认值，如在数据库里有一项数据很多重复，可以设为默认值。  
* 外键约束（Foreign Key constraint） 	--：用于在两个表之间建立关系，需要指定引用主表的哪一列。  

## 添加约束：

```sql
alter table tablename add constraint pk_colname primary key(colname)主建约束 
alter table tablename add constraint uq_colname unique (colname)唯一约束 
alter table tablename add constraint df_colname default('地址不详')for colname 默认约束 
alter table tablename add constraint ck_colname check(colname between 12 and 15)检查约束 
alter table tablename add constraint fk_colname foreign key(colname) references tablename(colname)外建约束 
```

## 删除约束

```sql
alter table tablename 
drop constraint 约束名  
```
