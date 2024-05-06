SELECT COUNT(*) AS live_patients  
FROM [dbo].[COVID19_DATA]
WHERE DATE_DIED = '9999-99-99';


/*a. Gender Distribution:

		• Count of Patients by Gender: Categorize patients by gender (male, female, other).*/
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
		  the count of patients in each group.
*/
	SELECT  
		CASE 
			WHEN AGE < 18 THEN '0-17'
			WHEN AGE between 18 and 40 THEN '18-40'
			WHEN AGE between 41 and 65 THEN '41-65'
			ELSE '65+'
			END AS Age_Groups,
			COUNT(*) as Total_Count
		 from [dbo].[COVID19_DATA]
		 GROUP by 
		 	CASE
		 	WHEN AGE < 18 THEN '0-17'
			WHEN AGE between 18 and 40 THEN '18-40'
			WHEN AGE between 41 and 65 THEN '41-65'
			ELSE '65+'
			END
		ORDER BY 1 asc;



/*
SELECT COUNT(*) as Total_patient_count, 
 CASE 
	WHEN  PATIENT_TYPE = 1 THEN 'returned home'
	ELSE 'hospitalization'
	END AS Patient_type
	FROM [dbo].[COVID19_DATA]
GROUP BY PATIENT_TYPE;

SELECT * FROM [dbo].[COVID19_DATA]*/


		/*
		-- Count of Patients by Age Group and COVID-19 Deaths: Analyze the count of patients in each age group who contracted COVID-19 and 
		--the number of deaths in each group.

		select count(DATE_DIED) as Counted_Of_Died, DATE_DIED as LIVE_Patients
		 from [dbo].[COVID19_DATA]
		 where DATE_DIED != '9999-99-99'
		 group by DATE_DIED;
		 	*/
-------------------------------------------------------------
SELECT
	CASE
		WHEN AGE < 18 THEN '0-17'
		WHEN AGE BETWEEN 18 AND 40 THEN '18-40'
		WHEN AGE BETWEEN 41 AND 65 THEN '41-65'
		ELSE '65+'
	END AS Age_Groups,
	COUNT(DATE_DIED) AS Counted_Of_Died
FROM
	[dbo].[COVID19_DATA]
WHERE
	DATE_DIED != '9999-99-99'
GROUP BY
	CASE
		WHEN AGE < 18 THEN '0-17'
		WHEN AGE BETWEEN 18 AND 40 THEN '18-40'
		WHEN AGE BETWEEN 41 AND 65 THEN '41-65'
		ELSE '65+'
	END;


/*
	c. Pregnant Patients:
		• Count of Pregnant Patients: Determine the total number of pregnant patients.
		• Count of Pregnant Patients and COVID-19 Deaths: Focus on the count of pregnant patients who
		contracted COVID-19 and provide the number of deaths among them.


SELECT * FROM [dbo].[COVID19_DATA]

SELECT COUNT (*) as Total_Pregnant_Patients 
FROM [dbo].[COVID19_DATA]
WHERE PREGNANT = 1 

UNION All 

SELECT COUNT(DATE_DIED) AS Counted_Of_Pregnant_Died
FROM
	[dbo].[COVID19_DATA]
WHERE
	DATE_DIED != '9999-99-99' 
	and 
	PREGNANT = 1;
	*/
-------------------------------------------------------------------------------------

	SELECT COUNT(*) AS Total_Pregnant_Patients,
    SUM(CASE 
		WHEN DATE_DIED != '9999-99-99' THEN 1 ELSE 0 END) AS Pregnant_Patients_Deaths
	FROM [dbo].[COVID19_DATA]
	WHERE PREGNANT = 1;


/*
d. Patients with Specific Conditions:
		• Count of Patients with Specific Conditions: Investigate the count of patients with specific conditions
			(e.g., diabetes, COPD, asthma, hypertension)
		  and analyze their outcomes, such as deaths related to COVID-19.
*/

SELECT * FROM [dbo].[COVID19_DATA];

SELECT
    Specific_Condition,
    COUNT(*) AS Total_Patients,
    SUM(CASE WHEN DATE_DIED != '9999-99-99' THEN 1 ELSE 0 END) AS Deaths
FROM
    (
        SELECT
            CASE
                WHEN DIABETES = 1 THEN 'DIABETES'
                WHEN COPD = 1 THEN 'COPD'
                WHEN ASTHMA = 1 THEN 'ASTHMA'
                WHEN INMSUPR = 1 THEN 'INMSUPR'
                WHEN HYPERTENSION = 1 THEN 'HYPERTENSION'
                WHEN OTHER_DISEASE = 1 THEN 'OTHER_DISEASE'
                WHEN CARDIOVASCULAR = 1 THEN 'CARDIOVASCULAR'
                WHEN OBESITY = 1 THEN 'OBESITY'
                WHEN RENAL_CHRONIC = 1 THEN 'RENAL_CHRONIC'
                WHEN TOBACCO = 1 THEN 'TOBACCO'
                ELSE 'No Specific Condition'
            END AS Specific_Condition,
            DATE_DIED
        FROM
            [dbo].[COVID19_DATA]
    ) AS ConditionData
GROUP BY
    Specific_Condition
ORDER BY
    Specific_Condition;

------------------------------------------------------------------------------------------------------------------

/*
•	classification: covid test findings. Values 1-3 mean that the patient was diagnosed with covid in different
Degrees. 4 or higher means that the patient is not a carrier of covid or that the test is inconclusive.

•	patient type: type of care the patient received in the unit. 1 for returned home and 2 for hospitalization.

icu: Indicates whether the patient had been admitted to an Intensive Care Unit. 

*/



SELECT * FROM [dbo].[COVID19_DATA]
WHERE CLASIFFICATION_FINAL in (1, 2, 3);


SELECT
 COUNT(*) FROM [dbo].[COVID19_DATA]
WHERE CLASIFFICATION_FINAL in (4, 5, 6, 7);
/*SELECT COUNT(*) 
FROM [dbo].[COVID19_DATA]
WHERE CLASIFFICATION_FINAL in(1, 2, 3)
GROUP BY CLASIFFICATION_FINAL;*/

--•	classification: covid test findings. Values 1-3 mean that the patient was diagnosed with covid in different
--Degrees. 4 or higher means that the patient is not a carrier of covid or that the test is inconclusive.


SELECT COUNT(*) as Total_patient_count, 
 CASE 
	WHEN  CLASIFFICATION_FINAL = 1 THEN 'diagnosed with Covid level 1'
	WHEN  CLASIFFICATION_FINAL = 2 THEN 'diagnosed with Covid level 2'
	WHEN  CLASIFFICATION_FINAL = 3 THEN 'diagnosed with Covid level 3'
	
	ELSE 'N/A'
	END AS CLASIFFICATION_FINAL
	FROM [dbo].[COVID19_DATA]
GROUP BY 
CASE 
	WHEN  CLASIFFICATION_FINAL = 1 THEN 'diagnosed with Covid level 1'
	WHEN  CLASIFFICATION_FINAL = 2 THEN 'diagnosed with Covid level 2'
	WHEN  CLASIFFICATION_FINAL = 3 THEN 'diagnosed with Covid level 3'
	ELSE 'N/A'
	END;


---------------------------------------------Demo 1-7--------------------------
SELECT COUNT(*) as Total_patient_count, 
 CASE 
	WHEN  CLASIFFICATION_FINAL = 1 THEN 'diagnosed with Covid level 1'
	WHEN  CLASIFFICATION_FINAL = 2 THEN 'diagnosed with Covid level 2'
	WHEN  CLASIFFICATION_FINAL = 3 THEN 'diagnosed with Covid level 3'
	WHEN  CLASIFFICATION_FINAL = 4 THEN 'inconclusive level 4'
	WHEN  CLASIFFICATION_FINAL = 5 THEN 'inconclusive level 5'
	WHEN  CLASIFFICATION_FINAL = 6 THEN 'inconclusive level 6'
	WHEN  CLASIFFICATION_FINAL = 7 THEN 'inconclusive level 7'
	ELSE 'N/A'
	END AS CLASIFFICATION_FINAL
	FROM [dbo].[COVID19_DATA]
GROUP BY 
CASE 
	WHEN  CLASIFFICATION_FINAL = 1 THEN 'diagnosed with Covid level 1'
	WHEN  CLASIFFICATION_FINAL = 2 THEN 'diagnosed with Covid level 2'
	WHEN  CLASIFFICATION_FINAL = 3 THEN 'diagnosed with Covid level 3'
	WHEN  CLASIFFICATION_FINAL = 4 THEN 'inconclusive level 4'
	WHEN  CLASIFFICATION_FINAL = 5 THEN 'inconclusive level 5'
	WHEN  CLASIFFICATION_FINAL = 6 THEN 'inconclusive level 6'
	WHEN  CLASIFFICATION_FINAL = 7 THEN 'inconclusive level 7'
	ELSE 'N/A'
	END;



--Patient Type
----------------------------------------

SELECT COUNT(*) as Total_patient_count, 
 CASE 
	WHEN  PATIENT_TYPE = 1 THEN 'returned home'
	ELSE 'hospitalization'
	END AS Patient_type
	FROM [dbo].[COVID19_DATA]
GROUP BY PATIENT_TYPE;




------------------------------------------------------
SELECT * FROM [dbo].[COVID19_DATA]
WHERE ICU in (99, 97);


--ICU values as 97 and 99 are missing data

SELECT COUNT(*) AS Count,
	CASE 
		WHEN ICU = 1 THEN 'Admitted'
		WHEN ICU = 2 THEN 'Not Admitted'
		WHEN ICU = 97 THEN 'Missing Data_97'
		WHEN ICU = 99 THEN 'Missing Data_99'
		ELSE 'N/A'
		END AS ICU_Report
FROM [dbo].[COVID19_DATA]
GROUP BY ICU;



------------------------INTUBED----------------------------------------

SELECT COUNT(*) AS Count,
	CASE 
		WHEN INTUBED = 1 THEN 'ventilator'
		WHEN INTUBED = 2 THEN 'Not ventilator'
		WHEN INTUBED = 97 THEN 'Missing Data_97'
		WHEN INTUBED = 99 THEN 'Missing Data_99'
		ELSE 'N/A'
		END AS Intubed_Report
FROM [dbo].[COVID19_DATA]
GROUP BY INTUBED;


---------------------------Medical-------------------------------------------------------

--•	usmr: Indicates whether the patient treated medical units of the first, second or third level.

SELECT COUNT(*) as Total_Medical_Count, 
 CASE 
	WHEN MEDICAL_UNIT != 12 THEN 'Other_Health_System'
	ELSE 'National_Health_System'
	END AS Medical_Unit
FROM [dbo].[COVID19_DATA]
GROUP BY
CASE 
	WHEN MEDICAL_UNIT != 12 THEN 'Other_Health_System'
	ELSE 'National_Health_System'
	END;

	--•	medical unit: type of institution of the National Health System that provided the care.

SELECT COUNT(*) as total_of_Patients, MEDICAL_UNIT
FROM [dbo].[COVID19_DATA]
GROUP BY MEDICAL_UNIT
ORDER BY 1 desc;


SELECT * FROM [dbo].[COVID19_DATA]

--------------------------USMER--------------------------------------- 

SELECT COUNT(*) as Total_USMER, 
 CASE 
	WHEN USMER = 1 THEN 'Medical_unit_L1'
	WHEN USMER = 2 THEN 'Medical_unit_L2'
	ELSE 'Medical_unit_L3'
	END AS Medical_Unit_Level
FROM [dbo].[COVID19_DATA]
GROUP BY
 CASE 
	WHEN USMER = 1 THEN 'Medical_unit_L1'
	WHEN USMER = 2 THEN 'Medical_unit_L2'
	ELSE 'Medical_unit_L3'
	END;
------------------------------------DEMO -----------------------------------------------------------

--Total Patients---------------



SELECT COUNT (*) as Count_Patients,
(SELECT COUNT(*) FROM [dbo].[COVID19_DATA]

WHERE CLASIFFICATION_FINAL NOT IN (1,2,3)) AS Not_Covid_Patients,
(SELECT COUNT(*) FROM [dbo].[COVID19_DATA]

WHERE CLASIFFICATION_FINAL IN (1,2,3)) AS Covid_Patients,
(SELECT COUNT(*) FROM [dbo].[COVID19_DATA]

WHERE CLASIFFICATION_FINAL IN (1,2,3) AND 
DATE_DIED != '9999-99-99') AS COVID_Patients_Deaths
FROM [dbo].[COVID19_DATA];


-----------------COunt Deaths----------------


WITH Ages_Group AS (
SELECT DATE_DIED, AGE, CLASIFFICATION_FINAL, SEX, 
	CASE 
		WHEN AGE < 18 THEN '18 under'
		WHEN AGE <= 40 THEN '18- 40 '
		WHEN AGE <= 65 THEN '41 - 65'
		ELSE '65 +'
	END AS Age_group
	FROM [dbo].[COVID19_DATA]
	)

	SELECT Age_group, 
		CASE WHEN SEX = '1' THEN 'Female'
		ELSE 'MALE'
		END AS Gender,
		COUNT(*) AS COUNT_COVID_Patients,
		SUM(
			CASE WHEN DATE_DIED != '9999-99-99' THEN 1 
			ELSE 0 END) AS Count_Deaths
			FROM Ages_Group
			WHERE CLASIFFICATION_FINAL IN (1,2,3)
			GROUP BY Age_group, SEX
			ORDER BY 1;
-----------------------------------------------------------------------


--------------------------Covid------------------------------------------

SELECT * FROM [dbo].[COVID19_DATA]



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
	SUM(CASE WHEN DATE_DIED = '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND PNEUMONIA = 1 THEN 1 ELSE 0 END) AS DIABETES,
	SUM(CASE WHEN DATE_DIED != '9999-99-99' AND CLASIFFICATION_FINAL IN (1, 2, 3) AND PNEUMONIA = 1 THEN 1 ELSE 0 END) AS DIABETES_Deaths,
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













