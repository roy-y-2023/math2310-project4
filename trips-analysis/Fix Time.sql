UPDATE TripStatus
SET secondsOfDay =
    (secondsOfDay - 28800 + 86400) % 86400;