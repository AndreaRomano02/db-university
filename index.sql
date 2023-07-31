--------------------------------------------------------------------------------------------------------------------------

--# QUERY SELECT

--* 1. Selezionare tutti gli studenti nati nel 1990 (160)

SELECT * 
FROM `students`
WHERE YEAR(`date_of_birth`) = '1990';

--* 2. Selezionare tutti i corsi che valgono più di 10 crediti (479)

SELECT `name`,`cfu`
FROM `courses`
WHERE `cfu` > 10;

--* 3. Selezionare tutti gli studenti che hanno più di 30 anni

SELECT * 
FROM `students`
WHERE ( YEAR(CURRENT_TIMESTAMP) - YEAR(`date_of_birth`)) > 30 
ORDER BY `date_of_birth` DESC;

--* 4. Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)

SELECT * 
FROM `courses`
WHERE `period` = 'I semestre'
AND `year` = 1;

--* 5. Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)

SELECT * 
FROM `exams`
WHERE HOUR(`hour`) >= 14
AND `date` = '2020-06-20';

--* 6. Selezionare tutti i corsi di laurea magistrale (38)

SELECT `name`,`level` 
FROM `degrees`
WHERE `level` = 'magistrale';

--* 7. Da quanti dipartimenti è composta l'università? (12)

SELECT COUNT(*) FROM `departments`;

--* 8. Quanti sono gli insegnanti che non hanno un numero di telefono? (50)

SELECT * 
FROM `teachers`
WHERE `phone` IS NULL;

--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
--# QUERY GROUP BY

--* 1. Contare quanti iscritti ci sono stati ogni anno

SELECT COUNT(*), YEAR(`enrolment_date`) AS `year`
FROM `students`
GROUP BY `year`;

--* 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT COUNT(*) AS `n_teachers`, `office_address`
FROM `teachers`
GROUP BY `office_address`;

--* 3. Calcolare la media dei voti di ogni appello d'esame

SELECT `exam_id`, ROUND(AVG(`vote`),2)
FROM `exam_student`
GROUP BY `exam_id`;

--* 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT `department_id`, COUNT(`name`) AS `n_of_courses`
FROM `degrees`
GROUP BY `department_id`;

--------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------
--# QUERY CON JOIN

--* 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT S.`name`, S. `surname`, S.`registration_number`
FROM `degrees` AS D
JOIN `students` AS S
ON D . `id` = S . `degree_id`
WHERE D. `name` = 'Corso di Laurea in Economia';

--* 2. Selezionare tutti i Corsi di Laurea del Dipartimento di Neuroscienze

SELECT DEG . `name` , DEG. `level`, DEG . `address`
FROM `departments` AS DEP
JOIN `degrees` AS DEG ON DEP . `id` = DEG . `department_id`
WHERE DEP . `name` = 'Dipartimento di Neuroscienze';

--* 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT C.`name`,C.`description`, C.`year` 
FROM `courses` AS C
JOIN `course_teacher` AS CT ON  C . `id` = CT.`course_id`
JOIN `teachers` AS T ON T.`id` = CT.`teacher_id`
WHERE T.`name` = 'Fulvio' 
AND T.`surname` = 'Amato';

--* 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT S.`surname`, S.`name`, S.`registration_number`, DEG.`name` AS 'Degree Name', DEP . `name` AS 'Department Name'
FROM `students` AS S
JOIN `degrees` AS DEG ON DEG.`id` = S.`degree_id`
JOIN `departments` AS DEP ON DEG.`id` = DEG.`department_id`
ORDER BY S.`surname`, S.`name`;

--* 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti


--* 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)


--* 7. BONUS: Selezionare per ogni studente quanti tentativi d’esame ha sostenuto per superare ciascuno dei suoi esami