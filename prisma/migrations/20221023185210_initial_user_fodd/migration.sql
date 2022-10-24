/*
  Warnings:

  - You are about to drop the column `userId` on the `Restaurant` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Foods" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "description" TEXT NOT NULL,
    "quantity" INTEGER NOT NULL DEFAULT 0,
    "image" TEXT NOT NULL,
    "restaurantId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Foods_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "Restaurant" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Foods_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Foods" ("description", "id", "image", "name", "price", "quantity", "restaurantId", "userId") SELECT "description", "id", "image", "name", "price", "quantity", "restaurantId", "userId" FROM "Foods";
DROP TABLE "Foods";
ALTER TABLE "new_Foods" RENAME TO "Foods";
CREATE TABLE "new_Restaurant" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "address" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "logo" TEXT NOT NULL,
    "openTime" TEXT NOT NULL
);
INSERT INTO "new_Restaurant" ("address", "id", "image", "logo", "name", "openTime") SELECT "address", "id", "image", "logo", "name", "openTime" FROM "Restaurant";
DROP TABLE "Restaurant";
ALTER TABLE "new_Restaurant" RENAME TO "Restaurant";
CREATE UNIQUE INDEX "Restaurant_name_key" ON "Restaurant"("name");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
