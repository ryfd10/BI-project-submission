DECLARE @txt VARCHAR(100) = 'logicel';

WITH ReverseCTE AS (
    SELECT 
        CAST('' AS VARCHAR(MAX)) AS reversed,
        LEN(@txt) AS i
    UNION ALL
    SELECT 
        reversed + SUBSTRING(@txt, i, 1),
        i - 1
    FROM ReverseCTE
    WHERE i > 0
)
SELECT TOP (1) @txt AS original, reversed AS reversed_result
FROM ReverseCTE
WHERE i = 0;

