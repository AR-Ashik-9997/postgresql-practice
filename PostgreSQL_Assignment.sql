-- Active: 1692117131729@@127.0.0.1@5432@university_db

-- Create a "students" table with the following fields:
CREATE TABLE students (
     student_id SERIAL PRIMARY KEY,
    student_name VARCHAR(100),
    age INT,
    email VARCHAR(255),
    frontend_mark INT,
    backend_mark INT,
    status VARCHAR(50)
);

-- Create a "courses" table with the following fields:
CREATE TABLE courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

-- Create an "enrollment" table with the following fields:
CREATE TABLE enrollment (
    enrollment_id SERIAL PRIMARY KEY,
    student_id INT REFERENCES students(student_id),
    course_id INT REFERENCES courses(course_id)
);

--Insert the following sample data into the "students" table:
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES
   ('Alice', 22, 'alice@example.com', 55, 57, 'NULL'),
    ('Bob', 21, 'bob@example.com', 34, 45, 'NULL'),
    ('Charlie', 23, 'charlie@example.com', 60, 59, 'NULL'),
    ('David', 20, 'david@example.com', 40, 49, 'NULL'),
    ('Eve', 24, 'newemail@example.com', 45, 34, 'NULL'),
    ('Rahim', 23, 'rahim@gmail.com', 46, 42, 'NULL');


 -- nsert the following sample data into the "courses" table:   
INSERT INTO courses (course_name,credits)
VALUES ('Next.js',3), ('React.js',4),('Databases',3),('Prisma',3);

-- Insert the following sample data into the "enrollment" table:
INSERT INTO enrollment (student_id,course_id)
VALUES (1,1),(1,2),(2,1),(3,2);

-- Query 1: Insert a new student record with the following details:
INSERT INTO students (student_name, age, email, frontend_mark, backend_mark, status)
VALUES ('Ashik', 22, 'ashikur.rahman9997@gmail.com', 70, 80, 'NULL');


-- Query 2: Retrieve the names of all students who are enrolled in the course titled 'Next.js'.
SELECT student_name FROM students JOIN enrollment ON students.student_id = enrollment.student_id JOIN courses ON courses.course_id = enrollment.course_id WHERE courses.course_name = 'Next.js';


--Query 3: Update the status of the student with the highest total (frontend_mark + backend_mark) mark to 'Awarded'
UPDATE students
SET status = 'Awarded'
WHERE (frontend_mark + backend_mark) = (
    SELECT MAX(frontend_mark + backend_mark)
    FROM students
);

-- Query 4: Delete all courses that have no students enrolled.
DELETE FROM courses WHERE course_id NOT IN (SELECT course_id FROM enrollment);


-- Query 5: Retrieve the names of students using a limit of 2, starting from the 3rd student.
SELECT student_name FROM students LIMIT 2 OFFSET 2;


-- Query 6: Retrieve the course names and the number of students enrolled in each course.
SELECT course_name, count(enrollment.student_id) as students_enrolled FROM courses JOIN enrollment ON courses.course_id=enrollment.course_id GROUP BY courses.course_name;


-- Query 7: Calculate and display the average age of all students.
SELECT avg(age) as average_age from students;


-- Query 8: Retrieve the names of students whose email addresses contain 'example.com'.
SELECT student_name FROM students WHERE email LIKE '%example.com';
