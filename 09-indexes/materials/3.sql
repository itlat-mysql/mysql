USE indexes;

INSERT INTO products (name, code, description, type, price) SELECT * FROM
(
    SELECT
        CONCAT('NAME ', a.name, ' ', b.name),
        MD5(CONCAT(a.code, ' ', b.code)),
        CONCAT('DESCRIPTION ', a.description, ' ', b.description),
        CONCAT('TYPE ', a.type, ' ', b.type),
        a.price
    FROM (
        WITH RECURSIVE rec1(name, code, description, type, price, n) AS
        (
            SELECT
                CAST(1 AS CHAR(100)),
                CAST(1 AS CHAR(100)),
                CAST(1 AS CHAR(100)),
                CAST(1 AS CHAR(100)),
                CAST(ROUND(RAND(), 2) * 1000 AS CHAR(100)),
                1
            UNION ALL
            SELECT
                CAST(n + 1 AS CHAR(100)),
                CAST(n + 1 AS CHAR(100)),
                CAST(n + 1 AS CHAR(100)),
                CAST(n + 1 AS CHAR(100)),
                CAST(ROUND(RAND(), 2) * 1000 AS CHAR(100)),
                n + 1
            FROM rec1 WHERE n < 1000
        )
        SELECT name, code, description, type, price FROM rec1
    ) a
    CROSS JOIN
    (
        WITH RECURSIVE rec2(name, code, description, type, price, n) AS
        (
            SELECT
                CAST(1 AS CHAR(100)),
                CAST(1 AS CHAR(100)),
                CAST(1 AS CHAR(100)),
                CAST(1 AS CHAR(100)),
                CAST(ROUND(RAND(), 2) * 1000 AS CHAR(100)),
                1
            UNION ALL
            SELECT
                CAST(n + 1 AS CHAR(100)),
                CAST(n + 1 AS CHAR(100)),
                CAST(n + 1 AS CHAR(100)),
                CAST(n + 1 AS CHAR(100)),
                CAST(ROUND(RAND(), 2) * 1000 AS CHAR(100)),
                n + 1
            FROM rec2 WHERE n < 1000
        )
        SELECT name, code, description, type, price FROM rec2
    ) b
) c;