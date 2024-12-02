-- List trips for each route
SELECT
    DISTINCT TripStatus.routeID,
    TripStatus.tripID
FROM TripStatus
ORDER BY TripStatus.routeID, TripStatus.tripID;

SELECT
    COUNT(DISTINCT TripStatus.TripID) AS TripCount
FROM TripStatus
WHERE routeID = '40_100479'
AND collectedAt >= 1732694400000 AND collectedAt < 1732780800000  -- 2024-11-27 to 2024-11-28
AND distanceAlongTrip > 0 -- ignore trip not started yet
AND tripID NOT LIKE '%Dup'