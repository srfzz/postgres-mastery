CREATE TABLE management.employees (
    emp_id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    dept_id BIGINT NOT NULL,
    full_name VARCHAR(150) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL, -- Index created automatically!
    salary NUMERIC(12, 2) CHECK (salary > 0),
    is_active BOOLEAN DEFAULT TRUE,
    
    CONSTRAINT fk_department 
        FOREIGN KEY(dept_id) 
        REFERENCES management.departments(dept_id) 
        ON DELETE RESTRICT
);

-- Create this one manually for performance on JOINs
CREATE INDEX idx_employees_dept_id ON management.employees(dept_id);