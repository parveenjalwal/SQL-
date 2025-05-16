# this section contains join qustion normal and advance both 

use mavenmovies ; 

-- starting with qustions >> 


# QUSTION 9:  Display the title of the movie, customer s first name, and last name who rented it.
			# Hint: Use JOIN between the film, inventory, rental, and customer tables.
            
# answer > 
select title , first_name , last_name , rental_id 
from customer c 
join rental r on r.customer_id = c.customer_id 
join inventory i on i.inventory_id =  r.inventory_id 
join film f on f.film_id = i.film_id ; 
-- here i connected firsly customer table with rental using rental id afterwrds rental table with inventroy using inventroy_id table 
-- eventully inventory table with film table  



#QUSTION 10 : Retrieve the names of all actors who have appeared in the film "Gone with the Wind."
            # Hint: Use JOIN between the film actor, film, and actor tables.
            
#answer >> 
select first_name , last_name , title 
from actor ac 
join film_actor fac on ac.actor_id = fac.actor_id 
join film f on f.film_id = fac.film_id 
where title like "Gone with the Wind" ; 


#QUSTION : 11 Retrieve the customer names along with the total amount they've spent on rentals ? 

# answer >> 
select * from customer ; 
select * from payment ;
select * from rental ; 

select first_name , 
sum(amount) as total_amount 
from customer c 
join payment p on p.customer_id = c.customer_id 
join rental r on r.rental_id = p.rental_id 
group by first_name ;  



#QUSTION 12 : List the titles of movies rented by each customer in a particular city (e.g., 'London').
			# Hint: JOIN customer, address, city, rental, inventory, and film tables, then use GROUP BY.
            
#answer > 
select * from customer ;  
select * from address ; 
select * from city ; 
select * from rental ;
select * from inventory ; 
select * from film ;  

select f.title ,  c.full_name   , ct.city 
from customer c 
join  address ad on c.address_id = ad.address_id 
join city ct on ct.city_id = ad.city_id 
join rental r on r.customer_id = c.customer_id 
join inventory i on i.inventory_id = r.inventory_id 
join film f on f.film_id = i.film_id 
where city = 'london' 
group by f.title , c.full_name ; 




#QUSTION 13 :  Display the top 5 rented movies along with the number of times they've been rented.
           #   Hint: JOIN film, inventory, and rental tables, then use COUNT () and GROUP BY, and limit the results. 
           
#answer >> 
 select title , 
 count(rental_id) as total_rented 
 from film f 
 join inventory i on i.film_id = f.film_id 
 join rental r on r.inventory_id = i.inventory_id 
 group by  title 
 order by total_rented desc 
 limit 5 ;  
 
 
 
 #QUSTION  14 : Determine the customers who have rented movies from both stores (store ID 1 and store ID 2).
          #     Hint: Use JOINS with rental, inventory, and customer tables and consider COUNT() and GROUP BY.
          
#answer >>

SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
JOIN inventory i ON r.inventory_id = i.inventory_id
WHERE i.store_id = 1
AND c.customer_id IN (
    SELECT c2.customer_id
    FROM customer c2
    JOIN rental r2 ON c2.customer_id = r2.customer_id
    JOIN inventory i2 ON r2.inventory_id = i2.inventory_id
    WHERE i2.store_id = 2
)
GROUP BY c.customer_id, c.first_name, c.last_name;
