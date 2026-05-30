-- Schema
DROP TABLE IF EXISTS students;
CREATE TABLE students (
  id           serial PRIMARY KEY,
  first_name   varchar(255) NOT NULL,
  last_name    varchar(255) NOT NULL,
  birthdate    date NOT NULL,
  address_id   integer
);
DROP TABLE IF EXISTS addresses;
CREATE TABLE addresses (
  id           serial PRIMARY KEY,
  line_1       varchar(255) NOT NULL,
  line_2       varchar(255),
  city         varchar(255) NOT NULL,
  state        varchar(30) NOT NULL,
  zipcode          varchar(6) NOT NULL
);
DROP TABLE IF EXISTS classes;
CREATE TABLE classes (
  id           serial PRIMARY KEY,
  name         varchar(255) NOT NULL,
  credits      integer NOT NULL
);
DROP TABLE IF EXISTS enrollments;
CREATE TABLE enrollments (
  id           serial PRIMARY KEY,
  student_id   integer REFERENCES students,
  class_id     integer REFERENCES classes,
  grade        varchar(3)
);