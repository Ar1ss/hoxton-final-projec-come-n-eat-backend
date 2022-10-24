/*
  Warnings:

  - You are about to drop the `Order` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Order";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "UserandFoods" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "userId" INTEGER NOT NULL,
    "foodsId" INTEGER NOT NULL,
    CONSTRAINT "UserandFoods_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "UserandFoods_foodsId_fkey" FOREIGN KEY ("foodsId") REFERENCES "Foods" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
