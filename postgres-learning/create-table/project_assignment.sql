create table management.project_assignmenets(
id bigint generated always as identity primary key,
emp_id bigint not null references management.employees (id) on delete cascade ,
project_id bigint not null references management.projects (id) on delete cascade,
role_in_project  varchar(100),
hours_allocated int,
created_at timestamptz default current_timestamp,
updated_at timestamp default current_timestamp,
constraint unique_emp_id_project_id unique(emp_id,project_id)

);