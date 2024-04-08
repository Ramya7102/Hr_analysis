-- Questions

-- 1.what is the gender breakdown of employees in the company?
SELECT gender,COUNT(*) AS count
FROM hr
WHERE age > 18 AND termdate = '0000-00-00'
GROUP BY 1;

-- 2. What is race/ethnicity breakdown of employees in the company?
SELECT race,COUNT(*) AS count
FROM hr
WHERE age > 18 AND termdate = '0000-00-00'
GROUP BY 1
ORDER BY 2 DESC;

-- 3. What is the age distribution of employees in the company

SELECT CASE WHEN age > 18 AND age <25 THEN '18 - 24'
            WHEN age > 25 AND age <35 THEN '25 - 34'
            WHEN age > 35 AND age <45 THEN '35 - 44'
            WHEN age > 45 AND age <=60 THEN '45 - 60'
            ELSE '65+'
            END AS Age_group, COUNT(*) AS count
            FROM hr
			WHERE  age >= 18 AND termdate = '0000-00-00'
            GROUP BY 1
            ORDER BY 1;
            
 SELECT CASE WHEN age >= 18 AND age <=24 THEN '18 - 24'
            WHEN age >= 25 AND age <=34 THEN '25 - 34'
            WHEN age >= 35 AND age <=44 THEN '35 - 44'
            WHEN age >= 45 AND age <=60 THEN '45 - 60'
            ELSE '60+'
            END AS Age_group,gender,COUNT(*) AS count
            FROM hr
			WHERE  age >= 18 AND termdate = '0000-00-00'
            GROUP BY 1,2
            ORDER BY 1,2;
            
            
            
-- 4. How many employees work at headquarters versus remote locations?

SELECT location , COUNT(*) AS count
FROM hr
WHERE  age >= 18 AND termdate = '0000-00-00'
GROUP BY 1
ORDER BY 2 DESC;

-- 5.What is the average length of employment for employees who have been terminated?

SELECT round(AVG(datediff(termdate,hire_date))/365,0) AS avg_duration
FROM hr
WHERE termdate<= curdate() AND termdate <>'0000-00-00' AND age >= 18;

-- 6. How does gender distribution vary across deparments and job titles?

SELECT department,gender,COUNT(*) AS count
FROM hr
WHERE age> 18 AND termdate ='0000-00-00'
GROUP BY 1,2
ORDER BY 1 ;   

-- 7.What is the distribution of job titles across thecompany?

SELECT jobtitle,COUNT(*) AS  count
FROM hr
WHERE age> 18 AND termdate ='0000-00-00'
GROUP BY 1
ORDER BY 1 ;  

-- 8.Which department ha highest turnover rate?

SELECT department,total_count,terminated_count,
	   terminated_count/total_count AS termination_rate
FROM(SELECT department,COUNT(*) AS total_count,
     SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS terminated_count
     FROM hr
     WHERE age >= 18
     GROUP BY department) AS subquery
ORDER BY 4 desc;

-- 9.What is the distribution of employess across locations by city and state?

SELECT Location_state , COUNT(*) AS count
FROM hr
WHERE age >= 18 AND termdate = '0000-00-00'
GROUP BY 1;

-- 10.How has company's employee count changed over time based on hire and term dates?

SELECT years,hires,Terminations,
hires - terminations AS net_change,
round((hires-terminations)/hires *100, 2) AS net_change_percent
FROM ( SELECT YEAR(hire_date) AS years,
	   COUNT(*) AS hires,
       SUM(CASE WHEN termdate <> '0000-00-00' AND termdate <= CURDATE() THEN 1 ELSE 0 END) AS Terminations
       FROM hr
       WHERE age >= 18
       GROUP BY 1) AS subquery
       ORDER BY 1 ;
       
-- 11. What is the tenure distributon of each department?

SELECT department,ROUND(avg(datediff(termdate,hire_date)/365),0) AS Avg_tenure
FROM hr
WHERE age >= 18 AND termdate <> '0000-00-00' AND termdate <= CURDATE()
GROUP BY 1
ORDER BY 2;
       

      