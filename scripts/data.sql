create table code_masters (
  master varchar(100) not null,
  code varchar(100) not null,
  name varchar(100),
  sequence int8,
  status char(1),
  primary key (master, code)
);
create table modules (
  module_id varchar(40) primary key,
  module_name varchar(255) not null,
  status char(1) not null,
  path varchar(255),
  resource_key varchar(255),
  icon varchar(255),
  sequence int not null,
  actions int4 null,
  parent varchar(40),
  created_by varchar(40),
  created_at timestamptz,
  updated_by varchar(40),
  updated_at timestamptz
);

create table users (
  user_id varchar(40) primary key,
  username varchar(255) not null,
  email varchar(255) not null,
  display_name varchar(255),
  status char(1) not null,
  gender char(1),
  phone varchar(20),
  title varchar(10),
  position varchar(40),
  image_url varchar(500),
  language varchar(5),
  dateformat varchar(12),
  max_password_age integer,
  created_by varchar(40),
  created_at timestamptz,
  updated_by varchar(40),
  updated_at timestamptz
);
create table passwords (
  user_id varchar(40) primary key,
  password varchar(255),
  success_time timestamptz,
  fail_time timestamptz,
  fail_count integer,
  locked_until_time timestamptz,
  changed_time timestamptz,
  history character varying[]
);
create table passcodes (
  id varchar(40) primary key,
  code varchar(500) not null,
  expired_at timestamptz not null
);
create table roles (
  role_id varchar(40) primary key,
  role_name varchar(255) not null,
  status char(1) not null,
  remark varchar(255),
  created_by varchar(40),
  created_at timestamptz,
  updated_by varchar(40),
  updated_at timestamptz
);
create table user_roles (
  user_id varchar(40) not null,
  role_id varchar(40) not null,
  primary key (user_id, role_id)
);
create table role_modules (
  role_id varchar(40) not null,
  module_id varchar(40) not null,
  permissions int not null,
  primary key (role_id, module_id)
);

create table audit_logs (
  id varchar(255) primary key,
  resource varchar(255),
  user_id varchar(255),
  ip varchar(255),
  action varchar(255),
  time timestamptz,
  status varchar(255),
  remark varchar(255)
);

create table histories (
  history_id varchar(40) primary key,
  entity varchar(40) not null,
  id varchar(40) not null,
  author varchar(40) not null,
  time timestamptz not null,
  action char(1),
  data jsonb
);

create table notifications (
  id varchar(40) primary key,
  sender varchar(40) not null,
  receiver varchar(40) not null,
  message varchar(1000) not null,
  url varchar(200),
  time timestamptz not null,
  status char(1)
);

/*
alter table user_roles add foreign key (user_id) references users (user_id);
alter table user_roles add foreign key (role_id) references roles (role_id);

alter table modules add foreign key (parent) references modules (module_id);

alter table role_modules add foreign key (role_id) references roles (role_id);
alter table role_modules add foreign key (module_id) references modules (module_id);

drop table modules;
drop table users;
drop table roles;
drop table user_roles;
drop table role_modules;
drop table audit_logs;
*/

create table categories (
  id varchar(40) primary key,
  name varchar(255) not null,
  status char(1) not null,
  path varchar(255),
  resource_key varchar(255),
  icon varchar(255),
  sequence int not null,
  type varchar(40),
  parent varchar(40),
  created_by varchar(40),
  created_at timestamptz,
  updated_by varchar(40),
  updated_at timestamptz,
  version integer
);
/*
home
services
news => dynamic
careers => dynamic
contact => dynamic
about
 + milestones
 + companies
 + leadership
*/

insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('home','Home','A','/','home','home',1,'content','');
insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('services','Services','A','/services','services','settings',2,'content','');
insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('news','News','A','/news','news','credit_card',3,'','');
insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('careers','Careers','A','/careers','careers','work',4,'','');
insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('contact','Contact','A','/contact','contact','mail',5,'','');
insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('about','About','A','/about','about','assignment',6,'','');

insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('milestones','Milestones','A','/milestones','milestones','public',1,'content','about');
insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('companies','Companies','A','/companies','companies','account_balance',2,'content','about');
insert into categories (id,name,status,path,resource_key,icon,sequence,type,parent) values ('leadership','Leadership','A','/leadership','leadership','person',3,'content','about');

update categories set version = 1;

insert into code_masters(master, code, name, sequence, status) values ('language','en','English',1,'A');
insert into code_masters(master, code, name, sequence, status) values ('language','vi','Tiếng Việt',2,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','yyyy/M/d','yyyy/M/d',1,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','yyyy/MM/dd','yyyy/MM/dd',2,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','yyyy-M-d','yyyy-M-d',3,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','yyyy-MM-dd','yyyy-MM-dd',4,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','yyyy.MM.dd','yyyy.MM.dd',5,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','yy.MM.dd','yy.MM.dd',6,'I');
insert into code_masters(master, code, name, sequence, status) values ('date_format','d/M/yyyy','d/M/yyyy',7,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','d/MM/yyyy','d/MM/yyyy',8,'I');
insert into code_masters(master, code, name, sequence, status) values ('date_format','dd/MM/yyyy','dd/MM/yyyy',9,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','dd/MM yyyy','dd/MM yyyy',10,'I');
insert into code_masters(master, code, name, sequence, status) values ('date_format','dd/MM/yy','dd/MM/yy',11,'I');
insert into code_masters(master, code, name, sequence, status) values ('date_format','d-M-yyyy','d-M-yyyy',12,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','dd-MM-yyyy','dd-MM-yyyy',13,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','dd-MM-yy','dd-MM-yy',14,'I');
insert into code_masters(master, code, name, sequence, status) values ('date_format','d.M.yyyy','d.M.yyyy',15,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','d.MM.yyyy','d.MM.yyyy',16,'I');
insert into code_masters(master, code, name, sequence, status) values ('date_format','dd.MM.yyyy','dd.MM.yyyy',17,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','dd.MM.yy','dd.MM.yy',18,'I');
insert into code_masters(master, code, name, sequence, status) values ('date_format','M/d/yyyy','M/d/yyyy',19,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','MM/dd/yyyy','MM/dd/yyyy',20,'A');
insert into code_masters(master, code, name, sequence, status) values ('date_format','MM.dd.yyyy','MM.dd.yyyy',21,'A');

insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('admin','Admin','A','/admin','admin','contacts',2,7,'');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('setup','Setup','A','/setup','setup','settings',3,7,'');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('report','Report','A','/report','report','pie_chart',4,7,'');

insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('user','User Management','A','/users','user','person',1,7,'admin');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('role','Role Management','A','/roles','role','credit_card',2,7,'admin');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('audit_log','Audit Log','A','/audit-logs','audit_log','zoom_in',4,1,'admin');

insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('category','Category','A','/categories','category','menu',1,15,'setup');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('content','Content','A','/contents','content','public',2,7,'setup');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('article','Article','A','/articles','article','public',3,15,'setup');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('job','Job','A','/jobs','jobs','local_atm',4,15,'setup');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('contact','Contact','A','/contacts','contact','public',5,7,'setup');

insert into roles (role_id, role_name, status, remark) values ('admin','Admin','A','Admin');
insert into roles (role_id, role_name, status, remark) values ('call_center','Call Center','A','Call Center');
insert into roles (role_id, role_name, status, remark) values ('it_support','IT Support','A','IT Support');
insert into roles (role_id, role_name, status, remark) values ('operator','Operator Group','A','Operator Group');
insert into roles (role_id, role_name, status, remark) values ('content_writer','Content Writer','A','Content Writer');
insert into roles (role_id, role_name, status, remark) values ('content_approver','Content Approver','A','Content Approver');

insert into role_modules(role_id, module_id, permissions) values ('admin', 'setup', 7);
insert into role_modules(role_id, module_id, permissions) values ('admin', 'report', 7);
insert into role_modules(role_id, module_id, permissions) values ('admin', 'admin', 7);
insert into role_modules(role_id, module_id, permissions) values ('admin', 'user', 7);
insert into role_modules(role_id, module_id, permissions) values ('admin', 'role', 7);
insert into role_modules(role_id, module_id, permissions) values ('admin', 'audit_log', 1);

insert into role_modules(role_id, module_id, permissions) values ('it_support', 'admin', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'user', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'role', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'audit_log', 1);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'setup', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'category', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'content', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'article', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'job', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'contact', 7);

insert into role_modules(role_id, module_id, permissions) values ('call_center', 'admin', 1);
insert into role_modules(role_id, module_id, permissions) values ('call_center', 'audit_log', 1);

insert into role_modules(role_id, module_id, permissions) values ('content_writer', 'setup', 7);
insert into role_modules(role_id, module_id, permissions) values ('content_writer', 'article', 7);
insert into role_modules(role_id, module_id, permissions) values ('content_approver', 'setup', 7);
insert into role_modules(role_id, module_id, permissions) values ('content_approver', 'article', 9);

insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('aft2KNdQhi','gareth.bale','gareth.bale@gmail.com','Gareth Bale','https://upload.wikimedia.org/wikipedia/commons/thumb/4/41/Liver-RM_%282%29_%28cropped%29.jpg/440px-Liver-RM_%282%29_%28cropped%29.jpg','A','M','0987654321','Mr','M');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('al6TZ0p4iE','cristiano.ronaldo','cristiano.ronaldo@gmail.com','Cristiano Ronaldo','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8c/Cristiano_Ronaldo_2018.jpg/400px-Cristiano_Ronaldo_2018.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('bkbH1PHu9O','james.rodriguez','james.rodriguez@gmail.com','James Rodríguez','https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/James_Rodriguez_2018.jpg/250px-James_Rodriguez_2018.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('bL7sQBeO5m','zinedine.zidane','zinedine.zidane@gmail.com','Zinedine Zidane','https://upload.wikimedia.org/wikipedia/commons/f/f3/Zinedine_Zidane_by_Tasnim_03.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('bphT4IllDy','kaka','kaka@gmail.com','Kaká','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Kak%C3%A1_visited_Stadium_St._Petersburg.jpg/500px-Kak%C3%A1_visited_Stadium_St._Petersburg.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('cHGwWRCdPx','luis.figo','luis.figo@gmail.com','Luís Figo','https://upload.wikimedia.org/wikipedia/commons/f/fe/Luis_Figo-2009.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('cKAvrWUwa1','paul.pogba','paul.pogba@gmail.com','Paul Pogba','https://upload.wikimedia.org/wikipedia/commons/b/be/Harry_Maguire_2018-07-11_1.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('cSojoy4GUs','ronaldo','ronaldo@gmail.com','Ronaldo','https://upload.wikimedia.org/wikipedia/commons/c/c8/Real_Valladolid-Valencia_CF%2C_2019-05-18_%2890%29_%28cropped%29.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('dXlkg4NA9J','luka.modric','luka.modric@gmail.com','Luka Modrić','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e9/ISL-HRV_%287%29.jpg/440px-ISL-HRV_%287%29.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('emAmlZff9p','xabi.alonso','xabi.alonso@gmail.com','Xabi Alonso','https://upload.wikimedia.org/wikipedia/commons/thumb/6/66/Xabi_Alonso_Euro_2012_vs_France_02.jpg/250px-Xabi_Alonso_Euro_2012_vs_France_02.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('ePXNMefKJx','karim.benzema','karim.benzema@gmail.com','Karim Benzema','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Karim_Benzema_2018.jpg/440px-Karim_Benzema_2018.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('ftMd80w4x2','sergino.dest','sergino.dest@gmail.com','Sergiño Dest','https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Sergino_Dest.jpg/440px-Sergino_Dest.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('gHZY91SouH','gerard.pique','gerard.pique@gmail.com','Gerard Piqué','https://upload.wikimedia.org/wikipedia/commons/4/4e/Gerard_Piqu%C3%A9_2018.jpg','A','M','0987654321','Mr','M');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('gLEDc8dQIp','thibaut.courtois','thibaut.courtois@gmail.com','Thibaut Courtois','https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Courtois_2018_%28cropped%29.jpg/440px-Courtois_2018_%28cropped%29.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('gPrLYi4xOy','ronald.araujo','ronald.araujo@gmail.com','Ronald Araújo','https://pbs.twimg.com/media/EtnqxaEU0AAc6A6.jpg','A','M','0987654321','Mr','M');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('gv99fpMeFy','harry.maguire','harry.maguire@gmail.com','Harry Maguire','https://upload.wikimedia.org/wikipedia/commons/b/be/Harry_Maguire_2018-07-11_1.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('hDx6jGifRZ','sergio.busquets','sergio.busquets@gmail.com','Sergio Busquets','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fd/Sergio_Busquets_2018.jpg/440px-Sergio_Busquets_2018.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('i4GSsUQvZa','antoine.griezmann','antoine.griezmann@gmail.com','Antoine Griezmann','https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Antoine_Griezmann_in_2018_%28cropped%29.jpg/440px-Antoine_Griezmann_in_2018_%28cropped%29.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('i5gkziUCaz','marc-andre.ter.stegen','marc-andre.ter.stegen@gmail.com','Marc-André ter Stegen','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/Marc-Andr%C3%A9_ter_Stegen.jpg/500px-Marc-Andr%C3%A9_ter_Stegen.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('jYz18HzzZk','miralem.pjanic','miralem.pjanic@gmail.com','Miralem Pjanić','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/20150331_2108_AUT_BIH_2382_%28edited%29.jpg/250px-20150331_2108_AUT_BIH_2382_%28edited%29.jpg','A','M','0987654321','Mrs','M');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('k0Zjb3fVJC','martin.braithwaite','martin.braithwaite@gmail.com','Martin Braithwaite','https://img.a.transfermarkt.technology/portrait/header/95732-1583334177.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('kcUrdo9w3H','ousmane.dembele','ousmane.dembele@gmail.com','Ousmane Dembélé','https://upload.wikimedia.org/wikipedia/commons/7/77/Ousmane_Demb%C3%A9l%C3%A9_2018.jpg','A','M','0987654321','Ms','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('mooFuhbZg2','riqui.puig','riqui.puig@gmail.com','Riqui Puig','https://upload.wikimedia.org/wikipedia/commons/thumb/0/0b/Riqui_Puig_against_Portland_Timbers_%28cropped2%29.jpg/250px-Riqui_Puig_against_Portland_Timbers_%28cropped2%29.jpg','A','M','0987654321','Ms','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('mswJ9jzUwN','philip.coutinho','philip.coutinho@gmail.com','Philip Coutinho','https://upload.wikimedia.org/wikipedia/commons/thumb/9/96/Norberto_Murara_Neto_2019.jpg/440px-Norberto_Murara_Neto_2019.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('nOf40L4Qxy','victor.lindelof','victor.lindelof@gmail.com','Victor Lindelöf','https://upload.wikimedia.org/wikipedia/commons/thumb/c/cc/CSKA-MU_2017_%286%29.jpg/440px-CSKA-MU_2017_%286%29.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('oaoe13uUnW','eric.bailly','eric.bailly@gmail.com','Eric Bailly','https://upload.wikimedia.org/wikipedia/commons/c/cf/Eric_Bailly_-_ManUtd.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('omT4HgQtVz','phil.jones','phil.jones@gmail.com','Phil Jones','https://upload.wikimedia.org/wikipedia/commons/f/fa/Phil_Jones_2018-06-28_1.jpg','I','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('p2OVzbV5g6','edinson.cavani','edinson.cavani@gmail.com','Edinson Cavani','https://upload.wikimedia.org/wikipedia/commons/thumb/8/88/Edinson_Cavani_2018.jpg/440px-Edinson_Cavani_2018.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('pfb2pwUKVQ','juan.mata','juan.mata@gmail.com','Juan Mata','https://upload.wikimedia.org/wikipedia/commons/7/70/Ukr-Spain2015_%286%29.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('pvUujIKB7Y','anthony.martial','anthony.martial@gmail.com','Anthony Martial','https://upload.wikimedia.org/wikipedia/commons/thumb/4/48/Anthony-Martial-2015.jpg/250px-Anthony-Martial-2015.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('q7oK9WEitp','marcus.rashford','marcus.rashford@gmail.com','Marcus Rashford','https://upload.wikimedia.org/wikipedia/commons/5/5e/Press_Tren_CSKA_-_MU_%283%29.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('s3oiicc88g','mason.greenwood','mason.greenwood@gmail.com','Mason Greenwood','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e0/Mason_Greenwood.jpeg/440px-Mason_Greenwood.jpeg','A','M','0987654321','Ms','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('tGBxG3ywmt','lee.grant','lee.grant@gmail.com','Lee Grant','https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/LeeGrant09.jpg/400px-LeeGrant09.jpg','A','M','0987654321','Ms','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('tiMdj7Zd0u','jesse.lingard','jesse.lingard@gmail.com','Jesse Lingard','https://upload.wikimedia.org/wikipedia/commons/thumb/1/11/Jesse_Lingard_2018-06-13_1.jpg/440px-Jesse_Lingard_2018-06-13_1.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('uTWR66xW3J','keylor.navas','keylor.navas@gmail.com','Keylor Navas','https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/Keylor_Navas_2018_%28cropped%29.jpg/220px-Keylor_Navas_2018_%28cropped%29.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('wodNv16WnS','achraf.hakimi','achraf.hakimi@gmail.com','Achraf Hakimi','https://upload.wikimedia.org/wikipedia/commons/9/91/Iran-Morocco_by_soccer.ru_14_%28Achraf_Hakimi%29.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('xG1GAvBRAa','presnel.kimpembe','presnel.kimpembe@gmail.com','Presnel Kimpembe','https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Presnel_Kimpembe.jpg/400px-Presnel_Kimpembe.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('xWH7nN5ZFe','sergio.ramos','sergio.ramos@gmail.com','Sergio Ramos','https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Sergio_Ramos_10mar2007.jpg/500px-Sergio_Ramos_10mar2007.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('yDa4bThoP0','marquinhos','marquinhos@gmail.com','Marquinhos','https://upload.wikimedia.org/wikipedia/commons/thumb/d/dc/FC_Salzburg_gegen_Paris_Saint-Germain_UEFA_Champions_League_49_%28cropped%29.jpg/250px-FC_Salzburg_gegen_Paris_Saint-Germain_UEFA_Champions_League_49_%28cropped%29.jpg','A','M','0987654321','Mr','E');
insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('yevNmG6Q0l','marco.verratti','marco.verratti@gmail.com','Marco Verratti','https://upload.wikimedia.org/wikipedia/commons/d/d0/Kiev-PSG_%289%29.jpg','A','M','0987654321','Mr','E');

update users set language = 'en', dateformat = 'd/M/yyyy';

insert into passwords(user_id, password)
select user_id, '$2b$10$LWBgFYSRFpw/lysdne3ybuODJRAk1/qi2z.nhu9fXKA5vH/10AYY.' from users;
/* Password1! */

insert into user_roles(user_id, role_id) values ('aft2KNdQhi','admin');
insert into user_roles(user_id, role_id) values ('al6TZ0p4iE','admin');
insert into user_roles(user_id, role_id) values ('bkbH1PHu9O','admin');
insert into user_roles(user_id, role_id) values ('bL7sQBeO5m','admin');
insert into user_roles(user_id, role_id) values ('bphT4IllDy','it_support');
insert into user_roles(user_id, role_id) values ('cHGwWRCdPx','it_support');
insert into user_roles(user_id, role_id) values ('cKAvrWUwa1','call_center');
insert into user_roles(user_id, role_id) values ('cSojoy4GUs','call_center');

insert into user_roles(user_id, role_id) values ('dXlkg4NA9J','finance_writer');
insert into user_roles(user_id, role_id) values ('emAmlZff9p','finance_writer');
insert into user_roles(user_id, role_id) values ('ePXNMefKJx','finance_writer');

insert into user_roles(user_id, role_id) values ('ftMd80w4x2','finance_approver');
insert into user_roles(user_id, role_id) values ('gHZY91SouH','finance_approver');
insert into user_roles(user_id, role_id) values ('gLEDc8dQIp','finance_approver');
insert into user_roles(user_id, role_id) values ('gPrLYi4xOy','finance_approver');
insert into user_roles(user_id, role_id) values ('gv99fpMeFy','finance_approver');

insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('6xydt3Qap', 'authentication', 'bphT4IllDy', '188.239.138.226', 'authenticate', '2023-07-02 21:00:06.811', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('gRAIVh1tM', 'term', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 12:09:51.659', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('d8sQRO1ap', 'entity', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 13:04:20.950', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('gMu1Rh1aM', 'entity', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 13:04:24.491', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('jrFkzsQaM', 'authentication', 'bphT4IllDy', '188.239.138.226', 'authenticate', '2023-07-03 16:00:42.627', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('4lVacs1aM', 'authentication', 'aft2KNdQhi', '::1', 'authenticate', '2023-07-03 16:22:13.157', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('a8Y-cbQtM', 'product', 'aft2KNdQhi', '95.194.49.166', 'patch', '2023-07-03 16:22:23.430', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('Wvc4Us1aM', 'term', 'aft2KNdQhi', '95.194.49.166', 'patch', '2023-07-03 20:43:31.757', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('tcztIsQap', 'term', 'aft2KNdQhi', '::1', 'create', '2023-07-03 20:44:02.086', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('dO7zIb1ap', 'entity', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 20:44:47.349', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('K-KcIbQtp', 'company', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 20:45:55.702', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('G5JcIsQap', 'company', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 20:45:59.129', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('HaLnIb1tM', 'company', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 20:46:02.818', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('h_kcUbQap', 'company', 'aft2KNdQhi', '219.62.20.91', 'patch', '2023-07-03 20:46:05.519', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('jpTZIbQtM', 'company', 'aft2KNdQhi', '70.182.126.53', 'patch', '2023-07-03 20:46:07.779', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('UH_ZUsQtp', 'company', 'aft2KNdQhi', '70.182.126.53', 'patch', '2023-07-03 20:46:32.408', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('wP1SUsQtp', 'company', 'aft2KNdQhi', '70.182.126.53', 'patch', '2023-07-03 20:46:34.747', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('BxYPUb1aM', 'role', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 20:46:42.944', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('rjegUs1tM', 'role', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 20:47:02.120', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('lbmgUbQtM', 'role', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 20:47:09.713', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('5o7-JsQap', 'role', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 21:02:15.442', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('6eTFGbQap', 'role', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 21:05:48.155', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('14S3JsQaM', 'role', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 21:05:55.771', 'fail', 'pq: duplicate key text violates unique constraint "rolemodules_pkey"');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('DOYhJb1tp', 'article', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 21:06:22.692', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('gKzOGs1tp', 'article', 'aft2KNdQhi', '::1', 'patch', '2023-07-03 21:06:25.995', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('SD3OJsQaM', 'authentication', 'bphT4IllDy', '188.239.138.226', 'authenticate', '2023-07-03 21:06:32.586', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('wD-7GbQaM', 'term', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:08:36.507', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('n3x7Js1tp', 'product', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:08:41.929', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('Jm2NJbQap', 'product', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:08:47.577', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('mHJNJbQtM', 'product', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:08:54.878', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('u2RuJs1tM', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:09:32.212', 'success', '');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('2GrXJb1tM', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:09:43.729', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('tx0dJsQtM', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:10:10.950', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('Ua9dJbQaM', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:10:15.896', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('QD3KJb1tp', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:10:21.980', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('CU5dGs1tM', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:10:26.719', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('UnAKJs1tM', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:10:31.352', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('SiyKGs1ap', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:10:38.634', 'fail', 'Data Validation Failed');
insert into audit_logs (id, resource, user_id, ip, "action", "time", status, remark) values('yYReJsQaM', 'user', 'bphT4IllDy', '188.239.138.226', 'patch', '2023-07-03 21:11:10.110', 'success', '');

/*
alter table userroles add foreign key (userid) references users (userid);
alter table userroles add foreign key (roleid) references roles (roleid);
alter table modules add foreign key (parent) references modules (moduleid);
alter table rolemodules add foreign key (roleid) references roles (roleid);
alter table rolemodules add foreign key (moduleid) references modules (moduleid);
*/

create table currency (
  code varchar(3) primary key,
  symbol varchar(6) not null,
  decimal_digits int4,
  status char(1)
);
create table locale (
  code varchar(40) primary key,
  name varchar(255),
  native_name varchar(255),
  country_code varchar(5),
  country_name varchar(255),
  native_country_name varchar(255),
  date_format varchar(14),
  first_day_of_week int2,
  decimal_separator varchar(3),
  group_separator varchar(3),
  currency_code char(3),
  currency_symbol varchar(6),
  currency_decimal_digits int2,
  currency_pattern int2,
  currency_sample varchar(40)
);
create table country (
  country_code varchar(5) primary key,
  country_name varchar(255),
  native_country_name varchar(255),
  date_format varchar(14),
  decimal_separator varchar(3),
  group_separator varchar(3),
  currency_code char(3),
  currency_symbol varchar(6),
  currency_decimal_digits int2,
  currency_pattern int2,
  currency_sample varchar(40),
  status char(1)
);

insert into currency(code,decimal_digits,symbol) values ('AED',2,'د.إ');
insert into currency(code,decimal_digits,symbol) values ('AFN',2,'؋');
insert into currency(code,decimal_digits,symbol) values ('ALL',2,'Lek');
insert into currency(code,decimal_digits,symbol) values ('AMD',2,'դր.');
insert into currency(code,decimal_digits,symbol) values ('ARS',2,'$');
insert into currency(code,decimal_digits,symbol) values ('AUD',2,'$');
insert into currency(code,decimal_digits,symbol) values ('AZN',2,'ман.');
insert into currency(code,decimal_digits,symbol) values ('BAM',2,'KM');
insert into currency(code,decimal_digits,symbol) values ('BDT',2,'৳');
insert into currency(code,decimal_digits,symbol) values ('BGN',2,'лв.');
insert into currency(code,decimal_digits,symbol) values ('BHD',3,'BD');
insert into currency(code,decimal_digits,symbol) values ('BND',0,'$');
insert into currency(code,decimal_digits,symbol) values ('BOB',2,'$b');
insert into currency(code,decimal_digits,symbol) values ('BRL',2,'R$');
insert into currency(code,decimal_digits,symbol) values ('BYR',2,'р.');
insert into currency(code,decimal_digits,symbol) values ('BZD',2,'BZ$');
insert into currency(code,decimal_digits,symbol) values ('CAD',2,'$');
insert into currency(code,decimal_digits,symbol) values ('CHF',2,'Fr.');
insert into currency(code,decimal_digits,symbol) values ('CLP',2,'$');
insert into currency(code,decimal_digits,symbol) values ('CNY',2,'¥');
insert into currency(code,decimal_digits,symbol) values ('COP',2,'$');
insert into currency(code,decimal_digits,symbol) values ('CRC',2,'₡');
insert into currency(code,decimal_digits,symbol) values ('CSD',2,'Дин.');
insert into currency(code,decimal_digits,symbol) values ('CZK',2,'Kč');
insert into currency(code,decimal_digits,symbol) values ('DKK',2,'kr.');
insert into currency(code,decimal_digits,symbol) values ('DOP',2,'RD$');
insert into currency(code,decimal_digits,symbol) values ('DZD',2,'DA');
insert into currency(code,decimal_digits,symbol) values ('EEK',2,'kr');
insert into currency(code,decimal_digits,symbol) values ('EGP',2,'£');
insert into currency(code,decimal_digits,symbol) values ('ETB',2,'Br');
insert into currency(code,decimal_digits,symbol) values ('EUR',2,'€');
insert into currency(code,decimal_digits,symbol) values ('GBP',2,'£');
insert into currency(code,decimal_digits,symbol) values ('GEL',2,'Lari');
insert into currency(code,decimal_digits,symbol) values ('GTQ',2,'Q');
insert into currency(code,decimal_digits,symbol) values ('HKD',2,'HK$');
insert into currency(code,decimal_digits,symbol) values ('HNL',2,'L.');
insert into currency(code,decimal_digits,symbol) values ('HRK',2,'kn');
insert into currency(code,decimal_digits,symbol) values ('HUF',2,'Ft');
insert into currency(code,decimal_digits,symbol) values ('IDR',0,'Rp');
insert into currency(code,decimal_digits,symbol) values ('ILS',2,'₪');
insert into currency(code,decimal_digits,symbol) values ('INR',2,'₹');
insert into currency(code,decimal_digits,symbol) values ('IQD',2,'ID');
insert into currency(code,decimal_digits,symbol) values ('IRR',2,'ريال');
insert into currency(code,decimal_digits,symbol) values ('ISK',0,'kr.');
insert into currency(code,decimal_digits,symbol) values ('JMD',2,'J$');
insert into currency(code,decimal_digits,symbol) values ('JOD',3,'د.أ');
insert into currency(code,decimal_digits,symbol) values ('JPY',0,'¥');
insert into currency(code,decimal_digits,symbol) values ('KES',2,'S');
insert into currency(code,decimal_digits,symbol) values ('KGS',2,'сом');
insert into currency(code,decimal_digits,symbol) values ('KHR',2,'៛');
insert into currency(code,decimal_digits,symbol) values ('KRW',0,'₩');
insert into currency(code,decimal_digits,symbol) values ('KWD',3,'KD');
insert into currency(code,decimal_digits,symbol) values ('KZT',2,'Т');
insert into currency(code,decimal_digits,symbol) values ('LAK',2,'₭');
insert into currency(code,decimal_digits,symbol) values ('LBP',2,'LL');
insert into currency(code,decimal_digits,symbol) values ('LKR',2,'රු.');
insert into currency(code,decimal_digits,symbol) values ('LTL',2,'Lt');
insert into currency(code,decimal_digits,symbol) values ('LVL',2,'Ls');
insert into currency(code,decimal_digits,symbol) values ('LYD',3,'LD');
insert into currency(code,decimal_digits,symbol) values ('MAD',2,'DH');
insert into currency(code,decimal_digits,symbol) values ('MKD',2,'ден.');
insert into currency(code,decimal_digits,symbol) values ('MNT',2,'₮');
insert into currency(code,decimal_digits,symbol) values ('MOP',2,'$');
insert into currency(code,decimal_digits,symbol) values ('MVR',2,'ރ.');
insert into currency(code,decimal_digits,symbol) values ('MXN',2,'$');
insert into currency(code,decimal_digits,symbol) values ('MYR',2,'RM');
insert into currency(code,decimal_digits,symbol) values ('NIO',2,'C$');
insert into currency(code,decimal_digits,symbol) values ('NOK',2,'kr');
insert into currency(code,decimal_digits,symbol) values ('NPR',2,'रु');
insert into currency(code,decimal_digits,symbol) values ('NZD',2,'$');
insert into currency(code,decimal_digits,symbol) values ('OMR',3,'R.O');
insert into currency(code,decimal_digits,symbol) values ('PAB',2,'B/.');
insert into currency(code,decimal_digits,symbol) values ('PEN',2,'S/.');
insert into currency(code,decimal_digits,symbol) values ('PHP',2,'₱');
insert into currency(code,decimal_digits,symbol) values ('PKR',2,'Rs');
insert into currency(code,decimal_digits,symbol) values ('PLN',2,'zł');
insert into currency(code,decimal_digits,symbol) values ('PYG',2,'Gs');
insert into currency(code,decimal_digits,symbol) values ('QAR',2,'QR');
insert into currency(code,decimal_digits,symbol) values ('RON',2,'lei');
insert into currency(code,decimal_digits,symbol) values ('RSD',2,'Дин.');
insert into currency(code,decimal_digits,symbol) values ('RUB',2,'һ.');
insert into currency(code,decimal_digits,symbol) values ('RWF',2,'R₣');
insert into currency(code,decimal_digits,symbol) values ('SAR',2,'SR');
insert into currency(code,decimal_digits,symbol) values ('SEK',2,'kr');
insert into currency(code,decimal_digits,symbol) values ('SGD',2,'$');
insert into currency(code,decimal_digits,symbol) values ('SYP',2,'LS');
insert into currency(code,decimal_digits,symbol) values ('THB',2,'฿');
insert into currency(code,decimal_digits,symbol) values ('TJS',2,'т.р.');
insert into currency(code,decimal_digits,symbol) values ('TMT',2,'m.');
insert into currency(code,decimal_digits,symbol) values ('TND',3,'DT');
insert into currency(code,decimal_digits,symbol) values ('TRY',2,'TL');
insert into currency(code,decimal_digits,symbol) values ('TTD',2,'TT$');
insert into currency(code,decimal_digits,symbol) values ('TWD',2,'NT$');
insert into currency(code,decimal_digits,symbol) values ('UAH',2,'₴');
insert into currency(code,decimal_digits,symbol) values ('USD',2,'$');
insert into currency(code,decimal_digits,symbol) values ('UYU',2,'$U');
insert into currency(code,decimal_digits,symbol) values ('UZS',0,'лв');
insert into currency(code,decimal_digits,symbol) values ('VEF',2,'Bs.');
insert into currency(code,decimal_digits,symbol) values ('VND',0,'₫');
insert into currency(code,decimal_digits,symbol) values ('XOF',2,'XOF');
insert into currency(code,decimal_digits,symbol) values ('YER',2,'﷼');
insert into currency(code,decimal_digits,symbol) values ('ZAR',2,'R');
insert into currency(code,decimal_digits,symbol) values ('ZWL',2,'Z$');

update currency set status = 'A';

insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('af-ZA','ZA','South Africa','Suid Afrika','Afrikaans (South Africa)','Afrikaans (Suid Afrika)','yyyy/MM/dd',1,'.',',',2,'ZAR',2,'R 10,000.00'),
('am-ET','ET','Ethiopia','ኢትዮጵያ','Amharic (Ethiopia)','አማርኛ (ኢትዮጵያ)','d/M/yyyy',1,'.',',',2,'ETB',0,'ETB10,000.00'),
('ar-AE','AE','U.A.E.','الإمارات العربية المتحدة','Arabic (U.A.E.)','العربية (الإمارات العربية المتحدة)','dd/MM/yyyy',7,'.',',',2,'AED',2,'د.إ.‏ 10,000.00'),
('ar-BH','BH','Bahrain','البحرين','Arabic (Bahrain)','العربية (البحرين)','dd/MM/yyyy',7,'.',',',3,'BHD',2,'د.ب.‏ 10,000.000'),
('ar-DZ','DZ','Algeria','الجزائر','Arabic (Algeria)','العربية (الجزائر)','dd-MM-yyyy',7,'.',',',2,'DZD',2,'د.ج.‏ 10,000.00'),
('ar-EG','EG','Egypt','مصر','Arabic (Egypt)','العربية (مصر)','dd/MM/yyyy',7,'.',',',2,'EGP',2,'ج.م.‏ 10,000.00'),
('ar-IQ','IQ','Iraq','العراق','Arabic (Iraq)','العربية (العراق)','dd/MM/yyyy',7,'.',',',2,'IQD',2,'د.ع.‏ 10,000.00'),
('ar-JO','JO','Jordan','الأردن','Arabic (Jordan)','العربية (الأردن)','dd/MM/yyyy',7,'.',',',3,'JOD',2,'د.ا.‏ 10,000.000'),
('ar-KW','KW','Kuwait','الكويت','Arabic (Kuwait)','العربية (الكويت)','dd/MM/yyyy',7,'.',',',3,'KWD',2,'د.ك.‏ 10,000.000'),
('ar-LB','LB','Lebanon','لبنان','Arabic (Lebanon)','العربية (لبنان)','dd/MM/yyyy',2,'.',',',2,'LBP',2,'ل.ل.‏ 10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('ar-LY','LY','Libya','ليبيا','Arabic (Libya)','العربية (ليبيا)','dd/MM/yyyy',7,'.',',',3,'LYD',0,'د.ل.‏10,000.000'),
('ar-MA','MA','Morocco','المملكة المغربية','Arabic (Morocco)','العربية (المملكة المغربية)','dd-MM-yyyy',2,'.',',',2,'MAD',2,'د.م.‏ 10,000.00'),
('ar-OM','OM','Oman','عمان','Arabic (Oman)','العربية (عمان)','dd/MM/yyyy',7,'.',',',3,'OMR',2,'ر.ع.‏ 10,000.000'),
('ar-QA','QA','Qatar','قطر','Arabic (Qatar)','العربية (قطر)','dd/MM/yyyy',7,'.',',',2,'QAR',2,'ر.ق.‏ 10,000.00'),
('ar-SA','SA','Saudi Arabia','المملكة العربية السعودية','Arabic (Saudi Arabia)','العربية (المملكة العربية السعودية)','dd/MM/yy',7,'.',',',2,'SAR',2,'ر.س.‏ 10,000.00'),
('ar-SY','SY','Syria','سوريا','Arabic (Syria)','العربية (سوريا)','dd/MM/yyyy',7,'.',',',2,'SYP',2,'ل.س.‏ 10,000.00'),
('ar-TN','TN','Tunisia','تونس','Arabic (Tunisia)','العربية (تونس)','dd-MM-yyyy',2,'.',',',3,'TND',2,'د.ت.‏ 10,000.000'),
('ar-YE','YE','Yemen','اليمن','Arabic (Yemen)','العربية (اليمن)','dd/MM/yyyy',7,'.',',',2,'YER',2,'ر.ي.‏ 10,000.00'),
('arn-CL','CL','Chile','Chile','Mapudungun (Chile)','Mapudungun (Chile)','dd-MM-yyyy',1,',','.',2,'CLP',2,'$ 10.000,00'),
('as-IN','IN','India','ভাৰত','Assamese (India)','অসমীয়া (ভাৰত)','dd-MM-yyyy',2,'.',',',2,'INR',1,'10,000.00ট');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('az-Cyrl-AZ','AZ','Azerbaijan','Азәрбајҹан','Azeri (Cyrillic, Azerbaijan)','Азәрбајҹан (Азәрбајҹан)','dd.MM.yyyy',2,',',' ',2,'AZN',3,'10 000,00 ман.'),
('az-Latn-AZ','AZ','Azerbaijan','Azərbaycan','Azeri (Latin, Azerbaijan)','Azərbaycan­ılı (Azərbaycan)','dd.MM.yyyy',2,',',' ',2,'AZN',3,'10 000,00 man.'),
('ba-RU','RU','Russia','Россия','Bashkir (Russia)','Башҡорт (Россия)','dd.MM.yy',2,',',' ',2,'RUB',3,'10 000,00 һ.'),
('be-BY','BY','Belarus','Беларусь','Belarusian (Belarus)','Беларускі (Беларусь)','dd.MM.yyyy',2,',',' ',2,'BYR',3,'10 000,00 р.'),
('bg-BG','BG','Bulgaria','България','Bulgarian (Bulgaria)','български (България)','d.M.yyyy ''г.''',2,',',' ',2,'BGN',3,'10 000,00 лв.'),
('bn-BD','BD','Bangladesh','বাংলাদেশ','Bengali (Bangladesh)','বাংলা (বাংলাদেশ)','dd-MM-yy',2,'.',',',2,'BDT',2,'৳ 10,000.00'),
('bn-IN','IN','India','ভারত','Bengali (India)','বাংলা (ভারত)','dd-MM-yy',2,'.',',',2,'INR',2,'টা 10,000.00'),
('bo-CN','CN','People''s Republic of China','ཀྲུང་ཧྭ་མི་དམངས་སྤྱི་མཐུན་རྒྱལ་ཁབ།','Tibetan (PRC)','བོད་ཡིག (ཀྲུང་ཧྭ་མི་དམངས་སྤྱི་མཐུན་རྒྱལ་ཁབ།)','yyyy/M/d',2,'.',',',2,'CNY',0,'¥10,000.00'),
('br-FR','FR','France','Frañs','Breton (France)','brezhoneg (Frañs)','dd/MM/yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('bs-Cyrl-BA','BA','Bosnia and Herzegovina','Босна и Херцеговина','Bosnian (Cyrillic, Bosnia and Herzegovina)','босански (Босна и Херцеговина)','d.M.yyyy',2,',','.',2,'BAM',3,'10.000,00 КМ');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('bs-Latn-BA','BA','Bosnia and Herzegovina','Bosna i Hercegovina','Bosnian (Latin, Bosnia and Herzegovina)','bosanski (Bosna i Hercegovina)','d.M.yyyy',2,',','.',2,'BAM',3,'10.000,00 KM'),
('ca-ES','ES','Spain','Espanya','Catalan (Catalan)','català (català)','dd/MM/yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('co-FR','FR','France','France','Corsican (France)','Corsu (France)','dd/MM/yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('cs-CZ','CZ','Czech Republic','Česká republika','Czech (Czech Republic)','čeština (Česká republika)','d.M.yyyy',2,',',' ',2,'CZK',3,'10 000,00 Kč'),
('cy-GB','GB','United Kingdom','y Deyrnas Unedig','Welsh (United Kingdom)','Cymraeg (y Deyrnas Unedig)','dd/MM/yyyy',2,'.',',',2,'GBP',0,'£10,000.00'),
('da-DK','DK','Denmark','Danmark','Danish (Denmark)','dansk (Danmark)','dd-MM-yyyy',2,',','.',2,'DKK',2,'kr. 10.000,00'),
('de-AT','AT','Austria','Österreich','German (Austria)','Deutsch (Österreich)','dd.MM.yyyy',2,',','.',2,'EUR',2,'€ 10.000,00'),
('de-CH','CH','Switzerland','Schweiz','German (Switzerland)','Deutsch (Schweiz)','dd.MM.yyyy',2,'.','',2,'CHF',2,'Fr. 10''000.00'),
('de-DE','DE','Germany','Deutschland','German (Germany)','Deutsch (Deutschland)','dd.MM.yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('de-LI','LI','Liechtenstein','Liechtenstein','German (Liechtenstein)','Deutsch (Liechtenstein)','dd.MM.yyyy',2,'.','',2,'CHF',2,'CHF 10''000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('de-LU','LU','Luxembourg','Luxemburg','German (Luxembourg)','Deutsch (Luxemburg)','dd.MM.yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('dsb-DE','DE','Germany','Nimska','Lower Sorbian (Germany)','dolnoserbšćina (Nimska)','d. M. yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('dv-MV','MV','Maldives','ދިވެހި ރާއްޖެ','Divehi (Maldives)','ދިވެހިބަސް (ދިވެހި ރާއްޖެ)','dd/MM/yy',1,'.',',',2,'MVR',3,'10,000.00 ރ.'),
('el-GR','GR','Greece','Ελλάδα','Greek (Greece)','Ελληνικά (Ελλάδα)','d/M/yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('en-029','29','Caribbean','Caribbean','English (Caribbean)','English (Caribbean)','MM/dd/yyyy',2,'.',',',2,'USD',0,'$10,000.00'),
('en-AU','AU','Australia','Australia','English (Australia)','English (Australia)','d/MM/yyyy',2,'.',',',2,'AUD',0,'$10,000.00'),
('en-BZ','BZ','Belize','Belize','English (Belize)','English (Belize)','dd/MM/yyyy',1,'.',',',2,'BZD',0,'BZ$10,000.00'),
('en-CA','CA','Canada','Canada','English (Canada)','English (Canada)','dd/MM/yyyy',1,'.',',',2,'CAD',0,'$10,000.00'),
('en-GB','GB','United Kingdom','United Kingdom','English (United Kingdom)','English (United Kingdom)','dd/MM/yyyy',2,'.',',',2,'GBP',0,'£10,000.00'),
('en-IE','IE','Ireland','Ireland','English (Ireland)','English (Ireland)','dd/MM/yyyy',2,'.',',',2,'EUR',0,'€ 10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('en-IN','IN','India','India','English (India)','English (India)','dd-MM-yyyy',2,'.',',',2,'INR',2,'Rs. 10,000.00'),
('en-JM','JM','Jamaica','Jamaica','English (Jamaica)','English (Jamaica)','dd/MM/yyyy',1,'.',',',2,'JMD',0,'J$10,000.00'),
('en-MY','MY','Malaysia','Malaysia','English (Malaysia)','English (Malaysia)','d/M/yyyy',1,'.',',',2,'MYR',0,'RM10,000.00'),
('en-NZ','NZ','New Zealand','New Zealand','English (New Zealand)','English (New Zealand)','d/MM/yyyy',2,'.',',',2,'NZD',0,'$10,000.00'),
('en-PH','PH','Philippines','Philippines','English (Republic of the Philippines)','English (Philippines)','M/d/yyyy',1,'.',',',2,'PHP',0,'Php10,000.00'),
('en-SG','SG','Singapore','Singapore','English (Singapore)','English (Singapore)','d/M/yyyy',1,'.',',',2,'SGD',0,'$10,000.00'),
('en-TT','TT','Trinidad and Tobago','Trinidad y Tobago','English (Trinidad and Tobago)','English (Trinidad y Tobago)','dd/MM/yyyy',1,'.',',',2,'TTD',0,'TT$10,000.00'),
('en-US','US','United States','United States','English (United States)','English (United States)','M/d/yyyy',1,'.',',',2,'USD',0,'$10,000.00'),
('en-ZA','ZA','South Africa','South Africa','English (South Africa)','English (South Africa)','yyyy/MM/dd',1,',',' ',2,'ZAR',2,'R 10 000.00'),
('en-ZW','ZW','Zimbabwe','Zimbabwe','English (Zimbabwe)','English (Zimbabwe)','M/d/yyyy',1,'.',',',2,'ZWL',0,'Z$10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('es-AR','AR','Argentina','Argentina','Spanish (Argentina)','Español (Argentina)','dd/MM/yyyy',1,',','.',2,'ARS',2,'$ 10.000,00'),
('es-BO','BO','Bolivia','Bolivia','Spanish (Bolivia)','Español (Bolivia)','dd/MM/yyyy',1,',','.',2,'BOB',2,'$b 10.000,00'),
('es-CL','CL','Chile','Chile','Spanish (Chile)','Español (Chile)','dd-MM-yyyy',1,',','.',2,'CLP',2,'$ 10.000,00'),
('es-CO','CO','Colombia','Colombia','Spanish (Colombia)','Español (Colombia)','dd/MM/yyyy',1,',','.',2,'COP',2,'$ 10.000,00'),
('es-CR','CR','Costa Rica','Costa Rica','Spanish (Costa Rica)','Español (Costa Rica)','dd/MM/yyyy',1,',','.',2,'CRC',0,'₡10.000,00'),
('es-DO','DO','Dominican Republic','República Dominicana','Spanish (Dominican Republic)','Español (República Dominicana)','dd/MM/yyyy',1,'.',',',2,'DOP',0,'RD$10,000.00'),
('es-EC','EC','Ecuador','Ecuador','Spanish (Ecuador)','Español (Ecuador)','dd/MM/yyyy',1,',','.',2,'USD',2,'$ 10.000,00'),
('es-ES','ES','Spain','España','Spanish (Spain, International Sort)','Español (España, alfabetización internacional)','dd/MM/yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('es-GT','GT','Guatemala','Guatemala','Spanish (Guatemala)','Español (Guatemala)','dd/MM/yyyy',1,'.',',',2,'GTQ',0,'Q10,000.00'),
('es-HN','HN','Honduras','Honduras','Spanish (Honduras)','Español (Honduras)','dd/MM/yyyy',1,'.',',',2,'HNL',2,'L. 10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('es-MX','MX','Mexico','México','Spanish (Mexico)','Español (México)','dd/MM/yyyy',1,'.',',',2,'MXN',0,'$10,000.00'),
('es-NI','NI','Nicaragua','Nicaragua','Spanish (Nicaragua)','Español (Nicaragua)','dd/MM/yyyy',1,'.',',',2,'NIO',2,'C$ 10,000.00'),
('es-PA','PA','Panama','Panamá','Spanish (Panama)','Español (Panamá)','MM/dd/yyyy',1,'.',',',2,'PAB',2,'B/. 10,000.00'),
('es-PE','PE','Peru','Perú','Spanish (Peru)','Español (Perú)','dd/MM/yyyy',1,'.',',',2,'PEN',2,'S/. 10,000.00'),
('es-PR','PR','Puerto Rico','Puerto Rico','Spanish (Puerto Rico)','Español (Puerto Rico)','dd/MM/yyyy',1,'.',',',2,'USD',2,'$10,000.00'),
('es-PY','PY','Paraguay','Paraguay','Spanish (Paraguay)','Español (Paraguay)','dd/MM/yyyy',2,',','.',2,'PYG',2,'Gs 10.000,00'),
('es-SV','SV','El Salvador','El Salvador','Spanish (El Salvador)','Español (El Salvador)','dd/MM/yyyy',1,'.',',',2,'USD',0,'$10,000.00'),
('es-US','US','United States','Estados Unidos','Spanish (United States)','Español (Estados Unidos)','M/d/yyyy',1,'.',',',2,'USD',0,'$10,000.00'),
('es-UY','UY','Uruguay','Uruguay','Spanish (Uruguay)','Español (Uruguay)','dd/MM/yyyy',2,',','.',2,'UYU',2,'$U 10.000,00'),
('es-VE','VE','Bolivarian Republic of Venezuela','Republica Bolivariana de Venezuela','Spanish (Bolivarian Republic of Venezuela)','Español (Republica Bolivariana de Venezuela)','dd/MM/yyyy',1,',','.',2,'VEF',2,'Bs. F. 10.000,00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('et-EE','EE','Estonia','Eesti','Estonian (Estonia)','eesti (Eesti)','d.MM.yyyy',2,'.',' ',2,'EEK',3,'10 000,00 kr'),
('eu-ES','ES','Spain','Espainia','Basque (Basque)','euskara (euskara)','yyyy/MM/dd',2,',','.',2,'EUR',3,'10.000,00 €'),
('fa-IR','IR','Iran','ایران','Persian','فارسى (ایران)','MM/dd/yyyy',7,'/',',',2,'IRR',2,'ريال 10,000.00'),
('fi-FI','FI','Finland','Suomi','Finnish (Finland)','suomi (Suomi)','d.M.yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('fil-PH','PH','Philippines','Pilipinas','Filipino (Philippines)','Filipino (Pilipinas)','M/d/yyyy',1,'.',',',2,'PHP',0,'PhP10,000.00'),
('fo-FO','FO','Faroe Islands','Føroyar','Faroese (Faroe Islands)','føroyskt (Føroyar)','dd-MM-yyyy',2,',','.',2,'DKK',2,'kr. 10.000,00'),
('fr-BE','BE','Belgium','Belgique','French (Belgium)','français (Belgique)','d/MM/yyyy',2,',','.',2,'EUR',2,'€ 10.000,00'),
('fr-CA','CA','Canada','Canada','French (Canada)','français (Canada)','yyyy-MM-dd',1,',',' ',2,'CAD',3,'10 000,00 $'),
('fr-CH','CH','Switzerland','Suisse','French (Switzerland)','français (Suisse)','dd.MM.yyyy',2,'.','',2,'CHF',2,'fr. 10''000.00'),
('fr-FR','FR','France','France','French (France)','français (France)','dd/MM/yyyy',2,',',' ',2,'EUR',3,'10 000,00 €');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('fr-LU','LU','Luxembourg','Luxembourg','French (Luxembourg)','français (Luxembourg)','dd/MM/yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('fr-MC','MC','Principality of Monaco','Principauté de Monaco','French (Monaco)','français (Principauté de Monaco)','dd/MM/yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('fy-NL','NL','Netherlands','Nederlân','Frisian (Netherlands)','Frysk (Nederlân)','d-M-yyyy',2,',','.',2,'EUR',2,'€ 10.000,00'),
('ga-IE','IE','Ireland','Éire','Irish (Ireland)','Gaeilge (Éire)','dd/MM/yyyy',2,'.',',',2,'EUR',0,'€ 10,000.00'),
('gd-GB','GB','United Kingdom','An Rìoghachd Aonaichte','Scottish Gaelic (United Kingdom)','Gàidhlig (An Rìoghachd Aonaichte)','dd/MM/yyyy',2,'.',',',2,'GBP',0,'£10,000.00'),
('gl-ES','ES','Spain','España','Galician (Galician)','galego (galego)','dd/MM/yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('gsw-FR','FR','France','Frànkrisch','Alsatian (France)','Elsässisch (Frànkrisch)','dd/MM/yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('gu-IN','IN','India','ભારત','Gujarati (India)','ગુજરાતી (ભારત)','dd-MM-yy',2,'.',',',2,'INR',2,'રૂ 10,000.00'),
('ha-Latn-NG','NG','Nigeria','Nigeria','Hausa (Latin, Nigeria)','Hausa (Nigeria)','d/M/yyyy',1,'.',',',2,'NIO',2,'N 10,000.00'),
('he-IL','IL','Israel','ישראל','Hebrew (Israel)','עברית (ישראל)','dd/MM/yyyy',1,'.',',',2,'ILS',2,'₪ 10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('hi-IN','IN','India','भारत','Hindi (India)','हिंदी (भारत)','dd-MM-yyyy',2,'.',',',2,'INR',2,'रु 10,000.00'),
('hr-BA','BA','Bosnia and Herzegovina','Bosna i Hercegovina','Croatian (Latin, Bosnia and Herzegovina)','hrvatski (Bosna i Hercegovina)','d.M.yyyy',2,',','.',2,'BAM',3,'10.000,00 KM'),
('hr-HR','HR','Croatia','Hrvatska','Croatian (Croatia)','hrvatski (Hrvatska)','d.M.yyyy.',2,',','.',2,'HRK',3,'10.000,00 kn'),
('hsb-DE','DE','Germany','Němska','Upper Sorbian (Germany)','hornjoserbšćina (Němska)','d. M. yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('hu-HU','HU','Hungary','Magyarország','Hungarian (Hungary)','magyar (Magyarország)','yyyy.MM.dd.',2,',',' ',2,'HUF',3,'10 000,00 Ft'),
('hy-AM','AM','Armenia','Հայաստան','Armenian (Armenia)','Հայերեն (Հայաստան)','dd.MM.yyyy',2,'.',',',2,'AMD',3,'10,000.00 դր.'),
('id-ID','ID','Indonesia','Indonesia','Indonesian (Indonesia)','Bahasa Indonesia (Indonesia)','dd/MM/yyyy',2,',','.',0,'IDR',0,'Rp10.000'),
('ig-NG','NG','Nigeria','Nigeria','Igbo (Nigeria)','Igbo (Nigeria)','d/M/yyyy',1,'.',',',2,'NIO',2,'N 10,000.00'),
('ii-CN','CN','People''s Republic of China','ꍏꉸꏓꂱꇭꉼꇩ','Yi (PRC)','ꆈꌠꁱꂷ (ꍏꉸꏓꂱꇭꉼꇩ)','yyyy/M/d',2,'.',',',2,'CNY',0,'¥10,000.00'),
('is-IS','IS','Iceland','Ísland','Icelandic (Iceland)','íslenska (Ísland)','d.M.yyyy',2,',','.',0,'ISK',3,'10.000 kr.');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('it-CH','CH','Switzerland','Svizzera','Italian (Switzerland)','italiano (Svizzera)','dd.MM.yyyy',2,'.','',2,'CHF',2,'fr. 10''000.00'),
('it-IT','IT','Italy','Italia','Italian (Italy)','italiano (Italia)','dd/MM/yyyy',2,',','.',2,'EUR',2,'€ 10.000,00'),
('iu-Cans-CA','CA','Canada','ᑲᓇᑕ','Inuktitut (Syllabics, Canada)','ᐃᓄᒃᑎᑐᑦ (ᑲᓇᑕᒥ)','d/M/yyyy',1,'.',',',2,'CAD',0,'$10,000.00'),
('iu-Latn-CA','CA','Canada','kanata','Inuktitut (Latin, Canada)','Inuktitut (Kanatami)','d/MM/yyyy',1,'.',',',2,'CAD',0,'$10,000.00'),
('ja-JP','JP','Japan','日本','Japanese (Japan)','日本語 (日本)','yyyy/MM/dd',1,'.',',',0,'JPY',0,'¥10,000'),
('ka-GE','GE','Georgia','საქართველო','Georgian (Georgia)','ქართული (საქართველო)','dd.MM.yyyy',2,',',' ',2,'GEL',3,'10 000,00 Lari'),
('kk-KZ','KZ','Kazakhstan','Қазақстан','Kazakh (Kazakhstan)','Қазақ (Қазақстан)','dd.MM.yyyy',2,'-',' ',2,'KZT',0,'Т10 000,00'),
('kl-GL','GL','Greenland','Kalaallit Nunaat','Greenlandic (Greenland)','kalaallisut (Kalaallit Nunaat)','dd-MM-yyyy',2,',','.',2,'DKK',2,'kr. 10.000,00'),
('km-KH','KH','Cambodia','កម្ពុជា','Khmer (Cambodia)','ខ្មែរ (កម្ពុជា)','yyyy-MM-dd',1,'.',',',2,'KHR',1,'10,000.00៛'),
('kn-IN','IN','India','ಭಾರತ','Kannada (India)','ಕನ್ನಡ (ಭಾರತ)','dd-MM-yy',2,'.',',',2,'INR',2,'ರೂ 10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('ko-KR','KR','Korea','대한민국','Korean (Korea)','한국어 (대한민국)','yyyy-MM-dd',1,'.',',',0,'KRW',0,'₩10,000'),
('kok-IN','IN','India','भारत','Konkani (India)','कोंकणी (भारत)','dd-MM-yyyy',2,'.',',',2,'INR',2,'रु 10,000.00'),
('ky-KG','KG','Kyrgyzstan','Кыргызстан','Kyrgyz (Kyrgyzstan)','Кыргыз (Кыргызстан)','dd.MM.yy',2,'-',' ',2,'KGS',3,'10 000,00 сом'),
('lb-LU','LU','Luxembourg','Luxembourg','Luxembourgish (Luxembourg)','Lëtzebuergesch (Luxembourg)','dd/MM/yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('lo-LA','LA','Lao P.D.R.','ສ.ປ.ປ. ລາວ','Lao (Lao P.D.R.)','ລາວ (ສ.ປ.ປ. ລາວ)','dd/MM/yyyy',1,'.',',',2,'LAK',1,'10,000.00₭'),
('lt-LT','LT','Lithuania','Lietuva','Lithuanian (Lithuania)','lietuvių (Lietuva)','yyyy.MM.dd',2,',','.',2,'LTL',3,'10.000,00 Lt'),
('lv-LV','LV','Latvia','Latvija','Latvian (Latvia)','latviešu (Latvija)','yyyy.MM.dd.',2,',',' ',2,'LVL',2,'Ls 10 000,00'),
('mi-NZ','NZ','New Zealand','Aotearoa','Maori (New Zealand)','Reo Māori (Aotearoa)','dd/MM/yyyy',2,'.',',',2,'NZD',0,'$10,000.00'),
('mk-MK','MK','Macedonia (FYROM)','Македонија','Macedonian (Former Yugoslav Republic of Macedonia)','македонски јазик (Македонија)','dd.MM.yyyy',2,',','.',2,'MKD',3,'10.000,00 ден.'),
('ml-IN','IN','India','ഭാരതം','Malayalam (India)','മലയാളം (ഭാരതം)','dd-MM-yy',2,'.',',',2,'INR',2,'ക 10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('mn-MN','MN','Mongolia','Монгол улс','Mongolian (Cyrillic, Mongolia)','Монгол хэл (Монгол улс)','yy.MM.dd',2,',',' ',2,'MNT',1,'10 000,00₮'),
('mn-Mong-CN','CN','People''s Republic of China','ᠪᠦᠭᠦᠳᠡ ᠨᠠᠢᠷᠠᠮᠳᠠᠬᠤ ᠳᠤᠮᠳᠠᠳᠤ ᠠᠷᠠᠳ ᠣᠯᠣᠰ','Mongolian (Traditional Mongolian, PRC)','ᠮᠤᠨᠭᠭᠤᠯ ᠬᠡᠯᠡ (ᠪᠦᠭᠦᠳᠡ ᠨᠠᠢᠷᠠᠮᠳᠠᠬᠤ ᠳᠤᠮᠳᠠᠳᠤ ᠠᠷᠠᠳ ᠣᠯᠣᠰ)','yyyy/M/d',2,'.',',',2,'CNY',0,'¥10,000.00'),
('moh-CA','CA','Canada','Canada','Mohawk (Mohawk)','Kanien''kéha','M/d/yyyy',1,'.',',',2,'CAD',0,'$10,000.00'),
('mr-IN','IN','India','भारत','Marathi (India)','मराठी (भारत)','dd-MM-yyyy',2,'.',',',2,'INR',2,'रु 10,000.00'),
('ms-BN','BN','Brunei Darussalam','Brunei Darussalam','Malay (Brunei Darussalam)','Bahasa Melayu (Brunei Darussalam)','dd/MM/yyyy',2,',','.',0,'BND',0,'$10.00'),
('ms-MY','MY','Malaysia','Malaysia','Malay (Malaysia)','Bahasa Melayu (Malaysia)','dd/MM/yyyy',2,'.',',',2,'MYR',0,'RM10,000'),
('mt-MT','MT','Malta','Malta','Maltese (Malta)','Malti (Malta)','dd/MM/yyyy',2,'.',',',2,'EUR',0,'€ 10,000.00'),
('nb-NO','NO','Norway','Norge','Norwegian, Bokmål (Norway)','norsk, bokmål (Norge)','dd.MM.yyyy',2,',',' ',2,'NOK',2,'kr 10 000,00'),
('ne-NP','NP','Nepal','नेपाल','Nepali (Nepal)','नेपाली (नेपाल)','M/d/yyyy',1,'.',',',2,'NPR',0,'रु10,000.00'),
('nl-BE','BE','Belgium','België','Dutch (Belgium)','Nederlands (België)','d/MM/yyyy',2,',','.',2,'EUR',2,'€ 10.000,00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('nl-NL','NL','Netherlands','Nederland','Dutch (Netherlands)','Nederlands (Nederland)','d-M-yyyy',2,',','.',2,'EUR',2,'€ 10.000,00'),
('nn-NO','NO','Norway','Noreg','Norwegian, Nynorsk (Norway)','norsk, nynorsk (Noreg)','dd.MM.yyyy',2,',',' ',2,'NOK',2,'kr 10 000,00'),
('nso-ZA','ZA','South Africa','Afrika Borwa','Sesotho sa Leboa (South Africa)','Sesotho sa Leboa (Afrika Borwa)','yyyy/MM/dd',1,'.',',',2,'ZAR',2,'R 10,000.00'),
('oc-FR','FR','France','França','Occitan (France)','Occitan (França)','dd/MM/yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('or-IN','IN','India','ଭାରତ','Oriya (India)','ଓଡ଼ିଆ (ଭାରତ)','dd-MM-yy',1,'.',',',2,'INR',2,'ଟ 10,000.00'),
('pa-IN','IN','India','ਭਾਰਤ','Punjabi (India)','ਪੰਜਾਬੀ (ਭਾਰਤ)','dd-MM-yy',2,'.',',',2,'INR',2,'ਰੁ 10,000.00'),
('pl-PL','PL','Poland','Polska','Polish (Poland)','polski (Polska)','yyyy-MM-dd',2,',',' ',2,'PLN',3,'10 000,00 zł'),
('prs-AF','AF','Afghanistan','افغانستان','Dari (Afghanistan)','درى (افغانستان)','dd/MM/yy',6,'.',',',2,'AFN',0,'؋10.000,00'),
('ps-AF','AF','Afghanistan','افغانستان','Pashto (Afghanistan)','پښتو (افغانستان)','dd/MM/yy',7,'٫','٬',2,'AFN',0,'؋10،000,00'),
('pt-BR','BR','Brazil','Brasil','Portuguese (Brazil)','Português (Brasil)','dd/MM/yyyy',1,',','.',2,'BRL',2,'R$ 10.000,00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('pt-PT','PT','Portugal','Portugal','Portuguese (Portugal)','português (Portugal)','dd-MM-yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('qut-GT','GT','Guatemala','Guatemala','K''iche (Guatemala)','K''iche (Guatemala)','dd/MM/yyyy',1,'.',',',2,'GTQ',0,'Q10,000.00'),
('quz-BO','BO','Bolivia','Bolivia Suyu','Quechua (Bolivia)','runasimi (Qullasuyu)','dd/MM/yyyy',1,',','.',2,'BOB',2,'$b 10.000,00'),
('quz-EC','EC','Ecuador','Ecuador Suyu','Quechua (Ecuador)','runasimi (Ecuador)','dd/MM/yyyy',1,',','.',2,'USD',2,'$ 10.000,00'),
('quz-PE','PE','Peru','Peru Suyu','Quechua (Peru)','runasimi (Piruw)','dd/MM/yyyy',1,'.',',',2,'PEN',2,'S/. 10,000.00'),
('rm-CH','CH','Switzerland','Svizra','Romansh (Switzerland)','Rumantsch (Svizra)','dd/MM/yyyy',2,'.','',2,'CHF',2,'fr. 10''000.00'),
('ro-RO','RO','Romania','România','Romanian (Romania)','română (România)','dd.MM.yyyy',2,',','.',2,'RON',3,'10.000,00 lei'),
('ru-RU','RU','Russia','Россия','Russian (Russia)','русский (Россия)','dd.MM.yyyy',2,',',' ',2,'RUB',1,'10 000,00р.'),
('rw-RW','RW','Rwanda','Rwanda','Kinyarwanda (Rwanda)','Kinyarwanda (Rwanda)','M/d/yyyy',1,',',' ',2,'RWF',2,'RWF 10 000,00'),
('sa-IN','IN','India','भारतम्','Sanskrit (India)','संस्कृत (भारतम्)','dd-MM-yyyy',1,'.',',',2,'INR',2,'रु 10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('sah-RU','RU','Russia','Россия','Yakut (Russia)','саха (Россия)','MM.dd.yyyy',2,',',' ',2,'RUB',1,'10 000,00с.'),
('se-FI','FI','Finland','Suopma','Sami, Northern (Finland)','davvisámegiella (Suopma)','d.M.yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('se-NO','NO','Norway','Norga','Sami, Northern (Norway)','davvisámegiella (Norga)','dd.MM.yyyy',2,',',' ',2,'NOK',2,'kr 10 000,00'),
('se-SE','SE','Sweden','Ruoŧŧa','Sami, Northern (Sweden)','davvisámegiella (Ruoŧŧa)','yyyy-MM-dd',2,',','.',2,'SEK',3,'10 000,00 kr'),
('si-LK','LK','Sri Lanka','ශ්‍රී ලංකා','Sinhala (Sri Lanka)','සිංහල (ශ්‍රී ලංකා)','yyyy-MM-dd',2,'.',',',2,'LKR',2,'රු. 10,000.00'),
('sk-SK','SK','Slovakia','Slovenská republika','Slovak (Slovakia)','slovenčina (Slovenská republika)','d. M. yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('sl-SI','SI','Slovenia','Slovenija','Slovenian (Slovenia)','slovenski (Slovenija)','d.M.yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('sma-NO','NO','Norway','Nöörje','Sami, Southern (Norway)','åarjelsaemiengiele (Nöörje)','dd.MM.yyyy',2,',',' ',2,'NOK',2,'kr 10 000,00'),
('sma-SE','SE','Sweden','Sveerje','Sami, Southern (Sweden)','åarjelsaemiengiele (Sveerje)','yyyy-MM-dd',2,',','.',2,'SEK',3,'10 000,00 kr'),
('smj-NO','NO','Norway','Vuodna','Sami, Lule (Norway)','julevusámegiella (Vuodna)','dd.MM.yyyy',2,',',' ',2,'NOK',2,'kr 10 000,00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('smj-SE','SE','Sweden','Svierik','Sami, Lule (Sweden)','julevusámegiella (Svierik)','yyyy-MM-dd',2,',','.',2,'SEK',3,'10 000,00 kr'),
('smn-FI','FI','Finland','Suomâ','Sami, Inari (Finland)','sämikielâ (Suomâ)','d.M.yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('sms-FI','FI','Finland','Lää´ddjânnam','Sami, Skolt (Finland)','sääm´ǩiõll (Lää´ddjânnam)','d.M.yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('sq-AL','AL','Albania','Shqipëria','Albanian (Albania)','shqipe (Shqipëria)','yyyy-MM-dd',2,',','.',2,'ALL',1,'10.000,00Lek'),
('sr-Cyrl-BA','BA','Bosnia and Herzegovina','Босна и Херцеговина','Serbian (Cyrillic, Bosnia and Herzegovina)','српски (Босна и Херцеговина)','d.M.yyyy',2,',','.',2,'BAM',3,'10.000,00 КМ'),
('sr-Cyrl-CS','CS','Serbia and Montenegro (Former)','Србија и Црна Гора (Претходно)','Serbian (Cyrillic, Serbia and Montenegro (Former))','српски (Србија и Црна Гора (Претходно))','d.M.yyyy',2,',','.',2,'CSD',3,'10.000,00 Дин.'),
('sr-Cyrl-ME','ME','Montenegro','Црна Гора','Serbian (Cyrillic, Montenegro)','српски (Црна Гора)','d.M.yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('sr-Cyrl-RS','RS','Serbia','Србија','Serbian (Cyrillic, Serbia)','српски (Србија)','d.M.yyyy',2,',','.',2,'RSD',3,'10.000,00 Дин.'),
('sr-Latn-BA','BA','Bosnia and Herzegovina','Bosna i Hercegovina','Serbian (Latin, Bosnia and Herzegovina)','srpski (Bosna i Hercegovina)','d.M.yyyy',2,',','.',2,'BAM',3,'10.000,00 KM'),
('sr-Latn-CS','CS','Serbia and Montenegro (Former)','Srbija i Crna Gora (Prethodno)','Serbian (Latin, Serbia and Montenegro (Former))','srpski (Srbija i Crna Gora (Prethodno))','d.M.yyyy',2,',','.',2,'CSD',3,'10.000,00 Din.');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('sr-Latn-ME','ME','Montenegro','Crna Gora','Serbian (Latin, Montenegro)','srpski (Crna Gora)','d.M.yyyy',2,',','.',2,'EUR',3,'10.000,00 €'),
('sr-Latn-RS','RS','Serbia','Srbija','Serbian (Latin, Serbia)','srpski (Srbija)','d.M.yyyy',2,',','.',2,'RSD',3,'10.000,00 Din.'),
('sv-FI','FI','Finland','Finland','Swedish (Finland)','svenska (Finland)','d.M.yyyy',2,',',' ',2,'EUR',3,'10 000,00 €'),
('sv-SE','SE','Sweden','Sverige','Swedish (Sweden)','svenska (Sverige)','yyyy-MM-dd',2,',','.',2,'SEK',3,'10 000,00 kr'),
('sw-KE','KE','Kenya','Kenya','Kiswahili (Kenya)','Kiswahili (Kenya)','M/d/yyyy',1,'.',',',2,'KES',0,'S10,000.00'),
('syr-SY','SY','Syria','سوريا','Syriac (Syria)','ܣܘܪܝܝܐ (سوريا)','dd/MM/yyyy',7,'.',',',2,'SYP',2,'ل.س.‏ 10,000.00'),
('ta-IN','IN','India','இந்தியா','Tamil (India)','தமிழ் (இந்தியா)','dd-MM-yyyy',2,'.',',',2,'INR',2,'ரூ 10,000.00'),
('te-IN','IN','India','భారత దేశం','Telugu (India)','తెలుగు (భారత దేశం)','dd-MM-yy',2,'.',',',2,'INR',2,'రూ 10,000.00'),
('tg-Cyrl-TJ','TJ','Tajikistan','Тоҷикистон','Tajik (Cyrillic, Tajikistan)','Тоҷикӣ (Тоҷикистон)','dd.MM.yy',1,';',' ',2,'TJS',3,'10 000,00 т.р.'),
('th-TH','TH','Thailand','ไทย','Thai (Thailand)','ไทย (ไทย)','d/M/yyyy',2,'.',',',2,'THB',0,'฿10,000.00');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('tk-TM','TM','Turkmenistan','Türkmenistan','Turkmen (Turkmenistan)','türkmençe (Türkmenistan)','dd.MM.yy',2,',',' ',2,'TMT',1,'10 000,00m.'),
('tn-ZA','ZA','South Africa','Aforika Borwa','Setswana (South Africa)','Setswana (Aforika Borwa)','yyyy/MM/dd',1,'.',',',2,'ZAR',2,'R 10,000.00'),
('tr-TR','TR','Turkey','Türkiye','Turkish (Turkey)','Türkçe (Türkiye)','dd.MM.yyyy',2,',','.',2,'TRY',3,'10.000,00 TL'),
('tt-RU','RU','Russia','Россия','Tatar (Russia)','Татар (Россия)','dd.MM.yyyy',2,',',' ',2,'RUB',3,'10 000,00 р.'),
('tzm-Latn-DZ','DZ','Algeria','Djazaïr','Tamazight (Latin, Algeria)','Tamazight (Djazaïr)','dd-MM-yyyy',7,'.',',',2,'DZD',3,'10.000,00 DZD'),
('ug-CN','CN','People''s Republic of China','جۇڭخۇا خەلق جۇمھۇرىيىتى','Uyghur (PRC)','ئۇيغۇرچە (جۇڭخۇا خەلق جۇمھۇرىيىتى)','yyyy-M-d',1,'.',',',2,'CNY',0,'¥10,000.00'),
('uk-UA','UA','Ukraine','Україна','Ukrainian (Ukraine)','українська (Україна)','dd.MM.yyyy',2,',',' ',2,'UAH',1,'10 000,00₴'),
('ur-PK','PK','Islamic Republic of Pakistan','پاکستان','Urdu (Islamic Republic of Pakistan)','اُردو (پاکستان)','dd/MM/yyyy',2,'.',',',2,'PKR',0,'Rs10,000.00'),
('uz-Cyrl-UZ','UZ','Uzbekistan','Ўзбекистон Республикаси','Uzbek (Cyrillic, Uzbekistan)','Ўзбек (Ўзбекистон)','dd.MM.yyyy',2,',',' ',0,'UZS',3,'10 000,00 сўм'),
('uz-Latn-UZ','UZ','Uzbekistan','U''zbekiston Respublikasi','Uzbek (Latin, Uzbekistan)','U''zbek (U''zbekiston Respublikasi)','dd/MM yyyy',2,',',' ',0,'UZS',3,'10 000 so''m');
insert into locale (code,country_code,country_name,native_country_name,name,native_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_decimal_digits,currency_code,currency_pattern,currency_sample) VALUES
('vi-VN','VN','Vietnam','Việt Nam','Vietnamese (Vietnam)','Tiếng Việt (Việt Nam)','dd/MM/yyyy',2,',','.',0,'VND',3,'10.000,00 ₫'),
('wo-SN','SN','Senegal','Sénégal','Wolof (Senegal)','Wolof (Sénégal)','dd/MM/yyyy',2,',',' ',2,'XOF',3,'10 000,00 XOF'),
('xh-ZA','ZA','South Africa','uMzantsi Afrika','isiXhosa (South Africa)','isiXhosa (uMzantsi Afrika)','yyyy/MM/dd',1,'.',',',2,'ZAR',2,'R 10,000.00'),
('yo-NG','NG','Nigeria','Nigeria','Yoruba (Nigeria)','Yoruba (Nigeria)','d/M/yyyy',1,'.',',',2,'NIO',2,'N 10,000.00'),
('zh-CN','CN','People''s Republic of China','中华人民共和国','Chinese (Simplified, PRC)','中文(中华人民共和国)','yyyy/M/d',1,'.',',',2,'CNY',0,'¥10,000.00'),
('zh-HK','HK','Hong Kong S.A.R.','香港特別行政區','Chinese (Traditional, Hong Kong S.A.R.)','中文(香港特別行政區)','d/M/yyyy',1,'.',',',2,'HKD',0,'HK$10,000.00'),
('zh-MO','MO','Macao S.A.R.','澳門特別行政區','Chinese (Traditional, Macao S.A.R.)','中文(澳門特別行政區)','d/M/yyyy',1,'.',',',2,'MOP',0,'MOP10,000.00'),
('zh-SG','SG','Singapore','新加坡','Chinese (Simplified, Singapore)','中文(新加坡)','d/M/yyyy',1,'.',',',2,'SGD',0,'$10,000.00'),
('zh-TW','TW','Taiwan','台灣','Chinese (Traditional, Taiwan)','中文(台灣)','yyyy/M/d',1,'.',',',2,'TWD',0,'NT$10,000.00'),
('zu-ZA','ZA','South Africa','iNingizimu Afrika','isiZulu (South Africa)','isiZulu (iNingizimu Afrika)','yyyy/MM/dd',1,'.',',',2,'ZAR',2,'R 10,000.00');

update locale l
set currency_symbol = c.symbol
    from currency c
where l.currency_code = c.code;

/* my sql */
update locale l
inner join currency c on l.currency_code = c.code
set l.currency_symbol = c.symbol;

insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('AF','Afghanistan','افغانستان','.',',','AFN','؋',2,0,'؋10.000,00','A'),
	 ('AZ','Azerbaijan','Azərbaycan',',',' ','AZN','ман.',2,3,'10 000,00 man.','A'),
	 ('BA','Bosnia and Herzegovina','Bosna i Hercegovina',',','.','BAM','KM',2,3,'10.000,00 KM','A'),
	 ('BO','Bolivia','Bolivia',',','.','BOB','$b',2,2,'$b 10.000,00','A'),
	 ('BR','Brazil','Brasil',',','.','BRL','R$',2,2,'R$ 10.000,00','A'),
	 ('AL','Albania','Shqipëria',',','.','ALL','Lek',2,1,'10.000,00Lek','A'),
	 ('AE','U.A.E.','الإمارات العربية المتحدة','.',',','AED','د.إ.‏',2,2,'د.إ.‏ 10,000.00','A'),
	 ('AM','Armenia','Հայաստան','.',',','AMD','դր.',2,3,'10,000.00 դր.','A'),
	 ('AR','Argentina','Argentina',',','.','ARS','$',2,2,'$ 10.000,00','A'),
	 ('AU','Australia','Australia','.',',','AUD','$',2,0,'$10,000.00','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('BD','Bangladesh','বাংলাদেশ','.',',','BDT','৳',2,2,'৳ 10,000.00','A'),
	 ('BG','Bulgaria','България',',',' ','BGN','лв.',2,3,'10 000,00 лв.','A'),
	 ('BH','Bahrain','البحرين','.',',','BHD','د.ب.‏',3,2,'د.ب.‏ 10,000.000','A'),
	 ('BN','Brunei Darussalam','Brunei Darussalam',',','.','BND','$',0,0,'$10.00','A'),
	 ('BY','Belarus','Беларусь',',',' ','BYR','р.',2,3,'10 000,00 р.','A'),
	 ('CA','Canada','Canada','.',',','CAD','$',2,0,'$10,000.00','A'),
	 ('CH','Switzerland','Schweiz','.','','CHF','Fr.',2,2,'Fr. 10''000.00','A'),
	 ('CL','Chile','Chile',',','.','CLP','$',2,2,'$ 10.000,00','A'),
	 ('CN','People''s Republic of China','中华人民共和国','.',',','CNY','¥',2,0,'¥10,000.00','A'),
	 ('FR','France','France',',',' ','EUR','€',2,3,'10 000,00 €','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('CS','Serbia and Montenegro (Former)','Srbija i Crna Gora (Prethodno)',',','.','CSD','Дин.',2,3,'10.000,00 Din.','A'),
	 ('DZ','Algeria','الجزائر','.',',','DZD','د.ج.‏',2,2,'د.ج.‏ 10,000.00','A'),
	 ('FI','Finland','Suomi',',',' ','EUR','€',2,3,'10 000,00 €','A'),
	 ('ME','Montenegro','Crna Gora',',','.','EUR','€',2,3,'10.000,00 €','A'),
	 ('NL','Netherlands','Nederland',',','.','EUR','€',2,2,'€ 10.000,00','A'),
	 ('BE','Belgium','België',',','.','EUR','€',2,2,'€ 10.000,00','A'),
	 ('LU','Luxembourg','Luxembourg',',',' ','EUR','€',2,3,'10 000,00 €','A'),
	 ('DE','Germany','Deutschland',',','.','EUR','€',2,3,'10.000,00 €','A'),
	 ('ES','Spain','España',',','.','EUR','€',2,3,'10.000,00 €','A'),
	 ('IE','Ireland','Éire','.',',','EUR','€',2,0,'€ 10,000.00','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('GB','United Kingdom','United Kingdom','.',',','GBP','£',2,0,'£10,000.00','A'),
	 ('GT','Guatemala','Guatemala','.',',','GTQ','Q',2,0,'Q10,000.00','A'),
	 ('IN','India','भारत','.',',','INR',' ₹‎',2,2,'रु 10,000.00','A'),
	 ('MY','Malaysia','Malaysia','.',',','MYR','RM',0,0,'RM10,000','A'),
	 ('NO','Norway','Noreg',',',' ','NOK','kr',2,2,'kr 10 000,00','A'),
	 ('NZ','New Zealand','New Zealand','.',',','NZD','$',2,0,'$10,000.00','A'),
	 ('PE','Peru','Perú','.',',','PEN','S/.',2,2,'S/. 10,000.00','A'),
	 ('PH','Philippines','Pilipinas','.',',','PHP','₱‎',2,0,'PhP10,000.00','A'),
	 ('RS','Serbia','Srbija',',','.','RSD','Дин.',2,3,'10.000,00 Din.','A'),
	 ('RU','Russia','Россия',',',' ','RUB','һ.',2,1,'10 000,00р.','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('SE','Sweden','Sverige',',','.','SEK','kr',2,3,'10 000,00 kr','A'),
	 ('SG','Singapore','Singapore','.',',','SGD','$',2,0,'$10,000.00','A'),
	 ('SY','Syria','سوريا','.',',','SYP','ل.س.‏',2,2,'ل.س.‏ 10,000.00','A'),
	 ('LI','Liechtenstein','Liechtenstein','.','','CHF','Fr.',2,2,'CHF 10''000.00','A'),
	 ('AT','Austria','Österreich',',','.','EUR','€',2,2,'€ 10.000,00','A'),
	 ('CO','Colombia','Colombia',',','.','COP','$',2,2,'$ 10.000,00','A'),
	 ('CR','Costa Rica','Costa Rica',',','.','CRC','₡',2,0,'₡10.000,00','A'),
	 ('CZ','Czech Republic','Česká republika',',',' ','CZK','Kč',2,3,'10 000,00 Kč','A'),
	 ('GL','Greenland','Kalaallit Nunaat',',','.','DKK','kr.',2,2,'kr. 10.000,00','A'),
	 ('FO','Faroe Islands','Føroyar',',','.','DKK','kr.',2,2,'kr. 10.000,00','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('DK','Denmark','Danmark',',','.','DKK','kr.',2,2,'kr. 10.000,00','A'),
	 ('DO','Dominican Republic','República Dominicana','.',',','DOP','RD$',2,0,'RD$10,000.00','A'),
	 ('EE','Estonia','Eesti','.',' ','EEK','kr',2,3,'10 000,00 kr','A'),
	 ('EG','Egypt','مصر','.',',','EGP','ج.م.‏',2,2,'ج.م.‏ 10,000.00','A'),
	 ('ET','Ethiopia','ኢትዮጵያ','.',',','ETB','ETB',2,0,'ETB10,000.00','A'),
	 ('SI','Slovenia','Slovenija',',','.','EUR','€',2,3,'10.000,00 €','A'),
	 ('SK','Slovakia','Slovenská republika',',',' ','EUR','€',2,3,'10 000,00 €','A'),
	 ('PT','Portugal','Portugal',',','.','EUR','€',2,3,'10.000,00 €','A'),
	 ('MT','Malta','Malta','.',',','EUR','€',2,0,'€ 10,000.00','A'),
	 ('IT','Italy','Italia',',','.','EUR','€',2,2,'€ 10.000,00','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('MC','Principality of Monaco','Principauté de Monaco',',',' ','EUR','€',2,3,'10 000,00 €','A'),
	 ('GR','Greece','Ελλάδα',',','.','EUR','€',2,3,'10.000,00 €','A'),
	 ('GE','Georgia','საქართველო',',',' ','GEL','Lari',2,3,'10 000,00 Lari','A'),
	 ('HK','Hong Kong S.A.R.','香港特別行政區','.',',','HKD','HK$',2,0,'HK$10,000.00','A'),
	 ('HN','Honduras','Honduras','.',',','HNL','L.',2,2,'L. 10,000.00','A'),
	 ('HR','Croatia','Hrvatska',',','.','HRK','kn',2,3,'10.000,00 kn','A'),
	 ('HU','Hungary','Magyarország',',',' ','HUF','Ft',2,3,'10 000,00 Ft','A'),
	 ('BZ','Belize','Belize','.',',','BZD','BZ$',2,0,'BZ$10,000.00','A'),
	 ('ID','Indonesia','Indonesia',',','.','IDR','Rp',0,0,'Rp10.000','A'),
	 ('IL','Israel','ישראל','.',',','ILS','₪',2,2,'₪ 10,000.00','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('IQ','Iraq','العراق','.',',','IQD','د.ع.‏',2,2,'د.ع.‏ 10,000.00','A'),
	 ('IR','Iran','ایران','/',',','IRR','ريال',2,2,'ريال 10,000.00','A'),
	 ('IS','Iceland','Ísland',',','.','ISK','kr.',0,3,'10.000 kr.','A'),
	 ('JM','Jamaica','Jamaica','.',',','JMD','J$',2,0,'J$10,000.00','A'),
	 ('JO','Jordan','الأردن','.',',','JOD','د.ا.‏',3,2,'د.ا.‏ 10,000.000','A'),
	 ('JP','Japan','日本','.',',','JPY','¥',0,0,'¥10,000','A'),
	 ('KE','Kenya','Kenya','.',',','KES','S',2,0,'S10,000.00','A'),
	 ('KG','Kyrgyzstan','Кыргызстан','-',' ','KGS','сом',2,3,'10 000,00 сом','A'),
	 ('KH','Cambodia','កម្ពុជា','.',',','KHR','៛',2,1,'10,000.00៛','A'),
	 ('KR','Korea','대한민국','.',',','KRW','₩',0,0,'₩10,000','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('KW','Kuwait','الكويت','.',',','KWD','د.ك.‏',3,2,'د.ك.‏ 10,000.000','A'),
	 ('KZ','Kazakhstan','Қазақстан','-',' ','KZT','Т',2,0,'Т10 000,00','A'),
	 ('LA','Lao P.D.R.','ສ.ປ.ປ. ລາວ','.',',','LAK','₭',2,1,'10,000.00₭','A'),
	 ('LB','Lebanon','لبنان','.',',','LBP','ل.ل.‏',2,2,'ل.ل.‏ 10,000.00','A'),
	 ('LK','Sri Lanka','ශ්‍රී ලංකා','.',',','LKR','රු.',2,2,'රු. 10,000.00','A'),
	 ('LT','Lithuania','Lietuva',',','.','LTL','Lt',2,3,'10.000,00 Lt','A'),
	 ('LV','Latvia','Latvija',',',' ','LVL','Ls',2,2,'Ls 10 000,00','A'),
	 ('LY','Libya','ليبيا','.',',','LYD','د.ل.‏',3,0,'د.ل.‏10,000.000','A'),
	 ('MA','Morocco','المملكة المغربية','.',',','MAD','د.م.‏',2,2,'د.م.‏ 10,000.00','A'),
	 ('MK','Macedonia (FYROM)','Македонија',',','.','MKD','ден.',2,3,'10.000,00 ден.','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('MN','Mongolia','Монгол улс',',',' ','MNT','₮',2,1,'10 000,00₮','A'),
	 ('MO','Macao S.A.R.','澳門特別行政區','.',',','MOP','MOP',2,0,'MOP10,000.00','A'),
	 ('PR','Puerto Rico','Puerto Rico','.',',','USD','$',2,2,'$10,000.00','A'),
	 ('MV','Maldives','ދިވެހި ރާއްޖެ','.',',','MVR','ރ.',2,3,'10,000.00 ރ.','A'),
	 ('MX','Mexico','México','.',',','MXN','$',2,0,'$10,000.00','A'),
	 ('NG','Nigeria','Nigeria','.',',','NIO','C$',2,2,'N 10,000.00','A'),
	 ('NI','Nicaragua','Nicaragua','.',',','NIO','C$',2,2,'C$ 10,000.00','A'),
	 ('NP','Nepal','नेपाल','.',',','NPR','रु',2,0,'रु10,000.00','A'),
	 ('OM','Oman','عمان','.',',','OMR','ر.ع.‏',3,2,'ر.ع.‏ 10,000.000','A'),
	 ('PA','Panama','Panamá','.',',','PAB','B/.',2,2,'B/. 10,000.00','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('PK','Islamic Republic of Pakistan','پاکستان','.',',','PKR','Rs',2,0,'Rs10,000.00','A'),
	 ('PL','Poland','Polska',',',' ','PLN','zł',2,3,'10 000,00 zł','A'),
	 ('PY','Paraguay','Paraguay',',','.','PYG','Gs',2,2,'Gs 10.000,00','A'),
	 ('QA','Qatar','قطر','.',',','QAR','ر.ق.‏',2,2,'ر.ق.‏ 10,000.00','A'),
	 ('RO','Romania','România',',','.','RON','lei',2,3,'10.000,00 lei','A'),
	 ('RW','Rwanda','Rwanda',',',' ','RWF','RWF',2,2,'RWF 10 000,00','A'),
	 ('SA','Saudi Arabia','المملكة العربية السعودية','.',',','SAR','ر.س.‏',2,2,'ر.س.‏ 10,000.00','A'),
	 ('TH','Thailand','ไทย','.',',','THB','฿',2,0,'฿10,000.00','A'),
	 ('TJ','Tajikistan','Тоҷикистон',';',' ','TJS','т.р.',2,3,'10 000,00 т.р.','A'),
	 ('TM','Turkmenistan','Türkmenistan',',',' ','TMT','m.',2,1,'10 000,00m.','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('TN','Tunisia','تونس','.',',','TND','د.ت.‏',3,2,'د.ت.‏ 10,000.000','A'),
	 ('TR','Turkey','Türkiye',',','.','TRY','TL',2,3,'10.000,00 TL','A'),
	 ('TT','Trinidad and Tobago','Trinidad y Tobago','.',',','TTD','TT$',2,0,'TT$10,000.00','A'),
	 ('TW','Taiwan','台灣','.',',','TWD','NT$',2,0,'NT$10,000.00','A'),
	 ('UA','Ukraine','Україна',',',' ','UAH','₴',2,1,'10 000,00₴','A'),
	 ('SV','El Salvador','El Salvador','.',',','USD','$',2,0,'$10,000.00','A'),
	 ('29','Caribbean','Caribbean','.',',','USD','$',2,0,'$10,000.00','A'),
	 ('UY','Uruguay','Uruguay',',','.','UYU','$U',2,2,'$U 10.000,00','A'),
	 ('VE','Bolivarian Republic of Venezuela','Republica Bolivariana de Venezuela',',','.','VEF','Bs. F.',2,2,'Bs. F. 10.000,00','A'),
	 ('VN','Vietnam','Việt Nam',',','.','VND','₫',0,3,'10.000,00 ₫','A');
insert into country (country_code,country_name,native_country_name,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
	 ('SN','Senegal','Sénégal',',',' ','XOF','XOF',2,3,'10 000,00 XOF','A'),
	 ('YE','Yemen','اليمن','.',',','YER','ر.ي.‏',2,2,'ر.ي.‏ 10,000.00','A'),
	 ('ZW','Zimbabwe','Zimbabwe','.',',','ZWL','Z$',2,0,'Z$10,000.00','A'),
	 ('EC','Ecuador','Ecuador',',','.','USD','$',2,2,'$ 10.000,00','A'),
	 ('US','United States','United States','.',',','USD','$',2,0,'$10,000.00','A'),
	 ('UZ','Uzbekistan','U''zbekiston Respublikasi',',',' ','UZS','лв',0,3,'10 000 so''m','A'),
	 ('ZA','South Africa','South Africa',',',' ','ZAR','R',2,2,'R 10 000.00','A');

/* postgres */
update country c
set date_format = l.date_format, decimal_separator = l.decimal_separator, group_separator = l.group_separator
  from locale l
where l.country_code = c.country_code;

/* my sql */
update country c inner join locale l on l.country_code = c.country_code
set c.date_format = l.date_format, c.decimal_separator = l.decimal_separator, c.group_separator = l.group_separator;

update country c set decimal_separator = '.', group_separator = ',' where country_code = 'AF';
update country c set decimal_separator = '.', group_separator = ',' where country_code = 'CA';
update country c set decimal_separator = ',', group_separator = ' ' where country_code = 'ZA';

update country c set date_format = 'd.M.yyyy' where country_code = 'BA';
update country c set date_format = 'dd/MM/yyyy' where country_code = 'CA';
update country c set date_format = 'dd.MM.yyyy' where country_code = 'CH';
update country c set date_format = 'yyyy/M/d' where country_code = 'CN';
update country c set date_format = 'dd.MM.yyyy' where country_code = 'DE';
update country c set date_format = 'dd/MM/yyyy' where country_code = 'ES';
update country c set date_format = 'dd-MM-yyyy' where country_code = 'IN';
update country c set date_format = 'dd/MM/yyyy' where country_code = 'LU';
update country c set date_format = 'dd/MM/yyyy' where country_code = 'MY';
update country c set date_format = 'dd/MM/yyyy' where country_code = 'NZ';
update country c set date_format = 'dd.MM.yyyy' where country_code = 'RU';
update country c set date_format = 'dd.MM.yyyy' where country_code = 'UZ';
/*
select * from locale where country_code in('AF', 'CA', 'ZA') order by country_code;
select * from locale where country_code in('BA', 'CA', 'CH', 'CN', 'DE', 'ES', 'IN', 'LU', 'MY', 'NZ', 'RU', 'UZ');

select * from locale l where code in (
  select a.code from locale a inner join locale b on a.country_code = b.country_code  and a.code  != b.code) 
order by country_code, code;

select distinct country_code, country_name, date_format from locale l where code in (
  select a.code from locale a inner join locale b on a.country_code = b.country_code  and a.code  != b.code) 
order by country_code;
*/