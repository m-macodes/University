-- DDL:-

CREATE TABLE user
(
    id       SERIAL PRIMARY KEY,
    email    VARCHAR(30) NOT NULL,
    password VARCHAR(30) NOT NULL
);

CREATE TABLE role
(
    id          SERIAL PRIMARY KEY,
    name        VARCHAR(30) NOT NULL,
    description VARCHAR(30) NOT NULL
);

-- 1
CREATE TABLE address
(
    id_user     INTEGER PRIMARY KEY,
    area_name   VARCHAR(30) NOT NULL,
    city_name   VARCHAR(30) NOT NULL,
    block_name  VARCHAR(30) NOT NULL,
    street_name VARCHAR(30) NOT NULL,
    CONSTRAINT fk_id FOREIGN KEY (id_user) REFERENCES user (id)
);

-- 3
CREATE TABLE employee
(
    employee_id     INTEGER PRIMARY KEY,
    full_name       VARCHAR(100)                   NOT NULL,
    salary          NUMERIC(8, 2) CHECK ( salary >= 0),
    date_of_birth   DATE                           NOT NULL,
    phone           INTEGER                        NOT NULL,
    email           VARCHAR(30)                    NOT NULL,
    sex             CHAR                           NOT NULL,
    employment_date DATE DEFAULT current_timestamp NOT NULL,
    CONSTRAINT emp_sex_chk CHECK (sex IN ('M', 'F')),
    CONSTRAINT EMP_FK_ADRES FOREIGN KEY (area_name, city_name, block_name, street_name) REFERENCES Address (area_name, city_name, block_name, street_name)
);

-- 4
CREATE TABLE building (
                          building_code CHAR (1) PRIMARY KEY,
                          building_desc VARCHAR(100) );

-- 6
CREATE TABLE room (
                      room_number INTEGER,
                      floor_number INTEGER,
                      building_code CHAR (1) NOT NULL,
                      capacity INTEGER NOT NULL,
                      FOREIGN KEY (building_code,floor_number) REFERENCES floor(building_code,floor_number),
                      PRIMARY KEY (building_code ,floor_number,room_number));

-- 7
CREATE TABLE department (
                            department_id INTEGER PRIMARY KEY,
                            department_name VARCHAR(30) NOT NULL UNIQUE,
                            room_number INTEGER,
                            floor_number INTEGER,
                            building_code CHAR (1),
                            FOREIGN KEY (building_code,floor_number,room_number) REFERENCES room (building_code,floor_number,room_number) );

-- 8
CREATE TABLE majors_department (
                                   majors_department_id INTEGER PRIMARY KEY ,
                                   majors_department_name VARCHAR(30) NOT NULL UNIQUE,
                                   room_number INTEGER,
                                   floor_number INTEGER,
                                   building_code CHAR (1),
                                   FOREIGN KEY (building_code,floor_number,room_number) REFERENCES room (building_code,floor_number,room_number) );

-- 9
CREATE TABLE major (
                       major_id INTEGER PRIMARY KEY,
                       major_name VARCHAR(30) NOT NULL UNIQUE,
                       majors_department_id INTEGER NOT NULL REFERENCES majors_department (majors_department_id) );

-- 10
CREATE TABLE course (
                        course_id VARCHAR(10) PRIMARY KEY ,
                        course_name VARCHAR(30) NOT NULL,
                        credit INTEGER NOT NULL,
                        clevel INTEGER NOT NULL,
                        description text,
                        majors_department_id INTEGER NOT NULL REFERENCES Majors_Department (majors_department_id) );

-- 11
CREATE TABLE pre_required_courses (
                                      course_id VARCHAR(10) NOT NULL REFERENCES course(course_id) ,
                                      pre_required_course_id VARCHAR(10) NOT NULL REFERENCES course(course_id),
                                      PRIMARY KEY (course_id,pre_required_course_id));

-- 12
CREATE TABLE teacher (
                         teacher_id INTEGER NOT NULL REFERENCES employee(employee_id) ,
                         teacher_start_date DATE DEFAULT current_timestamp,
                         teacher_end_date DATE,
                         majors_department_id INTEGER NOT NULL REFERENCES majors_department (majors_department_id),
                         salary NUMERIC (8,2) CHECK (salary >=0) ,
                         teacher_start_year INTEGER DEFAULT EXTRACT (YEAR FROM current_timestamp) NOT NULL,
                         teacher_start_semester INTEGER NOT NULL,
                         CONSTRAINT tchr_pk PRIMARY KEY (teacher_id , teacher_start_year , teacher_start_semester ),
                         CONSTRAINT tchr_strt_smstr_chk CHECK (teacher_start_semester IN (1,2,3)) );

-- 13
CREATE TABLE manager (
                         manager_id INTEGER NOT NULL REFERENCES employee(employee_id),
                         manager_start_date DATE DEFAULT current_timestamp,
                         manager_end_date DATE,
                         salary NUMERIC (8,2) check (salary >=0),
                         manager_grade VARCHAR(15) NOT NULL,
                         majors_department_id INTEGER REFERENCES majors_department (majors_department_id) ,
                         department_id INTEGER REFERENCES department (department_id) ,
                         manager_start_year INTEGER DEFAULT EXTRACT (YEAR FROM current_timestamp) NOT NULL,
                         manager_start_semester INTEGER NOT NULL,
                         CONSTRAINT mngr_pk PRIMARY KEY (manager_id , manager_start_year , manager_start_semester ),
                         CONSTRAINT mngr_strt_smstr_chk CHECK (manager_start_semester IN (1,2,3)),
                         CONSTRAINT mngr_dept_chk CHECK ( (majors_department_id IS NULL AND  department_id IS NOT NULL) OR (department_id IS NULL AND majors_department_id IS NOT NULL) )  );

-- 14
CREATE TABLE security (
                          security_id INTEGER NOT NULL REFERENCES employee(employee_id) ,
                          security_start_date DATE DEFAULT current_timestamp,
                          security_end_date DATE,
                          salary NUMERIC (8,2) CHECK (salary >=0),
                          department_id INTEGER NOT NULL REFERENCES department (department_id),
                          security_start_year INTEGER DEFAULT EXTRACT (YEAR FROM current_timestamp) NOT NULL,
                          security_start_semester INTEGER NOT NULL,
                          CONSTRAINT security_pk PRIMARY KEY (security_id , security_start_year , security_start_semester ),
                          CONSTRAINT security_strt_smstr_chk CHECK (security_start_semester IN (1,2,3)));

-- 18
CREATE TABLE study_plan (
                            plan_number INTEGER,
                            major_id INTEGER NOT NULL REFERENCES major (major_id) ,
                            PRIMARY KEY (plan_number, major_id));

-- 19
CREATE TABLE study_plan_courses (
                                    plan_number INTEGER NOT NULL ,
                                    major_id INTEGER,
                                    course_id VARCHAR(10) NOT NULL REFERENCES course (course_id),
                                    year INTEGER NOT NULL,
                                    semester INTEGER ,
                                    FOREIGN KEY (plan_number, major_id) REFERENCES study_plan (plan_number, major_id),
                                    PRIMARY KEY (plan_number, major_id, course_id),
                                    CONSTRAINT stdy_pln_smstr_chk CHECK (semester IN (1,2,3)));

-- 20
CREATE TABLE student (
                         student_id INTEGER PRIMARY KEY,
                         full_name_ar VARCHAR(100) NOT NULL,
                         full_name_en VARCHAR(100) NOT NULL,
                         nationality VARCHAR(20) NOT NULL REFERENCES nationality (nationality) ,
                         national_id INTEGER NOT NULL,
                         sex CHAR NOT NULL ,
                         social_status CHAR NOT NULL ,
                         guardian_name  VARCHAR(30) NOT NULL,
                         guardian_national_id INTEGER NOT NULL,
                         guardian_relation VARCHAR(10) NOT NULL,
                         birh_place VARCHAR(10) NOT NULL ,
                         date_of_birth DATE NOT NULL,
                         religion VARCHAR(20) NOT NULL,
                         health_status VARCHAR(40) NOT NULL  ,
                         mother_name VARCHAR(30) NOT NULL,
                         mother_job VARCHAR(20) NOT NULL ,
                         mother_job_desc VARCHAR(100) NOT NULL,
                         father_job VARCHAR(20) NOT NULL ,
                         father_job_desc VARCHAR(100) NOT NULL,
                         parents_status VARCHAR(30) NOT NULL ,
                         number_of_family_members INTEGER NOT NULL,
                         family_university_students INTEGER NOT NULL,
                         social_affairs VARCHAR(40) NOT NULL ,
                         phone INTEGER,
                         telephone_home INTEGER,
                         emergency_phone INTEGER NOT NULL,
                         email VARCHAR(30) ,
                         tawjihi_field CHAR NOT NULL,
                         area_name VARCHAR(30) NOT NULL,
                         city_name VARCHAR(30) NOT NULL,
                         block_name VARCHAR(30) NOT NULL,
                         street_name VARCHAR(30) NOT NULL,
                         major_id INTEGER NOT NULL REFERENCES major(major_id) ,
                         balance INTEGER NOT NULL,
                         FOREIGN KEY (area_name,city_name,block_name,street_name) REFERENCES address(area_name,city_name,block_name,street_name),
                         CONSTRAINT stdnt_sex_chk CHECK (sex IN ('M' , 'F')),
                         CONSTRAINT stdnt_social_status_chk CHECK ( social_status  IN ('S','M','D' ) ),
                         CONSTRAINT stdnt_twj_fld_chk CHECK (tawjihi_field  IN ('S' , 'L' )));

-- 22
CREATE TABLE section (
                         section_number INTEGER,Дата 
                         course_id VARCHAR(10) NOT NULL REFERENCES course (course_id) ,
                         teacher_id INTEGER ,
                         year INTEGER DEFAULT EXTRACT (YEAR FROM current_timestamp),
                         semester INTEGER ,
                         CONSTRAINT section_fk_tchr FOREIGN KEY (teacher_id ,year ,semester) REFERENCES teacher(teacher_id ,teacher_start_year , teacher_start_semester),
                         PRIMARY KEY (section_number, course_id, year, semester),
                         CONSTRAINT section_smstr_chk CHECK (semester IN (1,2,3)));

-- 23
CREATE TABLE enroll (
                        student_id INTEGER NOT NULL REFERENCES student (student_id) ,
                        course_id VARCHAR(10) ,
                        section_number INTEGER NOT NULL ,
                        year INTEGER DEFAULT EXTRACT (YEAR FROM current_timestamp),
                        semester INTEGER ,
                        grade_mid INTEGER DEFAULT NULL ,
                        grade_final INTEGER DEFAULT NULL,
                        FOREIGN KEY (section_number , course_id , year , semester) REFERENCES section (section_number , course_id , year , semester) ,
                        PRIMARY KEY (student_id , course_id , section_number , year , semester),
                        CONSTRAINT eroll_grade_chk CHECK ((grade_final+grade_mid >=40)and (grade_final+grade_mid <=100 )));

-- 24
CREATE TABLE section_rooms (
                               section_number INTEGER NOT NULL ,
                               course_id VARCHAR (10) ,
                               year INTEGER DEFAULT EXTRACT (YEAR FROM current_timestamp),
                               semester INTEGER,
                               room_number INTEGER,
                               floor_number INTEGER,
                               building_code CHAR (1) NOT NULL ,
                               day DATE NOT NULL,
                               start_time DATE ,
                               end_time DATE ,
                               FOREIGN KEY (building_code,floor_number,room_number) REFERENCES room (building_code,floor_number,room_number) ,
                               FOREIGN KEY (section_number , course_id , year , semester ) REFERENCES section (section_number , course_id , year , semester ) ,
                               PRIMARY KEY (building_code,floor_number, year , semester, room_number, start_time,day));