// test-db.js
const pool = require('./config/db');

async function testConnection() {
  try {
    const [rows] = await pool.query('SELECT 1 + 1 AS solution');
    console.log('La solución es:', rows[0].solution);
  } catch (error) {
    console.error('❌ Error al conectar a la base de datos:', error.message);
  }
}

testConnection();