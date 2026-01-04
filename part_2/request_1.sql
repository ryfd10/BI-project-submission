WITH WindowCounts AS (
  SELECT 
    A.UserID,
    A.RequestTime AS WindowStart,
    COUNT(*) AS RequestsInWindow
  FROM AccessRequests A
  JOIN AccessRequests B
    ON A.UserID = B.UserID
    AND B.RequestTime BETWEEN A.RequestTime AND DATEADD(MINUTE, 5, A.RequestTime)
  GROUP BY A.UserID, A.RequestTime
)
SELECT UserID, MAX(RequestsInWindow) AS MaxRequests
FROM WindowCounts
GROUP BY UserID
HAVING MAX(RequestsInWindow) > 10
ORDER BY MaxRequests DESC
