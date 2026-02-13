create table management.salaries(
id bigint generated always as identity primary key,
emp_id bigint not null unique references management.employees (id) on delete cascade ,
amount numeric(15,3) not null ,
currency varchar(3) not null default 'INR',
effective_date date  not null default current_date,
is_active boolean not null default true,
created_at timestamptz default current_timestamp,
updated_at timestamptz default current_timestamp
constraint check_positive_salary check(amount > 0)