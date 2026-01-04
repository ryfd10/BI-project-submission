SELECT TOP 1
    FORMAT(RequestTime, 'yyyy-MM-dd HH:00') AS HourWindow,
    AVG(DATEDIFF(SECOND, RequestTime, ResponseTime)) AS AvgWaitTimeSeconds
FROM AccessRequests
GROUP BY FORMAT(RequestTime, 'yyyy-MM-dd HH:00')
ORDER BY AvgWaitTimeSeconds DESC;
