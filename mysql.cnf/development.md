# Development

## 存储引擎选择

## 数据类型选择

* `char(n)`和`varchar(n)`中括号中`n`代表字符数，不是字节个数，所以当使用了中文(如：UTF8)的时候意味着可以插入`n`个中文，实际会占用`3n`个字节。
* 同时`char`和`varchar`最大的区别就在于`char`不管实际value都会占用`n`个字符的空间，而`varchar`只会占用`字符数+1`，并且实际空间 `n>=+1`。
* 超过`char`和`varchar`的n设置后，字符串会被截断。
* `char`的上限为255字节，`varchar`的上限65535字节，`text`的上限为65535。
* `char`在存储的时候会截断尾部的空格，`varchar`和`text`不会。
* `varchar`会使用1-3个字节来存储长度，`text`不会。

下图可以非常明显的看到结果：

Value       |CHAR(4)|Storage Required|VARCHAR(4)|Storage Required
------------|-------|----------------|----------|----------------
''          |'    ' |4 bytes         |''        |1 byte
'ab'        |'ab  ' |4 bytes         |'ab'      |3 bytes
'abcd'      |'abcd' |4 bytes         |'abcd'    |5 bytes
'abcdefgh'  |'abcd' |4 bytes         |'abcd'    |5 bytes


总体来说：

* `char`，存定长，速度快，存在空间浪费的可能，会处理尾部空格，上限255。
* `varchar`，存变长，速度慢，不存在空间浪费，不处理尾部空格，上限65535，但是有存储长度实际65532最大可用。
* `text`，存变长大数据，速度慢，不存在空间浪费，不处理尾部空格，上限65535，会用额外空间存放数据长度，顾可以全部使用65535。


接下来，我们说说这个场景的问题：

当`varchar`(n)后面的n非常大的时候我们是使用`varchar`好，还是text好呢？这是个明显的量变引发质变的问题。我们从2个方面考虑，第一是空间，第二是性能。

首先从空间方面：

从官方文档中我们可以得知当`varchar`大于某些数值的时候，其会自动转换为text，大概规则如下：

大于`varchar`(255)变为   tinytext
大于`varchar`(500)变为   text
大于`varchar`(20000)变为 mediumtext
所以对于过大的内容使用`varchar`和text没有太多区别。

其次从性能方面：

索引会是影响性能的最关键因素，而对于`text`来说，只能添加前缀索引，并且前缀索引最大只能达到1000字节。

而貌似`varhcar`可以添加全部索引，但是经过测试，其实也不是。由于会进行内部的转换，所以`long varchar`其实也只能添加1000字节的索引，如果超长了会自动截断。

```SQL
localhost.test>create table test (a `varchar`(1500));
Query OK, 0 rows affected (0.01 sec)

localhost.test>alter table test add index idx_a(a);
Query OK, 0 rows affected, 2 warnings (0.00 sec)
Records: 0  Duplicates: 0  Warnings: 2

localhost.test>show warnings;
+---------+------+---------------------------------------------------------+
| Level   | Code | Message                                                 |
+---------+------+---------------------------------------------------------+
| Warning | 1071 | Specified key was too long; max key length is 767 bytes |
| Warning | 1071 | Specified key was too long; max key length is 767 bytes |
+---------+------+---------------------------------------------------------+
```

从上面可以明显单看到索引被截断了。而这个767是怎么回事呢？这是由于innodb自身的问题，使用`innodb_large_prefix`设置。

从索引上看其实`long varchar`和`text`也没有太多区别。

所以我们认为当超过255的长度之后，使用`varchar`和`text`没有本质区别，只需要考虑一下两个类型的特性即可。(主要考虑text没有默认值的问题)

```SQL
CREATE TABLE `test` (
  `id` int(11) DEFAULT NULL,
  `a` `varchar`(500) DEFAULT NULL,
  `b` text
) ENGINE=InnoDB DEFAULT CHARSET=utf8

+----------+------------+-----------------------------------+
| Query_ID | Duration   | Query                             |
+----------+------------+-----------------------------------+
|        1 | 0.01513200 | select a from test where id=10000 |
|        2 | 0.01384500 | select b from test where id=10000 |
|        3 | 0.01124300 | select a from test where id=15000 |
|        4 | 0.01971600 | select b from test where id=15000 |
+----------+------------+-----------------------------------+
```

从上面的简单测试看，基本上是没有什么区别的，但是个人推荐使用`varchar`(10000)，毕竟这个还有截断，可以保证字段的最大值可控，如果使用text那么如果code有漏洞很有可能就写入数据库一个很大的内容，会造成风险。

故，本着short is better原则，还是使用`varchar`根据需求来限制最大上限最好。

附录：各个字段类型的存储需求



## 字符集

## 索引

## 视图

## 存储过程和函数

## 触发器

## 事务和锁
