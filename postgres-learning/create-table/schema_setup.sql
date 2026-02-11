-- ==========================================================
-- PROJECT: ENTERPRISE MANAGEMENT SYSTEM
-- AUTHOR: Sarfaraj
-- DESCRIPTION: Core Schema, Tables, and Performance Indexing
-- ==========================================================

-- 1. SCHEMA INITIALIZATION
-- Using a dedicated schema to isolate business logic from 'public'.
CREATE SCHEMA IF NOT EXISTS management;

-- 2. DEPARTMENTS TABLE
-- Designed with audit trails, soft-delete support, and strict data integrity.
CREATE TABLE management.departments (
    -- BIGINT used for enterprise-level scalability
    id BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    
    -- Ensures department names are unique and follow naming standards
    depart_name VARCHAR(100) NOT NULL UNIQUE,
    
    -- Default location set to REMOTE
    location VARCHAR(100) DEFAULT 'REMOTE',
    
    -- Audit Timestamps (Standard for enterprise tracking)
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP,
    deleted_at TIMESTAMP WITH TIME ZONE DEFAULT NULL,

    -- Regex Constraint: Only letters/spaces, minimum 2 characters
    CONSTRAINT check_depart_name_content 
        CHECK (length(depart_name) >= 2 AND depart_name ~ '^[a-zA-Z\s]+$')
);

-- 3. PERFORMANCE INDEXING STRATEGY
-- Indexes are vital for systems with millions of rows to prevent "Table Scans".

-- Index for location-based filtering
-- Using CONCURRENTLY to avoid locking the table during production updates.
CREATE INDEX CONCURRENTLY idx_department_location 
ON management.departments(location);

-- Partial Index for Soft-Deletes
-- Only indexes active records (deleted_at IS NULL). 
-- This keeps the index small, fast, and efficient for the application.
CREATE INDEX CONCURRENTLY idx_active_departments 
ON management.departments(id) 
WHERE deleted_at IS NULL;

-- ==========================================================
-- WHY THESE INDEXES ARE NECESSARY:
-- ==========================================================
/*
1. SEARCH SPEED: 
   Without an index, Postgres performs a "Sequential Scan" (reading the 
   entire table). With an index, it uses a "B-Tree Scan" (logarithmic search),
   turning seconds into milliseconds.

2. SYSTEM STABILITY:
   Partial indexes (WHERE deleted_at IS NULL) reduce disk I/O and RAM usage, 
   ensuring the database doesn't "break" or slow down under heavy load.

3. DATA INTEGRITY:
   The UNIQUE and PRIMARY KEY constraints automatically create hidden indexes 
   to verify data instantly before every INSERT.
*/