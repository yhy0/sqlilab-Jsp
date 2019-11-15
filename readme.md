# 简介

原版为php版，因为个人工作需求，目前已将1--20关改为jsp(后续有时间再改)，因个人技术原因，可能存在Bug。

# 使用说明

**使用之前修改db.properties 相关数据库连接信息**  默认用户、密码root  root

**sql-lab.sql 为数据库文件**

## 部署方式

 

### 1. sqlilabs文件夹 可以使用IDEA打开部署

### 2. ROOT.war放在tomcat/webapps/ 下

​	

## 可能会出现的问题

SQL注入时  如果出现"Illegal mix of collations for operation 'UNION'" ，请检查数据库，表，字段排序规则是否一致。（我以为移植到另台服务器时，被这个问题给坑了，以为我的代码有问题╮(╯▽╰)╭）

# 联系方式

1356654790@qq.com