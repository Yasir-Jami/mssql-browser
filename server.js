const express = require('express');
const sql = require('mssql');
const cors = require('cors');
require("dotenv").config("./.env");

const app = express();
const port = process.env.PORT || 3000;

const user = process.env.DB_USERNAME;
const password = process.env.DB_PASSWORD;
const server = process.env.DB_SERVER;
const database = process.env.DB_NAME;

const config = {
  user: user,
  password: password,
  server: server,
  database: database,
  options: {
    encrypt: true,
    trustServerCertificate: true
  },
}

app.use(cors());

app.post("/query", async (req, res) => {
  console.log("Body:", req.body);
  
  try {
    const query = req.body;
    const data = await queryDatabase(query);
    res.json(data);
  }
  catch (error) {
    console.error("Error:", error);
    res.status(500).json( { error: "Error querying the database" });
  }
});

async function queryDatabase(query) {
  try {
    await sql.connect(config);
    const result = await sql.query`${query}`
  }
  catch (error) {
    console.error("SQL Error:", error);
    throw error;
  }
  finally {
    sql.close();
  }
}

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
})