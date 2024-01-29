USE PROJECT ;
SELECT * FROM sales ; 

---------------------------------------------------------#FEATURE ENGINEERING--------------------------------------------------------------------------
---------------------------------------------------------#ADD NEW COLUMN NAMED TIME_OF_DAY-------------------------------------------------------------

SELECT TIME,
(
CASE
WHEN TIME BETWEEN "00:00:00" 
AND "12:00:00" THEN "MORNING"
WHEN TIME BETWEEN "12:00:00" 
AND "16:00:00" THEN "AFTERNOON"
ELSE "EVENING"
END
) AS TIME_OF_DAY
 FROM SALES ;
 
 ALTER TABLE SALES 
 ADD COLUMN TIME_OF_DAY 
 VARCHAR(100) ;
 
 UPDATE SALES 
 SET TIME_OF_DAY = 
 (
 CASE
WHEN TIME BETWEEN "00:00:00" 
AND "12:00:00" THEN "MORNING"
WHEN TIME BETWEEN "12:00:00" 
AND "16:00:00" THEN "AFTERNOON"
ELSE "EVENING"
END
);

----------------------------------------------------------#FEATURE ENGINEERING-------------------------------------------------------------------------
----------------------------------------------------------#ADD NEW COLUMN NAMED DAY_NAME---------------------------------------------------------------

SELECT DATE,DAYNAME(DATE) FROM SALES;
ALTER TABLE SALES 
ADD COLUMN DAY_NAME 
VARCHAR(100) ;
UPDATE SALES 
SET DAY_NAME = DAYNAME(DATE) ;


----------------------------------------------------------#FEATURE ENGINEERING-------------------------------------------------------------------------
----------------------------------------------------------#ADD NEW COLUMN NAMED MONTH_NAME-------------------------------------------------------------

SELECT DATE,MONTHNAME(DATE) FROM SALES ;

ALTER TABLE SALES 
ADD COLUMN MONTH_NAME 
VARCHAR(100) ;
UPDATE SALES 
SET MONTH_NAME = MONTHNAME(DATE) ;

----------------------------------------------------------#GENERIC QUESTION------------------------------------------------------------------------

-- Q-1 HOW MANY UNIQUE CITIES DOES THE DATA HAVE ?
SELECT DISTINCT 
City FROM SALES ;

-- Q-2 IN WHICH CITY IS EACH BRANCH ?
SELECT DISTINCT 
City,BRANCH FROM SALES ;

----------------------------------------------------------#PRODUCT QUESTION------------------------------------------------------------------------

-- Q-3 HOW MANY UNIQUE PRODUCT LINES DOES THE DATA HAVE?
SELECT 
COUNT(DISTINCT Product_line) 
FROM SALES ;

-- Q-4 WHAT IS THE MOST COMMON PAYMENT METHOD?
SELECT 
COUNT(Payment) AS Total,Payment FROM SALES 
GROUP BY Payment 
LIMIT 1 ;

-- Q-5 WHAT IS THE MOST SELLING PRODUCT LINE?
SELECT 
COUNT(Product_line),Product_line FROM SALES 
GROUP BY Product_line 
ORDER BY COUNT(Product_line) DESC 
LIMIT 1;

-- Q-6 WHAT IS THE TOTAL REVENUE BY MONTH?
SELECT 
SUM(Total),MONTH_NAME FROM SALES 
GROUP BY MONTH_NAME ;

-- Q-7 WHICH MONTH HAS THE LARGEST COGS?
SELECT 
MAX(cogs),MONTH_NAME FROM SALES 
GROUP BY MONTH_NAME 
ORDER BY MAX(cogs) DESC 
LIMIT 1;

-- Q-8 WHICH PRODUCT LINE HAS THE LARGEST REVENUE?
SELECT 
MAX(Total),Product_line FROM SALES 
GROUP BY Product_line 
ORDER BY MAX(Total) DESC 
LIMIT 1;

-- Q-9 WHAT IS THE CITY WITH THE LARGEST REVENUE?
SELECT 
MAX(Total),City FROM SALES 
GROUP BY City 
ORDER BY MAX(Total) DESC 
LIMIT 1  ;

-- Q-10 WHAT PRODUCT LINE HAS THE LARGEST VAT?
SELECT 
AVG(TAX) AS VAT,Product_line FROM SALES 
GROUP BY Product_line 
ORDER BY VAT DESC 
LIMIT 1;

-- Q-11 WHICH BRANCH SOLD MORE PRODUCTS THAN AVERAGE PRODUCT SOLD?
SELECT 
SUM(Quantity),Branch FROM SALES 
GROUP BY Branch 
HAVING SUM(Quantity) > (SELECT AVG(Quantity) FROM SALES) 
ORDER BY SUM(Quantity) DESC 
LIMIT 1 ;

-- Q-12 WHAT IS THE MOST COMMON PRODUCT LINE BY GENDER?
SELECT 
COUNT(GENDER),PRODUCT_LINE,GENDER FROM SALES 
GROUP BY PRODUCT_LINE,GENDER 
ORDER BY COUNT(GENDER) DESC;

-- Q-13 WHAT IS THE AVERAGE RATING OF EACH PRODUCT LINE
SELECT 
PRODUCT_LINE,ROUND(AVG(Rating),2) FROM SALES 
GROUP BY Product_line 
ORDER BY AVG(Rating) DESC ;


------------------------------------------------------#Sales Question----------------------------------------------------------------------------------

-- Q-14 NUMBER OF SALES MADE IN EACH TIME OF THE DAY PER WEEKDAY?
SELECT 
TIME_OF_DAY,COUNT(*) AS TOTAL_SALES FROM SALES 
WHERE DAY_NAME = "SUNDAY" 
GROUP BY TIME_OF_DAY 
ORDER BY TOTAL_SALES DESC ;

-- Q-15 WHICH OF THE CUSTOMER TYPES BRINGS THE MOST REVENUE?
SELECT 
ROUND(SUM(Total),2) AS TOTAL_REVENUE,Customer_type FROM SALES 
GROUP BY Customer_type 
ORDER BY TOTAL_REVENUE DESC ;

-- Q-16 WHICH PAYMENT METHOD IS USE TO GENERATE HIGHEST SALES REVENUE?
SELECT 
ROUND(SUM(Total),2) AS HIGHEST_REVENUE,Payment FROM SALES 
GROUP BY Payment 
ORDER BY HIGHEST_REVENUE DESC ;


------------------------------------------------------#Customer Question-------------------------------------------------------------------------------

-- Q-17 HOW MANY UNIQUE CUSTOMER TYPES DOES THE DATA HAVE?
SELECT 
COUNT(DISTINCT Customer_type) FROM SALES;

-- Q-18 HOW MANY UNIQUE PAYMENT METHODS DOES THE DATA HAVE?
SELECT 
COUNT(DISTINCT Payment) FROM SALES;

-- Q-19 WHAT IS THE MOST COMMON CUSTOMER TYPE?
SELECT 
MAX(Customer_type) FROM SALES;

-- Q-20 WHICH CUSTOMER TYPE BUYS THE MOST?
SELECT 
COUNT(*) AS BUYS,Customer_type FROM SALES 
GROUP BY Customer_type ;

-- Q-21 WHAT IS THE GENDER OF THE MOST OF THE CUSTOMER?
SELECT 
Gender,COUNT(*) AS Gender_count FROM SALES 
GROUP BY Gender 
ORDER BY Gender_count DESC ;

-- Q-22 WHAT IS THE GENDER DISTRIBUTION PER BRANCH?
SELECT 
GENDER,COUNT(*) AS Gender_cnt FROM SALES 
WHERE Branch = "A"  
GROUP BY Gender 
ORDER BY Gender_cnt DESC ;

SELECT 
GENDER,COUNT(*) AS Gender_cnt FROM SALES 
WHERE Branch = "B"  
GROUP BY Gender 
ORDER BY Gender_cnt DESC ;

SELECT 
GENDER,COUNT(*) AS Gender_cnt FROM SALES 
WHERE Branch = "C"  
GROUP BY Gender 
ORDER BY Gender_cnt DESC ;

-- Q-23 WHICH TIME OF THE DAY DO CUSTOMERS GIVE MOST RATING?
SELECT 
TIME_OF_DAY,AVG(Rating) AS AVG_RATING FROM SALES 
GROUP BY TIME_OF_DAY 
ORDER BY AVG_RATING DESC ;

-- Q-24 WHICH TIME OF THE DAY DO CUSTOMERS GIVE MOST RATING PER BRANCH?
SELECT
 TIME_OF_DAY,AVG(Rating) AS AVG_RATING FROM SALES 
 WHERE Branch = "A" 
 GROUP BY TIME_OF_DAY 
 ORDER BY AVG_RATING DESC ;

SELECT
 TIME_OF_DAY,AVG(Rating) AS AVG_RATING FROM SALES 
 WHERE Branch = "B" 
 GROUP BY TIME_OF_DAY 
 ORDER BY AVG_RATING DESC ;

SELECT
 TIME_OF_DAY,AVG(Rating) AS AVG_RATING FROM SALES 
 WHERE Branch = "C" 
 GROUP BY TIME_OF_DAY 
 ORDER BY AVG_RATING DESC ;

-- Q-25 WHICH DAY OF THE WEEK HAS THE BEST AVERAGE RATINGS?
SELECT
 DAY_NAME,ROUND(AVG(Rating),2) AS AVERAGE_RATING FROM SALES 
 GROUP BY DAY_NAME 
 ORDER BY AVERAGE_RATING DESC ;

-- Q-26 WHICH DAY OF THE WEEK HAS THE BEST AVERAGE RATINGS PER BRANC?
SELECT
 DAY_NAME,ROUND(AVG(Rating),2) AS AVERAGE_RATING FROM SALES 
 WHERE Branch = "A" 
 GROUP BY DAY_NAME 
 ORDER BY AVERAGE_RATING DESC ;

SELECT
 DAY_NAME,ROUND(AVG(Rating),2) AS AVERAGE_RATING FROM SALES
 WHERE Branch = "B" 
 GROUP BY DAY_NAME 
 ORDER BY AVERAGE_RATING DESC ;

SELECT 
DAY_NAME,ROUND(AVG(Rating),2) AS AVERAGE_RATING FROM SALES 
WHERE Branch = "C" 
GROUP BY DAY_NAME 
ORDER BY AVERAGE_RATING DESC ;




