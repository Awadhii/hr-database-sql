-- HR Searches used on day to day basis

-- search for a certain emoployee
SELECT *
FROM employee_directory
WHERE department = 'Information Technology'
;

-- calculation of total payroll, average payroll and headcount of employees
-- used for changing the structure or any modifications in the department requird

SELECT
d.name AS department,
COUNT(e.id) AS employee_count ,
SUM(e.payroll) AS total_payroll,
ROUND(AVG(e.payroll),2) AS average_payroll
FROM employees e
JOIN departments d ON e.department_id = d.id
GROUP BY d.id
ORDER BY total_payroll DESC;

-- My part which is Onboarding employees
INSERT INTO employees (first_name, last_name, email, hire_date, payroll, department_id, role_id)
VALUES('Fahad','AlMubarki','falmubarki@company.com', '2026-09-17',3500.00,1,3);

-- promotion of said emoployee updating payroll
UPDATE employees
SET role_id = (SELECT id FROM roles WHERE title = 'HR Officer & Admin'),
    payroll = 2000.00
    WHERE id = 4;


--performance review documentation
INSERT INTO performance_reviews (employee_id, reviewer_id, review_date,
rating, comments)
VALUES (4,1,'2026-09-13',5,'Excepetional performance in workflow automation and onboarding support.');

--Retrieve the details of performance review with the reviewers names and department
SELECT
e.first_name || ' ' || e.last_name AS employee,
r.title AS role,
d.name AS department,
rev.first_name || ' ' || rev.last_name AS reviewer,
pr.review_date,
pr.rating,
pr.comments
FROM performance_reviews pr
JOIN employees e ON pr.employee_id = e.id
JOIN employees rev ON pr.reviewer_id = rev.id
JOIN departments d ON e.department_id = d.id
JOIN roles r ON e.role_id = r.id
ORDER BY pr.review_date DESC;

-- Top performers identification rating higher or equal to 4
SELECT
    e.first_name,
    e.last_name,
    r.title AS role,
    pr.rating,
    e.payroll
FROM employees e
JOIN roles r ON e.role_id = r.id
JOIN performance_reviews pr ON e.id = pr.employee_id
WHERE pr.rating >= 4;


--remove an old perfeormance review entry
DELETE FROM performance_reviews
WHERE employee_id = 9 AND review_date = '2025-06-10'
;
