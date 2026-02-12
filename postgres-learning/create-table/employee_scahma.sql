create table management.employees(
id bigint generated always as identity primary key,
full_name varchar(100) not null,
email varchar(60) not null,
phone_number varchar(20) not null,
hire_date date not null default current_date,
job_id bigint not null references management.jobs(id),
depart_id bigint not null references management.departments(id),
created_at timestamptz  default current_timestamp,
updated_at timestamptz  default current_timestamp,
deleted_at timestamptz default null
);
create unique index unique_email_index on management.employees(email) where deleted_at is null;
create index idx_employee_depart_id on management.employees(depart_id);
create index idx_employee_job_id on management.employees(job_id);