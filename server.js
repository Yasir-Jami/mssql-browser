const express = require('express');
const sql = require('mssql');
const cors = require('cors');
require("dotenv").config("./.env");

const app = express();
app.use(cors());
app.use(express.json());

const user = process.env.DB_USERNAME;
const password = process.env.DB_PASSWORD;
const server = process.env.DB_SERVER;
const database = process.env.DB_NAME;
const port = process.env.PORT || 3000;

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

app.post("/rawquery", async (req, res) => {
  try {
    const query = req.body.text;
    const data = await queryDatabase(query, 0);
    res.json(data);
  }
  catch (error) {
    console.error("Error:", error);
    res.status(500).json( { error: "Error querying the database" });
  }
});

app.post("/storedprocedure", async (req, res) => {
  try {
    const query = req.body.text;
    const data = await queryDatabase(query, 1);
    res.json(data);
  }

  catch (error) {
    console.error("Error:", error);
    res.status(500).json( { error: "Error executing stored procedure" });
  }
});

async function queryDatabase(query, method) {
  try {
    let result;
    
    switch(method) {
      case 0: // Raw Query
        const pool = await sql.connect(config);  
        result = await pool.request().query(query);
        break;
      case 1: // Stored Procedure
        result = await sql.query`${query}`;
        break;
      default:
        break;
    }
    
    return result;
  }
  catch (error) {
    console.error("SQL Error:", error);
    return error;
  }
  finally {
    sql.close();
  }
}

app.listen(port, () => {
  console.log(`Server running on port ${port}`);
})