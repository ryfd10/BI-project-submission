DECLARE @X INT = 32;

 with maxK AS
 (SELECT
    Numbers1.val AS val1,
    Numbers2.val AS val2,
    Numbers3.val AS val3
FROM Numbers AS Numbers1
JOIN Numbers AS Numbers2 ON Numbers1.val > Numbers2.val
JOIN Numbers AS Numbers3 ON Numbers1.val > Numbers3.val
                         AND Numbers2.val > Numbers3.val
WHERE Numbers1.val + Numbers2.val + Numbers3.val = @X
)

SELECT TOP (1)*,
       val1 * val2 * val3 AS product
FROM maxK
ORDER BY product DESC;
