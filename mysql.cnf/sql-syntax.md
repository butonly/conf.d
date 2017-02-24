# SQL-Statement-Syntax


## SHOW

```sql
SHOW CHARACTER SET;
SHOW COLLATION;
```

## DDL - Data Definition Statements

### DATABASE

MySQL数据库信息存储在`db.opt`文件中，数据信息主要包括`字符编码`和`校对集`。

```sql
CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name 
[
    [DEFAULT] CHARACTER SET [=] charset_name | 
    [DEFAULT] COLLATE       [=] collation_name
] ...

DROP {DATABASE | SCHEMA} [IF EXISTS] db_name

ALTER {DATABASE | SCHEMA} [db_name] [DEFAULT] CHARACTER SET [=] charset_name | [DEFAULT] COLLATE [=] collation_name ...

# Use UPGRADE DATA DIRECTORY NAME in this case to explicitly tell the
# server to re-encode the database directory name to the current encoding format
# ALTER DATABASE `#mysql50#a-b-c` UPGRADE DATA DIRECTORY NAME;
ALTER {DATABASE | SCHEMA} db_name UPGRADE DATA DIRECTORY NAME
```

Example:
```sql
CREATE DATABASE IF NOT EXISTS cms_new DEFAULT CHARACTER SET = 'utf8' DEFAULT COLLATE "utf8_general_ci";
CREATE DATABASE IF NOT EXISTS db DEFAULT CHARACTER SET = 'utf8mb4' DEFAULT COLLATE "utf8mb4_general_ci";
CREATE DATABASE IF NOT EXISTS db CHARACTER SET = 'utf8mb4' COLLATE "utf8mb4_general_ci";
CREATE DATABASE IF NOT EXISTS db;

# 未指定名字时，操作的是当前数据库，即USE db_name时的数据库。
ALTER DATABASE db CHARACTER SET "utf8" COLLATE "utf8_general_ci"
ALTER DATABASE CHARACTER SET = "utf8" COLLATE "utf8_general_ci"

DROP DATABASE IF EXISTS db;
```


### TABLE

#### CREATE TABLE

一个表的信息包括表名，表的定义：表的选项，表的分区选项，表中列的定义。
列的信息包括列名，列的定义：列类型，是否允许为NULL，默认值，自增，主键|唯一键，注释，列的格式，存储
列的类型有 BIT，数值，时间，字符串，文本几大类

```sql
CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name  (create_definition,...)  [table_options] [partition_options]
CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name [(create_definition,...)] [table_options] [partition_options] [IGNORE | REPLACE] [AS] query_expression
CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name { LIKE old_tbl_name | (LIKE old_tbl_name) }

create_definition: 
col_name column_definition
| [CONSTRAINT [symbol]] PRIMARY KEY                     [index_type] (index_col_name,...) [index_option] ...
| {INDEX|KEY}                              [index_name] [index_type] (index_col_name,...) [index_option] ...
| [CONSTRAINT [symbol]] UNIQUE [INDEX|KEY] [index_name] [index_type] (index_col_name,...) [index_option] ...
| {FULLTEXT|SPATIAL} [INDEX|KEY]           [index_name]              (index_col_name,...) [index_option] ...
| [CONSTRAINT [symbol]] FOREIGN KEY        [index_name]              (index_col_name,...) reference_definition
| CHECK (expr)

column_definition:
data_type [NOT NULL | NULL] [DEFAULT default_value] [AUTO_INCREMENT] [UNIQUE [KEY] | [PRIMARY] KEY] [COMMENT 'string'] [COLUMN_FORMAT {FIXED|DYNAMIC|DEFAULT}] [STORAGE {DISK|MEMORY|DEFAULT}][reference_definition]

字段属性：名称、类型（长度、有无符号）、是否可以为NULL、默认值、是否可以自增、键类型（主键、唯一键）、注释、格式化方式（）、存储引擎、关联表定义

除名称和类型两个必选属性位置需固定外，其他属性位置可以变化。

# 以下并不是全部类型
data_type:
  BIT[(length)]
| TINYINT[(length)]            [UNSIGNED] [ZEROFILL]
| SMALLINT[(length)]           [UNSIGNED] [ZEROFILL]
| MEDIUMINT[(length)]          [UNSIGNED] [ZEROFILL]
| INT[(length)]                [UNSIGNED] [ZEROFILL]
| INTEGER[(length)]            [UNSIGNED] [ZEROFILL]
| BIGINT[(length)]             [UNSIGNED] [ZEROFILL]
| REAL[(length,decimals)]      [UNSIGNED] [ZEROFILL]
| DOUBLE[(length,decimals)]    [UNSIGNED] [ZEROFILL]
| FLOAT[(length,decimals)]     [UNSIGNED] [ZEROFILL]
| DECIMAL[(length[,decimals])] [UNSIGNED] [ZEROFILL]
| NUMERIC[(length[,decimals])] [UNSIGNED] [ZEROFILL]
| DATE
| TIME[(fsp)]
| TIMESTAMP[(fsp)]
| DATETIME[(fsp)]
| YEAR
| CHAR[(length)]            [BINARY] [CHARACTER SET charset_name] [COLLATE collation_name]
| VARCHAR(length)           [BINARY] [CHARACTER SET charset_name] [COLLATE collation_name]
| BINARY[(length)]
| VARBINARY(length)
| TINYBLOB
| BLOB
| MEDIUMBLOB
| LONGBLOB
| TINYTEXT [BINARY]         [CHARACTER SET charset_name] [COLLATE collation_name]
| TEXT [BINARY]             [CHARACTER SET charset_name] [COLLATE collation_name]
| MEDIUMTEXT [BINARY]       [CHARACTER SET charset_name] [COLLATE collation_name]
| LONGTEXT [BINARY]         [CHARACTER SET charset_name] [COLLATE collation_name]
| ENUM(value1,value2,...)   [CHARACTER SET charset_name] [COLLATE collation_name] | SET(value1,value2,value3,...) [CHARACTER SET charset_name] [COLLATE collation_name]
| spatial_type

index_col_name: col_name [(length)] [ASC | DESC]

index_type: USING {BTREE | HASH}

index_option: KEY_BLOCK_SIZE [=] value | index_type | WITH PARSER parser_name | COMMENT 'string'

reference_definition: REFERENCES tbl_name (index_col_name,...) [MATCH FULL | MATCH PARTIAL | MATCH SIMPLE] [ON DELETE reference_option] [ON UPDATE reference_option]

reference_option: RESTRICT | CASCADE | SET NULL | NO ACTION

table_options:
table_option [[,] table_option] ...

table_option:
  ENGINE                     [=] engine_name
| AUTO_INCREMENT             [=] value
| AVG_ROW_LENGTH             [=] value
| [DEFAULT] CHARACTER SET    [=] charset_name
| [DEFAULT] COLLATE          [=] collation_name
| CHECKSUM                   [=] {0 | 1}
| COMMENT                    [=] 'string'
| CONNECTION                 [=] 'connect_string'
| DELAY_KEY_WRITE            [=] {0 | 1}
| DATA DIRECTORY             [=] 'absolute path to directory'
| INDEX DIRECTORY            [=] 'absolute path to directory'
| INSERT_METHOD              [=] { NO | FIRST | LAST }
| KEY_BLOCK_SIZE             [=] value
| MAX_ROWS                   [=] value
| MIN_ROWS                   [=] value
| PACK_KEYS                  [=] {0 | 1 | DEFAULT}
| PASSWORD                   [=] 'string'
| ROW_FORMAT                 [=] {DEFAULT|DYNAMIC|FIXED|COMPRESSED|REDUNDANT|COMPACT}
| STATS_AUTO_RECALC          [=] {DEFAULT|0|1}
| STATS_PERSISTENT           [=] {DEFAULT|0|1}
| STATS_SAMPLE_PAGES         [=] value
| TABLESPACE tablespace_name [STORAGE {DISK|MEMORY|DEFAULT}]
| UNION                      [=] (tbl_name[,tbl_name]...)

partition_options:
PARTITION BY { 
      [LINEAR] HASH(expr)
    | [LINEAR] KEY [ALGORITHM={1|2}] (column_list)
    | RANGE{(expr) | COLUMNS(column_list)}
    | LIST{(expr) | COLUMNS(column_list)} 
} [PARTITIONS num]
[
  SUBPARTITION BY { 
        [LINEAR] HASH(expr)
      | [LINEAR] KEY [ALGORITHM={1|2}] (column_list) 
  } [SUBPARTITIONS num]
]
[(partition_definition [, partition_definition] ...)]

partition_definition:
PARTITION partition_name
[VALUES {LESS THAN {(expr | value_list) | MAXVALUE} | IN (value_list)}]
[[STORAGE] ENGINE   [=] engine_name]
[COMMENT            [=] 'comment_text' ]
[DATA DIRECTORY     [=] 'data_dir']
[INDEX DIRECTORY    [=] 'index_dir']
[MAX_ROWS           [=] max_number_of_rows]
[MIN_ROWS           [=] min_number_of_rows]
[TABLESPACE         [=] tablespace_name]
[NODEGROUP          [=] node_group_id]
[(subpartition_definition [, subpartition_definition] ...)]

subpartition_definition:
SUBPARTITION logical_name
[[STORAGE] ENGINE   [=] engine_name]
[COMMENT            [=] 'comment_text' ]
[DATA DIRECTORY     [=] 'data_dir']
[INDEX DIRECTORY    [=] 'index_dir']
[MAX_ROWS           [=] max_number_of_rows]
[MIN_ROWS           [=] min_number_of_rows]
[TABLESPACE         [=] tablespace_name]
[NODEGROUP          [=] node_group_id]

query_expression:
SELECT ... (Some valid select or union statement)
```

```sql
DROP [TEMPORARY] TABLE [IF EXISTS] tbl_name [, tbl_name] ... [RESTRICT | CASCADE]
```

```sql
ALTER [ONLINE|OFFLINE] [IGNORE] TABLE tbl_name [alter_specification [, alter_specification] ...] [partition_options]

alter_specification:
table_options
| ADD [COLUMN] col_name column_definition
[FIRST | AFTER col_name ]
| ADD [COLUMN] (col_name column_definition,...)
| ADD {INDEX|KEY} [index_name]
[index_type] (index_col_name,...) [index_option] ...

collation_name]
| [DEFAULT] CHARACTER SET [=] charset_name [COLLATE [=] collation_name]
| DISCARD TABLESPACE
| IMPORT TABLESPACE
| FORCE
| ADD PARTITION (partition_definition)
| DROP PARTITION partition_names
| TRUNCATE PARTITION {partition_names | ALL}
| COALESCE PARTITION number
| REORGANIZE PARTITION partition_names INTO (partition_definitions)
| EXCHANGE PARTITION partition_name WITH TABLE tbl_name
| ANALYZE PARTITION {partition_names | ALL}
| CHECK PARTITION {partition_names | ALL}
| OPTIMIZE PARTITION {partition_names | ALL}
| REBUILD PARTITION {partition_names | ALL}
| REPAIR PARTITION {partition_names | ALL}
| REMOVE PARTITIONING

index_col_name:
col_name [(length)] [ASC | DESC]

index_type:
USING {BTREE | HASH}

index_option:
KEY_BLOCK_SIZE [=] value
| index_type
| WITH PARSER parser_name
| COMMENT 'string'

table_options:
table_option [[,] table_option] ... (see CREATE TABLE options)
partition_options:
(see CREATE TABLE options)
```

### EVENT

```sql
CREATE [DEFINER = { user | CURRENT_USER }] EVENT [IF NOT EXISTS] event_name
ON SCHEDULE schedule [ON COMPLETION [NOT] PRESERVE]
[ENABLE | DISABLE | DISABLE ON SLAVE]
[COMMENT 'comment']
DO event_body;

schedule:
AT timestamp [+ INTERVAL interval] ...
| EVERY interval
[STARTS timestamp [+ INTERVAL interval] ...]
[ENDS timestamp [+ INTERVAL interval] ...]

interval:
quantity {YEAR | QUARTER | MONTH | DAY | HOUR | MINUTE |
WEEK | SECOND | YEAR_MONTH | DAY_HOUR | DAY_MINUTE |
DAY_SECOND | HOUR_MINUTE | HOUR_SECOND | MINUTE_SECOND}

DROP EVENT [IF EXISTS] event_name

ALTER [DEFINER = { user | CURRENT_USER }] EVENT event_name
[ON SCHEDULE schedule] [ON COMPLETION [NOT] PRESERVE]
[RENAME TO new_event_name]
[ENABLE | DISABLE | DISABLE ON SLAVE]
[COMMENT 'comment']
[DO event_body]
```

### INDEX

```sql
CREATE [ONLINE|OFFLINE] [UNIQUE|FULLTEXT|SPATIAL] INDEX index_name [index_type] ON tbl_name (index_col_name,...)
[index_option] [algorithm_option | lock_option] ...

index_col_name:
col_name [(length)] [ASC | DESC]

index_type:
USING {BTREE | HASH}

index_option:
KEY_BLOCK_SIZE [=] value
| index_type
| WITH PARSER parser_name
| COMMENT 'string'

DROP INDEX [ONLINE|OFFLINE] index_name ON tbl_name [algorithm_option | lock_option] ...

algorithm_option:
ALGORITHM [=] {DEFAULT|INPLACE|COPY}

lock_option:
LOCK [=] {DEFAULT|NONE|SHARED|EXCLUSIVE}

```


