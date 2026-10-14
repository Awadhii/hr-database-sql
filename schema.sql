-- All departments in the company
CREATE TABLE departments(
    id INTEGER,
    name TEXT NOT NULL UNIQUE,
    location TEXT,
    PRIMARY KEY(id)
);

-- All Job titles
CREATE TABLE roles(
    id INTEGER,
    title TEXT NOT NULL UNIQUE,
    PRIMARY KEY(id)
);

-- core employee info with payroll
CREATE TABLE employees(
    id INTEGER,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE,
    hire_date NUMERIC NOT NULL,
    payroll NUMERIC NOT NULL,
    department_id INTEGER,
    role_id INTEGER,
    PRIMARY KEY(id),
    FOREIGN KEY(department_id) REFERENCES departments(id),
    FOREIGN KEY(role_id) REFERENCES roles(id)
);

-- Performance Evaluation
CREATE TABLE performance_reviews(
    id INTEGER,
    employee_id INTEGER,
    reviewer_id INTEGER,
    review_date NUMERIC NOT NULL,
    rating INTEGER CHECK(rating BETWEEN 1 AND 5),
    comments TEXT,
    PRIMARY KEY(id),
    FOREIGN KEY(employee_id) REFERENCES employees(id),
    FOREIGN KEY(reviewer_id) REFERENCES employees(id)
);

-- INDEXES for common search email and dempartments
CREATE INDEX idx_employee_email ON employees(email);
CREATE INDEX idx_employee_department ON employees(department_id);

-- CREATE VIEW for quick employee directory search
CREATE VIEW employee_directory AS
SELECT
    e.first_name,
    e.last_name,
    e.email,
    d.name AS department,
    r.title AS role
    FROM employees e
    JOIN departments d ON e.department_id = d.id
    JOIN roles r ON e.role_id = r.id;

-- SAMPLE DATA

-- Inserted Departments
INSERT INTO departments (id, name, location) VALUES
(1, 'HR & GOV PR', 'Crystal Tower - Floor 7'),
(2, 'Underwriting', 'Crystal Tower - Floor 3'),
(3, 'Claims & Network Management', 'Crystal Tower - Floor 6'),
(4, 'Information Technology', 'Crystal Tower - Floor 8'),
(5, 'Distribution & Marketing PR', 'Crystal Tower - Floor 1'),
(6, 'Governance & Risk Compliance', 'Crystal Tower - Floor 2'),
(7, 'Finance', 'Crystal Tower - Floor 4'),
(8, 'Legal', 'Crystal Tower - Floor 5'),
(9, 'Executive Management', 'Crystal Tower - Penthouse');

-- 2. Insert Roles
INSERT INTO roles (id, title) VALUES
-- HR & GOV PR Roles
(1, 'Head of HR'),
(2, 'HR Officer & Admin'),
(3, 'Talent Acquisition'),
(4, 'HR Assistant'),

-- Underwriting Roles
(5, 'Head of Underwriting'),
(6, 'Senior Insurance Specialist'),
(7, 'Insurance Specialist'),
(8, 'Junior Insurance Specialist'),

-- Claims Roles (No Head)
(9, 'Senior Claims Specialist'),
(10, 'Claims Specialist'),
(11, 'Claims Auditor'),
(12, 'Junior Claims Auditor'),

-- IT Roles
(13, 'Head of IT'),
(14, 'Database Administrator'),
(15, 'Systems Administrator'),
(16, 'Tech Support Helpdesk'),

-- Distribution & Marketing Roles
(17, 'Customer Relations Manager'),
(18, 'Digital Transformation Specialist'),

-- GRC Roles
(19, 'Chief of GRC'),
(20, 'AML Officer'),
(21, 'Senior Risk Analyst'),
(22, 'Compliance Specialist'),

-- Finance Roles
(23, 'Chief Financial Officer'),
(24, 'Accountant - Receivables'),
(25, 'Accountant - Payables'),
(26, 'Cashier'),

-- Legal Roles
(27, 'General Counsel'),
(28, 'Legal Consultant'),
(29, 'Corporate Paralegal'),
(30, 'Legal Compliance Specialist'),

-- Executive Roles
(31, 'Chairman'),
(32, 'Chief Executive Officer');

-- 3. Insert 34 Custom Employees
INSERT INTO employees (id, first_name, last_name, email, hire_date, payroll, department_id, role_id) VALUES
-- HR & GOV PR (Dept 1)
(1, 'Sarah', 'Al-Mansoor', 'salmansoor@company.com', '2018-03-15', 4200.00, 1, 1),
(2, 'Abdulaziz', 'Al-Rashid', 'arashid@company.com', '2022-06-01', 2800.00, 1, 2),
(3, 'Haya', 'Al-Shatti', 'hshatti@company.com', '2023-01-10', 2200.00, 1, 3),
(4, 'Jassim', 'Al-Mulla', 'jalmulla@company.com', '2023-09-15', 1500.00, 1, 4),

-- Underwriting (Dept 2)
(5, 'Omar', 'Al-Fadli', 'oalfadli@company.com', '2017-11-05', 4500.00, 2, 5),
(6, 'Noura', 'Al-Kandari', 'nalkandari@company.com', '2021-10-12', 3100.00, 2, 6),
(7, 'Abdullah', 'Al-Otaibi', 'aalotaibi@company.com', '2022-05-18', 2300.00, 2, 7),
(8, 'Dana', 'Al-Salem', 'dsalem@company.com', '2023-04-30', 1600.00, 2, 8),

-- Claims & Network Management (Dept 3 - No Head)
(9, 'Bader', 'Al-Zaid', 'bzaid@company.com', '2018-02-14', 3800.00, 3, 9),
(10, 'Mena', 'Al-Qattan', 'mqattan@company.com', '2020-08-20', 2900.00, 3, 10),
(11, 'Zainab', 'Al-Farsi', 'zfarsi@company.com', '2022-11-01', 2200.00, 3, 11),
(12, 'Khaled', 'Al-Ghanim', 'kalghanim@company.com', '2023-06-15', 1450.00, 3, 12),

-- Information Technology (Dept 4)
(13, 'Ahmad', 'Hassan', 'ahassan@company.com', '2019-01-10', 4400.00, 4, 13),
(14, 'Fatima', 'Al-Enezi', 'falenezi@company.com', '2021-09-15', 3300.00, 4, 14),
(15, 'Fahad', 'Al-Ajmi', 'fajmi@company.com', '2022-08-14', 2400.00, 4, 15),
(16, 'Hamad', 'Al-Rashed', 'hrashed@company.com', '2023-03-22', 1700.00, 4, 16),

-- Distribution & Marketing PR (Dept 5)
(17, 'Maryam', 'Al-Sabah', 'malsabah@company.com', '2018-05-19', 4000.00, 5, 17),
(18, 'Ali', 'Al-Bahar', 'abalhar@company.com', '2020-12-01', 3100.00, 5, 18),
(19, 'Laila', 'Al-Hajri', 'lhajri@company.com', '2022-07-10', 2300.00, 5, 7),
(20, 'Tariq', 'Al-Eisa', 'teisa@company.com', '2023-08-08', 1600.00, 5, 8),

-- Governance & Risk Compliance (Dept 6)
(21, 'Khaled', 'Al-Mutawa', 'kalmutawa@company.com', '2017-09-01', 4600.00, 6, 19),
(22, 'Ghalia', 'Al-Nasser', 'galnasser@company.com', '2021-02-15', 3200.00, 6, 20),
(23, 'Faisal', 'Al-Marzouq', 'falmarzouq@company.com', '2022-10-05', 2700.00, 6, 21),
(24, 'Nadia', 'Al-Kazi', 'nalkazi@company.com', '2023-05-20', 1900.00, 6, 22),

-- Finance (Dept 7)
(25, 'Hussein', 'Al-Ali', 'halali@company.com', '2018-11-11', 4500.00, 7, 23),
(26, 'Mona', 'Al-Khaled', 'malkhaled@company.com', '2020-04-18', 2800.00, 7, 24),
(27, 'Yaqoub', 'Al-Sayegh', 'yalsayegh@company.com', '2022-09-01', 2800.00, 7, 25),
(28, 'Dalia', 'Al-Othman', 'dalothman@company.com', '2023-07-12', 1600.00, 7, 26),

-- Legal (Dept 8)
(29, 'Nasser', 'Al-Kharafi', 'nalkharafi@company.com', '2017-04-03', 4700.00, 8, 27),
(30, 'Shaikha', 'Al-Zamel', 'salzamel@company.com', '2020-06-25', 3300.00, 8, 28),
(31, 'Waleed', 'Al-Terkait', 'walterkait@company.com', '2022-03-30', 2100.00, 8, 29),
(32, 'Farah', 'Al-Roudhan', 'falroudhan@company.com', '2023-10-01', 2400.00, 8, 30),

-- Executive Management (Dept 9)
(33, 'Yousef', 'Al-Awadhi', 'yalawadhi@company.com', '2015-01-01', 8500.00, 9, 31),
(34, 'Yousef', 'Al-Majed', 'yalmajed@company.com', '2016-03-15', 7800.00, 9, 32);

--adding a sample performance review
INSERT INTO performance_reviews(employee_id,reviewer_id,review_date, rating, comments)
VALUES (9,1,'2025-06-10',3,'Solid claims officer, needs improvement on teamwork documentation.');
