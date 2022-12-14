import express from 'express'
import cors from 'cors'
import { PrismaClient } from '@prisma/client'
import bcrypt from 'bcryptjs'
import jwt from 'jsonwebtoken'

const app = express()
app.use(express.json())
app.use(cors())

const prisma = new PrismaClient()

const port = 3456

const SECRET = 'SECRET'

function getToken (id: number) {
  return jwt.sign({ id: id }, SECRET)
}
async function getCurrentUser (token: string) {
  const data = jwt.verify(token, SECRET)
  //@ts-ignore
  const user = await prisma.user.findUnique({ where: { id: data.id } })
  return user
}

app.get('/users', async (req, res) => {
  const users = await prisma.user.findMany({ include: {foods : true} })
  res.send(users)
})

app.get ('/foods', async (req, res) => {
  const foods = await prisma.food.findMany(
    { include: {user : true} }
  )
  res.send(foods)
})

app.get ('/foods/:id', async (req, res) => {
  const foods = await prisma.food.findMany(
    { where : {
      id: Number(req.params.id)
    },
    include: {user : true} }
  )
  res.send(foods)
})

    



app.post('/sign-up', async (req, res) => {
  try {
    const inputedEmail = await prisma.user.findUnique({
      where: { email: req.body.email }
    })
    if (inputedEmail) {
      res.status(404).send({ error: 'Account exists!' })
    } else {
      const user = await prisma.user.create({
        data: {
          email: req.body.email,
          name: req.body.name,
          password: bcrypt.hashSync(req.body.password)
        }
      })
      res.send({ user: user, token: getToken(user.id) })
    }
  } catch (error) {
    //@ts-ignore
    res.status(404).send({ error: error.message })
  }
})

app.post('/sign-in', async (req, res) => {
  const user = await prisma.user.findUnique({
    where: {
      email: req.body.email
    }
  })
  if (user && bcrypt.compareSync(req.body.password, user.password)) {
    res.send({ user: user, token: getToken(user.id) })
  } else {
    res.status(404).send({ error: 'Invalid email/password!' })
  }
})

app.get('/validate', async (req, res) => {
  try {
    if (req.headers.authorization) {
      const user = await getCurrentUser(req.headers.authorization)
      //@ts-ignore
      res.send({ user, token: getToken(user.id) })
    }
  } catch (error) {
    //@ts-ignore
    res.status(400).send({ error: error.message })
  }
})

app.get('/users/:id', async (req, res) => {
  try {
    const user = await prisma.user.findUnique({
      where: {
        id: Number(req.params.id)
      },
      include: { foods : true }
    })
    res.send(user)
  } catch (error) {
    // @ts-ignore
    res.status(404).send({ error: `404 not found` })
  }
})

app.get('/restaurants', async (req, res) => {
  const restaurant = await prisma.restaurant.findMany({
    //@ts-ignore
    include: { Foods: true }
  })
  res.send(restaurant)
})


//get restaurant by id
app.get('/restaurants/:id', async (req, res) => {
  try {
    const id = Number(req.params.id)
    const restaurant = await prisma.restaurant.findUnique({
      where: { id },
      //@ts-ignore
      include: { Foods: true }
    })
    res.send(restaurant)
  } catch (error) {
    // @ts-ignore
    res.status(404).send({ error: error.message })
  }
})

app.get("/users/:id", async (req, res) => {
  try{
    const user = await prisma.user.findUnique({
    where: {
      id:Number(req.params.id),
    },
    include: { foods: true },
  });
  res.send(user);
  }catch(error){
    // @ts-ignore
    res.status(404).send({ error: error.message });
  }
});

app.get ("/ownedFoods", async (req, res) => {
  const userId = req.body.id
  const ownedFoods = await prisma.food.findMany({
    where: {
      userId: userId
    }
  })
  res.send(ownedFoods)
})

app.patch('/foods/:id', async (req, res) => {
  try {
    const id = Number(req.params.id)
    const userId = req.body.userId
    const updateFood = await prisma.food.update({
      where: { id },
      data: {
        userId: userId
      }
    })
    res.send(updateFood)
  } catch (error) {
    // @ts-ignore
    res.status(404).send({ error: error.message })
  }
})

app.patch ('/users/:id', async (req, res) => {
  try {
    const email = req.body.email
    const password = req.body.password
    const updatedProfile = await prisma.user.update({
      where: { id: Number(req.params.id) },
      data: {
        email: email,
        password: bcrypt.hashSync(password)
      }
    })
    res.send(updatedProfile)
  } catch (error) {
    // @ts-ignore
    res.status(404).send({ error: error.message })
  }
})

app.listen(port, () => {
  console.log(`http://localhost:${port}`)
})
