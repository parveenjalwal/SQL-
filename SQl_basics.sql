create database sql_assignment ; 

use sql_assignment ;   

-- sql basic all qustion 

# 1. qustion 

-- creating a table emplyees 

create table employees (
emp_id int primary key , -- it means it only accepts null_null and unique value 
emp_name varchar(50) not null , -- should not be null 
age int check(age > 18) ,  -- age has to be more then 18 
email varchar(60) unique ,  -- each email id has to be unique
salary decimal (6,2) default 3000.00 ) ; -- values should be in decimals 

-- now our emplyees table has been created with all requred constrants 

select * from employees ; 


-- Qus2: Explain the purpose of constraints and how they help maintain data integrity in a database. Provide
--       examples of common types of constraints ? 

-- answer > constarants are simply way to take  our data which is being inserted in table in based on certain parmeters . constrants works as filtration 
-- only data or to be clear values which will only accept data which will met those written constrants . these are of genrlly six types 
-- primary key , forigion key 
-- not null , unique , default , check 

-- 1 not null >> it says when  any column is consist of this constrants then when data will be inserted any rows with respect to that sepcific column 
-- should not has to be null else data will not be accpted . 

-- 2 unique >> this is also an constrants which states while inserting data in our table each and every vales with respect to that column has to be unique . 
-- mean duplicate values are not allowed 

-- 3  default > it says when table is created there along with columns name an deffault values will be defined , if any case user does not provide 
 -- any value then that already defined values will be automatically fatched up . 
--  but if user defince vlaue then first priorty will be given to user defined values instead default values 

-- 4 check - it works asif conditions do . here after writing our col name we will be writing an spcific conditions which . afterwords when data will be inserted 
-- then only data which is going to statisfy that written condition will be accepted and fatched for table . there are chances some data might not full fill condition
-- then this data will not be taken . 




-- QUS 3 :: .Why would you apply the NOT NULL constraint to a column? Can a primary key contain NULL values? Justify your answer ? 

-- answer >> when we expect our data for any specific column to not having null values in such case we tend to write null values . in simple words any null any will not be 
-- allowed . mean each value has to have a certian data . on the other hand primary key is an  consrant. it says neither values can be null nor 
-- values can be duplicate when insreted values will match both conidtion then only will be allowed to be filled inside table . here we have two consition , in addtion 
-- a one table can only have one primary key not more then that . 
-- it eforces the uniqueness and eunsure that entigrity of data in table  , it improve our qurry performance and helps us create relatioship among two table where 
-- we refer table using forign key .. 




# QUS4 :  Explain the steps and SQL commands used to add or remove constraints on an existing table. Provide an
#         example for both adding and removing a constraint.

-- answer >> 
create table players_info(
player_id int  , 
name1 varchar (45) not null , 
state varchar (40) default 'India',
game varchar(34)  , 
play_time float , 
device char ); 

select * from players_info ;

-- now we have added unique constraints in our id columns 

alter table players_info add constraint unique (player_id) ;  

alter table players_info add constraint play_time check(play_time <= 6 ) ; 
-- now we added one more check constrsint in our table 
-- using these alter table we can add more constrint such as not null and default 


-- now remving these above pre existing constrint >> 
alter table players_info drop index player_id ;  
-- now using drop index i removed unique constrint from player_id column , however we can not use drop constrint here 

alter table players_info drop check play_time ;
-- here  we romved check constriant , but one observation here instead of writing  drop constrint , we are writing drop and reight nect its constrint name such as check \




# QUS 5 : Explain the consequences of attempting to insert, update, or delete data in a way that violates constraints.
#         Provide an example of an error message that might occur when violating a constraint.

-- answer >>  
-- atemplting to insert , update and delete in such a way that voilated constraints 

-- table 
create table players(
player_id int primary key, 
name1 varchar (45) not null , 
state varchar (40) default 'India',
game varchar(34) default 'cod' , 
device varchar(10) not null , 
age int check(age > 16) ,
duration int check(duration < 6 ));   

select * from players ; 

-- insert *** 

insert into players values 
(355,'parveen','rajasthan','cod','android',18,4) ; 
-- all values are fine and matches all constriants 

insert into players values 
(355,'parveen','rajasthan','cod','android',18,4) ;
-- it could not be inserted becasue here our player_id primary key is being voilated , its has duplicate key whcih is not accepted 
-- Error Code: 1062. Duplicate entry '355' for key 'players.PRIMARY'

insert into players values 
(435,'ravan','rajasthan','cod','android',14,4) ; 
-- it is voilating age check condition 
-- Error Code: 3819. Check constraint 'players_chk_1' is violated.

insert into players (player_id, state, game, device, age, duration)values 
(500,'rajasthan','cod','android',14,4) ; 
-- here we delibratly left name column null which again caused null vlaue error
 -- Error Code: 1364. Field 'name1' doesn't have a default value

insert into players (player_id, name1, device, age, duration) values 
(345,'rahul','apple',19,4) ; 
-- here we voildated default constraint , therefor all predefined default vlaues in those constraints were filled in place of these emply vlaues 


select * from players ;  
insert into players values 
(325,'akash','gujrat','mini militia','apple',17,4) ;

insert into players  (player_id, name1, game, device, age, duration) values 
(459,'aman','pubg','andriod',22,5) ; 
  
  -- update : 
  
  update players
  set game = 'free fire' 
  where player_id = 345 ; -- this one has been succesfull 
  
update players 
set age = 13 
where player_id = 459 ; 
-- here we tried replacing age of 459 id with 13 year which does not fullfill condition of check constrint 
-- Error Code: 3819. Check constraint 'players_chk_1' is violated.

SET SQL_SAFE_UPDATES = 0;

update players 
set player_id = 325 , duration = 7 
where name1 = 'parveen' ; 
-- here we are voilating two conitions firstly id was changed into 325 which is duplaicate of another moreover duration was changed into 7 wich agian volites check condition 

update players 
set name1 = "" 
where player_id = 355 ; 

select * from players ;

update players 
set name1 = NULL
where player_id = 345; 
-- here name1 not null constrint cond got voilated because of null entry 
-- Error Code: 1048. Column 'name1' cannot be null


-- delete : 
-- new table 
create table games (
game_id int primary key ,
size float default 1.0 ,
player_id int ,
foreign key(player_id) references players(player_id)); 

-- now attempting to delete -- 
select * from games ;

alter table games drop player_id ; 
-- here cuase it was forigen key which establish connection among two tables therefor it could not be delted . 
-- Error Code: 1828. Cannot drop column 'player_id': needed in a foreign key constraint 'games_ibfk_1'



# QUS 6 : You created a products table without constraints as follows ? 

CREATE TABLE products (
product_id INT,
product_name VARCHAR(50),
price DECIMAL(10, 2)); 

select * from products ; 
-- here our table has been created succsfully , now we just want to add some of more  constrint 
-- which should have been added previously .. 

-- firstly we are adding primary key in product_id column 

alter table products add primary key (product_id);  
-- here our primary key has been added succesfully in this table 

-- now its time to add peding default constrint in price 

alter table products alter price set default 50.00 ; 
-- here we added an default values in our price by setting a new 50 default value 



# QUS 7 :    You have two tables: qustion > Write a query to fetch the student_name and class_name for each student using an INNER JOIN.

-- creating two tables students and classes >> 
create table students (
student_id int unique ,
student_name varchar(50) not null ,
class_id int primary key ) ;

create table classes (
class_id int ,
class_name varchar(60) ,
foreign key(class_id) references students(class_id) ) ; 
-- here i defined class_id in forign key constraint to establish connection among them using primary key 

-- inserting data into both tables >> 
insert into students values 
(1,'Alice',101) ,
(2,'Bob',102) ,
(3,"Charlie",103) ; 

insert into classes values 
(101,'Math') ,
(102,"Science") , 
(103 , 'History') ; 

select * from students ; 
select * from classes ; 

-- answer of above qustion >> 

select  upper(s.student_name) as stud_name , upper(c.class_name) as class_name 
from students s 
inner join classes c 
on s.class_id = c.class_id ; 
-- here using inner join i have joined these both table where class_id is commen column 
-- here these new combined table is consist of stud_names and class_name 





# QUSTION 8 : Consider the following three tables: 
-- customers 1>  
-- orders 2 > 
-- prodcuts 3 > 

-- creating three tables >>> 
create table customers (
cust_id int primary key ,
cust_name varchar(50) not null ) ; 
-- here our first tables has been created which has cust_id as primary key 

create table orders ( 
order_id int primary key , -- here order_id is being considred as primary key 
order_date date ,
cust_id int ,
foreign key(cust_id) references customers(cust_id) ) ; 
-- here we defined cust_id as forign key in order to conncect this tble with above table by giving its refrance of customers table 

create table products ( 
product_id int primary key ,
product_name varchar(50) default 'unknown', 
order_id int  , 
foreign key(order_id)  references orders(order_id) ); 
-- here is our third table which has  product_id as primary id and 
-- here order_id is working as forign key which creats relation among products and orders table by refring orders tables based on order_id column 


-- nwo inserting data one by one in each table 

insert into customers values 
(101,'Alice') ,
(102,'Bob')  ; 

insert into orders values 
(1,'2024-01-01',101) ,
(2,'2024-01-03',102) ; 

-- now inserting in data into products 
insert into products values 
(1,'laptop',1) ; 

insert into products (product_id, product_name) values 
(2,'Phone') ; 
-- but in products table one order_id in null 

# accessing all tables 
select * from customers ;
select * from orders ;
select * from products ; 

-- nwo all dataset has been created succsfully 
-- qusrion from these tables >  Write a query that shows all order_id, customer_name, and product_name, ensuring that all products are
							#   listed even if they are not associated with an order 
				
# soltion 
select p.product_name , c.cust_name , p.order_id 
from products p 
left join orders o on o.order_id = p.order_id 
left join customers c on c.cust_id = o.cust_id ;  

-- here we joind first product table using left join with orders  which is taking whole product_name 
-- and its matching data from orders table . afterwards these combination of both table using left join mean taking whole data from these tabls
-- joined them with customers .. 
-- ulitimalty we got all corrponding cost_name and order_id with respect to product names 



# QUS 9 : 5 Given the following tables:

-- here again creating two tables >> 
 
create table products2 (
product_id int primary key ,
product_name varchar(50) not null ) ; 
-- here product_id is primary key 

create table sales2 (
sale_id  int primary key  ,
product_id int ,
amount int not null ,
foreign key(product_id) references products2(product_id) );  
-- both tables has been created succsufully 
-- here using forgin key in sales2 tabels creting an relationship with above products table 


-- now inserting data in these both tables 

insert into sales2 values 
(1,101,500) ,
(2,102,300) ,
(3,101,700) ;    

insert into products2 values 
(101,'laptop') ,
(102,'Phone') ; 
-- data has been installed in both tables 

select * from sales2 ;
select * from products2 ;   

-- qustion given from these tables is >> Write a query to find the total sales amount for each product using an INNER JOIN and the SUM() function. 

select s.product_id , pp.product_name , 
sum(amount) as total_sales 
from sales2 s 
inner join products2 pp 
on s.product_id = pp.product_id 
group by s.product_id ; 

-- first we took sales table and did some aggiration later joined that aggriated tabels with products table using inner join , which inly takes commen data from both table 
-- afterwards performed group by using product id to get total sales in each product _id  




# qusd 10 :  You are given three tables: > 

-- creating some tables .. 

create table customers10 (
cust_id int primary key ,
cust_name varchar(50) not null ) ;  
-- here in 1st table cust_id is the primary key here 

create table orders10 (
order_id int primary key , 
order_date date , 
cust_id int ,
foreign key(cust_id) references customers10(cust_id) ) ;  
-- 2nd table also has been created , and connected to abvoe customers10 table 


create table order_details10 (
order_id int , 
product_id int , 
quntity int not null ,
foreign key(order_id) references orders10(order_id) ) ;
-- this one is connected with above order table based on order_id column 


-- nwo inserting data in each and every table for further oprations 

insert into customers10 values 
(1,'Alice') ,
(2,'Bob') ; 

insert into orders10 values 
(1,'2024-01-02',1) ,
(2,'2024-01-05',2) ; 

insert into order_details10 values 
(1,101,2) ,
(1,102,1) ,
(2,101,3) ; 

-- data has been inserted into each table  

select * from customers10 ; 
select * from orders10 ; 
select * from order_details10; 

-- QUSTION : Write a query to display the order_id, customer_name, and the quantity of products ordered by each
		  -- customer using an INNER JOIN between all three tables.
          
          
# answer >. 
select od.order_id , upper(c.cust_name) as cust_nm ,
sum(od.quntity) as total_quntity   
from order_details10  od 
inner join  orders10 o  on o.order_id = od.order_id 
inner join customers10 c on c.cust_id = o.cust_id 
group by od.order_id ; 

-- here got answer after connecting these all tables using inner join 

-- '1', 'ALICE', '3'
-- '2', 'BOB',   '3' answer 











