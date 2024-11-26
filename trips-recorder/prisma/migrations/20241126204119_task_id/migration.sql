/*
  Warnings:

  - Added the required column `taskID` to the `ScraperRunLog` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ScraperRunLog" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "scraperSessionID" TEXT NOT NULL,
    "taskID" TEXT NOT NULL,
    "beginAt" DATETIME NOT NULL,
    "endAt" DATETIME NOT NULL,
    "routeCount" INTEGER NOT NULL,
    "tripCount" INTEGER NOT NULL,
    "routeFetchTimeS" REAL NOT NULL,
    "tripFetchTimeS" REAL NOT NULL
);
INSERT INTO "new_ScraperRunLog" ("beginAt", "endAt", "id", "routeCount", "routeFetchTimeS", "scraperSessionID", "tripCount", "tripFetchTimeS") SELECT "beginAt", "endAt", "id", "routeCount", "routeFetchTimeS", "scraperSessionID", "tripCount", "tripFetchTimeS" FROM "ScraperRunLog";
DROP TABLE "ScraperRunLog";
ALTER TABLE "new_ScraperRunLog" RENAME TO "ScraperRunLog";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
