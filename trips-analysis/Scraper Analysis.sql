SELECT
    ROUND(routeFetchTimeS * 1000, 0) AS routeFetchTimeMS
FROM ScraperRunLog;


SELECT
    ROUND(tripFetchTimeS / tripCount * 1000, 0) AS avgTripFetchTimeMS
FROM ScraperRunLog;