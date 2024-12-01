-- List trips for each route
SELECT
    DISTINCT TripStatus.routeID,
    TripStatus.tripID
FROM TripStatus
ORDER BY TripStatus.routeID, TripStatus.tripID;