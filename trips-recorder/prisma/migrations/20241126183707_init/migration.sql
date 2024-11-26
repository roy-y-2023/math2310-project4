-- CreateTable
CREATE TABLE "TripStatus" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "collectedAt" DATETIME NOT NULL,
    "tripID" TEXT NOT NULL,
    "scheduleDeviation" INTEGER NOT NULL
);
