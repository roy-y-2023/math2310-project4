/*
  Warnings:

  - Added the required column `distanceAlongTrip` to the `TripStatus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nextStopID` to the `TripStatus` table without a default value. This is not possible if the table is not empty.
  - Added the required column `nextStopTimeOffset` to the `TripStatus` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_TripStatus" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "collectedAt" DATETIME NOT NULL,
    "routeID" TEXT NOT NULL,
    "tripID" TEXT NOT NULL,
    "scheduleDeviation" INTEGER NOT NULL,
    "scraperSessionID" TEXT NOT NULL,
    "nextStopID" TEXT NOT NULL,
    "nextStopTimeOffset" INTEGER NOT NULL,
    "distanceAlongTrip" REAL NOT NULL
);
INSERT INTO "new_TripStatus" ("collectedAt", "id", "routeID", "scheduleDeviation", "scraperSessionID", "tripID") SELECT "collectedAt", "id", "routeID", "scheduleDeviation", "scraperSessionID", "tripID" FROM "TripStatus";
DROP TABLE "TripStatus";
ALTER TABLE "new_TripStatus" RENAME TO "TripStatus";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
