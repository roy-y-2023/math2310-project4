-- All
SELECT
    scheduleDeviation
FROM TripStatus
WHERE routeID = '1_102745'
-- WHERE routeID = '40_100479'
AND collectedAt >= 1732694400000 AND collectedAt < 1733040000000  -- 2024-11-27 to 2024-11-30
AND distanceAlongTrip > 0; -- ignore trip not started yet


-- median for each trip
SELECT
--     tripID,
    median(scheduleDeviation)
FROM TripStatus
WHERE routeID = '1_102745'
GROUP BY tripID
