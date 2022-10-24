/*
  Warnings:

  - Added the required column `logoImage` to the `Restaurant` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Restaurant" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "logoImage" TEXT NOT NULL,
    "openTime" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Restaurant_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Restaurant" ("address", "id", "image", "name", "openTime", "userId") SELECT "address", "id", "image", "name", "openTime", "userId" FROM "Restaurant";
DROP TABLE "Restaurant";
ALTER TABLE "new_Restaurant" RENAME TO "Restaurant";
CREATE UNIQUE INDEX "Restaurant_name_key" ON "Restaurant"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
