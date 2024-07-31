
CREATE TABLE course
(
course_code VARCHAR(6) NOT NULL,
course_name VARCHAR(255),
PRIMARY KEY (course_code)
);

CREATE TABLE section
(
id VARCHAR(8) NOT NULL,
course_code VARCHAR(6),
room_num SMALLINT,
instructor VARCHAR(255),
PRIMARY KEY (id),
FOREIGN KEY (course_code) REFERENCES course(course_code)
);

CREATE TABLE grade
(
id INT NOT NULL AUTO_INCREMENT,
student_name VARCHAR(255),
section_id VARCHAR(8),
score INT,
PRIMARY KEY (id),
FOREIGN KEY (section_id) REFERENCES section(id)
);

INSERT INTO course (course_code, course_name)
VALUES  ('CS101', 'Intro to Java'),
        ('CS103',  'Databases');

INSERT INTO section (id, course_code, room_num, instructor)
VALUES  ('CS101-A', 'CS101', 1802, 'Balderez'),
        ('CS101-B', 'CS101',  1650, 'Su'),
        ('CS103-A', 'CS103',  1200, 'Rojas'),
        ('CS103-B', 'CS103',  1208, 'Tonno');

INSERT INTO grade (student_name, section_id, score)
VALUES  ('Maya Charlotte', 'CS101-A', 98),
        ('James Fields', 'CS101-A', 82),
        ('Michael Alcocer', 'CS101-B', 65),
        ('Maya Charlotte', 'CS103-A', 89),
        ('Tomas Lacroix', 'CS101-A', 99),
        ('Sara Bisat', 'CS101-A', 87),
        ('James Fields', 'CS103-A', 46),
        ('Helena Sepulvida', 'CS103-A', 72),
        ('Michael Goodman', 'CS101-A', 85),
        ('Sara Bisat', 'CS103-A', 77),
        ('Jacob Armas', 'CS101-B', 92),
        ('Luceilla Sepulvida', 'CS103-A', 88),
        ('Tomas Lacroix', 'CS103-A', 100),
        ('Michael Alcocer', 'CS103-A', 93),
        ('Michael Goodman' , 'CS103-A', 80),
        ('Helena Sepulvida', 'CS101-B', 90);

SELECT * FROM course;

SELECT * FROM section;

SELECT * FROM grade;

-- ######### AGREGACION SQL ############

-- Calificación promedio para cada estudiante
select grade.student_name as Estudiante, AVG(score) as Nota_Media from grade
group by student_name;

-- Numero total de cursos tomados por cada estudiante
select grade.student_name as Estudiante, COUNT(section_id) as Total_Cursos_Apuntado from grade
group by student_name;

-- Calificacion minima para cada seccion
select section_id as Seccion, MIN(score) as Calificacion_Minima from grade
group by section_id;

-- Calificacion maxima para cada seccion
select section_id as Seccion, MAX(score) as Calificacion_Minima from grade
group by section_id;

-- Numero total de cursos tomados por un estudiante que ha tomado mas de 1 curso
select grade.student_name as Estudiante, COUNT(section_id) as Total_Cursos_Apuntado from grade
group by student_name HAVING COUNT(section_id) > 1;

-- ######### CONSULTAS INTERMEDIAS ############

-- Nombre del estudiante y puntuacion para todas las secciones de CS103
-- ordenadas por la puntuacion de mayor a menor
select  student_name as Estudiante, score as Calificacion from grade
WHERE section_id LIKE 'CS103%'
ORDER BY score DESC;

-- Una lista alfabetica de estudiantes distintos cuyos nombres de pila
-- caen alfabeticamente de L a R.
select  DISTINCT student_name as Estudiante from grade
WHERE student_name BETWEEN 'L' AND 'R'
ORDER BY student_name;

-- ######### UNIONES SQL ############
-- Utilizando las mismas tablas y datos del ejercicio anterior y utilizando
-- uniones, consulta los nombres y las evaluaciones de los estudiantes para
-- los cursos llamados “Bases de datos”.
select student_name as Estudiante, score as Calificacion from grade
INNER JOIN section ON grade.section_id = section.id
INNER JOIN course ON section.course_code = course.course_code
WHERE course_name = 'DataBases';
