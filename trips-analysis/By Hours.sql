SELECT
    COUNT(DISTINCT tripID) AS tripCount,
    COUNT(*) AS recordCount,
    MIN(scheduleDeviation) AS minScheduleDeviation,
    MAX(scheduleDeviation) AS maxScheduleDeviation,
    AVG(scheduleDeviation) AS avgScheduleDeviation,
    MEDIAN(scheduleDeviation) AS medianScheduleDeviation
FROM TripStatus
WHERE routeID = '40_100479'
AND collectedAt >= 1732694400000 AND collectedAt < 1732780800000  -- 2024-11-27 to 2024-11-28
AND distanceAlongTrip > 0 -- ignore trip not started yet
AND tripID NOT LIKE '%Dup'
AND secondsOfDay >= (3600*23) AND secondsOfDay < (3600*24);