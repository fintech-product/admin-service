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

insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('currency','Currency Management','A','/currencies','currency','local_atm',1,7,'setup');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('country','Country Management','A','/countries','country','public',2,7,'setup');
insert into modules (module_id,module_name,status,path,resource_key,icon,sequence,actions,parent) values ('locale','Locale Management','A','/locales','locale','public',3,7,'setup');

insert into roles (role_id, role_name, status, remark) values ('admin','Admin','A','Admin');
insert into roles (role_id, role_name, status, remark) values ('call_center','Call Center','A','Call Center');
insert into roles (role_id, role_name, status, remark) values ('it_support','IT Support','A','IT Support');
insert into roles (role_id, role_name, status, remark) values ('operator','Operator Group','A','Operator Group');
insert into roles (role_id, role_name, status, remark) values ('finance_writer','Finance Writer','A','Finance Writer');
insert into roles (role_id, role_name, status, remark) values ('finance_approver','Finance Approver','A','Finance Approver');

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
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'currency', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'country', 7);
insert into role_modules(role_id, module_id, permissions) values ('it_support', 'locale', 7);

insert into role_modules(role_id, module_id, permissions) values ('call_center', 'admin', 1);
insert into role_modules(role_id, module_id, permissions) values ('call_center', 'audit_log', 1);

insert into role_modules(role_id, module_id, permissions) values ('finance_writer', 'setup', 7);
insert into role_modules(role_id, module_id, permissions) values ('finance_writer', 'currency', 7);
insert into role_modules(role_id, module_id, permissions) values ('finance_approver', 'setup', 7);
insert into role_modules(role_id, module_id, permissions) values ('finance_approver', 'currency', 9);

insert into users (user_id,username,email,display_name,image_url,status,gender,phone,title,position) values ('aft2KNdQhi','gareth.bale','gareth.bale@gmail.com','Gareth Bale','https://upload.wikimedia.org/wikipedia/commons/thumb/1/1e/2022_FIFA_World_Cup_United_States_1%E2%80%931_Wales_-_%2832%29_%28cropped%29.jpg/250px-2022_FIFA_World_Cup_United_States_1%E2%80%931_Wales_-_%2832%29_%28cropped%29.jpg','A','M','0987654321','Mr','M');
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

insert into currency (code,symbol,decimal_digits,status) values
  ('AED','د.إ',2,'A'),
  ('AFN','؋',2,'A'),
  ('ALL','Lek',2,'A'),
  ('AMD','դր.',2,'A'),
  ('ARS','$',2,'A'),
  ('AUD','$',2,'A'),
  ('AZN','ман.',2,'A'),
  ('BAM','KM',2,'A'),
  ('BDT','৳',2,'A'),
  ('BGN','лв.',2,'A'),
  ('BHD','BD',3,'A'),
  ('BND','$',0,'A'),
  ('BOB','$b',2,'A'),
  ('BRL','R$',2,'A'),
  ('BYR','р.',2,'A'),
  ('BZD','BZ$',2,'A'),
  ('CAD','$',2,'A'),
  ('CHF','Fr.',2,'A'),
  ('CLP','$',2,'A'),
  ('CNY','¥',2,'A'),
  ('COP','$',2,'A'),
  ('CRC','₡',2,'A'),
  ('CSD','Дин.',2,'A'),
  ('CZK','Kč',2,'A'),
  ('DKK','kr.',2,'A'),
  ('DOP','RD$',2,'A'),
  ('DZD','DA',2,'A'),
  ('EEK','kr',2,'A'),
  ('EGP','£',2,'A'),
  ('ETB','Br',2,'A'),
  ('EUR','€',2,'A'),
  ('GBP','£',2,'A'),
  ('GEL','Lari',2,'A'),
  ('GTQ','Q',2,'A'),
  ('HKD','HK$',2,'A'),
  ('HNL','L.',2,'A'),
  ('HRK','kn',2,'A'),
  ('HUF','Ft',2,'A'),
  ('IDR','Rp',0,'A'),
  ('ILS','₪',2,'A'),
  ('INR','₹',2,'A'),
  ('IQD','ID',2,'A'),
  ('IRR','ريال',2,'A'),
  ('ISK','kr.',0,'A'),
  ('JMD','J$',2,'A'),
  ('JOD','د.أ',3,'A'),
  ('JPY','¥',0,'A'),
  ('KES','S',2,'A'),
  ('KGS','сом',2,'A'),
  ('KHR','៛',2,'A'),
  ('KRW','₩',0,'A'),
  ('KWD','KD',3,'A'),
  ('KZT','Т',2,'A'),
  ('LAK','₭',2,'A'),
  ('LBP','LL',2,'A'),
  ('LKR','රු.',2,'A'),
  ('LTL','Lt',2,'A'),
  ('LVL','Ls',2,'A'),
  ('LYD','LD',3,'A'),
  ('MAD','DH',2,'A'),
  ('MKD','ден.',2,'A'),
  ('MNT','₮',2,'A'),
  ('MOP','$',2,'A'),
  ('MVR','ރ.',2,'A'),
  ('MXN','$',2,'A'),
  ('MYR','RM',2,'A'),
  ('NIO','C$',2,'A'),
  ('NOK','kr',2,'A'),
  ('NPR','रु',2,'A'),
  ('NZD','$',2,'A'),
  ('OMR','R.O',3,'A'),
  ('PAB','B/.',2,'A'),
  ('PEN','S/.',2,'A'),
  ('PHP','₱',2,'A'),
  ('PKR','Rs',2,'A'),
  ('PLN','zł',2,'A'),
  ('PYG','Gs',2,'A'),
  ('QAR','QR',2,'A'),
  ('RON','lei',2,'A'),
  ('RSD','Дин.',2,'A'),
  ('RUB','һ.',2,'A'),
  ('RWF','R₣',2,'A'),
  ('SAR','SR',2,'A'),
  ('SEK','kr',2,'A'),
  ('SGD','$',2,'A'),
  ('SYP','LS',2,'A'),
  ('THB','฿',2,'A'),
  ('TJS','т.р.',2,'A'),
  ('TMT','m.',2,'A'),
  ('TND','DT',3,'A'),
  ('TRY','TL',2,'A'),
  ('TTD','TT$',2,'A'),
  ('TWD','NT$',2,'A'),
  ('UAH','₴',2,'A'),
  ('USD','$',2,'A'),
  ('UYU','$U',2,'A'),
  ('UZS','лв',0,'A'),
  ('VEF','Bs.',2,'A'),
  ('VND','₫',0,'A'),
  ('XOF','XOF',2,'A'),
  ('YER','﷼',2,'A'),
  ('ZAR','R',2,'A'),
  ('ZWL','Z$',2,'A');

insert into locale (code,name,native_name,country_code,country_name,native_country_name,date_format,first_day_of_week,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample) values
  ('af-ZA','Afrikaans (South Africa)','Afrikaans (Suid Afrika)','ZA','South Africa','Suid Afrika','yyyy/MM/dd',1,'.',',','ZAR','R',2,2,'R 10,000.00'),
  ('am-ET','Amharic (Ethiopia)','አማርኛ (ኢትዮጵያ)','ET','Ethiopia','ኢትዮጵያ','d/M/yyyy',1,'.',',','ETB','Br',2,0,'ETB10,000.00'),
  ('ar-AE','Arabic (U.A.E.)','العربية (الإمارات العربية المتحدة)','AE','U.A.E.','الإمارات العربية المتحدة','dd/MM/yyyy',7,'.',',','AED','د.إ',2,2,'د.إ.‏ 10,000.00'),
  ('ar-BH','Arabic (Bahrain)','العربية (البحرين)','BH','Bahrain','البحرين','dd/MM/yyyy',7,'.',',','BHD','BD',3,2,'د.ب.‏ 10,000.000'),
  ('ar-DZ','Arabic (Algeria)','العربية (الجزائر)','DZ','Algeria','الجزائر','dd-MM-yyyy',7,'.',',','DZD','DA',2,2,'د.ج.‏ 10,000.00'),
  ('ar-EG','Arabic (Egypt)','العربية (مصر)','EG','Egypt','مصر','dd/MM/yyyy',7,'.',',','EGP','£',2,2,'ج.م.‏ 10,000.00'),
  ('ar-IQ','Arabic (Iraq)','العربية (العراق)','IQ','Iraq','العراق','dd/MM/yyyy',7,'.',',','IQD','ID',2,2,'د.ع.‏ 10,000.00'),
  ('ar-JO','Arabic (Jordan)','العربية (الأردن)','JO','Jordan','الأردن','dd/MM/yyyy',7,'.',',','JOD','د.أ',3,2,'د.ا.‏ 10,000.000'),
  ('ar-KW','Arabic (Kuwait)','العربية (الكويت)','KW','Kuwait','الكويت','dd/MM/yyyy',7,'.',',','KWD','KD',3,2,'د.ك.‏ 10,000.000'),
  ('ar-LB','Arabic (Lebanon)','العربية (لبنان)','LB','Lebanon','لبنان','dd/MM/yyyy',2,'.',',','LBP','LL',2,2,'ل.ل.‏ 10,000.00'),
  ('ar-LY','Arabic (Libya)','العربية (ليبيا)','LY','Libya','ليبيا','dd/MM/yyyy',7,'.',',','LYD','LD',3,0,'د.ل.‏10,000.000'),
  ('ar-MA','Arabic (Morocco)','العربية (المملكة المغربية)','MA','Morocco','المملكة المغربية','dd-MM-yyyy',2,'.',',','MAD','DH',2,2,'د.م.‏ 10,000.00'),
  ('ar-OM','Arabic (Oman)','العربية (عمان)','OM','Oman','عمان','dd/MM/yyyy',7,'.',',','OMR','R.O',3,2,'ر.ع.‏ 10,000.000'),
  ('ar-QA','Arabic (Qatar)','العربية (قطر)','QA','Qatar','قطر','dd/MM/yyyy',7,'.',',','QAR','QR',2,2,'ر.ق.‏ 10,000.00'),
  ('ar-SA','Arabic (Saudi Arabia)','العربية (المملكة العربية السعودية)','SA','Saudi Arabia','المملكة العربية السعودية','dd/MM/yy',7,'.',',','SAR','SR',2,2,'ر.س.‏ 10,000.00'),
  ('ar-SY','Arabic (Syria)','العربية (سوريا)','SY','Syria','سوريا','dd/MM/yyyy',7,'.',',','SYP','LS',2,2,'ل.س.‏ 10,000.00'),
  ('ar-TN','Arabic (Tunisia)','العربية (تونس)','TN','Tunisia','تونس','dd-MM-yyyy',2,'.',',','TND','DT',3,2,'د.ت.‏ 10,000.000'),
  ('ar-YE','Arabic (Yemen)','العربية (اليمن)','YE','Yemen','اليمن','dd/MM/yyyy',7,'.',',','YER','﷼',2,2,'ر.ي.‏ 10,000.00'),
  ('arn-CL','Mapudungun (Chile)','Mapudungun (Chile)','CL','Chile','Chile','dd-MM-yyyy',1,',','.','CLP','$',2,2,'$ 10.000,00'),
  ('as-IN','Assamese (India)','অসমীয়া (ভাৰত)','IN','India','ভাৰত','dd-MM-yyyy',2,'.',',','INR','₹',2,1,'10,000.00ট'),
  ('az-Cyrl-AZ','Azeri (Cyrillic, Azerbaijan)','Азәрбајҹан (Азәрбајҹан)','AZ','Azerbaijan','Азәрбајҹан','dd.MM.yyyy',2,',',' ','AZN','ман.',2,3,'10 000,00 ман.'),
  ('az-Latn-AZ','Azeri (Latin, Azerbaijan)','Azərbaycan­ılı (Azərbaycan)','AZ','Azerbaijan','Azərbaycan','dd.MM.yyyy',2,',',' ','AZN','ман.',2,3,'10 000,00 man.'),
  ('ba-RU','Bashkir (Russia)','Башҡорт (Россия)','RU','Russia','Россия','dd.MM.yy',2,',',' ','RUB','һ.',2,3,'10 000,00 һ.'),
  ('be-BY','Belarusian (Belarus)','Беларускі (Беларусь)','BY','Belarus','Беларусь','dd.MM.yyyy',2,',',' ','BYR','р.',2,3,'10 000,00 р.'),
  ('bg-BG','Bulgarian (Bulgaria)','български (България)','BG','Bulgaria','България','d.M.yyyy ''г.''',2,',',' ','BGN','лв.',2,3,'10 000,00 лв.'),
  ('bn-BD','Bengali (Bangladesh)','বাংলা (বাংলাদেশ)','BD','Bangladesh','বাংলাদেশ','dd-MM-yy',2,'.',',','BDT','৳',2,2,'৳ 10,000.00'),
  ('bn-IN','Bengali (India)','বাংলা (ভারত)','IN','India','ভারত','dd-MM-yy',2,'.',',','INR','₹',2,2,'টা 10,000.00'),
  ('bo-CN','Tibetan (PRC)','བོད་ཡིག (ཀྲུང་ཧྭ་མི་དམངས་སྤྱི་མཐུན་རྒྱལ་ཁབ།)','CN','People''s Republic of China','ཀྲུང་ཧྭ་མི་དམངས་སྤྱི་མཐུན་རྒྱལ་ཁབ།','yyyy/M/d',2,'.',',','CNY','¥',2,0,'¥10,000.00'),
  ('br-FR','Breton (France)','brezhoneg (Frañs)','FR','France','Frañs','dd/MM/yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('bs-Cyrl-BA','Bosnian (Cyrillic, Bosnia and Herzegovina)','босански (Босна и Херцеговина)','BA','Bosnia and Herzegovina','Босна и Херцеговина','d.M.yyyy',2,',','.','BAM','KM',2,3,'10.000,00 КМ'),
  ('bs-Latn-BA','Bosnian (Latin, Bosnia and Herzegovina)','bosanski (Bosna i Hercegovina)','BA','Bosnia and Herzegovina','Bosna i Hercegovina','d.M.yyyy',2,',','.','BAM','KM',2,3,'10.000,00 KM'),
  ('ca-ES','Catalan (Catalan)','català (català)','ES','Spain','Espanya','dd/MM/yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('co-FR','Corsican (France)','Corsu (France)','FR','France','France','dd/MM/yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('cs-CZ','Czech (Czech Republic)','čeština (Česká republika)','CZ','Czech Republic','Česká republika','d.M.yyyy',2,',',' ','CZK','Kč',2,3,'10 000,00 Kč'),
  ('cy-GB','Welsh (United Kingdom)','Cymraeg (y Deyrnas Unedig)','GB','United Kingdom','y Deyrnas Unedig','dd/MM/yyyy',2,'.',',','GBP','£',2,0,'£10,000.00'),
  ('da-DK','Danish (Denmark)','dansk (Danmark)','DK','Denmark','Danmark','dd-MM-yyyy',2,',','.','DKK','kr.',2,2,'kr. 10.000,00'),
  ('de-AT','German (Austria)','Deutsch (Österreich)','AT','Austria','Österreich','dd.MM.yyyy',2,',','.','EUR','€',2,2,'€ 10.000,00'),
  ('de-CH','German (Switzerland)','Deutsch (Schweiz)','CH','Switzerland','Schweiz','dd.MM.yyyy',2,'.','''','CHF','Fr.',2,2,'Fr. 10''000.00'),
  ('de-DE','German (Germany)','Deutsch (Deutschland)','DE','Germany','Deutschland','dd.MM.yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('de-LI','German (Liechtenstein)','Deutsch (Liechtenstein)','LI','Liechtenstein','Liechtenstein','dd.MM.yyyy',2,'.','''','CHF','Fr.',2,2,'CHF 10''000.00'),
  ('de-LU','German (Luxembourg)','Deutsch (Luxemburg)','LU','Luxembourg','Luxemburg','dd.MM.yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('dsb-DE','Lower Sorbian (Germany)','dolnoserbšćina (Nimska)','DE','Germany','Nimska','d. M. yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('dv-MV','Divehi (Maldives)','ދިވެހިބަސް (ދިވެހި ރާއްޖެ)','MV','Maldives','ދިވެހި ރާއްޖެ','dd/MM/yy',1,'.',',','MVR','ރ.',2,3,'10,000.00 ރ.'),
  ('el-GR','Greek (Greece)','Ελληνικά (Ελλάδα)','GR','Greece','Ελλάδα','d/M/yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('en-029','English (Caribbean)','English (Caribbean)','29','Caribbean','Caribbean','MM/dd/yyyy',2,'.',',','USD','$',2,0,'$10,000.00'),
  ('en-AU','English (Australia)','English (Australia)','AU','Australia','Australia','d/MM/yyyy',2,'.',',','AUD','$',2,0,'$10,000.00'),
  ('en-BZ','English (Belize)','English (Belize)','BZ','Belize','Belize','dd/MM/yyyy',1,'.',',','BZD','BZ$',2,0,'BZ$10,000.00'),
  ('en-CA','English (Canada)','English (Canada)','CA','Canada','Canada','dd/MM/yyyy',1,'.',',','CAD','$',2,0,'$10,000.00'),
  ('en-GB','English (United Kingdom)','English (United Kingdom)','GB','United Kingdom','United Kingdom','dd/MM/yyyy',2,'.',',','GBP','£',2,0,'£10,000.00'),
  ('en-IE','English (Ireland)','English (Ireland)','IE','Ireland','Ireland','dd/MM/yyyy',2,'.',',','EUR','€',2,0,'€ 10,000.00'),
  ('en-IN','English (India)','English (India)','IN','India','India','dd-MM-yyyy',2,'.',',','INR','₹',2,2,'Rs. 10,000.00'),
  ('en-JM','English (Jamaica)','English (Jamaica)','JM','Jamaica','Jamaica','dd/MM/yyyy',1,'.',',','JMD','J$',2,0,'J$10,000.00'),
  ('en-MY','English (Malaysia)','English (Malaysia)','MY','Malaysia','Malaysia','d/M/yyyy',1,'.',',','MYR','RM',2,0,'RM10,000.00'),
  ('en-NZ','English (New Zealand)','English (New Zealand)','NZ','New Zealand','New Zealand','d/MM/yyyy',2,'.',',','NZD','$',2,0,'$10,000.00'),
  ('en-PH','English (Republic of the Philippines)','English (Philippines)','PH','Philippines','Philippines','M/d/yyyy',1,'.',',','PHP','₱',2,0,'Php10,000.00'),
  ('en-SG','English (Singapore)','English (Singapore)','SG','Singapore','Singapore','d/M/yyyy',1,'.',',','SGD','$',2,0,'$10,000.00'),
  ('en-TT','English (Trinidad and Tobago)','English (Trinidad y Tobago)','TT','Trinidad and Tobago','Trinidad y Tobago','dd/MM/yyyy',1,'.',',','TTD','TT$',2,0,'TT$10,000.00'),
  ('en-US','English (United States)','English (United States)','US','United States','United States','M/d/yyyy',1,'.',',','USD','$',2,0,'$10,000.00'),
  ('en-ZA','English (South Africa)','English (South Africa)','ZA','South Africa','South Africa','yyyy/MM/dd',1,',',' ','ZAR','R',2,2,'R 10 000.00'),
  ('en-ZW','English (Zimbabwe)','English (Zimbabwe)','ZW','Zimbabwe','Zimbabwe','M/d/yyyy',1,'.',',','ZWL','Z$',2,0,'Z$10,000.00'),
  ('es-AR','Spanish (Argentina)','Español (Argentina)','AR','Argentina','Argentina','dd/MM/yyyy',1,',','.','ARS','$',2,2,'$ 10.000,00'),
  ('es-BO','Spanish (Bolivia)','Español (Bolivia)','BO','Bolivia','Bolivia','dd/MM/yyyy',1,',','.','BOB','$b',2,2,'$b 10.000,00'),
  ('es-CL','Spanish (Chile)','Español (Chile)','CL','Chile','Chile','dd-MM-yyyy',1,',','.','CLP','$',2,2,'$ 10.000,00'),
  ('es-CO','Spanish (Colombia)','Español (Colombia)','CO','Colombia','Colombia','dd/MM/yyyy',1,',','.','COP','$',2,2,'$ 10.000,00'),
  ('es-CR','Spanish (Costa Rica)','Español (Costa Rica)','CR','Costa Rica','Costa Rica','dd/MM/yyyy',1,',','.','CRC','₡',2,0,'₡10.000,00'),
  ('es-DO','Spanish (Dominican Republic)','Español (República Dominicana)','DO','Dominican Republic','República Dominicana','dd/MM/yyyy',1,'.',',','DOP','RD$',2,0,'RD$10,000.00'),
  ('es-EC','Spanish (Ecuador)','Español (Ecuador)','EC','Ecuador','Ecuador','dd/MM/yyyy',1,',','.','USD','$',2,2,'$ 10.000,00'),
  ('es-ES','Spanish (Spain, International Sort)','Español (España, alfabetización internacional)','ES','Spain','España','dd/MM/yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('es-GT','Spanish (Guatemala)','Español (Guatemala)','GT','Guatemala','Guatemala','dd/MM/yyyy',1,'.',',','GTQ','Q',2,0,'Q10,000.00'),
  ('es-HN','Spanish (Honduras)','Español (Honduras)','HN','Honduras','Honduras','dd/MM/yyyy',1,'.',',','HNL','L.',2,2,'L. 10,000.00'),
  ('es-MX','Spanish (Mexico)','Español (México)','MX','Mexico','México','dd/MM/yyyy',1,'.',',','MXN','$',2,0,'$10,000.00'),
  ('es-NI','Spanish (Nicaragua)','Español (Nicaragua)','NI','Nicaragua','Nicaragua','dd/MM/yyyy',1,'.',',','NIO','C$',2,2,'C$ 10,000.00'),
  ('es-PA','Spanish (Panama)','Español (Panamá)','PA','Panama','Panamá','MM/dd/yyyy',1,'.',',','PAB','B/.',2,2,'B/. 10,000.00'),
  ('es-PE','Spanish (Peru)','Español (Perú)','PE','Peru','Perú','dd/MM/yyyy',1,'.',',','PEN','S/.',2,2,'S/. 10,000.00'),
  ('es-PR','Spanish (Puerto Rico)','Español (Puerto Rico)','PR','Puerto Rico','Puerto Rico','dd/MM/yyyy',1,'.',',','USD','$',2,2,'$10,000.00'),
  ('es-PY','Spanish (Paraguay)','Español (Paraguay)','PY','Paraguay','Paraguay','dd/MM/yyyy',2,',','.','PYG','Gs',2,2,'Gs 10.000,00'),
  ('es-SV','Spanish (El Salvador)','Español (El Salvador)','SV','El Salvador','El Salvador','dd/MM/yyyy',1,'.',',','USD','$',2,0,'$10,000.00'),
  ('es-US','Spanish (United States)','Español (Estados Unidos)','US','United States','Estados Unidos','M/d/yyyy',1,'.',',','USD','$',2,0,'$10,000.00'),
  ('es-UY','Spanish (Uruguay)','Español (Uruguay)','UY','Uruguay','Uruguay','dd/MM/yyyy',2,',','.','UYU','$U',2,2,'$U 10.000,00'),
  ('es-VE','Spanish (Bolivarian Republic of Venezuela)','Español (Republica Bolivariana de Venezuela)','VE','Bolivarian Republic of Venezuela','Republica Bolivariana de Venezuela','dd/MM/yyyy',1,',','.','VEF','Bs.',2,2,'Bs. F. 10.000,00'),
  ('et-EE','Estonian (Estonia)','eesti (Eesti)','EE','Estonia','Eesti','d.MM.yyyy',2,'.',' ','EEK','kr',2,3,'10 000,00 kr'),
  ('eu-ES','Basque (Basque)','euskara (euskara)','ES','Spain','Espainia','yyyy/MM/dd',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('fa-IR','Persian','فارسى (ایران)','IR','Iran','ایران','MM/dd/yyyy',7,'٫',',','IRR','ريال',2,2,'ريال 10,000.00'),
  ('fi-FI','Finnish (Finland)','suomi (Suomi)','FI','Finland','Suomi','d.M.yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('fil-PH','Filipino (Philippines)','Filipino (Pilipinas)','PH','Philippines','Pilipinas','M/d/yyyy',1,'.',',','PHP','₱',2,0,'PhP10,000.00'),
  ('fo-FO','Faroese (Faroe Islands)','føroyskt (Føroyar)','FO','Faroe Islands','Føroyar','dd-MM-yyyy',2,',','.','DKK','kr.',2,2,'kr. 10.000,00'),
  ('fr-BE','French (Belgium)','français (Belgique)','BE','Belgium','Belgique','d/MM/yyyy',2,',','.','EUR','€',2,2,'€ 10.000,00'),
  ('fr-CA','French (Canada)','français (Canada)','CA','Canada','Canada','yyyy-MM-dd',1,',',' ','CAD','$',2,3,'10 000,00 $'),
  ('fr-CH','French (Switzerland)','français (Suisse)','CH','Switzerland','Suisse','dd.MM.yyyy',2,'.','''','CHF','Fr.',2,2,'fr. 10''000.00'),
  ('fr-FR','French (France)','français (France)','FR','France','France','dd/MM/yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('fr-LU','French (Luxembourg)','français (Luxembourg)','LU','Luxembourg','Luxembourg','dd/MM/yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('fr-MC','French (Monaco)','français (Principauté de Monaco)','MC','Principality of Monaco','Principauté de Monaco','dd/MM/yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('fy-NL','Frisian (Netherlands)','Frysk (Nederlân)','NL','Netherlands','Nederlân','d-M-yyyy',2,',','.','EUR','€',2,2,'€ 10.000,00'),
  ('ga-IE','Irish (Ireland)','Gaeilge (Éire)','IE','Ireland','Éire','dd/MM/yyyy',2,'.',',','EUR','€',2,0,'€ 10,000.00'),
  ('gd-GB','Scottish Gaelic (United Kingdom)','Gàidhlig (An Rìoghachd Aonaichte)','GB','United Kingdom','An Rìoghachd Aonaichte','dd/MM/yyyy',2,'.',',','GBP','£',2,0,'£10,000.00'),
  ('gl-ES','Galician (Galician)','galego (galego)','ES','Spain','España','dd/MM/yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('gsw-FR','Alsatian (France)','Elsässisch (Frànkrisch)','FR','France','Frànkrisch','dd/MM/yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('gu-IN','Gujarati (India)','ગુજરાતી (ભારત)','IN','India','ભારત','dd-MM-yy',2,'.',',','INR','₹',2,2,'રૂ 10,000.00'),
  ('ha-Latn-NG','Hausa (Latin, Nigeria)','Hausa (Nigeria)','NG','Nigeria','Nigeria','d/M/yyyy',1,'.',',','NIO','C$',2,2,'N 10,000.00'),
  ('he-IL','Hebrew (Israel)','עברית (ישראל)','IL','Israel','ישראל','dd/MM/yyyy',1,'.',',','ILS','₪',2,2,'₪ 10,000.00'),
  ('hi-IN','Hindi (India)','हिंदी (भारत)','IN','India','भारत','dd-MM-yyyy',2,'.',',','INR','₹',2,2,'रु 10,000.00'),
  ('hr-BA','Croatian (Latin, Bosnia and Herzegovina)','hrvatski (Bosna i Hercegovina)','BA','Bosnia and Herzegovina','Bosna i Hercegovina','d.M.yyyy',2,',','.','BAM','KM',2,3,'10.000,00 KM'),
  ('hr-HR','Croatian (Croatia)','hrvatski (Hrvatska)','HR','Croatia','Hrvatska','d.M.yyyy.',2,',','.','HRK','kn',2,3,'10.000,00 kn'),
  ('hsb-DE','Upper Sorbian (Germany)','hornjoserbšćina (Němska)','DE','Germany','Němska','d. M. yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('hu-HU','Hungarian (Hungary)','magyar (Magyarország)','HU','Hungary','Magyarország','yyyy.MM.dd.',2,',',' ','HUF','Ft',2,3,'10 000,00 Ft'),
  ('hy-AM','Armenian (Armenia)','Հայերեն (Հայաստան)','AM','Armenia','Հայաստան','dd.MM.yyyy',2,'.',',','AMD','դր.',2,3,'10,000.00 դր.'),
  ('id-ID','Indonesian (Indonesia)','Bahasa Indonesia (Indonesia)','ID','Indonesia','Indonesia','dd/MM/yyyy',2,',','.','IDR','Rp',0,0,'Rp10.000'),
  ('ig-NG','Igbo (Nigeria)','Igbo (Nigeria)','NG','Nigeria','Nigeria','d/M/yyyy',1,'.',',','NIO','C$',2,2,'N 10,000.00'),
  ('ii-CN','Yi (PRC)','ꆈꌠꁱꂷ (ꍏꉸꏓꂱꇭꉼꇩ)','CN','People''s Republic of China','ꍏꉸꏓꂱꇭꉼꇩ','yyyy/M/d',2,'.',',','CNY','¥',2,0,'¥10,000.00'),
  ('is-IS','Icelandic (Iceland)','íslenska (Ísland)','IS','Iceland','Ísland','d.M.yyyy',2,',','.','ISK','kr.',0,3,'10.000 kr.'),
  ('it-CH','Italian (Switzerland)','italiano (Svizzera)','CH','Switzerland','Svizzera','dd.MM.yyyy',2,'.','''','CHF','Fr.',2,2,'fr. 10''000.00'),
  ('it-IT','Italian (Italy)','italiano (Italia)','IT','Italy','Italia','dd/MM/yyyy',2,',','.','EUR','€',2,2,'€ 10.000,00'),
  ('iu-Cans-CA','Inuktitut (Syllabics, Canada)','ᐃᓄᒃᑎᑐᑦ (ᑲᓇᑕᒥ)','CA','Canada','ᑲᓇᑕ','d/M/yyyy',1,'.',',','CAD','$',2,0,'$10,000.00'),
  ('iu-Latn-CA','Inuktitut (Latin, Canada)','Inuktitut (Kanatami)','CA','Canada','kanata','d/MM/yyyy',1,'.',',','CAD','$',2,0,'$10,000.00'),
  ('ja-JP','Japanese (Japan)','日本語 (日本)','JP','Japan','日本','yyyy/MM/dd',1,'.',',','JPY','¥',0,0,'¥10,000'),
  ('ka-GE','Georgian (Georgia)','ქართული (საქართველო)','GE','Georgia','საქართველო','dd.MM.yyyy',2,',',' ','GEL','Lari',2,3,'10 000,00 Lari'),
  ('kk-KZ','Kazakh (Kazakhstan)','Қазақ (Қазақстан)','KZ','Kazakhstan','Қазақстан','dd.MM.yyyy',2,',',' ','KZT','Т',2,0,'Т10 000,00'),
  ('kl-GL','Greenlandic (Greenland)','kalaallisut (Kalaallit Nunaat)','GL','Greenland','Kalaallit Nunaat','dd-MM-yyyy',2,',','.','DKK','kr.',2,2,'kr. 10.000,00'),
  ('km-KH','Khmer (Cambodia)','ខ្មែរ (កម្ពុជា)','KH','Cambodia','កម្ពុជា','yyyy-MM-dd',1,'.',',','KHR','៛',2,1,'10,000.00៛'),
  ('kn-IN','Kannada (India)','ಕನ್ನಡ (ಭಾರತ)','IN','India','ಭಾರತ','dd-MM-yy',2,'.',',','INR','₹',2,2,'ರೂ 10,000.00'),
  ('ko-KR','Korean (Korea)','한국어 (대한민국)','KR','Korea','대한민국','yyyy-MM-dd',1,'.',',','KRW','₩',0,0,'₩10,000'),
  ('kok-IN','Konkani (India)','कोंकणी (भारत)','IN','India','भारत','dd-MM-yyyy',2,'.',',','INR','₹',2,2,'रु 10,000.00'),
  ('ky-KG','Kyrgyz (Kyrgyzstan)','Кыргыз (Кыргызстан)','KG','Kyrgyzstan','Кыргызстан','dd.MM.yy',2,',',' ','KGS','сом',2,3,'10 000,00 сом'),
  ('lb-LU','Luxembourgish (Luxembourg)','Lëtzebuergesch (Luxembourg)','LU','Luxembourg','Luxembourg','dd/MM/yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('lo-LA','Lao (Lao P.D.R.)','ລາວ (ສ.ປ.ປ. ລາວ)','LA','Lao P.D.R.','ສ.ປ.ປ. ລາວ','dd/MM/yyyy',1,'.',',','LAK','₭',2,1,'10,000.00₭'),
  ('lt-LT','Lithuanian (Lithuania)','lietuvių (Lietuva)','LT','Lithuania','Lietuva','yyyy.MM.dd',2,',','.','LTL','Lt',2,3,'10.000,00 Lt'),
  ('lv-LV','Latvian (Latvia)','latviešu (Latvija)','LV','Latvia','Latvija','yyyy.MM.dd.',2,',',' ','LVL','Ls',2,2,'Ls 10 000,00'),
  ('mi-NZ','Maori (New Zealand)','Reo Māori (Aotearoa)','NZ','New Zealand','Aotearoa','dd/MM/yyyy',2,'.',',','NZD','$',2,0,'$10,000.00'),
  ('mk-MK','Macedonian (Former Yugoslav Republic of Macedonia)','македонски јазик (Македонија)','MK','Macedonia (FYROM)','Македонија','dd.MM.yyyy',2,',','.','MKD','ден.',2,3,'10.000,00 ден.'),
  ('ml-IN','Malayalam (India)','മലയാളം (ഭാരതം)','IN','India','ഭാരതം','dd-MM-yy',2,'.',',','INR','₹',2,2,'ക 10,000.00'),
  ('mn-MN','Mongolian (Cyrillic, Mongolia)','Монгол хэл (Монгол улс)','MN','Mongolia','Монгол улс','yy.MM.dd',2,',',' ','MNT','₮',2,1,'10 000,00₮'),
  ('mn-Mong-CN','Mongolian (Traditional Mongolian, PRC)','ᠮᠤᠨᠭᠭᠤᠯ ᠬᠡᠯᠡ (ᠪᠦᠭᠦᠳᠡ ᠨᠠᠢᠷᠠᠮᠳᠠᠬᠤ ᠳᠤᠮᠳᠠᠳᠤ ᠠᠷᠠᠳ ᠣᠯᠣᠰ)','CN','People''s Republic of China','ᠪᠦᠭᠦᠳᠡ ᠨᠠᠢᠷᠠᠮᠳᠠᠬᠤ ᠳᠤᠮᠳᠠᠳᠤ ᠠᠷᠠᠳ ᠣᠯᠣᠰ','yyyy/M/d',2,'.',',','CNY','¥',2,0,'¥10,000.00'),
  ('moh-CA','Mohawk (Mohawk)','Kanien''kéha','CA','Canada','Canada','M/d/yyyy',1,'.',',','CAD','$',2,0,'$10,000.00'),
  ('mr-IN','Marathi (India)','मराठी (भारत)','IN','India','भारत','dd-MM-yyyy',2,'.',',','INR','₹',2,2,'रु 10,000.00'),
  ('ms-BN','Malay (Brunei Darussalam)','Bahasa Melayu (Brunei Darussalam)','BN','Brunei Darussalam','Brunei Darussalam','dd/MM/yyyy',2,',','.','BND','$',0,0,'$10.00'),
  ('ms-MY','Malay (Malaysia)','Bahasa Melayu (Malaysia)','MY','Malaysia','Malaysia','dd/MM/yyyy',2,'.',',','MYR','RM',2,0,'RM10,000'),
  ('mt-MT','Maltese (Malta)','Malti (Malta)','MT','Malta','Malta','dd/MM/yyyy',2,'.',',','EUR','€',2,0,'€ 10,000.00'),
  ('nb-NO','Norwegian, Bokmål (Norway)','norsk, bokmål (Norge)','NO','Norway','Norge','dd.MM.yyyy',2,',',' ','NOK','kr',2,2,'kr 10 000,00'),
  ('ne-NP','Nepali (Nepal)','नेपाली (नेपाल)','NP','Nepal','नेपाल','M/d/yyyy',1,'.',',','NPR','रु',2,0,'रु10,000.00'),
  ('nl-BE','Dutch (Belgium)','Nederlands (België)','BE','Belgium','België','d/MM/yyyy',2,',','.','EUR','€',2,2,'€ 10.000,00'),
  ('nl-NL','Dutch (Netherlands)','Nederlands (Nederland)','NL','Netherlands','Nederland','d-M-yyyy',2,',','.','EUR','€',2,2,'€ 10.000,00'),
  ('nn-NO','Norwegian, Nynorsk (Norway)','norsk, nynorsk (Noreg)','NO','Norway','Noreg','dd.MM.yyyy',2,',',' ','NOK','kr',2,2,'kr 10 000,00'),
  ('nso-ZA','Sesotho sa Leboa (South Africa)','Sesotho sa Leboa (Afrika Borwa)','ZA','South Africa','Afrika Borwa','yyyy/MM/dd',1,'.',',','ZAR','R',2,2,'R 10,000.00'),
  ('oc-FR','Occitan (France)','Occitan (França)','FR','France','França','dd/MM/yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('or-IN','Oriya (India)','ଓଡ଼ିଆ (ଭାରତ)','IN','India','ଭାରତ','dd-MM-yy',1,'.',',','INR','₹',2,2,'ଟ 10,000.00'),
  ('pa-IN','Punjabi (India)','ਪੰਜਾਬੀ (ਭਾਰਤ)','IN','India','ਭਾਰਤ','dd-MM-yy',2,'.',',','INR','₹',2,2,'ਰੁ 10,000.00'),
  ('pl-PL','Polish (Poland)','polski (Polska)','PL','Poland','Polska','yyyy-MM-dd',2,',',' ','PLN','zł',2,3,'10 000,00 zł'),
  ('prs-AF','Dari (Afghanistan)','درى (افغانستان)','AF','Afghanistan','افغانستان','dd/MM/yy',6,'.',',','AFN','؋',2,0,'؋10.000,00'),
  ('ps-AF','Pashto (Afghanistan)','پښتو (افغانستان)','AF','Afghanistan','افغانستان','dd/MM/yy',7,'٫','٬','AFN','؋',2,0,'؋10،000,00'),
  ('pt-BR','Portuguese (Brazil)','Português (Brasil)','BR','Brazil','Brasil','dd/MM/yyyy',1,',','.','BRL','R$',2,2,'R$ 10.000,00'),
  ('pt-PT','Portuguese (Portugal)','português (Portugal)','PT','Portugal','Portugal','dd-MM-yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('qut-GT','K''iche (Guatemala)','K''iche (Guatemala)','GT','Guatemala','Guatemala','dd/MM/yyyy',1,'.',',','GTQ','Q',2,0,'Q10,000.00'),
  ('quz-BO','Quechua (Bolivia)','runasimi (Qullasuyu)','BO','Bolivia','Bolivia Suyu','dd/MM/yyyy',1,',','.','BOB','$b',2,2,'$b 10.000,00'),
  ('quz-EC','Quechua (Ecuador)','runasimi (Ecuador)','EC','Ecuador','Ecuador Suyu','dd/MM/yyyy',1,',','.','USD','$',2,2,'$ 10.000,00'),
  ('quz-PE','Quechua (Peru)','runasimi (Piruw)','PE','Peru','Peru Suyu','dd/MM/yyyy',1,'.',',','PEN','S/.',2,2,'S/. 10,000.00'),
  ('rm-CH','Romansh (Switzerland)','Rumantsch (Svizra)','CH','Switzerland','Svizra','dd/MM/yyyy',2,'.','''','CHF','Fr.',2,2,'fr. 10''000.00'),
  ('ro-RO','Romanian (Romania)','română (România)','RO','Romania','România','dd.MM.yyyy',2,',','.','RON','lei',2,3,'10.000,00 lei'),
  ('ru-RU','Russian (Russia)','русский (Россия)','RU','Russia','Россия','dd.MM.yyyy',2,',',' ','RUB','һ.',2,1,'10 000,00р.'),
  ('rw-RW','Kinyarwanda (Rwanda)','Kinyarwanda (Rwanda)','RW','Rwanda','Rwanda','M/d/yyyy',1,',',' ','RWF','R₣',2,2,'RWF 10 000,00'),
  ('sa-IN','Sanskrit (India)','संस्कृत (भारतम्)','IN','India','भारतम्','dd-MM-yyyy',1,'.',',','INR','₹',2,2,'रु 10,000.00'),
  ('sah-RU','Yakut (Russia)','саха (Россия)','RU','Russia','Россия','MM.dd.yyyy',2,',',' ','RUB','һ.',2,1,'10 000,00с.'),
  ('se-FI','Sami, Northern (Finland)','davvisámegiella (Suopma)','FI','Finland','Suopma','d.M.yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('se-NO','Sami, Northern (Norway)','davvisámegiella (Norga)','NO','Norway','Norga','dd.MM.yyyy',2,',',' ','NOK','kr',2,2,'kr 10 000,00'),
  ('se-SE','Sami, Northern (Sweden)','davvisámegiella (Ruoŧŧa)','SE','Sweden','Ruoŧŧa','yyyy-MM-dd',2,',','.','SEK','kr',2,3,'10 000,00 kr'),
  ('si-LK','Sinhala (Sri Lanka)','සිංහල (ශ්‍රී ලංකා)','LK','Sri Lanka','ශ්‍රී ලංකා','yyyy-MM-dd',2,'.',',','LKR','රු.',2,2,'රු. 10,000.00'),
  ('sk-SK','Slovak (Slovakia)','slovenčina (Slovenská republika)','SK','Slovakia','Slovenská republika','d. M. yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('sl-SI','Slovenian (Slovenia)','slovenski (Slovenija)','SI','Slovenia','Slovenija','d.M.yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('sma-NO','Sami, Southern (Norway)','åarjelsaemiengiele (Nöörje)','NO','Norway','Nöörje','dd.MM.yyyy',2,',',' ','NOK','kr',2,2,'kr 10 000,00'),
  ('sma-SE','Sami, Southern (Sweden)','åarjelsaemiengiele (Sveerje)','SE','Sweden','Sveerje','yyyy-MM-dd',2,',','.','SEK','kr',2,3,'10 000,00 kr'),
  ('smj-NO','Sami, Lule (Norway)','julevusámegiella (Vuodna)','NO','Norway','Vuodna','dd.MM.yyyy',2,',',' ','NOK','kr',2,2,'kr 10 000,00'),
  ('smj-SE','Sami, Lule (Sweden)','julevusámegiella (Svierik)','SE','Sweden','Svierik','yyyy-MM-dd',2,',','.','SEK','kr',2,3,'10 000,00 kr'),
  ('smn-FI','Sami, Inari (Finland)','sämikielâ (Suomâ)','FI','Finland','Suomâ','d.M.yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('sms-FI','Sami, Skolt (Finland)','sääm´ǩiõll (Lää´ddjânnam)','FI','Finland','Lää´ddjânnam','d.M.yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('sq-AL','Albanian (Albania)','shqipe (Shqipëria)','AL','Albania','Shqipëria','yyyy-MM-dd',2,',','.','ALL','Lek',2,1,'10.000,00Lek'),
  ('sr-Cyrl-BA','Serbian (Cyrillic, Bosnia and Herzegovina)','српски (Босна и Херцеговина)','BA','Bosnia and Herzegovina','Босна и Херцеговина','d.M.yyyy',2,',','.','BAM','KM',2,3,'10.000,00 КМ'),
  ('sr-Cyrl-CS','Serbian (Cyrillic, Serbia and Montenegro (Former))','српски (Србија и Црна Гора (Претходно))','CS','Serbia and Montenegro (Former)','Србија и Црна Гора (Претходно)','d.M.yyyy',2,',','.','CSD','Дин.',2,3,'10.000,00 Дин.'),
  ('sr-Cyrl-ME','Serbian (Cyrillic, Montenegro)','српски (Црна Гора)','ME','Montenegro','Црна Гора','d.M.yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('sr-Cyrl-RS','Serbian (Cyrillic, Serbia)','српски (Србија)','RS','Serbia','Србија','d.M.yyyy',2,',','.','RSD','Дин.',2,3,'10.000,00 Дин.'),
  ('sr-Latn-BA','Serbian (Latin, Bosnia and Herzegovina)','srpski (Bosna i Hercegovina)','BA','Bosnia and Herzegovina','Bosna i Hercegovina','d.M.yyyy',2,',','.','BAM','KM',2,3,'10.000,00 KM'),
  ('sr-Latn-CS','Serbian (Latin, Serbia and Montenegro (Former))','srpski (Srbija i Crna Gora (Prethodno))','CS','Serbia and Montenegro (Former)','Srbija i Crna Gora (Prethodno)','d.M.yyyy',2,',','.','CSD','Дин.',2,3,'10.000,00 Din.'),
  ('sr-Latn-ME','Serbian (Latin, Montenegro)','srpski (Crna Gora)','ME','Montenegro','Crna Gora','d.M.yyyy',2,',','.','EUR','€',2,3,'10.000,00 €'),
  ('sr-Latn-RS','Serbian (Latin, Serbia)','srpski (Srbija)','RS','Serbia','Srbija','d.M.yyyy',2,',','.','RSD','Дин.',2,3,'10.000,00 Din.'),
  ('sv-FI','Swedish (Finland)','svenska (Finland)','FI','Finland','Finland','d.M.yyyy',2,',',' ','EUR','€',2,3,'10 000,00 €'),
  ('sv-SE','Swedish (Sweden)','svenska (Sverige)','SE','Sweden','Sverige','yyyy-MM-dd',2,',','.','SEK','kr',2,3,'10 000,00 kr'),
  ('sw-KE','Kiswahili (Kenya)','Kiswahili (Kenya)','KE','Kenya','Kenya','M/d/yyyy',1,'.',',','KES','S',2,0,'S10,000.00'),
  ('syr-SY','Syriac (Syria)','ܣܘܪܝܝܐ (سوريا)','SY','Syria','سوريا','dd/MM/yyyy',7,'.',',','SYP','LS',2,2,'ل.س.‏ 10,000.00'),
  ('ta-IN','Tamil (India)','தமிழ் (இந்தியா)','IN','India','இந்தியா','dd-MM-yyyy',2,'.',',','INR','₹',2,2,'ரூ 10,000.00'),
  ('te-IN','Telugu (India)','తెలుగు (భారత దేశం)','IN','India','భారత దేశం','dd-MM-yy',2,'.',',','INR','₹',2,2,'రూ 10,000.00'),
  ('tg-Cyrl-TJ','Tajik (Cyrillic, Tajikistan)','Тоҷикӣ (Тоҷикистон)','TJ','Tajikistan','Тоҷикистон','dd.MM.yy',1,',',' ','TJS','т.р.',2,3,'10 000,00 т.р.'),
  ('th-TH','Thai (Thailand)','ไทย (ไทย)','TH','Thailand','ไทย','d/M/yyyy',2,'.',',','THB','฿',2,0,'฿10,000.00'),
  ('tk-TM','Turkmen (Turkmenistan)','türkmençe (Türkmenistan)','TM','Turkmenistan','Türkmenistan','dd.MM.yy',2,',',' ','TMT','m.',2,1,'10 000,00m.'),
  ('tn-ZA','Setswana (South Africa)','Setswana (Aforika Borwa)','ZA','South Africa','Aforika Borwa','yyyy/MM/dd',1,'.',',','ZAR','R',2,2,'R 10,000.00'),
  ('tr-TR','Turkish (Turkey)','Türkçe (Türkiye)','TR','Turkey','Türkiye','dd.MM.yyyy',2,',','.','TRY','TL',2,3,'10.000,00 TL'),
  ('tt-RU','Tatar (Russia)','Татар (Россия)','RU','Russia','Россия','dd.MM.yyyy',2,',',' ','RUB','һ.',2,3,'10 000,00 р.'),
  ('tzm-Latn-DZ','Tamazight (Latin, Algeria)','Tamazight (Djazaïr)','DZ','Algeria','Djazaïr','dd-MM-yyyy',7,'.',',','DZD','DA',2,3,'10.000,00 DZD'),
  ('ug-CN','Uyghur (PRC)','ئۇيغۇرچە (جۇڭخۇا خەلق جۇمھۇرىيىتى)','CN','People''s Republic of China','جۇڭخۇا خەلق جۇمھۇرىيىتى','yyyy-M-d',1,'.',',','CNY','¥',2,0,'¥10,000.00'),
  ('uk-UA','Ukrainian (Ukraine)','українська (Україна)','UA','Ukraine','Україна','dd.MM.yyyy',2,',',' ','UAH','₴',2,1,'10 000,00₴'),
  ('ur-PK','Urdu (Islamic Republic of Pakistan)','اُردو (پاکستان)','PK','Islamic Republic of Pakistan','پاکستان','dd/MM/yyyy',2,'.',',','PKR','Rs',2,0,'Rs10,000.00'),
  ('uz-Cyrl-UZ','Uzbek (Cyrillic, Uzbekistan)','Ўзбек (Ўзбекистон)','UZ','Uzbekistan','Ўзбекистон Республикаси','dd.MM.yyyy',2,',',' ','UZS','лв',0,3,'10 000,00 сўм'),
  ('uz-Latn-UZ','Uzbek (Latin, Uzbekistan)','U''zbek (U''zbekiston Respublikasi)','UZ','Uzbekistan','U''zbekiston Respublikasi','dd/MM yyyy',2,',',' ','UZS','лв',0,3,'10 000 so''m'),
  ('vi-VN','Vietnamese (Vietnam)','Tiếng Việt (Việt Nam)','VN','Vietnam','Việt Nam','dd/MM/yyyy',2,',','.','VND','₫',0,3,'10.000,00 ₫'),
  ('wo-SN','Wolof (Senegal)','Wolof (Sénégal)','SN','Senegal','Sénégal','dd/MM/yyyy',2,',',' ','XOF','XOF',2,3,'10 000,00 XOF'),
  ('xh-ZA','isiXhosa (South Africa)','isiXhosa (uMzantsi Afrika)','ZA','South Africa','uMzantsi Afrika','yyyy/MM/dd',1,'.',',','ZAR','R',2,2,'R 10,000.00'),
  ('yo-NG','Yoruba (Nigeria)','Yoruba (Nigeria)','NG','Nigeria','Nigeria','d/M/yyyy',1,'.',',','NIO','C$',2,2,'N 10,000.00'),
  ('zh-CN','Chinese (Simplified, PRC)','中文(中华人民共和国)','CN','People''s Republic of China','中华人民共和国','yyyy/M/d',1,'.',',','CNY','¥',2,0,'¥10,000.00'),
  ('zh-HK','Chinese (Traditional, Hong Kong S.A.R.)','中文(香港特別行政區)','HK','Hong Kong S.A.R.','香港特別行政區','d/M/yyyy',1,'.',',','HKD','HK$',2,0,'HK$10,000.00'),
  ('zh-MO','Chinese (Traditional, Macao S.A.R.)','中文(澳門特別行政區)','MO','Macao S.A.R.','澳門特別行政區','d/M/yyyy',1,'.',',','MOP','$',2,0,'MOP10,000.00'),
  ('zh-SG','Chinese (Simplified, Singapore)','中文(新加坡)','SG','Singapore','新加坡','d/M/yyyy',1,'.',',','SGD','$',2,0,'$10,000.00'),
  ('zh-TW','Chinese (Traditional, Taiwan)','中文(台灣)','TW','Taiwan','台灣','yyyy/M/d',1,'.',',','TWD','NT$',2,0,'NT$10,000.00'),
  ('zu-ZA','isiZulu (South Africa)','isiZulu (iNingizimu Afrika)','ZA','South Africa','iNingizimu Afrika','yyyy/MM/dd',1,'.',',','ZAR','R',2,2,'R 10,000.00');

insert into country (country_code,country_name,native_country_name,date_format,decimal_separator,group_separator,currency_code,currency_symbol,currency_decimal_digits,currency_pattern,currency_sample,status) values
  ('29','Caribbean','Caribbean','MM/dd/yyyy','.',',','USD','$',2,0,'$10,000.00','A'),
  ('AE','U.A.E.','الإمارات العربية المتحدة','dd/MM/yyyy','.',',','AED','د.إ',2,2,'د.إ.‏ 10,000.00','A'),
  ('AF','Afghanistan','افغانستان','dd/MM/yy','.',',','AFN','؋',2,0,'؋10.000,00','A'),
  ('AL','Albania','Shqipëria','yyyy-MM-dd',',','.','ALL','Lek',2,1,'10.000,00Lek','A'),
  ('AM','Armenia','Հայաստան','dd.MM.yyyy','.',',','AMD','դր.',2,3,'10,000.00 դր.','A'),
  ('AR','Argentina','Argentina','dd/MM/yyyy',',','.','ARS','$',2,2,'$ 10.000,00','A'),
  ('AT','Austria','Österreich','dd.MM.yyyy',',','.','EUR','€',2,2,'€ 10.000,00','A'),
  ('AU','Australia','Australia','d/MM/yyyy','.',',','AUD','$',2,0,'$10,000.00','A'),
  ('AZ','Azerbaijan','Azərbaycan','dd.MM.yyyy',',',' ','AZN','ман.',2,3,'10 000,00 man.','A'),
  ('BA','Bosnia and Herzegovina','Bosna i Hercegovina','d.M.yyyy',',','.','BAM','KM',2,3,'10.000,00 KM','A'),
  ('BD','Bangladesh','বাংলাদেশ','dd-MM-yy','.',',','BDT','৳',2,2,'৳ 10,000.00','A'),
  ('BE','Belgium','België','d/MM/yyyy',',','.','EUR','€',2,2,'€ 10.000,00','A'),
  ('BG','Bulgaria','България','d.M.yyyy ''г.''',',',' ','BGN','лв.',2,3,'10 000,00 лв.','A'),
  ('BH','Bahrain','البحرين','dd/MM/yyyy','.',',','BHD','BD',3,2,'د.ب.‏ 10,000.000','A'),
  ('BN','Brunei Darussalam','Brunei Darussalam','dd/MM/yyyy',',','.','BND','$',0,0,'$10.00','A'),
  ('BO','Bolivia','Bolivia','dd/MM/yyyy',',','.','BOB','$b',2,2,'$b 10.000,00','A'),
  ('BR','Brazil','Brasil','dd/MM/yyyy',',','.','BRL','R$',2,2,'R$ 10.000,00','A'),
  ('BY','Belarus','Беларусь','dd.MM.yyyy',',',' ','BYR','р.',2,3,'10 000,00 р.','A'),
  ('BZ','Belize','Belize','dd/MM/yyyy','.',',','BZD','BZ$',2,0,'BZ$10,000.00','A'),
  ('CA','Canada','Canada','dd/MM/yyyy','.',',','CAD','$',2,0,'$10,000.00','A'),
  ('CH','Switzerland','Schweiz','dd.MM.yyyy','.','''','CHF','Fr.',2,2,'Fr. 10''000.00','A'),
  ('CL','Chile','Chile','dd-MM-yyyy',',','.','CLP','$',2,2,'$ 10.000,00','A'),
  ('CN','People''s Republic of China','中华人民共和国','yyyy/M/d','.',',','CNY','¥',2,0,'¥10,000.00','A'),
  ('CO','Colombia','Colombia','dd/MM/yyyy',',','.','COP','$',2,2,'$ 10.000,00','A'),
  ('CR','Costa Rica','Costa Rica','dd/MM/yyyy',',','.','CRC','₡',2,0,'₡10.000,00','A'),
  ('CS','Serbia and Montenegro (Former)','Srbija i Crna Gora (Prethodno)','d.M.yyyy',',','.','CSD','Дин.',2,3,'10.000,00 Din.','A'),
  ('CZ','Czech Republic','Česká republika','d.M.yyyy',',',' ','CZK','Kč',2,3,'10 000,00 Kč','A'),
  ('DE','Germany','Deutschland','dd.MM.yyyy',',','.','EUR','€',2,3,'10.000,00 €','A'),
  ('DK','Denmark','Danmark','dd-MM-yyyy',',','.','DKK','kr.',2,2,'kr. 10.000,00','A'),
  ('DO','Dominican Republic','República Dominicana','dd/MM/yyyy','.',',','DOP','RD$',2,0,'RD$10,000.00','A'),
  ('DZ','Algeria','الجزائر','dd-MM-yyyy','.',',','DZD','DA',2,2,'د.ج.‏ 10,000.00','A'),
  ('EC','Ecuador','Ecuador','dd/MM/yyyy',',','.','USD','$',2,2,'$ 10.000,00','A'),
  ('EE','Estonia','Eesti','d.MM.yyyy','.',' ','EEK','kr',2,3,'10 000,00 kr','A'),
  ('EG','Egypt','مصر','dd/MM/yyyy','.',',','EGP','£',2,2,'ج.م.‏ 10,000.00','A'),
  ('ES','Spain','España','dd/MM/yyyy',',','.','EUR','€',2,3,'10.000,00 €','A'),
  ('ET','Ethiopia','ኢትዮጵያ','d/M/yyyy','.',',','ETB','Br',2,0,'ETB10,000.00','A'),
  ('FI','Finland','Suomi','d.M.yyyy',',',' ','EUR','€',2,3,'10 000,00 €','A'),
  ('FO','Faroe Islands','Føroyar','dd-MM-yyyy',',','.','DKK','kr.',2,2,'kr. 10.000,00','A'),
  ('FR','France','France','dd/MM/yyyy',',',' ','EUR','€',2,3,'10 000,00 €','A'),
  ('GB','United Kingdom','United Kingdom','dd/MM/yyyy','.',',','GBP','£',2,0,'£10,000.00','A'),
  ('GE','Georgia','საქართველო','dd.MM.yyyy',',',' ','GEL','Lari',2,3,'10 000,00 Lari','A'),
  ('GL','Greenland','Kalaallit Nunaat','dd-MM-yyyy',',','.','DKK','kr.',2,2,'kr. 10.000,00','A'),
  ('GR','Greece','Ελλάδα','d/M/yyyy',',','.','EUR','€',2,3,'10.000,00 €','A'),
  ('GT','Guatemala','Guatemala','dd/MM/yyyy','.',',','GTQ','Q',2,0,'Q10,000.00','A'),
  ('HK','Hong Kong S.A.R.','香港特別行政區','d/M/yyyy','.',',','HKD','HK$',2,0,'HK$10,000.00','A'),
  ('HN','Honduras','Honduras','dd/MM/yyyy','.',',','HNL','L.',2,2,'L. 10,000.00','A'),
  ('HR','Croatia','Hrvatska','d.M.yyyy.',',','.','HRK','kn',2,3,'10.000,00 kn','A'),
  ('HU','Hungary','Magyarország','yyyy.MM.dd.',',',' ','HUF','Ft',2,3,'10 000,00 Ft','A'),
  ('ID','Indonesia','Indonesia','dd/MM/yyyy',',','.','IDR','Rp',0,0,'Rp10.000','A'),
  ('IE','Ireland','Éire','dd/MM/yyyy','.',',','EUR','€',2,0,'€ 10,000.00','A'),
  ('IL','Israel','ישראל','dd/MM/yyyy','.',',','ILS','₪',2,2,'₪ 10,000.00','A'),
  ('IN','India','भारत','dd-MM-yyyy','.',',','INR','₹',2,2,'रु 10,000.00','A'),
  ('IQ','Iraq','العراق','dd/MM/yyyy','.',',','IQD','ID',2,2,'د.ع.‏ 10,000.00','A'),
  ('IR','Iran','ایران','MM/dd/yyyy','٫',',','IRR','ريال',2,2,'ريال 10,000.00','A'),
  ('IS','Iceland','Ísland','d.M.yyyy',',','.','ISK','kr.',0,3,'10.000 kr.','A'),
  ('IT','Italy','Italia','dd/MM/yyyy',',','.','EUR','€',2,2,'€ 10.000,00','A'),
  ('JM','Jamaica','Jamaica','dd/MM/yyyy','.',',','JMD','J$',2,0,'J$10,000.00','A'),
  ('JO','Jordan','الأردن','dd/MM/yyyy','.',',','JOD','د.أ',3,2,'د.ا.‏ 10,000.000','A'),
  ('JP','Japan','日本','yyyy/MM/dd','.',',','JPY','¥',0,0,'¥10,000','A'),
  ('KE','Kenya','Kenya','M/d/yyyy','.',',','KES','S',2,0,'S10,000.00','A'),
  ('KG','Kyrgyzstan','Кыргызстан','dd.MM.yy',',',' ','KGS','сом',2,3,'10 000,00 сом','A'),
  ('KH','Cambodia','កម្ពុជា','yyyy-MM-dd','.',',','KHR','៛',2,1,'10,000.00៛','A'),
  ('KR','Korea','대한민국','yyyy-MM-dd','.',',','KRW','₩',0,0,'₩10,000','A'),
  ('KW','Kuwait','الكويت','dd/MM/yyyy','.',',','KWD','KD',3,2,'د.ك.‏ 10,000.000','A'),
  ('KZ','Kazakhstan','Қазақстан','dd.MM.yyyy',',',' ','KZT','Т',2,0,'Т10 000,00','A'),
  ('LA','Lao P.D.R.','ສ.ປ.ປ. ລາວ','dd/MM/yyyy','.',',','LAK','₭',2,1,'10,000.00₭','A'),
  ('LB','Lebanon','لبنان','dd/MM/yyyy','.',',','LBP','LL',2,2,'ل.ل.‏ 10,000.00','A'),
  ('LI','Liechtenstein','Liechtenstein','dd.MM.yyyy','.','','CHF','Fr.',2,2,'CHF 10''000.00','A'),
  ('LK','Sri Lanka','ශ්‍රී ලංකා','yyyy-MM-dd','.',',','LKR','රු.',2,2,'රු. 10,000.00','A'),
  ('LT','Lithuania','Lietuva','yyyy.MM.dd',',','.','LTL','Lt',2,3,'10.000,00 Lt','A'),
  ('LU','Luxembourg','Luxembourg','dd/MM/yyyy',',','.','EUR','€',2,3,'10 000,00 €','A'),
  ('LV','Latvia','Latvija','yyyy.MM.dd.',',',' ','LVL','Ls',2,2,'Ls 10 000,00','A'),
  ('LY','Libya','ليبيا','dd/MM/yyyy','.',',','LYD','LD',3,0,'د.ل.‏10,000.000','A'),
  ('MA','Morocco','المملكة المغربية','dd-MM-yyyy','.',',','MAD','DH',2,2,'د.م.‏ 10,000.00','A'),
  ('MC','Principality of Monaco','Principauté de Monaco','dd/MM/yyyy',',',' ','EUR','€',2,3,'10 000,00 €','A'),
  ('ME','Montenegro','Crna Gora','d.M.yyyy',',','.','EUR','€',2,3,'10.000,00 €','A'),
  ('MK','Macedonia (FYROM)','Македонија','dd.MM.yyyy',',','.','MKD','ден.',2,3,'10.000,00 ден.','A'),
  ('MN','Mongolia','Монгол улс','yy.MM.dd',',',' ','MNT','₮',2,1,'10 000,00₮','A'),
  ('MO','Macao S.A.R.','澳門特別行政區','d/M/yyyy','.',',','MOP','$',2,0,'MOP10,000.00','A'),
  ('MT','Malta','Malta','dd/MM/yyyy','.',',','EUR','€',2,0,'€ 10,000.00','A'),
  ('MV','Maldives','ދިވެހި ރާއްޖެ','dd/MM/yy','.',',','MVR','ރ.',2,3,'10,000.00 ރ.','A'),
  ('MX','Mexico','México','dd/MM/yyyy','.',',','MXN','$',2,0,'$10,000.00','A'),
  ('MY','Malaysia','Malaysia','dd/MM/yyyy','.',',','MYR','RM',0,0,'RM10,000','A'),
  ('NG','Nigeria','Nigeria','d/M/yyyy','.',',','NIO','C$',2,2,'N 10,000.00','A'),
  ('NI','Nicaragua','Nicaragua','dd/MM/yyyy','.',',','NIO','C$',2,2,'C$ 10,000.00','A'),
  ('NL','Netherlands','Nederland','d-M-yyyy',',','.','EUR','€',2,2,'€ 10.000,00','A'),
  ('NO','Norway','Noreg','dd.MM.yyyy',',',' ','NOK','kr',2,2,'kr 10 000,00','A'),
  ('NP','Nepal','नेपाल','M/d/yyyy','.',',','NPR','रु',2,0,'रु10,000.00','A'),
  ('NZ','New Zealand','New Zealand','dd/MM/yyyy','.',',','NZD','$',2,0,'$10,000.00','A'),
  ('OM','Oman','عمان','dd/MM/yyyy','.',',','OMR','R.O',3,2,'ر.ع.‏ 10,000.000','A'),
  ('PA','Panama','Panamá','MM/dd/yyyy','.',',','PAB','B/.',2,2,'B/. 10,000.00','A'),
  ('PE','Peru','Perú','dd/MM/yyyy','.',',','PEN','S/.',2,2,'S/. 10,000.00','A'),
  ('PH','Philippines','Pilipinas','M/d/yyyy','.',',','PHP','₱',2,0,'PhP10,000.00','A'),
  ('PK','Islamic Republic of Pakistan','پاکستان','dd/MM/yyyy','.',',','PKR','Rs',2,0,'Rs10,000.00','A'),
  ('PL','Poland','Polska','yyyy-MM-dd',',',' ','PLN','zł',2,3,'10 000,00 zł','A'),
  ('PR','Puerto Rico','Puerto Rico','dd/MM/yyyy','.',',','USD','$',2,2,'$10,000.00','A'),
  ('PT','Portugal','Portugal','dd-MM-yyyy',',','.','EUR','€',2,3,'10.000,00 €','A'),
  ('PY','Paraguay','Paraguay','dd/MM/yyyy',',','.','PYG','Gs',2,2,'Gs 10.000,00','A'),
  ('QA','Qatar','قطر','dd/MM/yyyy','.',',','QAR','QR',2,2,'ر.ق.‏ 10,000.00','A'),
  ('RO','Romania','România','dd.MM.yyyy',',','.','RON','lei',2,3,'10.000,00 lei','A'),
  ('RS','Serbia','Srbija','d.M.yyyy',',','.','RSD','Дин.',2,3,'10.000,00 Din.','A'),
  ('RU','Russia','Россия','dd.MM.yyyy',',',' ','RUB','һ.',2,1,'10 000,00р.','A'),
  ('RW','Rwanda','Rwanda','M/d/yyyy',',',' ','RWF','R₣',2,2,'RWF 10 000,00','A'),
  ('SA','Saudi Arabia','المملكة العربية السعودية','dd/MM/yy','.',',','SAR','SR',2,2,'ر.س.‏ 10,000.00','A'),
  ('SE','Sweden','Sverige','yyyy-MM-dd',',','.','SEK','kr',2,3,'10 000,00 kr','A'),
  ('SG','Singapore','Singapore','d/M/yyyy','.',',','SGD','$',2,0,'$10,000.00','A'),
  ('SI','Slovenia','Slovenija','d.M.yyyy',',','.','EUR','€',2,3,'10.000,00 €','A'),
  ('SK','Slovakia','Slovenská republika','d. M. yyyy',',',' ','EUR','€',2,3,'10 000,00 €','A'),
  ('SN','Senegal','Sénégal','dd/MM/yyyy',',',' ','XOF','XOF',2,3,'10 000,00 XOF','A'),
  ('SV','El Salvador','El Salvador','dd/MM/yyyy','.',',','USD','$',2,0,'$10,000.00','A'),
  ('SY','Syria','سوريا','dd/MM/yyyy','.',',','SYP','LS',2,2,'ل.س.‏ 10,000.00','A'),
  ('TH','Thailand','ไทย','d/M/yyyy','.',',','THB','฿',2,0,'฿10,000.00','A'),
  ('TJ','Tajikistan','Тоҷикистон','dd.MM.yy',',',' ','TJS','т.р.',2,3,'10 000,00 т.р.','A'),
  ('TM','Turkmenistan','Türkmenistan','dd.MM.yy',',',' ','TMT','m.',2,1,'10 000,00m.','A'),
  ('TN','Tunisia','تونس','dd-MM-yyyy','.',',','TND','DT',3,2,'د.ت.‏ 10,000.000','A'),
  ('TR','Turkey','Türkiye','dd.MM.yyyy',',','.','TRY','TL',2,3,'10.000,00 TL','A'),
  ('TT','Trinidad and Tobago','Trinidad y Tobago','dd/MM/yyyy','.',',','TTD','TT$',2,0,'TT$10,000.00','A'),
  ('TW','Taiwan','台灣','yyyy/M/d','.',',','TWD','NT$',2,0,'NT$10,000.00','A'),
  ('UA','Ukraine','Україна','dd.MM.yyyy',',',' ','UAH','₴',2,1,'10 000,00₴','A'),
  ('US','United States','United States','M/d/yyyy','.',',','USD','$',2,0,'$10,000.00','A'),
  ('UY','Uruguay','Uruguay','dd/MM/yyyy',',','.','UYU','$U',2,2,'$U 10.000,00','A'),
  ('UZ','Uzbekistan','U''zbekiston Respublikasi','dd.MM.yyyy',',',' ','UZS','лв',0,3,'10 000 so''m','A'),
  ('VE','Bolivarian Republic of Venezuela','Republica Bolivariana de Venezuela','dd/MM/yyyy',',','.','VEF','Bs.',2,2,'Bs. F. 10.000,00','A'),
  ('VN','Vietnam','Việt Nam','dd/MM/yyyy',',','.','VND','₫',0,3,'10.000,00 ₫','A'),
  ('YE','Yemen','اليمن','dd/MM/yyyy','.',',','YER','﷼',2,2,'ر.ي.‏ 10,000.00','A'),
  ('ZA','South Africa','South Africa','yyyy/MM/dd',',',' ','ZAR','R',2,2,'R 10 000.00','A'),
  ('ZW','Zimbabwe','Zimbabwe','M/d/yyyy','.',',','ZWL','Z$',2,0,'Z$10,000.00','A');
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