# HR Database (CS50 SQL Final Project)

A SQLite database for managing an insurance company's HR data: departments, roles, employees and performance reviews.

**Video walkthrough:** https://youtu.be/UyQOyHRyPx4

## Files
- `schema.sql`: tables, constraints, indexes, a view and sample data
- `queries.sql`: onboarding, promotion, payroll reports, reviews and top performers
- `DESIGN.md`: design document (scope, ERD, relationships, optimizations, limitations)
- `Hr entity diagram.jpg`: entity relationship diagram

## Run it
```
sqlite3 hr.db < schema.sql
sqlite3 hr.db
.headers on
.mode column
.read queries.sql
```
