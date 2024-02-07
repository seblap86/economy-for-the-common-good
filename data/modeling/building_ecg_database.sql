use ecg;

CREATE TABLE countries (
	id INT NOT NULL UNIQUE,
    country_code VARCHAR(255),
    country_name VARCHAR(255),
	PRIMARY KEY (id)
    );

CREATE TABLE sizes (
	id INT NOT NULL UNIQUE,
    company_size_category VARCHAR(255),
	PRIMARY KEY (id)
    );

CREATE TABLE sectors (
	id INT NOT NULL UNIQUE,
    economic_sector_EN VARCHAR(255),
    economic_sector_DE VARCHAR(255),
    PRIMARY KEY (id)
    );

CREATE TABLE balance_types (
	id INT NOT NULL UNIQUE,
    type_code VARCHAR(255),
    PRIMARY KEY (id)
    );

CREATE TABLE balance_versions (
	id INT NOT NULL UNIQUE,
    balance_version VARCHAR(255),
    PRIMARY KEY (id)
    );

CREATE TABLE balance_audit_types (
	id INT NOT NULL UNIQUE,
    audit_type VARCHAR(255),
    PRIMARY KEY (id)
    );

CREATE TABLE balance_documents (
	id INT NOT NULL UNIQUE,
    document VARCHAR(255),
    PRIMARY KEY (id)
    );

CREATE TABLE locations (
	id INT NOT NULL UNIQUE,
    postal_code VARCHAR(255),
    city VARCHAR(255),
    country_id INT,
	PRIMARY KEY (id),
    FOREIGN KEY (country_id)
		REFERENCES countries(id)
    );

CREATE TABLE employees (
	id INT NOT NULL UNIQUE,
    employees VARCHAR(255),
    sizes_id INT,
    PRIMARY KEY (id),
    FOREIGN KEY (sizes_id)
		REFERENCES sizes(id)
    );

CREATE TABLE organizations (
	id INT NOT NULL UNIQUE,
	organization VARCHAR(255),
    locations_id INT,
    employees_id INT,
	sectors_id INT,
    PRIMARY KEY (id),
	FOREIGN KEY (locations_id)
		REFERENCES locations(id),
	FOREIGN KEY (employees_id)
		REFERENCES employees(id),
	FOREIGN KEY (sectors_id)
		REFERENCES sectors(id)
    );
    
CREATE TABLE balances (
	id INT NOT NULL UNIQUE,
    organizations_id INT,
    entry_number INT,
    types_id INT,
    versions_id INT,
    audit_types_id INT,
    year INT,
    valid_until_date DATE,
    valid_until_year INT,
    score INT,
    PRIMARY KEY (id),
    FOREIGN KEY (organizations_id)
		REFERENCES organizations(id),
    FOREIGN KEY (types_id)
		REFERENCES balance_types(id),
    FOREIGN KEY (versions_id)
		REFERENCES balance_versions(id),
	FOREIGN KEY (audit_types_id)
		REFERENCES balance_audit_types(id)
    );

CREATE TABLE balances_x_documents (
	id INT NOT NULL UNIQUE,
    balances_id INT,
    balance_documents_id INT,
	PRIMARY KEY (id),
    FOREIGN KEY (balances_id)
		REFERENCES balances(id),
    FOREIGN KEY (balance_documents_id)
		REFERENCES balance_documents(id)
    );