

create type management.project_status as enum(
'PLANNING','ACTIVE','COMPLETED','ONHOLD'
);
create table management.projects(
id bigint generated always as identity primary key,
project_name varchar(150) not null,
start_date date not null default current_date,
end_date date,
budget numeric(15,3) not null,
status management.project_status default 'PLANNING',
created_at timestamptz default current_timestamp,
updated_at timestamptz default current_timestamp
);