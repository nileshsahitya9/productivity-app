const mongoose = require("mongoose");
const request = require("supertest");

const app = require("../app");

require("dotenv").config();

/* Connecting to the database before each test. */
beforeEach(async () => {
  await mongoose.connect(process.env.MONGODB_URI);
});

/* Closing database connection after each test. */
afterEach(async () => {
  await mongoose.connection.close();
});

describe("GET /api/activities", () => {
  it("should get all the activities", async () => {
    const token = await request(app).post("/api/auth/login").send({
      email: process.env.EMAIL,
      password: process.env.PASSWORD,
    });

    const response = await request(app)
      .get("/api/activities")
      .set({
        Authorization: "bearer " + token.body.token,
        "Content-Type": "application/json",
      });

    expect(response.statusCode).toBe(200);
  });
});

