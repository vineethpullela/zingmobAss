CREATE TABLE Users (
  id INTEGER PRIMARY KEY ,
  username VARCHAR(25) UNIQUE,  -- Enforce unique usernames
  password TEXT,
  role TEXT CHECK(role IN ('super_admin', 'admin', 'teacher', 'student')),
  college_id INTEGER REFERENCES Colleges(id) ON DELETE CASCADE,
  section TEXT NULL
);

SELECT * FROM Users


 INSERT INTO Users (username, password, role, college_id, section)
VALUES ('super_admin', '(hashed password)', 'super_admin', NULL, NULL),
       ('admin_hyd', '(hashed password)', 'admin', 1, NULL),
       ('teacher_blore', '(hashed password)', 'teacher', 3, 'A'),
       ('student_a', '(hashed password)', 'student', 1, 'A'),
       ('student_b', '(hashed password)', 'student', 1, 'B'),
       ('student_c', '(hashed password)', 'student', 2, NULL);

CREATE TABLE Colleges (
  id INT PRIMARY KEY,
  name VARCHAR(255) UNIQUE,
  state VARCHAR(255),
  city VARCHAR(255),
  campus VARCHAR(255)
);

INSERT INTO Colleges (name, state, city, campus)
VALUES ('Sri Chaitanya', 'Telangana', 'Hyderabad', 'KPHB'),
       ('St. Xavier\s College', 'Andhra Pradesh', 'Vijayawada', 'Main Campus'),
       ('National Institute', 'Karnataka', 'Bangalore', 'Central');

CREATE TABLE Students (
  id INT PRIMARY KEY,
  user_id INT ,
  FOREIGN KEY (user_id) REFERENCES Users(id) ON DELETE CASCADE
);

//ALTER TABLE Students ADD  name varchar(25);

INSERT INTO Students (user_id, name)
VALUES (4, 'Aditya'),
       (5, 'Brinda'),
       (6, 'Chandra');

CREATE TABLE Subjects (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT
);

INSERT INTO Subjects (name)
VALUES ('Mathematics'),
       ('Science'),
       ('English'),
       ('History')

CREATE TABLE StudentMarks (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  student_id INTEGER REFERENCES Students(id),
  subject_id INTEGER REFERENCES Subjects(id),
  mark INTEGER
);

INSERT INTO StudentMarks (student_id, subject_id, mark)
VALUES (1, 1, 85),
       (1, 2, 90),
       (1, 3, 78),
       (1, 4, 82)