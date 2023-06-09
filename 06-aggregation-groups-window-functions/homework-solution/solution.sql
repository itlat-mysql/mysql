-- предположим, что необходимая база данных aggregation уже существует - переключимся на нее
USE aggregation;


-- решение первого задания (найти те департаменты, где работающие в этих департаментах женщины составляют менее 50% от всех работающих в этом департаменте людей)
SELECT
    w.department, w.woman_qty / t.total_qty * 100 AS woman_percent
FROM (
    SELECT department, COUNT(*) AS woman_qty 
	FROM workers WHERE sex = 'woman' GROUP BY department
) AS w
JOIN (
    SELECT department, COUNT(*) AS total_qty 
	FROM workers GROUP BY department
) AS t ON w.department = t.department
WHERE w.woman_qty / t.total_qty * 100 < 50;


-- решение второго задания - найти в каждом департаменте работника с наибольшей зарплатой (вариант с коррелирующим подзапросом)
SELECT
    a.department, a.name, a.salary
FROM workers a WHERE a.id = (
	SELECT b.id 
	FROM workers b 
	WHERE b.department = a.department 
	ORDER BY b.salary DESC 
	LIMIT 1
);


-- альтернативное решение второго задания (вариант без коррелирующего подзапроса - для тех, кто уже знает оконные функции)
SELECT
    t.department, t.name, t.salary
FROM (
    SELECT
        name,
        ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS position,
        MAX(salary) OVER(PARTITION BY department) AS salary, 
		department
    FROM workers
) t WHERE t.position = 1 ORDER BY salary DESC;


-- решение третьего задания - найти работников, которые участвуют абсолютно во всех проектах фирмы
SELECT
    name, t.quantity
FROM workers
JOIN (
    SELECT
        worker_id, COUNT(task_id) AS quantity
    FROM workers_tasks
    GROUP BY worker_id
    HAVING COUNT(task_id) = (SELECT COUNT(*) FROM tasks)
) AS t ON id = t.worker_id;