/*
  Warnings:

  - You are about to drop the column `userId` on the `Foods` table. All the data in the column will be lost.

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
    CONSTRAINT "Foods_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "Restaurant" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Foods" ("description", "id", "image", "name", "price", "quantity", "restaurantId") SELECT "description", "id", "image", "name", "price", "quantity", "restaurantId" FROM "Foods";
DROP TABLE "Foods";
ALTER TABLE "new_Foods" RENAME TO "Foods";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
