# task4-SQL-Internship
# 🗂️ SQL Developer Internship - Task 4: Triggers for Auditing

## 📌 Objective
The goal of this task is to **track INSERT, UPDATE, and DELETE operations** on a table using **triggers** and record these changes into an **audit log table**.  
This ensures that every modification in the database is monitored for auditing and accountability.

---

## 🔑 Key Concepts
- **Triggers** → Special stored programs that execute automatically on INSERT/UPDATE/DELETE events.  
- **BEFORE & AFTER triggers** → Control whether logic runs before or after the event.  
- **NEW & OLD references** → Provide access to row values before and after changes.  
- **Auditing** → Keeping a history of what data was changed, when, and by whom.  

---

## 🏗️ Schema Design

### 1. Main Table: `employees`
```sql
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

