/*
  Warnings:

  - Added the required column `ruoteID` to the `TripStatus` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_TripStatus" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "collectedAt" DATETIME NOT NULL,
    "ruoteID" TEXT NOT NULL,
    "tripID" TEXT NOT NULL,
    "scheduleDeviation" INTEGER NOT NULL
);
INSERT INTO "new_TripStatus" ("collectedAt", "id", "scheduleDeviation", "tripID") SELECT "collectedAt", "id", "scheduleDeviation", "tripID" FROM "TripStatus";
DROP TABLE "TripStatus";
ALTER TABLE "new_TripStatus" RENAME TO "TripStatus";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
