CREATE TABLE if not exists roles
(
    id   serial primary key,
    name varchar(30),
    name_ru varchar(30)
);

CREATE TABLE country
(
    id         serial primary key,
    name       varchar(30) not null,
    short_name varchar(10) not null
);

CREATE TABLE address
(
    id               SERIAL primary key,
    country          integer     not null,
    city             VARCHAR(30) not null,
    street           VARCHAR(30) not null,
    building_number  VARCHAR(5)  not null,
    apartment_number VARCHAR(5),
    foreign key (country) references country (id)
);

CREATE TABLE users
(
    id           serial primary key,
    email        VARCHAR(30) not null unique,
    password     VARCHAR     not null,
    name         VARCHAR(30) not null,
    surname      VARCHAR(30) not null,
    patronymic   VARCHAR(30),
    phone_number varchar(30) not null,
    address      integer     not null,
    role         integer     not null,
    foreign key (address) references address (id),
    foreign key (role) references roles (id)
);



-- CREATE TABLE user_role
-- (
-- --     id      serial primary key,
--     user_id integer,
--     role_id integer,
--     PRIMARY KEY (user_id, role_id),
--     foreign key (user_id) references users (id),
--     foreign key (role_id) references roles (id)
-- );

CREATE TABLE teacher
(
    user_id         integer primary key,
    title           varchar(30) not null,
    department      varchar(30) not null,
    employment_date timestamp default current_timestamp,
    foreign key (user_id) references users (id)
);

CREATE TABLE department
(
    id           serial primary key,
    name         varchar(30) not null,
    abbreviation varchar(5)  not null,
    dean         integer     not null,
    foreign key (dean) references teacher (user_id)
);

CREATE TABLE direction
(
    id         serial primary key,
    name       varchar(30) not null,
    department integer     not null,
    foreign key (department) references department (id)
);

CREATE TABLE groups
(
    id        serial primary key,
    number    varchar(5) not null,
    direction integer    not null,
    curator   integer    not null,
    foreign key (curator) references teacher (user_id)
);

CREATE TABLE student
(
    user_id            integer primary key,
    group_number       integer not null,
    record_book_number varchar(10) unique,
    foreign key (user_id) references users (id),
    foreign key (group_number) references groups (id)
);

CREATE TABLE course
(
    id        serial primary key,
    name      varchar(30),
    direction integer not null,
    credits   integer not null,
    teacher   integer not null,
    half_year integer,
    foreign key (direction) references direction (id),
    foreign key (teacher) references teacher (user_id)
);

CREATE TABLE course_info
(
    id         serial primary key,
    course     integer   not null,
    type       integer   not null,
    day_week   character not null,
    start_time time      not null,
    end_time   time      not null,
    teacher    integer   not null,
    foreign key (course) references course (id),
    foreign key (teacher) references teacher (user_id)
);

CREATE TABLE record_book
(
    record_book varchar(10),
    course_id   integer,
    grade       integer not null,
    primary key (record_book, course_id),
    foreign key (record_book) references student (record_book_number),
    foreign key (course_id) references course (id)
);






