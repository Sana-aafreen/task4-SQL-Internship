Create database Company;
use Company;

-- Step 1: Create Sample Table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Step 2: Create Audit Log Table

CREATE TABLE employee_audit (
    audit_id INT PRIMARY KEY AUTO_INCREMENT,
    emp_id INT,
    action_type VARCHAR(10),
    old_name VARCHAR(100),
    new_name VARCHAR(100),
    old_department VARCHAR(50),
    new_department VARCHAR(50),
    old_salary DECIMAL(10,2),
    new_salary DECIMAL(10,2),
    changed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Trigger: a) INSERT Trigger/
CREATE TRIGGER trg_employee_insert
AFTER INSERT ON employees
FOR EACH ROW
INSERT INTO employee_audit(emp_id, action_type, new_name, new_department, new_salary)
VALUES (NEW.emp_id, 'INSERT', NEW.name, NEW.department, NEW.salary);

-- b) UPDATE Trigger
CREATE TRIGGER trg_employee_update
AFTER UPDATE ON employees
FOR EACH ROW
INSERT INTO employee_audit(emp_id, action_type, old_name, new_name, old_department, new_department, old_salary, new_salary)
VALUES (OLD.emp_id, 'UPDATE', OLD.name, NEW.name, OLD.department, NEW.department, OLD.salary, NEW.salary);

-- c) DELETE Trigger
CREATE TRIGGER trg_employee_delete
AFTER DELETE ON employees
FOR EACH ROW
INSERT INTO employee_audit(emp_id, action_type, old_name, old_department, old_salary)
VALUES (OLD.emp_id, 'DELETE', OLD.name, OLD.department, OLD.salary);

-- Sample Execution

-- Insert data
INSERT INTO employees(name, department, salary)
VALUES ('Alice', 'HR', 50000);

-- Update data
UPDATE employees SET salary = 60000 WHERE emp_id = 1;

-- Delete data
DELETE FROM employees WHERE emp_id = 1;

-- Check audit log
SELECT * FROM employee_audit;

