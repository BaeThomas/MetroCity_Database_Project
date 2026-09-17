CREATE DATABASE IF NOT EXISTS metrocity_college;
USE metrocity_college;

CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    department VARCHAR(100) NOT NULL
);

CREATE TABLE Course (
    course_id INT PRIMARY KEY,
    course_code VARCHAR(20) NOT NULL,
    course_title VARCHAR(100) NOT NULL,
    credits INT NOT NULL,
    department VARCHAR(100) NOT NULL
);

CREATE TABLE Enrollment (
    enrollment_id INT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    term VARCHAR(20) NOT NULL,
    enrollment_status VARCHAR(20) NOT NULL,

    FOREIGN KEY (student_id)
        REFERENCES Student(student_id),

    FOREIGN KEY (course_id)
        REFERENCES Course(course_id)
);


CREATE TABLE ExamScore (
    score_id INT PRIMARY KEY,
    enrollment_id INT NOT NULL,
    exam_type VARCHAR(30) NOT NULL,
    score DECIMAL(5,2) NOT NULL,
    score_date DATE NOT NULL,

    FOREIGN KEY (enrollment_id)
        REFERENCES Enrollment(enrollment_id)
);

INSERT INTO Student
(student_id, first_name, last_name, email, phone, department)
VALUES
(1, 'Aung', 'Min', 'aungmin@email.com', '0911111111', 'Computer Science'),
(2, 'May', 'Thu', 'maythu@email.com', '0922222222', 'Computer Science'),
(3, 'John', 'Smith', 'johnsmith@email.com', '0933333333', 'Business'),
(4, 'Anna', 'Lee', 'annalee@email.com', '0944444444', 'Engineering');

INSERT INTO Course
(course_id, course_code, course_title, credits, department)
VALUES
(101, 'CS101', 'Database Systems', 3, 'Computer Science'),
(102, 'CS102', 'Web Development', 3, 'Computer Science'),
(103, 'BUS101', 'Business Management', 3, 'Business'),
(104, 'ENG101', 'Engineering Mathematics', 4, 'Engineering');

INSERT INTO Enrollment
(enrollment_id, student_id, course_id, term, enrollment_status)
VALUES
(1001, 1, 101, '2025-S1', 'Active'),
(1002, 1, 102, '2025-S1', 'Active'),
(1003, 2, 101, '2025-S1', 'Active'),
(1004, 3, 103, '2025-S1', 'Completed'),
(1005, 2, 102, '2025-S1', 'Active');

INSERT INTO ExamScore
(score_id, enrollment_id, exam_type, score, score_date)
VALUES
(5001, 1001, 'Midterm', 85, '2025-03-15'),
(5002, 1001, 'Final', 88, '2025-05-20'),
(5003, 1002, 'Midterm', 78, '2025-03-16'),
(5004, 1003, 'Midterm', 90, '2025-03-15'),
(5005, 1003, 'Final', 92, '2025-05-20'),
(5006, 1004, 'Final', 75, '2025-05-22'),
(5007, 1005, 'Midterm', 82, '2025-03-16');

SELECT * FROM Student;
SELECT * FROM Course;
SELECT * FROM Enrollment;
SELECT * FROM ExamScore;

-- Test 01: Primary Key Constraint Test

INSERT INTO Student
(student_id, first_name, last_name, email, phone, department)
VALUES
(1, 'David', 'Lee', 'davidlee@email.com', '0955555555', 'Computer Science');

-- Test 02: Foreign Key Constraint Test

INSERT INTO Enrollment
(enrollment_id, student_id, course_id, term, enrollment_status)
VALUES
(1006, 9999, 101, '2025-S1', 'Active');

-- Test 03: NULL Constraint Test

INSERT INTO Student
(student_id, first_name, last_name, email, phone, department)
VALUES
(5, NULL, 'Win', 'win@email.com', '0966666666', 'Computer Science');

-- Test 04: Data Type Validation Test

INSERT INTO Course
(course_id, course_code, course_title, credits, department)
VALUES
(105, 'CS103', 'Programming Basics', 'ABC', 'Computer Science');

-- Test 01: Create Test

INSERT INTO Student
(student_id, first_name, last_name, email, phone, department)
VALUES
(5, 'Kevin', 'Tan', 'kevintan@email.com', '0955555555', 'Computer Science');

-- Verify the inserted record
SELECT student_id, first_name, last_name, email, phone, department
FROM Student
WHERE student_id = 5;

-- Test 02: Read Test

SELECT
    student_id,
    first_name,
    last_name,
    email,
    phone,
    department
FROM Student
WHERE student_id = 5;


-- Test 03: Update Test

UPDATE Student
SET phone = '0999999999'
WHERE student_id = 5;

-- Verify the updated record
SELECT student_id, first_name, last_name, phone
FROM Student
WHERE student_id = 5;

-- Test 04: Delete Test

DELETE FROM Student
WHERE student_id = 5;

-- Verify that the record has been deleted
SELECT student_id, first_name, last_name
FROM Student
WHERE student_id = 5;

-- Test 01: Single-Table Performance Test

SELECT
    student_id,
    first_name,
    last_name,
    email,
    department
FROM Student
WHERE department = 'Computer Science'
ORDER BY student_id;


-- Test 02: Multi-Table Performance Test

SELECT
    Student.student_id,
    Student.first_name,
    Student.last_name,
    Course.course_code,
    Course.course_title,
    Enrollment.term,
    Enrollment.enrollment_status
FROM Student
INNER JOIN Enrollment
    ON Student.student_id = Enrollment.student_id
INNER JOIN Course
    ON Enrollment.course_id = Course.course_id
ORDER BY Student.student_id;
