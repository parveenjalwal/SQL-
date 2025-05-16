-- SQl commends 
use mavenmovies ;  
 
-- here all data is taken from maven movies >. 

# qus1: -Identify the primary keys and foreign keys in maven movies db. Discuss the differences

#answer >> 
select TABLE_NAME , COLUMN_NAME , CONSTRAINT_NAME, REFERENCED_TABLE_NAME, REFERENCED_COLUMN_NAME
FROM INFORMATION_SCHEMA.KEY_COLUMN_USAGE
WHERE TABLE_SCHEMA = 'MavenMovies'; 


 # qus 2 :  List all details of actors 
 
-- answer >>
select * from actor ; 


# qus 3: List all customer information from DB.
-- answer >> 
select * from customer ;  


#QUS 4 :  -List different countries. country
# answer >> 
select country_id , upper(country) as country 
from country ; 


#QUS 5 :  Display all active customers

#answer : 
select * 
from customer
where active = 1  and  active is not null;  


# QUS6 : List of all rental IDs for customer with ID 1.

# answer >> 
select  rental_id , customer_id 
from rental 
where staff_id = 1 and staff_id is not null ;   


# QUS7 : Display all the films whose rental duration is greater than 5 . 

# answer >> 
select lower(title) as title , lower(description) as discrip , rental_duration 
from film 
where rental_duration > 5 
order by rental_duration desc ; 


# QUS 8  :  List the total number of films whose replacement cost is greater than $15 and less than $20.

 #answer > 
 select title , description , replacement_cost 
 from film 
 where replacement_cost between 15 and 20 ;  
 
 
 #QUS 9 : Display the count of unique first names of actors. 
 
 # answer > 
 select count(distinct first_name) as first_name_count 
 from actor ; 
 
# first_name_count
# '128' 


# QUS 10 : Display the first 10 records from the customer table . 

# answer > 
select * 
from customer 
limit 10 ; 


# QUS 11 : Display the first 3 records from the customer table whose first name starts with ‘b’ ? 

# answer > 
select * 
from customer
where first_name like "b%" 
limit 3 ; 

# QUS 12 : Display the names of the first 5 movies which are rated as ‘G’. 

# answer >> 
select title , description 
from film 
where rating like  'g'
limit 5 ; 


#QUS 13 :  Find all customers whose first name starts with "a" ? 

# answer >> 
select * 
from customer 
where first_name like "a%" ; 



#QUS 14 :  Find all customers whose first name ends with "a".

# answer >> 
select * 
from customer 
where first_name like "%a" ; 


# QUS 15 : Display the list of first 4 cities which start and end with ‘a’ .

# answer >> 
select * 
from city 
where city like "a%" and city like "%a" ; 


#QUS 16:  Find all customers whose first name have "NI" in any position 

# answer >> 
select * 
from customer 
where (first_name like "ni%") or (first_name like "%ni%") or (first_name like "%ni") ; 

#QUS 17 : Find all customers whose first name have "r" in the second position .

# answer >> 
select * 
from customer 
where first_name  like "_r%" ; 

#QUS 18 :  Find all customers whose first name starts with "a" and are at least 5 characters in length ? 

#answer >> 
select * 
from customer 
where first_name like "a%" and length(first_name) >= 5 ; -- total five cherector and begain from a 


#QUS 19 :  Find all customers whose first name starts with "a" and ends with "o" ? 

# answer >> 
select * 
from customer 
where first_name like "a%" and first_name like "%o" ; 


# QUS 20 : Get the films with pg and pg-13 rating using IN operator .. 

# answer >> 
select * 
from film 
where rating in ('pg','pg-13') ; 


#QUS 21 :  Get the films with length between 50 to 100 using between operator. 

# answer >> 
select title , length  
from film 
where length between 50 and 100  
order by length ; 


# QUS 22 : Get the top 50 actors using limit operator 

# answer >> 
select * 
from actor 
limit 50 ; 


# qus23 : - Get the distinct film ids from inventory table 

# answer >> 
select * 
from inventory ; 

select distinct film_id , store_id 
from inventory ; 




