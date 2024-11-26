-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_TripStatus" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "collectedAt" DATETIME NOT NULL,
    "routeID" TEXT NOT NULL,
    "tripID" TEXT NOT NULL,
    "scheduleDeviation" INTEGER NOT NULL,
    "scraperSessionID" TEXT NOT NULL DEFAULT ''
);
INSERT INTO "new_TripStatus" ("collectedAt", "id", "routeID", "scheduleDeviation", "tripID") SELECT "collectedAt", "id", "routeID", "scheduleDeviation", "tripID" FROM "TripStatus";
DROP TABLE "TripStatus";
ALTER TABLE "new_TripStatus" RENAME TO "TripStatus";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
