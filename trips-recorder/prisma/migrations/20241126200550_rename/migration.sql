/*
  Warnings:

  - You are about to drop the column `collectedAt` on the `ScraperRunLog` table. All the data in the column will be lost.
  - Added the required column `beginTime` to the `ScraperRunLog` table without a default value. This is not possible if the table is not empty.
  - Added the required column `endTime` to the `ScraperRunLog` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA defer_foreign_keys=ON;
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_ScraperRunLog" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "scraperSessionID" TEXT NOT NULL,
    "beginTime" DATETIME NOT NULL,
    "endTime" DATETIME NOT NULL,
    "routeCount" INTEGER NOT NULL,
    "tripCount" INTEGER NOT NULL,
    "routeFetchTimeS" REAL NOT NULL,
    "tripFetchTimeS" REAL NOT NULL
);
INSERT INTO "new_ScraperRunLog" ("id", "routeCount", "routeFetchTimeS", "scraperSessionID", "tripCount", "tripFetchTimeS") SELECT "id", "routeCount", "routeFetchTimeS", "scraperSessionID", "tripCount", "tripFetchTimeS" FROM "ScraperRunLog";
DROP TABLE "ScraperRunLog";
ALTER TABLE "new_ScraperRunLog" RENAME TO "ScraperRunLog";
PRAGMA foreign_keys=ON;
PRAGMA defer_foreign_keys=OFF;
