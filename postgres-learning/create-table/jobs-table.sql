CREATE TABLE management.jobs (
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    job_title VARCHAR(100) NOT NULL,
    min_salary NUMERIC(12, 2),
    max_salary NUMERIC(12, 2),
    
    -- Auditing & Soft Delete Columns
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITH TIME ZONE,
    
    CONSTRAINT check_salary_range CHECK (max_salary >= min_salary)
);

-- The "Smart" Unique Index
CREATE UNIQUE INDEX idx_unique_active_job_title 
ON management.jobs (job_title) 
WHERE deleted_at IS NULL;


