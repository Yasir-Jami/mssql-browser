const express = require('express');
const sql = require('mssql');
const env = require("./.env");

const app = express();
const port = 3000;

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
    trustServerCertificate: true
  },
}

console.log(process.env.DB_PASSWORD)

