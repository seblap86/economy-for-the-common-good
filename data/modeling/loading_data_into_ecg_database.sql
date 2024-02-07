use ecg;

# Truncate existing rows
SET FOREIGN_KEY_CHECKS=0;

TRUNCATE TABLE balance_audit_types;
TRUNCATE TABLE balance_documents;
TRUNCATE TABLE balances;
TRUNCATE TABLE balances_x_documents;
TRUNCATE TABLE balance_types;
TRUNCATE TABLE balance_versions;
TRUNCATE TABLE countries;
TRUNCATE TABLE employees;
TRUNCATE TABLE locations;
TRUNCATE TABLE organizations;
TRUNCATE TABLE sectors;
TRUNCATE TABLE sizes;

SET FOREIGN_KEY_CHECKS=1;

# Load data
SET GLOBAL local_infile=ON;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/countries.csv'
INTO TABLE countries
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/sizes.csv'
INTO TABLE sizes
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/sectors.csv'
INTO TABLE sectors
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/balance_types.csv'
INTO TABLE balance_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/balance_versions.csv'
INTO TABLE balance_versions
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/balance_audit_types.csv'
INTO TABLE balance_audit_types
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/balance_documents.csv'
INTO TABLE balance_documents
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/locations.csv'
INTO TABLE locations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/employees.csv'
INTO TABLE employees
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/organizations.csv'
INTO TABLE organizations
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/balances.csv'
INTO TABLE balances
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE '/home/seblap/Files/Arbeit/Data Analytics/GitHub repos/economy-for-the-common-good/data/modeling/tables/balances_x_documents.csv'
INTO TABLE balances_x_documents
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SET GLOBAL local_infile=OFF;