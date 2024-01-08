### BASIC SCHEMA SETUP FOR RAW TABLE IMPORT
# Creating the ECG schema
CREATE SCHEMA ecg;

# Using the schema
USE ecg;

# Creating a raw table for import
CREATE TABLE companies (
	id VARCHAR(255),
    organization VARCHAR(255),
    country VARCHAR(255),
    postal_code VARCHAR(255),
    city VARCHAR(255),
    company_size VARCHAR(255),
    economic_sector VARCHAR(255)
);

# Loading the .csv file
LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/ecg_df.csv'
INTO TABLE companies
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


### DATA EXPLORATION
# Quick check
SELECT * FROM companies;

# Checking number of rows (cases)
SELECT COUNT(*)
FROM companies;

# Checking for missing values (individual column)
SELECT COUNT(*)
FROM companies
WHERE id IS NULL;

# Checking for missing values (all columns)
SELECT 
    SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) AS id_null_num, 
    SUM(CASE WHEN organization IS NULL THEN 1 ELSE 0 END) AS organizations_null_num,
    SUM(CASE WHEN country IS NULL THEN 1 ELSE 0 END) AS country_null_num,
	SUM(CASE WHEN postal_code IS NULL THEN 1 ELSE 0 END) AS postal_code_null_num,
	SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS city_null_num,
	SUM(CASE WHEN company_size IS NULL THEN 1 ELSE 0 END) AS company_size_null_sum,
	SUM(CASE WHEN economic_sector IS NULL THEN 1 ELSE 0 END) AS economic_sector_null_num
FROM companies;

# Checking unique values of some of the columns
SELECT DISTINCT country, COUNT(id) as count
	FROM companies
	GROUP BY country
	ORDER BY count DESC;

SELECT DISTINCT company_size, COUNT(id) as count
	FROM companies
	GROUP BY company_size
	ORDER BY company_size ASC;

SELECT DISTINCT economic_sector, COUNT(id) as count
	FROM companies
    GROUP BY economic_sector
    ORDER BY economic_sector ASC;

### DATA WRANGLING
# Overview of columns
DESCRIBE companies;

# Setting the correct data types and adding primary key
ALTER TABLE companies
	MODIFY id INT NOT NULL,
	ADD PRIMARY KEY (id);

# Renaming organization column
ALTER TABLE companies
	RENAME COLUMN organization TO company;

# Row correction: Case 92435 was scraped incorrectly (found in unique values of company_size)
SELECT *
	FROM companies
	WHERE id = 92435;

UPDATE companies
	SET company = 'IMPRESUM GRAFICAS LITOLEMA S.L.',
		country = 'ES',
		postal_code = '46006',
		city = 'Valencia',
		company_size = '(8) Todas las tallas',
		economic_sector = 'Otros' # Inserted after checking on website
	WHERE id = 92435;

# Renaming countries
UPDATE companies
	SET country = CASE WHEN country = 'DE' THEN 'Germany'
					   WHEN country = 'AT' THEN 'Austria'
					   WHEN country = 'ES' THEN 'Spain'
					   WHEN country = 'IT' THEN 'Italy'
					   WHEN country = 'CH' THEN 'Switzerland'
					   WHEN country = 'NL' THEN 'Netherlands'
					   WHEN country = 'BE' THEN 'Belgium'
					   WHEN country = 'LU' THEN 'Luxembourg'
					   WHEN country = 'SE' THEN 'Sweden'
					   WHEN country = 'DK' THEN 'Denmark'
					   WHEN country = 'US' THEN 'United States'
					   WHEN country = 'PT' THEN 'Portugal'
					   WHEN country = 'UK' THEN 'United Kingdom'
					   WHEN country = 'HR' THEN 'Croatia'
					   WHEN country = 'UR' THEN 'Uruguay'
                  END
	WHERE country IN ('DE', 'AT', 'ES', 'IT', 'CH', 'NL', 'BE', 'LU', 'SE', 'DK', 'US', 'PT', 'UK', 'HR', 'UR')
		  AND id <> 0; # This is necessary so that the safe update mode does not intervene

UPDATE companies
	SET economic_sector = CASE WHEN economic_sector = 'Abfallentsorgung' THEN 'Waste disposal'
							   WHEN economic_sector = 'Assicurazione' THEN 'Waste disposal'
							   WHEN economic_sector = 'Assistenza sanitaria / Servizi sociali / Infermieristica' THEN 'Health care / Social affairs / Nursing'
                               # ...
                  END
	WHERE economic_sector IN (
							 'Abfallentsorgung',
							 'Assicurazione',
                             'Assistenza sanitaria / Servizi sociali / Infermieristica'
                             # ...
                             )
		  AND id <> 0; # This is necessary so that the safe update mode does not intervene