use ecg;

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