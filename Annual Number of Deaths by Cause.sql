--Looking at the data to be used
SELECT *
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses

--Looking at the data from Nigeria
SELECT *
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria'
ORDER BY 3 DESC 

--Total Deaths from executions in Nigeria (according to	Amnesty International)
SELECT entity, SUM(number_of_executions) exe_tot
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria'
GROUP BY entity


--Total Deaths from Meningitis in Nigeria
SELECT entity, SUM(number_of_deaths_from_meningitis) men_tot
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria'
GROUP BY entity

--Total Deaths from Alzheimer's Disease and other Dementias in Nigeria
SELECT entity, SUM(number_of_deaths_from_alzheimers_disease_and_other_dementias) alz_tot
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria'
GROUP BY entity

--Total deaths by each cause
SELECT entity,
SUM(number_of_executions) exe_tot,
SUM(number_of_deaths_from_meningitis) men_tot,
SUM(number_of_deaths_from_alzheimers_disease_and_other_dementias) alz_tot,
SUM(number_of_deaths_from_parkinsons_disease) park_tot,
SUM(number_of_deaths_from_nutritional_deficiencies) nut_tot,
SUM(number_of_deaths_from_malaria) mal_tot,
SUM(number_of_deaths_from_drowning) drow_tot,
SUM(number_of_deaths_from_interpersonal_violence) int_vio_tot,
SUM(number_of_deaths_from_maternal_disorders) mat_tot,
SUM(number_of_deaths_from_hiv_aids) hiv_tot,
SUM(number_of_deaths_from_drug_use_disorders) drug_use_tot,
SUM(number_of_deaths_from_tuberculosis) tube_tot,
SUM(number_of_deaths_from_cardiovascular_diseases) cardio_dis_tot,
SUM(number_of_deaths_from_lower_respiratory_infections) low_resp_tot,
SUM(number_of_deaths_from_neonatal_disorders) neo_tot,
SUM(number_of_deaths_from_alcohol_use_disorders) alc_tot,
SUM(number_of_deaths_from_self_harm) self_harm_tot,
SUM(number_of_deaths_from_exposure_to_forces_of_nature) exp_tot,
SUM(number_of_deaths_from_diarrheal_diseases) diar_tot,
SUM(number_of_deaths_from_environmental_heat_and_cold_exposure) env_tot,
SUM(number_of_deaths_from_neoplasms) neop_tot,
SUM(number_of_deaths_from_conflict_and_terrorism) con_tot,
SUM(number_of_deaths_from_diabetes_mellitus) diab_mell_tot,
SUM(number_of_deaths_from_chronic_kidney_disease) chr_kid_tot,
SUM(number_of_deaths_from_poisonings) pois_tot,
SUM(number_of_deaths_from_protein_energy_malnutrition) prot_tot,
SUM(number_of_deaths_from_terrorism) terr_tot,
SUM(number_of_deaths_from_road_injuries) road_inj_tot,
SUM(number_of_deaths_from_chronic_respiratory_diseases) chr_res_tot,
SUM(number_of_deaths_from_cirrhosis_and_other_chronic_liver_diseases) cirr_tot,
SUM(number_of_deaths_from_digestive_diseases) dige_tot,
SUM(number_of_deaths_from_fire_heat_and_hot_substances) fire_tot,
SUM(number_of_deaths_from_acute_hepatitis) acu_hep_tot
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria'
GROUP BY entity

--Creating a temp table to view the sum of deaths by each cause
DROP TABLE IF EXISTS #Total_Deaths
CREATE TABLE #Total_Deaths (
entity varchar(100),
cause varchar(100),
total int)

INSERT INTO #Total_Deaths VALUES 
('Nigeria', 'executions', 7),
('Nigeria', 'meningitis', 1520376),
('Nigeria', 'alzheimers_disease', 241713),
('Nigeria', 'parkinsons_disease', 66545),
('Nigeria', 'nutritional_deficiencies', 286858),
('Nigeria', 'malaria', 6422063),
('Nigeria', 'drowning', 103723),
('Nigeria', 'interpersonal_violence', 306846),
('Nigeria', 'maternal_disorders', 525566),
('Nigeria', 'hiv_aids', 2216718),
('Nigeria', 'drug_use_disorders', 4897),
('Nigeria', 'tuberculosis', 1769390),
('Nigeria', 'cardiovascular_diseases', 4176488),
('Nigeria', 'lower_respiratory_infections', 5917528),
('Nigeria', 'neonatal_disorders', 5262229),
('Nigeria', 'alcohol_use_disorders', 28341),
('Nigeria', 'self_harm', 190297),
('Nigeria', 'exposure_to_forces_of_nature', 1899),
('Nigeria', 'diarrheal_diseases', 7449328),
('Nigeria', 'environmental_heat_and_cold_exposure', 26363),
('Nigeria', 'neoplasms', 1618730),
('Nigeria', 'conflict_and_terrorism', 78908),
('Nigeria', 'diabetes_mellitus', 541020),
('Nigeria', 'chronic_kidney_disease', 464656),
('Nigeria', 'poisonings', 107604),
('Nigeria', 'protein_energy_malnutrition', 270470),
('Nigeria', 'terrorism', 22674),
('Nigeria', 'road_injuries', 487695),
('Nigeria', 'chronic_respiratory_diseases', 641714),
('Nigeria', 'cirrhosis_and_other_chronic_liver_diseases', 995203),
('Nigeria', 'digestive_diseases', 1716202),
('Nigeria', 'fire_heat_and_hot_substances', 110784),
('Nigeria', 'acute_hepatitis', 119860)

SELECT *
FROM #Total_Deaths

--Getting the causes of the most deaths 
SELECT cause, total
FROM #Total_Deaths
GROUP BY cause, total
ORDER BY total DESC

--The top 10 causes of the most deaths 
SELECT TOP 10 total, cause
FROM #Total_Deaths
GROUP BY cause, total
ORDER BY total DESC

--Getting the total deaths altogether.
SELECT SUM(total) AS SumofTotalDeaths
FROM #Total_Deaths


--Looking at the yearly distribution of deaths of the top 3 causes
SELECT year, number_of_deaths_from_diarrheal_diseases
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria'
ORDER BY year


SELECT year, number_of_deaths_from_malaria
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria'
ORDER BY year


SELECT year, number_of_deaths_from_lower_respiratory_infections
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria'
ORDER BY year


--Creating a temp table to view the sum of deaths by each year
CREATE TABLE #Yearly_Stats
(entity varchar(100),
year int,
total_annual_deaths int)

--An example of stats from the year 2013
SELECT 
(SELECT number_of_deaths_from_meningitis + 
number_of_deaths_from_alzheimers_disease_and_other_dementias + 
number_of_deaths_from_parkinsons_disease + 
number_of_deaths_from_nutritional_deficiencies +
number_of_deaths_from_malaria +
number_of_deaths_from_drowning +
number_of_deaths_from_interpersonal_violence + 
number_of_deaths_from_maternal_disorders + 
number_of_deaths_from_hiv_aids +
number_of_deaths_from_drug_use_disorders +
number_of_deaths_from_tuberculosis +
number_of_deaths_from_cardiovascular_diseases +
number_of_deaths_from_lower_respiratory_infections +
number_of_deaths_from_neonatal_disorders +
number_of_deaths_from_alcohol_use_disorders +
number_of_deaths_from_self_harm +
number_of_deaths_from_exposure_to_forces_of_nature +
number_of_deaths_from_diarrheal_diseases + 
number_of_deaths_from_environmental_heat_and_cold_exposure + 
number_of_deaths_from_neoplasms + 
number_of_deaths_from_conflict_and_terrorism + 
number_of_deaths_from_diabetes_mellitus + 
number_of_deaths_from_chronic_kidney_disease + 
number_of_deaths_from_poisonings + 
number_of_deaths_from_protein_energy_malnutrition + 
number_of_deaths_from_terrorism + 
number_of_deaths_from_road_injuries + 
number_of_deaths_from_chronic_respiratory_diseases + 
number_of_deaths_from_cirrhosis_and_other_chronic_liver_diseases + 
number_of_deaths_from_digestive_diseases + 
number_of_deaths_from_fire_heat_and_hot_substances + 
number_of_deaths_from_acute_hepatitis
+ number_of_executions)
FROM PersonalTutorial.dbo.AnnualNumberofDeathsbyCauses
WHERE entity = 'Nigeria' AND year = 2013


INSERT INTO #Yearly_Stats VALUES
('Nigeria', 1990, 1169882),
('Nigeria', 1991, 1215101),
('Nigeria', 1992, 1235700),
('Nigeria', 1993, 1267130),
('Nigeria', 1994, 1299980),
('Nigeria', 1995, 1331943),
('Nigeria', 1996, 1378453),
('Nigeria', 1997, 1397465),
('Nigeria', 1998, 1432393),
('Nigeria', 1999, 1469547),
('Nigeria', 2000, 1499222),
('Nigeria', 2001, 1523202),
('Nigeria', 2002, 1543128),
('Nigeria', 2003, 1553850),
('Nigeria', 2004, 1555326),
('Nigeria', 2005, 1547426),
('Nigeria', 2006, 1574546),
('Nigeria', 2007, 1580894),
('Nigeria', 2008, 1575815),
('Nigeria', 2009, 1573247),
('Nigeria', 2010, 1557022),
('Nigeria', 2011, 1535016),
('Nigeria', 2012, 1524636),
('Nigeria', 2013, 1516328),
('Nigeria', 2014, 1519214),
('Nigeria', 2015, 1500176),
('Nigeria', 2016, 1473052),
('Nigeria', 2017, 1455083),
('Nigeria', 2018, 1448418),
('Nigeria', 2019, 1439500)

SELECT *
FROM #Yearly_Stats

--To find out the most number of deaths
SELECT MAX(total_annual_deaths)
FROM #Yearly_Stats

--To find out the year with the most number of deaths
SELECT year, total_annual_deaths
FROM #Yearly_Stats
WHERE total_annual_deaths = 1580894

--To find out the least number of deaths
SELECT MIN(total_annual_deaths)
FROM #Yearly_Stats

--To find out the year with the least number of deaths
SELECT year, total_annual_deaths
FROM #Yearly_Stats
WHERE total_annual_deaths = 1169882

--To find out the average number of deaths
SELECT AVG(total_annual_deaths)
FROM #Yearly_Stats

--Total Number of Deaths by Cause
SELECT SUM(total) AS SumofTotalDeaths
FROM #Total_Deaths


--Total Number of Deaths by Year
SELECT SUM(total_annual_deaths) AS SumByYear
FROM #Yearly_Stats
