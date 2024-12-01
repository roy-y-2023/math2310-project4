-- Single Trip Pattern
SELECT
    *
FROM TripStatus
WHERE routeID = '40_100479'
AND collectedAt >= 1732694400000 AND collectedAt < 1732780800000  -- 2024-11-27 to 2024-11-28
-- AND collectedAt >= 1732719600000 AND collectedAt < 1732723200000 -- 2024-11-27 07:00:00 to 2024-11-28 08:00:00
AND distanceAlongTrip > 0; -- ignore trip not started yet
