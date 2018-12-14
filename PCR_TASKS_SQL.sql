USE PCR_NEW;
/*... SELECT queries ...*/

SELECT * FROM company;
SELECT * FROM report;
SELECT * FROM section;
SELECT * FROM sectionData;
SELECT * FROM heading;
SELECT * FROM users;


/*...  CREATE queries   ...*/

CREATE TABLE company (
CIN  char(21) NOT NULL  PRIMARY KEY,
cName  varchar(50)  NOT NULL,
cAddress  varchar(250)  NOT NULL,
startData date NOT NULL,
otherInfo  varchar(150)  DEFAULT NULL,
logo varchar(200) NOT NULL
);

CREATE TABLE report (
RID int NOT NULL PRIMARY KEY IDENTITY(1,1),
rName varchar(50) NOT NULL,
rDate date NOT NULL,
CIN char(21) FOREIGN KEY REFERENCES company(CIN) NOT NULL,
otherInfo varchar(150)  DEFAULT NULL 
);

 CREATE TABLE section(
 SID int NOT NULL PRIMARY KEY IDENTITY(1,1),
 sName  varchar(50) NOT NULL,
 fixed  int  DEFAULT 0
 );

 CREATE TABLE sectionData (
 SDID int NOT NULL PRIMARY KEY IDENTITY(1,1),
 SID int NOT NULL FOREIGN KEY REFERENCES section(SID),
 sData varchar(max) DEFAULT NULL,
 otherInfo varchar(150)  DEFAULT NULL,
 RID int FOREIGN KEY REFERENCES report(RID) NOT NULL 
 );

 CREATE TABLE heading (
 HID int NOT NULL PRIMARY KEY IDENTITY(1,1),
 hName varchar(50) NOT NULL,
 hData varchar(max) DEFAULT NULL,
 SDID int FOREIGN KEY REFERENCES sectionData(SDID) NOT NULL
 );
 
 CREATE TABLE users (
 email varchar(50) NOT NULL PRIMARY KEY,
 password varchar(16) NOT NULL,
 name varchar(50) NOT NULL,
 mobile bigint NOT NULL,
 address varchar(250) DEFAULT NULL,
 gender char(1) NOT NULL,
 role varchar(100) NOT NULL,
 RID int FOREIGN KEY REFERENCES report(RID) NOT NULL,
 fullAccess int DEFAULT 0 
 );
 
 CREATE TABLE progress (
 PID int NOT NULL PRIMARY KEY IDENTITY(1,1),
 RID int FOREIGN KEY REFERENCES report(RID) NOT NULL,
 email varchar(50) FOREIGN KEY REFERENCES users(email) NOT NULL,
 action varchar(20) NOT NULL,
 date datetime NOT NULL,
 );
 
 /*.............. changes  ......*/
 
 ALTER TABLE report
 ADD progressLavel int DEFAULT 2
 
 UPDATE report
 SET progressLavel = 2
 WHERE RID = 1
 
 UPDATE report
 SET progressLavel = 2
 WHERE RID = 2
 
 UPDATE report
 SET progressLavel = 2
 WHERE RID = 3
 
 UPDATE report
 SET progressLavel = 2
 WHERE RID = 4
 
 ALTER TABLE progress
 ADD didAction varchar(50) FOREIGN KEY REFERENCES users(email) NOT NULL
 /*...  INSERT queries ... */ 
 
 INSERT INTO company(CIN,cName,cAddress,startData,otherInfo,logo)
       VALUES('AM123456789AM12345678', 'AMAZON', 'AMAZON DLF,Cyber city','1111-11-11', 'other information of AMAZON',
	          'D:\Cold_Fusion_project\PCR_TASKS\Assets\serverLogo\AM123456789AM12345678.png');
 INSERT INTO company(CIN,cName,cAddress,startData,otherInfo,logo)
       VALUES('FL123456789FL12345678', 'FLIPKART', 'FLIPKART DLF,Cyber city','1191-11-11', 'other information of FLIPKART',
	           'D:\Cold_Fusion_project\PCR_TASKS\Assets\serverLogo\FL123456789FL12345678.png');


 INSERT INTO report(rName,rDate,CIN)
       VALUES('AMAZON FIRST REPORT', '2018-11-11','AM123456789AM12345678'); 
 INSERT INTO report(rName,rDate,CIN,otherInfo)
       VALUES('AMAZON SECOND REPORT', '2018-10-09','AM123456789AM12345678','THIS is other info');
 INSERT INTO report(rName,rDate,CIN)
       VALUES('FLIPKART FIRST REPORT', '2018-10-10','FL123456789FL12345678');  
 INSERT INTO report(rName,rDate,CIN)
       VALUES('FLIPKART SECOND REPORT', '2018-10-15','FL123456789FL12345678'); 

       
 INSERT INTO section(sName,fixed)
	   VALUES ('Analytical Overview',1); 
 INSERT INTO section(sName,fixed)
	   VALUES ('Highlights',1); 	    
 INSERT INTO section(sName,fixed)
	   VALUES ('Financial Snapshot',1); 
 INSERT INTO section(sName,fixed)
	   VALUES ('Financial Table',1);
 INSERT INTO section(sName,fixed)
	   VALUES ('Financial Map',1);
 INSERT INTO section(sName,fixed)
	   VALUES ('Financial Chart',1);
 /* not fix 
	   
 INSERT INTO section(sName,fixed)
	   VALUES ('Analytical Not',0); 
  INSERT INTO section(sName,fixed)
	   VALUES ('Financial Not',0); 
  INSERT INTO section(sName,fixed)
	   VALUES ('Highlights Not',0); */
 

 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(1,'This is Analytical Overview data of amazon first report',1);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(2,NULL,1);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(3,NULL,1);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(4,'This is data of amazon',1);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(5,'This is financial map data of amazon first report',1);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(6,NULL,1);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(1,'This is Analytical Overview data of amazon second report',2);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(2,NULL,2);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(3,NULL,2);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(4,'This is data of amazon',2);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(5,'This is financial map data of amazon second report',2);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(6,NULL,2);
INSERT INTO sectionData(SID,sData,RID)
	   VALUES(1,'This is Analytical Overview data of flipkart first report',3);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(2,NULL,3);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(3,NULL,3);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(4,'This is data of flipkart',3);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(5,'This is financial map data of flipkart first report',3);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(6,NULL,3);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(1,'This is Analytical Overview data of flipkart second report',4);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(2,NULL,4);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(3,NULL,4);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(4,'This is data of flipkart',4);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(5,'This is financial map data of flipkart second report',4);
 INSERT INTO sectionData(SID,sData,RID)
	   VALUES(6,NULL,4);

/*
INSERT INTO heading(hName,hData,SDID)
	   VALUES('Heading1','Heading data of section',3);
 INSERT INTO heading(hName,hData,SDID)
	   VALUES('Heading2','Heading2 data of section',3);
 INSERT INTO heading(hName,hData,SDID)
	   VALUES('Heading3','Heading3 data of section',3);
 INSERT INTO heading(hName,hData,SDID)
	   VALUES('Heading4','Heading4 data of section',3);
 INSERT INTO heading(hName,hData,SDID)
	   VALUES('Heading5','Heading5 data of section',3);
 INSERT INTO heading(hName,hData,SDID)
	   VALUES('Heading6','Heading6 data of section',12);
 INSERT INTO heading(hName,hData,SDID)
	   VALUES('Heading7','Heading7 data of section',12);
 INSERT INTO heading(hName,hData,SDID)
	   VALUES('Heading8','Heading8 data of section',12);
*/
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 	    VALUES('default@gmail.com',hashbytes('md5','Default@123'),'Deafult',9999933385,'abcd 1/34 block','M','Research','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('anil@gmail.com',hashbytes('md5','Anil@123'),'Anil Singh',9999933385,'abcd 1/34 block','M','Research','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('ankur@gmail.com',hashbytes('md5','Ankur@123'),'John Parker',9999999985,'abc 1/3 block','M','Research','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('jarrett@gmail.com',hashbytes('md5','Jarrett@123'),'Jarrett C',9954999432,'a 1/6 block','M','Research','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('jim@gmail.com',hashbytes('md5','Jimc@123'),'Jimy Cycle',9954943432,'a 1/9 block','M','Research','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('jonb@gmail.com',hashbytes('md5','Jonb@123'),'Jon Barash',9955443432,'b 2/9 block','M','Real Estate','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('josua@gmail.com',hashbytes('md5','Josua@123'),'Josua Suffin',4355443432,'b 2/2 block','M','Real Estate','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('marc@gmail.com',hashbytes('md5','Marc@123'),'Marc Heller',4355673432,'b 2/3 block','M','Real Estate','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('alan@gmail.com',hashbytes('md5','Alan@123'),'Alan Lee',4355673432,'c 3/1 block','M','Analyst Team','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('andrew@gmail.com',hashbytes('md5','Andrew@123'),'Andrew Cote',9855673432,'d 4/2 block','M','Analyst Team','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('owen@gmail.com',hashbytes('md5','Owen@123'),'Owen Meyer',9955673432,'d 3/3 block','M','Analyst Team','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('skyler@gmail.com',hashbytes('md5','Skyler@123'),'Skyler Admin',9955673499,'A 1/3 block','M','Admin','AM123456789AM12345678',1);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('robert@gmail.com',hashbytes('md5','Robert@123'),'Robert Marzo',7689456372,'d 1/3 block','M','Executive Management','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('steve@gmail.com',hashbytes('md5','Steve@123'),'Steve Dove',7689456543,'F 11/3 block','M','Executive Management','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('kevin@gmail.com',hashbytes('md5','Kevin@123'),'Kevin Slack',7689453453,'G 10/3 block','M','Executive Management','AM123456789AM12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('joanne@gmail.com',hashbytes('md5','Joanne@123'),'Joanne Fanara',9955673123,'A 1/4 block','M','Admin','AM123456789AM12345678',1);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('marlenni@gmail.com',hashbytes('md5','Marlenni@123'),'Marlenni Lovos',9955673234,'A 1/5 block','M','Admin','AM123456789AM12345678',1);

 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('ankit@gmail.com',hashbytes('md5','Ankit@123'),'Marlenni Lovos',9955673234,'A 1/5 block','M','Admin','FL123456789FL12345678',1);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('simmy@gmail.com',hashbytes('md5','Simmy@123'),'Simmy Fanara',9955673231,'E 1/5 block','F','Executive Management','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('timmy@gmail.com',hashbytes('md5','Timmy@123'),'Timmy Fanara',9955673987,'E 1/5 block','F','Executive Management','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('johny@gmail.com',hashbytes('md5','Johny@123'),'Johny Heller',9951233987,'E 1/5 block','M','Executive Management','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('sunny@gmail.com',hashbytes('md5','Sunny@123'),'Sunny Tellor',9951233375,'F 5/9 block','M','Analyst Team','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('tonny@gmail.com',hashbytes('md5','Tonny@123'),'Tonny Heller',9951233399,'A 5/4 block','M','Analyst Team','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('lara@gmail.com',hashbytes('md5','Lara@123'),'Lara Slack',9951233388,'B 9/1 block','M','Analyst Team','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('parker@gmail.com',hashbytes('md5','Parker@123'),'Parker More',9951231199,'R 5/4 block','M','Real Estate','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('dove@gmail.com',hashbytes('md5','Dove@123'),'Dove Parker',9951231199,'R 10/4 block','M','Real Estate','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('slack@gmail.com',hashbytes('md5','Slack@123'),'Slack Heller',9951231199,'R1 /4 block','M','Real Estate','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('fanara@gmail.com',hashbytes('md5','Fanara@123'),'Fanara Heller',9951231559,'T1 /4 block','M','Research','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('kanara@gmail.com',hashbytes('md5','Kanara@123'),'Kanara Teller',9951231511,'T3 /4 block','M','Research','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('sitara@gmail.com',hashbytes('md5','Sitara@123'),'Sitara Dove',9951231500,'T4 4/4 block','M','Research','FL123456789FL12345678',0);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('flip@gmail.com',hashbytes('md5','Flip@123'),'Flip Dove',9951230000,'A5 4/4 block','M','Admin','FL123456789FL12345678',1);
 
 
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('arunyc2@gmail.com',hashbytes('md5','Arun@123'),'Arun Yadav',9951230011,'B5 4/4 block','F','Admin','FL123456789FL12345678',1);
 INSERT INTO users(email,password,name,mobile,address,gender,role,CIN,fullAccess)
 		VALUES('harshgupta951114@gmail.com',hashbytes('md5','Harsh@123'),'Harsh More',9951230221,'C5 4/4 block','F','Admin','FL123456789FL12345678',1);
 		/*.............................................................................................*/

	   
	   
	   
	   
	   
	   
	   
	   
	        