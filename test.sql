CREATE TABLE faculty(
    id INTEGER NOT NULL,
    first_name VARCHAR(20) NOT NULL,
    last_name VARCHAR(20) NOT NULL,
    office VARCHAR(20) NOT NULL,
    start_date DATE NOT NULL,
    phone_number char(12) NOT NULL,
    department VARCHAR(20) NOT NULL,
    CONSTRAINT faculty_pk PRIMARY KEY (id),
    CONSTRAINT faculty_ck2 UNIQUE (first_name,last_name,office),
    CONSTRAINT faculty_ck3 UNIQUE (first_name,last_name,start_date),
    CONSTRAINT faculty_ck4 UNIQUE (first_name,last_name,phone_number),
    CONSTRAINT faculty_fk FOREIGN KEY (department) REFERENCES departments(code) ON DELETE CASCADE
    );

CREATE TABLE departments(
    name VARCHAR(20) NOT NULL,
    office VARCHAR(20) NOT NULL,
    phone_number char(12) NOT NULL,
    number_of_faculty INTEGER,
    college VARCHAR(20) NOT NULL,
    code VARCHAR(20) NOT NULL,
    CONSTRAINT departments_pk PRIMARY KEY (code),
    CONSTRAINT departments_ck1 UNIQUE (name),
    CONSTRAINT departments_ck2 UNIQUE (office),
    CONSTRAINT departments_ck3 UNIQUE (phone_number)
);

CREATE TABLE academic_advisors(
    major VARCHAR(20) NOT NULL,
    advisor VARCHAR(50) NOT NULL,
    date_started DATE NOT NULL,
    CONSTRAINT academic_advisors PRIMARY KEY (major,advisor),
    CONSTRAINT academic_advisors_fk FOREIGN KEY(major) REFERENCES majors(code),
    CONSTRAINT academic_advisors_fkk FOREIGN KEY(advisor) REFERENCES faculty(id)
);