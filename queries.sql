-- MySQL 8.0

-- Создание базы данных
CREATE DATABASE company;
USE company;

-- 1
CREATE TABLE employees (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(255) NOT NULL,
    start_date DATE,
    job_title VARCHAR(255),
    lvl ENUM('junior', 'middle', 'senior', 'lead'),
    salary INT,
    department_id INT,
    driving_license BOOLEAN,
    FOREIGN KEY (department_id) REFERENCES departments (id)
    );


-- 2
CREATE TABLE departments (
   id INT AUTO_INCREMENT PRIMARY KEY,
   name VARCHAR(255),
   director_name VARCHAR(255),
   employees_number INT
    );

-- Добавление записей в таблицу departments
INSERT INTO departments (name, director_name, employees_number)
VALUES
(
    'Бухгалтерский отдел',
    'Иванов Иван Иванович',
    50
),
(
    'IT отдел',
    'Петров Петр Петрович',
    155
),
(
    'Отдел кадров',
    'Андреева Анастасия Ивановна',
    35
),
(
    'Отдел по работе с партнерами',
    'Михайлов Николай Петрович',
    115
);

-- Добавление записей в таблицу employees
INSERT INTO employees (full_name, start_date, job_title, lvl, salary, department_id, driving_license)
VALUES
('Николаев А. И.', '2015-7-04', 'Тестировщик', 'middle', 150, 2, True),
('Дмитриева Е. С.', '2019-10-21', 'Кадровик', Null, 75, 3, False),
('Алексеев Н. В.', '2011-6-08', 'Главный бухгалтер', Null, 108, 1, True),
('Кириллова Н. А.', '2022-1-15', 'Менеджер по работе с партнерами', Null, 100, 4, True),
('Андреев С. В.', '2010-2-03', 'Системный аналитик', 'senior', 230, 2, True),
('Герасимов П. П.', '2020-12-17', 'Python Программист', 'junior', 95, 2, False),
('Смирнов В. А.', '2011-11-11', 'Java Программист', 'lead', 210, 2, True),
('Казаков М. С.', '2019-7-01', 'Специалист по поддержке пользователей', Null, 100, 4, False),
('Зайцева О. П.', '2012-5-04', 'Помощник бухгалтера', Null, 70, 1, True),
('Винокуров А. А.', '2017-8-18', 'C# программист', 'middle', 150, 2, True);


-- 3
CREATE TABLE employee_rating (
    id INT AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    first_year_quarter ENUM('A', 'B', 'C', 'D', 'E'),
    second_year_quarter ENUM('A', 'B', 'C', 'D', 'E'),
    third_year_quarter ENUM('A', 'B', 'C', 'D', 'E'),
    fourth_year_quarter ENUM('A', 'B', 'C', 'D', 'E'),
    FOREIGN KEY (employee_id) REFERENCES employees (id)
    );

-- Добавление данных в таблицу employee_rating
-- Копирование id работников из таблицы employees
INSERT INTO employee_rating (employee_id)
SELECT id FROM employees;

-- Добавление оценок для каждого работника по кварталам
INSERT INTO employee_rating  (
    employee_id,
    first_year_quarter,
    second_year_quarter,
    third_year_quarter,
    fourth_year_quarter
    )
VALUES
(1, 'A', 'A', 'C', 'B'),
(2, 'A', 'B', 'B', 'B'),
(3, 'C', 'D', 'D', 'D'),
(4, 'E', 'D', 'B', 'C'),
(5, 'A', 'A', 'A', 'A'),
(6, 'E', 'E', 'E', 'C'),
(7, 'B', 'E', 'E', 'D'),
(8, 'A', 'B', 'C', 'A'),
(9, 'C', 'E', 'D', 'B'),
(10, 'B', 'B', 'B', 'B');

-- 5
-- Добавление отдела
INSERT INTO departments (name, director_name, employees_number)
VALUES
(
    'Отдел Интеллектуального анализа данных',
    'Григорьев Николай Сергеевич',
    3
);
-- Добавление сотрудников для добавленного отдела
INSERT INTO employees (full_name, start_date, job_title, lvl, salary, department_id, driving_license)
VALUES
('Алексеев Н. А.', '2022-11-14', 'Инженер данных', 'middle', 190, 6, True),
('Сергеева Н. С.', '2022-11-14', 'Специалист по анализу данных', 'middle', 185, 6, True);

-- 6. Теперь пришла пора анализировать наши данные – напишите запросы для получения следующей информации:
-- o   Уникальный номер сотрудника, его ФИО и стаж работы – для всех сотрудников компании
SELECT id, full_name, DATEDIFF(CURDATE(), start_date) as Days_work_experience
FROM employees;

-- o   Уникальный номер сотрудника, его ФИО и стаж работы – только первых 3-х сотрудников
SELECT id, full_name, DATEDIFF(CURDATE(), start_date) as Days_work_experience
FROM employees
LIMIT 3;

-- o   Уникальный номер сотрудников - водителей
SELECT id
FROM employees
WHERE driving_license = True;

-- o   Выведите номера сотрудников, которые хотя бы за 1 квартал получили оценку D или E
SELECT employee_id
FROM employee_rating
WHERE (first_year_quarter = 'D' OR first_year_quarter = 'E')
OR (second_year_quarter = 'D' OR second_year_quarter = 'E')
OR (third_year_quarter = 'D' OR third_year_quarter = 'E')
OR (fourth_year_quarter = 'D' OR fourth_year_quarter = 'E');

-- o   Выведите самую высокую зарплату в компании.
SELECT MAX(salary) from employees;


