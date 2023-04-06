   /* The analysis was done on a conflict-reporting dataset downloaded from https://ucdp.uu.se/country/530 */

         /* 1.Showing the conflicts ordered by year */

        SELECT 
            *
        FROM
            conflict.ethiopia
        ORDER BY year;

        /* 2. How many conflicts have occured that can be categorized as state based violence in each decade ? */

        SELECT 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END AS Decade, COUNT(type_of_violence) AS 'Number of State Based Violence'
        FROM 
          conflict.ethiopia
        WHERE 
          type_of_violence = 1
        GROUP BY 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END;
        /* 3. How many conflicts have occured that can be ategorized as Non-state violence in each decade ? */

        SELECT 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END AS Decade, COUNT(type_of_violence) AS 'Number of Non-State  Violence'
        FROM 
          conflict.ethiopia
        WHERE 
          type_of_violence = 2
        GROUP BY 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END
        ORDER BY 
          Decade;

        /* 4. How many conflicts have occured that can be ategorized as one-sided violence in each decade ? */

        SELECT 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END AS Decade, COUNT(type_of_violence) AS 'Number of one-sided Violence'
        FROM 
          conflict.ethiopia
        WHERE 
          type_of_violence = 3
        GROUP BY 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END
        ORDER BY 
          Decade;

        /* 5. Which decade was the most active decade interms of number of conflicts of all types? */

        SELECT 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END AS Decade, COUNT(type_of_violence) AS 'Number of Instances of Violence'
        FROM 
          conflict.ethiopia
        WHERE 
          type_of_violence IN (1, 2, 3)
        GROUP BY 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END
        ORDER BY 
          Decade;

        /* 6. What was the amount of civilian deaths in conflicts in each deacade? */

        SELECT 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END AS Decade, COUNT(type_of_violence) AS 'Number of Instances of Violence',
                SUM(deaths_civilians) AS 'Civilian Deaths'
        FROM 
          conflict.ethiopia
        WHERE 
          type_of_violence IN (1, 2, 3)
        GROUP BY 
          CASE 
            WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                ELSE '2020-2030'
                END
        ORDER BY 
          Decade, COUNT(type_of_violence);

        /* 7. What was the decade to decade trend for both number of conflicts and civilian deaths? */

        SELECT 
          a.Decade, a.Number_of_Instances_of_Violence, LAG(a.Number_of_Instances_of_Violence) 
            OVER (ORDER BY a.Decade) AS previous_decade_violence,  
            CONCAT(ROUND(100.0 * (a.Number_of_Instances_of_Violence - LAG(a.Number_of_Instances_of_Violence) 
            OVER (ORDER BY a.Decade))/(LAG(a.Number_of_Instances_of_Violence) 
            OVER (ORDER BY a.Decade)),2), ' %') AS 'Conflict Trend By Decade',
            a.Civilian_Deaths, 
            LAG(a.Civilian_Deaths) OVER (ORDER BY a.Decade) AS previous_decade_death,
            CONCAT(ROUND(100.0 * (a.Civilian_Deaths - LAG(a.Civilian_Deaths) OVER (ORDER BY a.Decade))/ 
            (LAG(a.Civilian_Deaths) OVER (ORDER BY a.Decade)),2), ' %') AS 'Death Trend By Decade'
        FROM 
          (SELECT 
            CASE 
              WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
              WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
              WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
              WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
              ELSE '2020-2030'
              END AS Decade, COUNT(type_of_violence) AS Number_of_Instances_of_Violence,
              SUM(deaths_civilians) AS Civilian_Deaths
          FROM 
            conflict.ethiopia
          WHERE 
            type_of_violence IN (1, 2, 3)
          GROUP BY 
            CASE 
              WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
              WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
              WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
              WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
              ELSE '2020-2030'
              END
          ORDER BY 
            Decade, COUNT(type_of_violence)) a ;

        /* In adm_1 field, We have to change the word 'province' to 'state' so that we can get a 
          more accurate analysis. */

        UPDATE conflict.ethiopia SET adm_1 = 'Tigray state'
        WHERE adm_1 = 'Tigray province';

        /* 8. Which part of the country has seen the most conflict? */

        SELECT 
          adm_1 AS Region, COUNT(type_of_violence) AS 'Instances of Violence'
        FROM 
          conflict.ethiopia
        WHERE 
          adm_1 IS NOT NULL AND adm_1 <> ''
        GROUP BY 
          adm_1
        ORDER BY 
          COUNT(type_of_violence) DESC;

        /* 9. Which part of the country has seen the most conflict in each decade? */

        SELECT 
          b.Decade, b.Region, b.Instances_of_Violence
        FROM 
          (SELECT 
            RANK() OVER (PARTITION BY a.Decade ORDER BY MAX(a.Instances_of_Violence) DESC) AS rn,
            a.Decade AS Decade, a.Region AS Region, MAX(a.Instances_of_Violence) AS Instances_of_Violence
          FROM 
            (SELECT 
              CASE 
                  WHEN year BETWEEN 1980 AND 1989 THEN '1980-1990'
                  WHEN year BETWEEN 1990 AND 1999 THEN '1990-2000'
                  WHEN year BETWEEN 2000 AND 2009 THEN '2000-2010'
                  WHEN year BETWEEN 2010 AND 2020 THEN '2010-2020'
                  ELSE '2020-2030'
                  END AS Decade, adm_1 AS Region, COUNT(type_of_violence) AS Instances_of_Violence
            FROM 
              conflict.ethiopia
            WHERE 
              adm_1 IS NOT NULL AND adm_1 <> ''
            GROUP BY 
              Decade, adm_1
            ORDER BY 
              Decade) a
          GROUP BY
            a.Decade, a.Region) b
        WHERE 
          b.rn = 1;

         /* 10. What is the year to year conflict breakdown in the country? In cobination with
            civilian deaths in each year, it will help us to identify bloodiest in the country. */ 

        SELECT 
          year, COUNT(type_of_violence) As 'Instances of Conflict', 
            SUM(deaths_civilians) AS 'Civilian Deaths'
        FROM 
          conflict.ethiopia
        Group BY 
          year
        ORDER BY 
          year;

        /* 11. What is the year to year conflict and civilian death trend? Is the country becoming peaceful
               or still ravaged by conflict? */

        SELECT 
          year, COUNT(type_of_violence) As 'Instances of Conflict', 
            CONCAT(ROUND(100.0 * (COUNT(type_of_violence) - LAG(COUNT(type_of_violence)) OVER (ORDER BY year))/
            (LAG(COUNT(type_of_violence)) OVER (ORDER BY year)),2), ' %') AS 'Conflict Trend',
            SUM(deaths_civilians) AS 'Civilian Deaths',
            CONCAT(ROUND(100.0 * (SUM(deaths_civilians) - LAG(SUM(deaths_civilians)) OVER (ORDER BY year))/
            (LAG(SUM(deaths_civilians)) OVER (ORDER BY year)),2), '%') AS 'Death Trend'
        FROM
          conflict.ethiopia
        Group BY 
          year
        ORDER BY 
          year;

        /* 12. Which type of violence has occured the most in the country? In this dataset, 
           type_of_violence = 1 means 'state based violence', type_of_violence = 2 means 
           'non-state violence', and type_of_violence = 3 means 'one-sided violence' */

        SELECT 
          type_of_violence, COUNT(type_of_violence) AS 'Instances',
            CASE 
            WHEN type_of_violence = 1 THEN 'State-Based Violence'
                WHEN type_of_violence = 2 THEN 'Non-State Violence' 
                ELSE 'One-Sided Violence'
                END AS 'Remark'
        FROM 
          conflict.ethiopia
        GROUP BY 
          type_of_violence;

        /* 13. Which type of violence is the bloodiest? In this dataset, 
           type_of_violence = 1 means 'state based violence', type_of_violence = 2 means 
           'non-state violence', and type_of_violence = 3 means 'one-sided violence' */

        SELECT 
          type_of_violence, COUNT(type_of_violence) AS 'Instances',
            SUM(deaths_civilians) AS 'Civilian Deaths', 
            CASE 
            WHEN type_of_violence = 1 THEN 'State-Based Violence'
                WHEN type_of_violence = 2 THEN 'Non-State Violence' 
                ELSE 'One-Sided Violence'
                END AS 'Remark'
        FROM 
          conflict.ethiopia
        GROUP BY 
          type_of_violence
        ORDER BY 
          SUM(deaths_civilians) DESC;

        /* 14. Which conflict was the longest running instance of conflict in the country? (Top 10) */

        SELECT 
          year, conflict_name, adm_1, dyad_name, 
             date_end - date_start
        FROM 
          conflict.ethiopia
        GROUP BY 
          year, conflict_name, adm_1, dyad_name, date_end - date_start
        ORDER BY 
          date_end - date_start DESC, year
        ;

        /* 15. How many has the same dyad (two sides of the war) have been in conflict? Repeated 
          belligerency */

        SELECT 
          dyad_name, COUNT(type_of_violence) AS 'Instances of Violence', 
            SUM(deaths_civilians) AS 'Civilian Deaths'
        FROM 
          conflict.ethiopia
        GROUP BY 
          dyad_name
        ORDER BY 
          COUNT(type_of_violence) DESC;

        /* 16. Which conflict dyad has been the bloodiest interms of combatant deaths?
           ( Combined deaths > 250) */

        SELECT 
          conflict_name, dyad_name, SUM(deaths_a) + SUM(deaths_b)  AS 'Combatant-deaths'
        FROM 
          conflict.ethiopia
        GROUP BY 
          conflict_name, dyad_name
        HAVING 
          SUM(deaths_a) + SUM(deaths_b) > 250
        ORDER BY 
          SUM(deaths_a) + SUM(deaths_b) DESC
          
        /* 17. What is the most number of conflicts that have happened in a single day all over the 
	country? */
    
         SELECT 
                  date_start, COUNT(type_of_violence) AS number_of_instances 
         FROM 
                  conflict.ethiopia
         GROUP BY 
                  date_start
         ORDER BY 
                  COUNT(type_of_violence) DESC;

         /*18.  What was the bloodiest day in Ethiopian history in the past 30 years? */

         SELECT 
                  date_start AS day, SUM(deaths_civilians) AS "Civilian Deaths" 
         FROM 
                  conflict.ethiopia
         GROUP BY 
                  date_start
         ORDER BY 
                  SUM(deaths_civilians) DESC

    
