CREATE TABLE department (
  name VARCHAR(30) PRIMARY KEY,
  school VARCHAR(50)
);

CREATE TABLE employee (
  id varchar(20) PRIMARY KEY,
  name VARCHAR(100),
  age INTEGER,
  department_name VARCHAR(30),
  CONSTRAINT fk_department_employee
    FOREIGN KEY(department_name)
      REFERENCES department(name)
);

CREATE TABLE rooms (
  name VARCHAR(20) PRIMARY KEY,
  department VARCHAR(30),
  CONSTRAINT fk_department_rooms
    FOREIGN KEY(department)
      REFERENCES department(name)
);

CREATE TABLE employee_room (
  room_name VARCHAR(20),
  employee_id VARCHAR(20),
  PRIMARY KEY(room_name, employee_id),
  CONSTRAINT fk_employee_room
    FOREIGN KEY(room_name)
      REFERENCES rooms(name),
  CONSTRAINT fk_employee_employee
    FOREIGN KEY(employee_id)
      REFERENCES employee(id)
);

CREATE TABLE desktop (
  id SERIAL PRIMARY KEY,
  name VARCHAR(30),
  employee_id VARCHAR(20),
  desktop_type VARCHAR(10),
  CONSTRAINT fk_employee
    FOREIGN KEY(employee_id)
      REFERENCES employee(id)
);

CREATE TABLE skill (
  name VARCHAR(10) PRIMARY KEY,
  description VARCHAR(20)
);

CREATE TABLE skill_level (
  level_name VARCHAR(10) PRIMARY KEY,
  description VARCHAR(20)
);

CREATE TABLE employee_skills (
  employee_id VARCHAR(20),
  skill_name VARCHAR(20),
  skill_level VARCHAR(10),
  PRIMARY KEY(employee_id, skill_name),
  CONSTRAINT fk_employee_skills_employee
    FOREIGN KEY(employee_id)
      REFERENCES employee(id),
  CONSTRAINT fk_employee_skills_skill
    FOREIGN KEY(skill_name)
      REFERENCES skill(name),
  CONSTRAINT fk_employee_skills_level
    FOREIGN KEY(skill_level)
      REFERENCES skill_level(level_name)
);