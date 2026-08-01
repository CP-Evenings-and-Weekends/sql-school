SELECT * FROM addresses;
SELECT * FROM classes;
SELECT * FROM enrollments;
SELECT * FROM students;


-- Insert an additional address into the addresses table.

	-- Added line 2 already 

-- Update the students table so the student without an address gets assigned to the new address.

WITH new_address AS (
    INSERT INTO addresses (
    	line_1, 
    	line_2, 
    	city, 
    	state, 
    	zipcode)
    VALUES (
    	'842 Willowbrook Lane', 
    	'Apt 3B', 
    	'Rivertown', 
    	'Oregon', 
    	'97045')
    RETURNING id
)
UPDATE 
	students
SET 
	address_id = (SELECT id FROM new_address)
WHERE 
	address_id IS NULL;

-- Insert a sibling of that same student as a new row in students (same last name, different first name).

INSERT INTO 
	public.students
		(
		id, 
		first_name, 
		last_name, 
		birthdate, 
		address_id)
VALUES(
		nextval('students_id_seq'::regclass), 
		'Bo', 
		'Kunde', 
		'1988-1-18', 
		3
);

SELECT * FROM students;

-- Create a new table extracurriculars (e.g. football, journalism, debate team) with id and name.

CREATE TABLE extracurriculars (
	ex_id serial PRIMARY KEY,
	student_id INTEGER REFERENCES students
);


-- Forgot to add activity column

ALTER TABLE extracurriculars
ADD COLUMN activity VARCHAR(255)

SELECT * FROM EXTRACURRICULARS;

-- Insert at least 3 rows into extracurriculars.

INSERT INTO extracurriculars (student_id, activity) VALUES
(1, 'Debate Club'),
(2, 'Varsity Soccer'),
(3, 'Chess Club'),
(5, 'Marching Band'),
(9, 'Chess Club'),
(4, 'Student Council');

-- Alter the students table to add a new column extracurricular_id referencing the extracurriculars table.

ALTER TABLE students  
ADD COLUMN extracurricular_id integer REFERENCES extracurriculars(ex_id);

-- Update the students table to assign each student an extracurricular_id.

-- Update the students table to assign each student an extracurricular_id.

UPDATE students SET extracurricular_id = 1 WHERE id = 1;
UPDATE students SET extracurricular_id = 2 WHERE id = 2;
UPDATE students SET extracurricular_id = 3 WHERE id = 3;
UPDATE students SET extracurricular_id = 4 WHERE id = 5;
UPDATE students SET extracurricular_id = 5 WHERE id = 9;
UPDATE students SET extracurricular_id = 6 WHERE id = 4;


