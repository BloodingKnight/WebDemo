### WebDemo

## create database
drop database if exists `webdemo`;
create database `webdemo`;
use `webdemo`;

## create tables
create table accounts (
  `id` int primary key auto_increment,
  `username` nchar (20) not null,
  `password` nchar (20) not null
);

create table `functions` (
  `id` int primary key auto_increment,
  `name` nchar (20) not null,
  `url` nchar (100) not null,
  `parent` int default null,
  `type` nchar (1) not null
);

create table `roles` (
  `id` int primary key auto_increment,
  `name` nchar (20) not null
);

create table `account_role` (
  `id` int primary key auto_increment,
  `account` int not null,
  `role` int not null
);

create table `role_permission` (
  `id` int primary key auto_increment,
  `role` int not null,
  `function` int not null
);

create table `account_permission` (
  `id` int primary key auto_increment,
  `account` int not null,
  `function` int not null
);

## Add foreign keys
alter table `account_role`
  add constraint `FK_ACCOUNT_ROLE` foreign key (`account`) references accounts (`id`);
alter table `account_role`
  add constraint `FK_ROLE_ACCOUNT` foreign key (`role`) references `roles` (`id`);

alter table `account_permission`
  add constraint `FK_ACCOUNT_PERMISSION` foreign key (`account`) references accounts (`id`);
alter table `account_permission`
  add constraint `FK_PERMISSION_ACCOUNT` foreign key (`function`) references `functions` (`id`);

alter table `role_permission`
  add constraint `FK_ROLE_PERMISSION` foreign key (`role`) references `roles` (`id`);
alter table `role_permission`
  add constraint `FK_PERMISSION_ROLE` foreign key (`function`) references `functions` (`id`);

alter table `functions`
  add constraint `FK_PERMISSION_PARENT` foreign key (`parent`) references `functions` (`id`);

## Initial data
# Root User
insert into accounts(`username`, `password`) values ('root', 'root');

insert into `functions`(`name`, `url`, `type`) values ('功能管理', '/functions', '1');
insert into `functions`(`name`, `url`, `type`, `parent`) values ('列表', '/functions/list', '0', 1);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('添加对话框', '/functions/add', '0', 1);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('插入', '/functions/insert', '0', 1);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('修改对话框', '/functions/edit', '0', 1);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('更新', '/functions/update', '0', 1);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('删除', '/functions/remove', '0', 1);

insert into `functions`(`name`, `url`, `type`) values ('角色管理', '/roles', '1');
insert into `functions`(`name`, `url`, `type`, `parent`) values ('列表', '/roles/list', '0', 8);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('添加对话框', '/roles/add', '0', 8);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('插入', '/roles/insert', '0', 8);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('修改对话框', '/roles/edit', '0', 8);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('更新', '/roles/update', '0', 8);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('删除', '/roles/remove', '0', 8);

insert into `functions`(`name`, `url`, `type`) values ('用户管理', '/accounts', '1');
insert into `functions`(`name`, `url`, `type`, `parent`) values ('列表', '/accounts/list', '0', 15);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('添加对话框', '/accounts/add', '0', 15);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('插入', '/accounts/insert', '0', 15);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('修改对话框', '/accounts/edit', '0', 15);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('更新', '/accounts/update', '0', 15);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('删除', '/accounts/remove', '0', 15);

insert into `functions`(`name`, `url`, `type`) values ('角色权限管理', '/accounts', '1');
insert into `functions`(`name`, `url`, `type`, `parent`) values ('列表', '/accounts/list', '0', 22);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('添加对话框', '/accounts/add', '0', 22);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('插入', '/accounts/insert', '0', 22);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('修改对话框', '/accounts/edit', '0', 22);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('更新', '/accounts/update', '0', 22);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('删除', '/accounts/remove', '0', 22);

insert into `functions`(`name`, `url`, `type`) values ('角色权限管理', '/accounts', '1');
insert into `functions`(`name`, `url`, `type`, `parent`) values ('列表', '/accounts/list', '0', 29);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('添加对话框', '/accounts/add', '0', 29);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('插入', '/accounts/insert', '0', 29);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('修改对话框', '/accounts/edit', '0', 29);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('更新', '/accounts/update', '0', 29);
insert into `functions`(`name`, `url`, `type`, `parent`) values ('删除', '/accounts/remove', '0', 29);

create procedure `alterRoot`(max int unsigned)
  begin
    declare i int unsigned default 1;
    while i <= max do
      begin
        insert into `account_permission` (`account`, `function`)
            values (1, i);
        set i = i + 1;
      end;
    end while;
  end;

call `alterRoot`(35)
