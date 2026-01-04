DECLARE @X INT = 32;

SELECT
    Numbers1.val AS val1,
    Numbers2.val AS val2,
    Numbers3.val AS val3
FROM Numbers Numbers1
JOIN Numbers Numbers2 ON Numbers1.val <> Numbers2.val
JOIN Numbers Numbers3 
    ON Numbers1.val <> Numbers3.val
    AND Numbers2.val <> Numbers3.val
WHERE Numbers1.val + Numbers2.val + Numbers3.val = @X;
