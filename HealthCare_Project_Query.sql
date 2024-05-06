
SELECT * FROM [dbo].[COVID19_DATA];

-- Total patient = 1 048 575
--Death_Patients = 22706;
--Not_Covid_Patients = 656 596
--Covid_Patients = 391979

--Use subquery, where condition

SELECT 
    COUNT(*) AS Total_patients,
    (SELECT COUNT(*) FROM [dbo].[COVID19_DATA] WHERE CLASIFFICATION_FINAL NOT IN (1, 2, 3)) AS Negative_Covid_Patients,
    (SELECT COUNT(*) FROM [dbo].[COVID19_DATA] WHERE CLASIFFICATION_FINAL IN (1, 2, 3)) AS Positeve_Covid_Patients,
	(SELECT COUNT(*) FROM [dbo].[COVID19_DATA] WHERE CLASIFFICATION_FINAL IN (1, 2, 3) AND DATE_DIED != '9999-99-99') AS Covid_Death_Patients
FROM [dbo].[COVID19_DATA];

----------------------------------------Total-----------------------------------------------------------


WITH Analys_CTE AS (
    SELECT
        CASE
            WHEN AGE < 18 THEN '18 under'
            WHEN AGE BETWEEN 18 AND 40 THEN '18-40'
            WHEN AGE BETWEEN 41 AND 65 THEN '41-65'
            ELSE '65 over'
        END AS Age_Group, *
    
    FROM [dbo].[COVID19_DATA]
)

SELECT 
    CASE 
        WHEN SEX = '1' THEN 'Female'
        WHEN SEX = '2' THEN 'Male'
        ELSE 'Other'
    END AS Gender,
    Age_Group,
    COUNT(*) AS Total_Patients,
	SUM(CASE WHEN CLASIFFICATION_FINAL IN (1, 2, 3) THEN 1 ELSE 0 END) AS Covid_Patients,
    SUM(CASE WHEN CLASIFFICATION_FINAL NOT IN (1, 2, 3) THEN 1 ELSE 0 END) AS Not_Covid_Patients,
    SUM(CASE WHEN DATE_DIED != '9999-99-99' THEN 1 ELSE 0 END) AS Total_Deaths, 
    SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND PATIENT_TYPE = 1 THEN 1 ELSE 0 END) AS Count_Deaths_Home,
    SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND PATIENT_TYPE = 2 THEN 1 ELSE 0 END) AS Count_Deaths_Hospital,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND PREGNANT = 1 THEN 1 ELSE 0 END) AS Total_Covid_Pregnant,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND PREGNANT = 1 THEN 1 ELSE 0 END) AS Pregnant_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND PNEUMONIA = 1 THEN 1 ELSE 0 END) AS PNEUMONIA,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND PNEUMONIA = 1 THEN 1 ELSE 0 END) AS PNEUMONIA_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND DIABETES = 1 THEN 1 ELSE 0 END) AS DIABETES,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND DIABETES = 1 THEN 1 ELSE 0 END) AS DIABETES_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND COPD = 1 THEN 1 ELSE 0 END) AS COPD,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND COPD = 1 THEN 1 ELSE 0 END) AS COPD_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND ASTHMA = 1 THEN 1 ELSE 0 END) AS ASTHMA,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND ASTHMA = 1 THEN 1 ELSE 0 END) AS ASTHMA_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND INMSUPR = 1 THEN 1 ELSE 0 END) AS INMSUPR,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND INMSUPR = 1 THEN 1 ELSE 0 END) AS INMSUPR_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND HYPERTENSION = 1 THEN 1 ELSE 0 END) AS HYPERTENSION,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND HYPERTENSION = 1 THEN 1 ELSE 0 END) AS HYPERTENSION_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND OTHER_DISEASE = 1 THEN 1 ELSE 0 END) AS OTHER_DISEASE,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND OTHER_DISEASE = 1 THEN 1 ELSE 0 END) AS OTHER_DISEASE_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND CARDIOVASCULAR = 1 THEN 1 ELSE 0 END) AS CARDIOVASCULAR,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND CARDIOVASCULAR = 1 THEN 1 ELSE 0 END) AS CARDIOVASCULAR_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND OBESITY = 1 THEN 1 ELSE 0 END) AS OBESITY,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND OBESITY = 1 THEN 1 ELSE 0 END) AS OBESITY_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND RENAL_CHRONIC = 1 THEN 1 ELSE 0 END) AS RENAL_CHRONIC,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND RENAL_CHRONIC = 1 THEN 1 ELSE 0 END) AS RENAL_CHRONIC_Deaths,
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND TOBACCO = 1 THEN 1 ELSE 0 END) AS TOBACCO,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND TOBACCO = 1 THEN 1 ELSE 0 END) AS TOBACCO_Deaths
	
FROM Analys_CTE
GROUP BY SEX, Age_Group;



/*
a. Gender Distribution:
	• Count of Patients by Gender: Categorize patients by gender (male, female, other).

*/

/*WITH AgeGroup AS (
    SELECT
        CASE
            WHEN AGE < 18 THEN '18 under'
            WHEN AGE BETWEEN 18 AND 40 THEN '18-40'
            WHEN AGE BETWEEN 41 AND 65 THEN '41-65'
            ELSE '65 over'
        END AS Age_Group, CLASIFFICATION_FINAL
       
    FROM [dbo].[COVID19_DATA]
)

*/
WITH GenderCounts AS (
	SELECT  
		CASE 
			WHEN SEX = 1 THEN 'Female'
			WHEN SEX = 2 THEN 'Male'
			ELSE 'Other'
			END AS Gender_Patients,
			COUNT(*) as Total_Count
		 from [dbo].[COVID19_DATA]
		 GROUP by SEX
)
	 SELECT 
		Gender_Patients, 
		Total_Count
	from  GenderCounts;


/*
b. Age Group Analysis:
		• Count of Patients by Age Group: Categorize patients into age groups (e.g., under 18, 18-40, 41-65, over 65) and provide 
		  the count of patients in each group. Count of Patients by Age Group and COVID-19 Deaths: Analyze the count of patients 
		  in each age group who contracted COVID-19 and the number of deaths in each group.
*/

WITH AgeGroup AS (
    SELECT
        CASE
            WHEN AGE < 18 THEN '18 under'
            WHEN AGE BETWEEN 18 AND 40 THEN '18-40'
            WHEN AGE BETWEEN 41 AND 65 THEN '41-65'
            ELSE '65 over'
        END AS Age_Group, CLASIFFICATION_FINAL,
        CASE
            WHEN DATE_DIED != '9999-99-99' THEN 1 ELSE 0
        END AS Died_Covid
    FROM [dbo].[COVID19_DATA]
)
SELECT
    Age_Group,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN CLASIFFICATION_FINAL IN (1, 2, 3) THEN 1 ELSE 0 END) AS Covid_Positive,
    SUM(Died_Covid) AS Covid_Deaths
FROM AgeGroup
GROUP BY Age_Group;



/*
c. Pregnant Patients:
		• Count of Pregnant Patients: Determine the total number of pregnant patients.
		• Count of Pregnant Patients and COVID-19 Deaths: Focus on the count of pregnant patients who contracted COVID-19 and provide the number of deaths among them.
			Use CTE  
*/
WITH AgeGroup AS (
    SELECT 
        DATE_DIED, AGE, CLASIFFICATION_FINAL, SEX, PREGNANT,
        CASE 
		    WHEN AGE < 18 THEN '18 under'
            WHEN AGE BETWEEN 18 AND 40 THEN '18-40'
            WHEN AGE BETWEEN 41 AND 65 THEN '41-65'
            ELSE '65 over'
        END AS Age_group
    FROM [dbo].[COVID19_DATA]
)
SELECT 
    Age_group, 
    COUNT(*) AS Total_Pregnant_Patients, 
    SUM(CASE WHEN DATE_DIED != '9999-99-99' THEN 1 ELSE 0 END) AS Counts_deaths
FROM AgeGroup
WHERE PREGNANT = 1 AND CLASIFFICATION_FINAL IN (1, 2, 3)
GROUP BY Age_group;

/*
d. Patients with Specific Conditions:
		• Count of Patients with Specific Conditions: Investigate the count of patients with specific conditions (e.g., diabetes, COPD, asthma, hypertension)
		  and analyze their outcomes, such as deaths related to COVID-19.
*/




SELECT 
    COUNT(*) AS Total_patients,
    (SELECT COUNT(*) FROM [dbo].[COVID19_DATA] WHERE CLASIFFICATION_FINAL NOT IN (1, 2, 3)) AS Negative_Covid_Patients,
    (SELECT COUNT(*) FROM [dbo].[COVID19_DATA] WHERE CLASIFFICATION_FINAL IN (1, 2, 3)) AS Positeve_Covid_Patients,
	(SELECT COUNT(*) FROM [dbo].[COVID19_DATA] WHERE CLASIFFICATION_FINAL IN (1, 2, 3) AND DATE_DIED != '9999-99-99') AS Covid_Death_Patients
FROM [dbo].[COVID19_DATA];






