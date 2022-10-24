/*
  Warnings:

  - You are about to drop the `UserandFoods` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "UserandFoods";
PRAGMA foreign_keys=on;

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
    "userId" INTEGER NOT NULL DEFAULT 0,
    CONSTRAINT "Foods_restaurantId_fkey" FOREIGN KEY ("restaurantId") REFERENCES "Restaurant" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Foods_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Foods" ("description", "id", "image", "name", "price", "quantity", "restaurantId") SELECT "description", "id", "image", "name", "price", "quantity", "restaurantId" FROM "Foods";
DROP TABLE "Foods";
ALTER TABLE "new_Foods" RENAME TO "Foods";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
