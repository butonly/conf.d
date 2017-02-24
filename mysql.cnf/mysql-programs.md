# MySQL Programs

https://dev.mysql.com/doc/refman/5.7/en/programs-overview.html

## MySQL Server And Manager

The MySQL server, mysqld, is the main program that does most of the work in a MySQL installation. The server is accompanied by several related scripts that assist you in starting and stopping the server:

* mysqld

The SQL daemon (that is, the MySQL server). To use client programs, mysqld must be running, because clients gain access to databases by connecting to the server. 

* mysql.server

A server startup script. This script is used on systems that use System V-style run directories containing scripts that start system services for particular run levels. It invokes mysqld_safe to start the MySQL server. 

* mysqld_multi

A server startup script that can start or stop multiple servers installed on the system. 


## MySQL client programs that connect to the MySQL server

* mysql

The command-line tool for interactively entering SQL statements or executing them from a file in batch mode. 

* mysqladmin

A client that performs administrative operations, such as creating or dropping databases, reloading the grant tables, flushing tables to disk, and reopening log files. mysqladmin can also be used to retrieve version, process, and status information from the server. 

* mysqlcheck

A table-maintenance client that checks, repairs, analyzes, and optimizes tables.

* mysqldump

A client that dumps a MySQL database into a file as SQL, text, or XML.

* mysqlimport

A client that imports text files into their respective tables using LOAD DATA INFILE. 

* mysqlpump

A client that dumps a MySQL database into a file as SQL.

* mysqlsh

An advanced command-line client and code editor for the MySQL Server. In addition to SQL, MySQL Shell also offers scripting capabilities for JavaScript and Python. When MySQL Shell is connected to the MySQL Server through the X Protocol, the X DevAPI can be used to work with both relational and document data. 

* mysqlshow

A client that displays information about databases, tables, columns, and indexes.

* mysqlslap

A client that is designed to emulate client load for a MySQL server and report the timing of each stage. It works as if multiple clients are accessing the server. 
