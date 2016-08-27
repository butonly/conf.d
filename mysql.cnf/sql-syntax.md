# SQL-Statement-Syntax

## DDL - Data Definition Statements

### DATABASE

```sql
CREATE {DATABASE | SCHEMA} [IF NOT EXISTS] db_name 
[
    [DEFAULT] CHARACTER SET [=] charset_name | 
    [DEFAULT] COLLATE       [=] collation_name
] ...

DROP {DATABASE | SCHEMA} [IF EXISTS] db_name

ALTER {DATABASE | SCHEMA} [db_name] alter_specification ...

ALTER {DATABASE | SCHEMA} db_name UPGRADE DATA DIRECTORY NAME

alter_specification:
[DEFAULT] CHARACTER SET [=] charset_name
| [DEFAULT] COLLATE [=] collation_name
```

### 

```sql
CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name (create_definition,...)   [table_options] [partition_options]
CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name [(create_definition,...)] [table_options] [partition_options] [IGNORE | REPLACE] [AS] query_expression
CREATE [TEMPORARY] TABLE [IF NOT EXISTS] tbl_name { LIKE old_tbl_name | (LIKE old_tbl_name) }

create_definition:
col_name column_definition
| [CONSTRAINT [symbol]] PRIMARY KEY [index_type] (index_col_name,...) [index_option] ...
| {INDEX|KEY} [index_name] [index_type] (index_col_name,...)          [index_option] ...
| [CONSTRAINT [symbol]] UNIQUE [INDEX|KEY] [index_name] [index_type] (index_col_name,...) [index_option] ...
| {FULLTEXT|SPATIAL} [INDEX|KEY] [index_name] (index_col_name,...)    [index_option] ...
| [CONSTRAINT [symbol]] FOREIGN KEY [index_name] (index_col_name,...) reference_definition
| CHECK (expr)

column_definition:
data_type [NOT NULL | NULL] [DEFAULT default_value]
[AUTO_INCREMENT] [UNIQUE [KEY] | [PRIMARY] KEY]
[COMMENT 'string']
[COLUMN_FORMAT {FIXED|DYNAMIC|DEFAULT}]
[STORAGE {DISK|MEMORY|DEFAULT}]
[reference_definition]

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


