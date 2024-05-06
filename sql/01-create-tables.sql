CREATE TABLE department (
  name VARCHAR(30) PRIMARY KEY,
  school VARCHAR(50)
);

CREATE TABLE employee (
  id SERIAL PRIMARY KEY,
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
  employee_id INTEGER,
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
  employee_id INTEGER,
  desktop_type VARCHAR(10),
  CONSTRAINT fk_employee
    FOREIGN KEY(employee_id)
      REFERENCES employee(id)
);