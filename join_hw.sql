-- Week 4 - Wednesday Questions 

-- 1. List all customers who live in Texas (use 
-- JOINs) 
-- ANS: 5 customers: 
-- Jennifer Davis
-- Kim Cruz
-- Richard Mccrary
-- Bryan Hardison
-- Ian Still

select customer_id, CONCAT(first_name, ' ', last_name) as Name, district
from customer
join address
on customer.address_id = address.address_id
where district = 'Texas';

-- 2. Get all payments above $6.99 with the Customer's Full Name
-- ANS: 599 entries

select concat(first_name, ' ', last_name)
from customer
-- set filter if they live in subquery below (payments>6.99)
where customer_id in(
	select customer_id -- only one primary key
	from payment 
	-- get customer_id under condition of having > 6.99
	group by customer_id
	having sum(amount) > 6.99
);

-- 3. Show all customers names who have made payments over $175(use subqueries) 
--ANS: 6 entries
-- Rhonda	Kennedy
-- Clara	Shaw
-- Eleanor	Hunt
-- Marion	Snyder
-- Tommy	Collazo
-- Karl	Seal

select first_name, last_name
from customer
-- set filter if they live in subquery below (payments>175)
where customer_id in(
	select customer_id -- only one primary key
	from payment 
	-- get customer_id under condition of > 175
	group by customer_id
	having sum(amount) > 175
	order by sum(amount) desc
);

-- 4. List all customers that live in Nepal (use the city 
-- table) ANS: Kevin Schuler

select customer_id, CONCAT(first_name, ' ', last_name) as Name
from customer
join address
on customer.address_id = address.address_id
join city
on address.city_id = city.city_id
join country 
on city.country_id = country.country_id 
where country = 'Nepal';

-- 5. Which staff member had the most 
-- transactions? 
-- ANS: John Stephens

select concat(first_name, ' ', last_name) as Name
from staff
join payment
on payment.staff_id = staff.staff_id
group by Name
order by count(rental_id) desc;


-- 6. How many movies of each rating are 
-- there? 

-- ANS:

-- 178 - G
-- 194 - PG
-- 195 - R
-- 210 - NC-17
-- 223 - PG-13

select count(title) as TotalMovies, rating
from film
group by rating
order by TotalMovies;

-- 7.Show all customers who have made a single payment above $6.99 (Use Subqueries)
-- ANS: need to revisit this codeblock
select concat(first_name, ' ', last_name)
from customer
where customer_id in(
	select customer_id
	from payment 
	group by customer_id
	having sum(amount) > 6.99 
	where amount in (
        select amount
        from payment
        having count(amount) = 1
    )
);

-- 8. How many free rentals did our stores give away?
-- ANS: 24 free rentals

select *
from payment;

select amount
from payment 
where amount = 0;