CREATE TABLE IF NOT EXISTS walmart (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL, 
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6,4) NOT NULL,
    total DECIMAL(12,4) NOT NULL,
    `date` DATETIME NOT NULL,
    `time` TIME NOT NULL,
    payment_method VARCHAR(15) NOT NULL, 
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12,4) NOT NULL,
    rating FLOAT(2,1)
);
------------------------------------------------------------------------------------------------

SELECT *
FROM walmart;
------------------------------------------------------------------------------------------------

SELECT time, (CASE WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
			  WHEN `time` BETWEEN "12:00:00" AND "16:00:00" THEN "Afternoon"
              ELSE "Evening" 
              END) AS time_of_day
FROM walmart;
-------------------------------------------------------------------------------------------------

ALTER TABLE walmart ADD COLUMN time_of_day VARCHAR(20);
--------------------------------------------------------------------------------------------------

UPDATE walmart
SET time_of_day = (CASE WHEN `time` BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
			  WHEN `time` BETWEEN "12:00:00" AND "16:00:00" THEN "Afternoon"
              ELSE "Evening" 
              END);
----------------------------------------------------------------------------------------------------

SELECT date, dayname(date)
FROM walmart;
-------------------------------------------------------------------------------------------------------
              
ALTER TABLE walmart ADD COLUMN `day` VARCHAR(10);
-------------------------------------------------------------------------------------------------------

UPDATE walmart
SET day = (dayname(date));
-------------------------------------------------------------------------------------------------------

SELECT date, monthname(date)
FROM walmart;
------------------------------------------------------------------------------------------------------

ALTER TABLE walmart ADD COLUMN `month` VARCHAR(10);
------------------------------------------------------------------------------------------------------

UPDATE walmart
SET month = (monthname(date));
------------------------------------------------------------------------------------------------------

SELECT distinct city
FROM walmart;
------------------------------------------------------------------------------------------------------

------ How many unique cities does the data have?
SELECT distinct city, branch
FROM walmart;
-----------------------------------------------------------------------------------------------------

------- In which city is each branch?
SELECT COUNT(distinct product_line)
FROM walmart;
-----------------------------------------------------------------------------------------------------


--------- What is the most common payment method?
SELECT payment_method, COUNT(payment_method) payment
FROM walmart
GROUP BY payment_method
ORDER BY COUNT(payment_method) DESC LIMIT 1;
-----------------------------------------------------------------------------------------------------

---- What is the most selling product line?
SELECT product_line, COUNT(product_line) sales
FROM walmart
GROUP BY product_line
ORDER BY COUNT(product_line) DESC;
-----------------------------------------------------------------------------------------------------

----- What is the total revenue by month?
SELECT `month`, SUM(total) as revenue
FROM walmart
GROUP BY `month`
ORDER BY revenue DESC;
-----------------------------------------------------------------------------------------------------

---- What month had the largest COGS?
SELECT `month`, SUM(cogs) as cogs
FROM walmart
GROUP BY `month`
ORDER BY cogs DESC LIMIT 1;
-----------------------------------------------------------------------------------------------------

---- What product line had the largest revenue?
SELECT product_line, SUM(total) as revenue
FROM walmart
GROUP BY product_line
ORDER BY revenue DESC;
------------------------------------------------------------------------------------------------------

---- What is the city with the largest revenue?
SELECT city, SUM(total) as revenue
FROM walmart
GROUP BY city
ORDER BY revenue DESC;
-------------------------------------------------------------------------------------------------------

---- What product line had the largest VAT?
SELECT product_line, AVG(vat) as revenue
FROM walmart
GROUP BY product_line
ORDER BY revenue DESC;
--------------------------------------------------------------------------------------------------------

---- Which branch sold more products than average product sold?
SELECT branch, SUM(quantity) AS qty
FROM walmart
GROUP BY branch
HAVING SUM(quantity) > (SELECT AVG(quantity) FROM walmart);
------------------------------------------------------------------------------------------------------

---- What is the most common product line by gender?
SELECT gender, product_line, COUNT(gender) AS gender_count
FROM walmart
GROUP BY gender, product_line
ORDER BY gender_count DESC;
-----------------------------------------------------------------------------------------------------

--- What is the average rating of each product line?
SELECT ROUND(AVG(rating),2) AS rating, product_line
FROM walmart
GROUP BY product_line
ORDER BY AVG(rating) DESC;
------------------------------------------------------------------------------------------------------

---- Number of sales made in each time of the day per weekday
SELECT time_of_day, COUNT(*) AS sales
FROM walmart
WHERE `day` = "Monday"
GROUP BY time_of_day
ORDER BY sales DESC;
-----------------------------------------------------------------------------------------------------

---- Which of the customer types brings the most revenue?
SELECT customer_type, SUM(total) AS revenue
FROM walmart
GROUP BY customer_type
ORDER BY revenue DESC;
-----------------------------------------------------------------------------------------------------

----- Which city has the largest tax percent/ VAT (Value Added Tax)?
SELECT city, ROUND(AVG(VAT),2) as tax
FROM walmart
GROUP BY city
ORDER BY tax DESC;
-----------------------------------------------------------------------------------------------------

---- Which customer type pays the most in VAT?
SELECT customer_type, ROUND(AVG(VAT),2) as tax
FROM walmart
GROUP BY customer_type
ORDER BY tax DESC;
----------------------------------------------------------------------------------------------------

SELECT distinct customer_type
FROM walmart;
----------------------------------------------------------------------------------------------------

SELECT distinct payment_method
FROM walmart;
----------------------------------------------------------------------------------------------------

---- What is the most common customer type?
SELECT customer_type, COUNT(*) AS cnt
FROM walmart
GROUP BY customer_type
ORDER BY cnt DESC limit 1;
---------------------------------------------------------------------------------------------------

---- What is the gender of most of the customers?
SELECT gender, COUNT(*) AS cnt
FROM walmart
GROUP BY gender
ORDER BY cnt DESC limit 1;
----------------------------------------------------------------------------------------------------

---- What is the gender distribution per branch?
SELECT gender, branch, COUNT(*) AS cnt
FROM walmart
WHERE branch = "B"
GROUP BY gender
ORDER BY cnt DESC;
----------------------------------------------------------------------------------------------------

---- Which time of the day do customers give most ratings?
SELECT time_of_day, AVG(rating) AS rtg
FROM walmart
GROUP BY time_of_day
ORDER BY AVG(rating) DESC;
----------------------------------------------------------------------------------------------------

---- Which time of the day do customers give most ratings per branch?
SELECT time_of_day, AVG(rating) AS rtg
FROM walmart
WHERE branch = "c"
GROUP BY time_of_day
ORDER BY AVG(rating) DESC;
----------------------------------------------------------------------------------------------------

---- Which day fo the week has the best avg ratings?
SELECT `day`, AVG(rating) AS rtg
FROM walmart
GROUP BY `day`
ORDER BY AVG(rating) DESC;
----------------------------------------------------------------------------------------------------

---- Which day of the week has the best average ratings per branch?
SELECT `day`, AVG(rating) AS rtg
FROM walmart
WHERE branch = "A"
GROUP BY `day`
ORDER BY AVG(rating) DESC;
-----------------------------------------------------------------------------------------------------

