-- 1
SELECT 
    c.name, 
    o.total 
FROM clients c
JOIN (
    SELECT 
        client_id, 
        SUM(price) AS total 
    FROM orders 
    GROUP BY client_id 
    ORDER BY total DESC 
    LIMIT 1
) o ON c.id = o.client_id;

-- 2
SELECT 
    c.name, 
    o.average_sum 
FROM clients c
LEFT JOIN (
    SELECT 
        client_id, 
        AVG(price) AS average_sum 
    FROM orders 
    GROUP BY client_id
) o ON c.id = o.client_id;

-- 3
SELECT 
    c.type, 
    MIN(o.price) AS min_price
FROM clients c 
LEFT JOIN orders o ON c.id = o.client_id 
GROUP BY c.type;

-- 4
SELECT 
    t.name, 
    t.price,
    t.reference
FROM (
    SELECT 
        c.name, 
        o.price,
        o.reference,
        RANK() OVER(PARTITION BY c.id ORDER BY o.price DESC) pos 
    FROM clients c 
    LEFT JOIN orders o ON c.id = o.client_id
) t WHERE t.pos = 1;

-- 5
SELECT 
    reference, 
    price, 
    price / SUM(price) OVER() * 100 AS percent 
FROM orders;

-- 6
SELECT 
    o.reference, 
    c.name, 
    o.price, 
    o.price / SUM(o.price) OVER(PARTITION BY o.client_id) * 100 AS percent 
FROM orders o
LEFT JOIN clients c ON c.id = o.client_id;

-- 7
SELECT 
    o.reference, 
    c.name, 
    o.price, 
    o.price - LAG(o.price) OVER(PARTITION BY o.client_id ORDER BY o.created_at) AS diff
FROM orders o
LEFT JOIN clients c ON c.id = o.client_id;

-- 8
SELECT 
    AVG(t.diff) AS avg_time 
FROM (
    SELECT
        TIMESTAMPDIFF(
            second,
            LAG(created_at) OVER(PARTITION BY order_id ORDER BY created_at),
            created_at
        ) AS diff
    FROM statuses 
    WHERE name IN('PLACED', 'CONFIRMED')
) t;

-- 9
SELECT 
    c.name, -- применение функциональной зависимости от t.client_id (интересный случай) !!!
    AVG(t.diff) AS avg_time
FROM (
    SELECT
        o.client_id,
        TIMESTAMPDIFF(
            second,
            LAG(s.created_at) OVER(PARTITION BY o.id ORDER BY s.created_at),
            s.created_at
        ) AS diff
    FROM orders o 
    JOIN statuses s ON o.id = s.order_id AND s.name IN('PLACED', 'CONFIRMED')
) t 
JOIN clients c ON c.id = t.client_id
GROUP BY t.client_id;

-- 10
SELECT 
    c.type, 
    AVG(t.diff) AS avg_time
FROM (
    SELECT
        o.client_id,
        TIMESTAMPDIFF(
            second,
            LAG(s.created_at) OVER(PARTITION BY o.id ORDER BY s.created_at),
            s.created_at
        ) AS diff
    FROM orders o 
    JOIN statuses s ON o.id = s.order_id AND s.name IN('PLACED', 'DELIVERED')
) t 
JOIN clients c ON c.id = t.client_id
GROUP BY c.type;