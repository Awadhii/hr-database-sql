# Design Document

By Yousef AlAwadhi

Video overview: <[URL HERE](https://youtu.be/UyQOyHRyPx4)>

## Scope

* What is the purpose of your database?

Jobs are hard to find these days, and I ended up working as an HR & Admin Officer at an insurance company, even though my passion has always been computers and hardware. So I decided to bring my Computer Engineering degree into the HR role and build a database that makes the HR side of things easier to manage. The goal is a single reliable place for employee records, company structure and performance reviews, instead of scattered spreadsheets.

* Which people, places, things, etc. are you including in the scope of your database?

Departments, roles, and employees at the administrative, operational and executive levels. Crystal Tower is the main location in the database, and each department is tied to a floor in it. Employee records are stored along with their job roles and performance reviews.

* Which people, places, things, etc. are *outside* the scope of your database?

Payroll processing, bank account details, and the time and attendance system (leave balances, sick leave, etc). Each employee does have a `payroll` amount stored, but only as a reference figure for HR budgeting, not for running salary payments.

## Functional Requirements

* What should a user be able to do with your database?

The database is mainly for HR use. A user can add and onboard new employees, look up employees by name, ID or email, filter employees by department, and reorganize the structure of the company. A user can also calculate headcount and total and average payroll per department, promote an employee by updating their role and payroll, record performance reviews, see who reviewed whom, and identify top performers by rating.

* What's beyond the scope of what a user should be able to do with your database?

Daily attendance, access control for locked doors using ID cards, and job applications or CVs. These need real-time logging or a separate recruitment workflow, which is a different problem from managing existing employees.

## Representation

### Entities

* Which entities will you choose to represent in your database?

Departments, roles, employees, and performance reviews.

* What attributes will those entities have?

The `departments` table has an `id`, a unique `name` and a `location` inside Crystal Tower. The `roles` table has an `id` and a unique `title`. The `employees` table has an `id`, `first_name`, `last_name`, a unique `email`, a `hire_date` and a `payroll` amount, along with `department_id` and `role_id` linking them to their department and role. The `performance_reviews` table has an `id`, the `employee_id` of the person being reviewed, the `reviewer_id` of the person doing the review, a `review_date`, a `rating` from 1 to 5 and free-text `comments`.

* Why did you choose the types you did?

INTEGER for the primary keys so they auto increment. TEXT for things like names, emails and titles, so I can put NOT NULL and UNIQUE on them. NUMERIC for dates and payroll, since SQLite handles both date strings and decimal amounts with it.

* Why did you choose the constraints you did?

NOT NULL stops a field from being left blank if someone forgets to fill it in, like an employee's name or email.
UNIQUE prevents duplicates, which matters a lot for emails and role titles, since two employees with the same email or two identical roles would break lookups.
FOREIGN KEY links the tables together, so an employee can't point to a department or role that doesn't exist.
CHECK on `rating` limits it to 1 through 5, so performance data stays consistent and easy to average.

### Relationships

The entity relationship diagram below shows how the four entities connect:

![HR Database ERD](Hr%20entity%20diagram.jpg)

Departments to employees is one to many. One department can have many employees, but an employee can only belong to one department.

Roles to employees is also one to many. Many employees can share a role, but no employee has two titles.

Employees to performance reviews is one to many, and also self referencing. One employee can receive many performance reviews over time. Since managers are stored in the employees table too, there is no separate managers table. Instead, `performance_reviews` has two foreign keys that both point to `employees.id`: `employee_id` is the person being reviewed and `reviewer_id` is the person doing the review. That means an employee can appear on either side of a review.

## Optimizations

* Which optimizations (e.g., indexes, views) did you create? Why?

I created `idx_employee_department` so filtering employees by department doesn't have to scan the whole table, since that is the search HR runs the most. I confirmed with `EXPLAIN QUERY PLAN` that SQLite uses this index for department lookups. I also created `idx_employee_email`, but SQLite already creates an index automatically for the UNIQUE constraint on email, so it is largely redundant, and I would drop it in a production version.

I also created the `employee_directory` view, which joins employees, departments and roles into one table. That way a user doesn't need to write a three-table JOIN just to do a basic employee lookup.

## Limitations

* What are the limitations of your design?

In a real system I would keep a record of the date and time of every update, like each salary change. Without that, updating `payroll` or `role_id` just overwrites the old value, so an audit can't see when someone's career path changed, when their salary went up, or what they were paid before.

* What might your database not be able to represent very well?

As an HR & Admin Officer I also work in facilities and procurement. People at work know that, but the database doesn't, because each employee has only one role, so I can't be stored as both HR Officer and Procurement Officer at the same time.

The reviews are also limited. They only store who was reviewed, who reviewed them, the date, a rating and a comment, with no separate field for the manager's own opinion or a self-assessment from the employee.
