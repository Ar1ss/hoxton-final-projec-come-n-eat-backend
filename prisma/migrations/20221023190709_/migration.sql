/*
  Warnings:

  - You are about to drop the column `address` on the `Food` table. All the data in the column will be lost.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Food" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "image" TEXT NOT NULL,
    "price" INTEGER NOT NULL,
    "restaurantId" INTEGER NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Food_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "Restaurant" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Food_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);
INSERT INTO "new_Food" ("description", "id", "image", "name", "price", "restaurantId", "userId") SELECT "description", "id", "image", "name", "price", "restaurantId", "userId" FROM "Food";
DROP TABLE "Food";
ALTER TABLE "new_Food" RENAME TO "Food";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
