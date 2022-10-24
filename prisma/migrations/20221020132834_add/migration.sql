/*
  Warnings:

  - Added the required column `userId` to the `Foods` table without a default value. This is not possible if the table is not empty.

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
INSERT INTO "new_Foods" ("description", "id", "image", "name", "price", "quantity", "restaurantId") SELECT "description", "id", "image", "name", "price", "quantity", "restaurantId" FROM "Foods";
DROP TABLE "Foods";
ALTER TABLE "new_Foods" RENAME TO "Foods";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
