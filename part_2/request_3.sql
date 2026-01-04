WITH Ordered AS (
  SELECT *,
    ROW_NUMBER() OVER (ORDER BY Priority DESC, RequestTime) AS RowNum
  FROM AccessRequests
),
GreedyPick AS (
  SELECT A.*
  FROM Ordered A
  WHERE NOT EXISTS (
    SELECT 1
    FROM Ordered B
    WHERE B.RowNum < A.RowNum
      AND B.ExpirationTime > A.RequestTime
      AND A.RequestTime >= B.RequestTime
  )
)
SELECT *
FROM GreedyPick
ORDER BY RequestTime;
