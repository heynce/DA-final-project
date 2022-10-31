														-- Heynce ASSINGMENT 



																-- 1. 
"1. Provide the payment amount from payment table here the payment amount is greater than 2";


select * from payment;


							-- answer is below.
select amount as amount_greater_than_2 
										from payment 
										where amount > 2;
                                        
                                        
                                        
                                        
                                        
														-- 2.
"2. Provide film titles and the replacement_cost where the rating is PG and the replacement cost is less than 10.";



select title, replacement_cost, rating
from film
where rating = 'PG'
and replacement_cost <=10;




															-- 3 .
"3. Calculate the average rental price (rental_rate) for the movies in each rating, provide the answer with only 2 decimal places. 
Not rounded!+3. Calculate the average rental price (rental_rate) for the movies in each rating, 
provide the answer with only 2 decimal places. 
Not rounded! Just "cut" the answer to two decimal places. Use table film. . Use table film. ";



select rating, avg(rental_rate)
from film
group by rating;

select rating, round(avg(rental_rate), 2) as Rounded_Rental_Rate -- round
									from film
									group by rating;
                                  
select rating, truncate(avg(rental_rate), 2) as Rounded_Rental_Rate -- having decimal number, not rounded.
									from film
									group by rating;




													-- 4.
"4. Print the names of all the customers (first_name) and count the length of each name 
(how many letters there are in the name) next to the names column. Use the customer table. ";

								
select first_name, length(first_name) as NAME_LENGTH
	from customer
	group by first_name;




												-- 5.
"5. Locate the position of the first "e" in the description of each movie. Use table film. "

select description, locate( 'e', description)
	from film;
    
    
    
    
    
    
												-- 6.
"6.  Sum the total length of the films, grouped by each rating.
 Afterwards, print only rating where the summed length is greater than 22000. 
 Use the film table.    ";

select rating, sum(length)
from film
group by rating
having sum(length) > 22000;  -- having works after group by.







																-- 7
"7. Print the descriptions of all the movies, a second column with the length of the description, 
and then a third column where its the description again 
but replacing all the letters "a" with "OO".   ";


select description, length(description), replace(description, 'a', '00') 
from film;




													-- 8


"8. Write an SQL query that would classify movies according to their ratings into the following categories:
If the rating is "PG" or "G" then "PG_G"
If the rating is NC-17 or PG-13 then “NC-17-PG-13”
Assign all other ratings to "Not important"
Display categories in a column called Rating_Group
Use table film. 
 ";

select title, rating,											-- lengthy way of doing.
case
	when rating = 'PG' then 'PG_G'
	when rating = 'G' then 'PG_G'
	when rating = 'NC-17' then 'NC-17-PG-13'
	when rating = 'PG-13' then 'NC-17-PG-13'
			else 'NOT_IMPORTANT'
end as RATING_GROUP
from film;



select title, rating,
case
when rating =  'PG' or rating = 'G' then 'PG_G'
when rating = 'NC-17' or rating = 'PG-13' then 'NC-17-PG-13'		-- and command not working, why?
else 'NOT_IMPORTANT'
end as RATING_GROUP
from film;





																-- 9
'9. Add up the rental duration (rental_duration) for each movie category (use the category name, not just the category id). 
Print only those categories with a rental_duration greater than 300. Use the tables film, film_category, category. ';

select c.category_id, c.name , f.rental_duration
from category as c

inner join film_category as fc
on c.category_id = fc.category_id			-- INVALID USE OF GROUP FUNCTION ERROR.

inner join film as f
on fc.film_id = f.film_id

where f.rental_duration = sum(rental_duration)   
                                                              
group by 2  ;


-- 				----------------------------correct answer is below --------------------------

select  c.category_id, c.name, sum(rental_duration) as TOTAL_DURATION
from film as f
			inner join film_category as fc
            on fc.film_id = f.film_id
            
            inner join category as c
            on c.category_id = fc.category_id
            
group by 1 -- very important, to ask, why c.name doesnt work, or name doesnt work, and why 1 is grouping on name????
having TOTAL_DURATION > 300;
               
               
               
               
               
               
               

													-- 10
" 10. Provide the names (first_name) and surnames (last_name) of the customers who rented the movie "AGENT TRUMAN". 
Complete the task using subquery. Use tables for customer, rental, inventory, film. ";

                                            -- i checked the id's one by one, they match.
select first_name, last_name -- , customer_id
from customer
where customer_id IN ( select customer_id 
						from rental 
                        where rental_id IN ( select inventory_id 
											from inventory 
                                            where film_id IN ( select film_id 
																				from film
                                                                                where title = 'agent truman')))
                                                                              --  order by customer_id ASC
;




													-- 11
                                                    
"11.1 Create Employees table with Name, Surname, Phone Number and Work Experience columns";


create table Employees 
						(NAME VARCHAR(30) not null, 
                        SURNAME VARCHAR(30) not null, 
                        Phone varchar(15), -- int function was not working, cause i think int has a max value
                        Work_experience INT)
                        ;
                        
                        
                        
                        
                        
                        
										-- 11.2		"insert values";        
                                                
                                                
                                                
insert into Employees (NAME, SURNAME, PHONE, Work_experience)
			values('John', 'Simons', '085478535545', '5'), -- to add , comma after each insert
					('Simon', 'Jones', '086214465122', '8'),
                    ('Silvia', 'Mary-Jones', '086579656664', '3')
                    ;
                        
                        


						 


"11.3 Calculate the average length of service of employees. Round the answer to two decimal places. ";
select truncate(avg(Work_experience), 2) from Employees;





"11.4 SImon lost his phone, which changed his number to +37085369874. Update the data in the table. ";
update Employees 
				set PHONE = +37085369874
                where NAME = 'simon'
                ;







"11.5 An error occurred, the length of service of the employees was entered not in years but in months. 
In the new column "stazas_years", reflect the employee's length of service in a year with two decimal places 
(hint: divide the column "Work_stazas" by 12. )";
						-- stažas means experience

alter table  Employees add Work_stazas int;
update Employees set Work_stazas = Work_experience/12;
				-- how to do them together????





"11.6 Delete all data about Simon from the table "Employees” ;

delete from employees where name = 'simon';    -- my answer






"11.7 Delete all data from the "Employees" table (but not the table itself). ees" ;

truncate table employees;    -- my answer
delete from Employees;




'11.8 Delete the "Employees" table. '
Drop Table employees;











                                      