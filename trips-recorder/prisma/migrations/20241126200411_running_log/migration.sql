-- CreateTable
CREATE TABLE "ScraperRunLog" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "scraperSessionID" TEXT NOT NULL,
    "collectedAt" DATETIME NOT NULL,
    "routeCount" INTEGER NOT NULL,
    "tripCount" INTEGER NOT NULL,
    "routeFetchTimeS" REAL NOT NULL,
    "tripFetchTimeS" REAL NOT NULL
);
