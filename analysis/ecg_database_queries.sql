use ecg;

SELECT * FROM balance_audit_types;

# Checking balance audit types
SELECT t.audit_type, COUNT(b.id)
FROM balances as b
INNER JOIN balance_audit_types as t
ON b.audit_types_id = t.id
GROUP BY t.audit_type;

### VIEWS
# Highscores? ;)
CREATE OR REPLACE VIEW highscores AS
SELECT
	o.organization,
    c.country_name,
    b.entry_number,
    b.year,
	a.audit_type,
    b.score
FROM organizations AS o
	INNER JOIN balances AS b
		ON o.id = b.organizations_id
	INNER JOIN balance_audit_types AS a
		ON a.id = b.audit_types_id
	INNER JOIN locations AS l
		ON l.id = o.locations_id
	INNER JOIN countries AS c
		ON c.id = l.country_id
ORDER BY b.score DESC
LIMIT 100;

# Lowscores? ;)
CREATE OR REPLACE VIEW lowscores AS
SELECT
	o.organization,
    c.country_name,
    b.entry_number,
    b.year,
	a.audit_type,
    b.score
FROM organizations AS o
	INNER JOIN balances AS b
		ON o.id = b.organizations_id
	INNER JOIN balance_audit_types AS a
		ON a.id = b.audit_types_id
	INNER JOIN locations AS l
		ON l.id = o.locations_id
	INNER JOIN countries AS c
		ON c.id = l.country_id
WHERE score IS NOT NULL
ORDER BY b.score ASC
LIMIT 100;

### EXPLORATION
# How was the development within companies (year & score of each balance)?
SELECT
	o.organization,
    b.entry_number,
    b.year,
    b.score
FROM organizations AS o
	INNER JOIN balances AS b
		ON o.id = b.organizations_id;

# Large companies from Germany and how many balances they have in their records?
SELECT 
	o.organization,
    e.employees,
    l.postal_code,
    l.city,
    COUNT(o.id) AS number_of_balances
FROM organizations AS o
	INNER JOIN employees AS e
		ON o.employees_id = e.id
	INNER JOIN sizes AS s
		ON e.sizes_id = s.id
	INNER JOIN locations AS l
		ON o.locations_id = l.id
	INNER JOIN balances AS b
		ON o.id = b.organizations_id
WHERE s.id = 4 AND l.country_id = 4
GROUP BY 
	o.organization,
    e.employees,
    l.postal_code,
    l.city
ORDER BY number_of_balances DESC;