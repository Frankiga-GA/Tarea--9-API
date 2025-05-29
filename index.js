// index.js
const express = require('express');
const cors = require('cors');

const examenesRoutes = require('./routes/examenes');

const app = express();

// Middleware para procesar JSON
app.use(express.json());
app.use(cors());

// Rutas
app.use('/api/examenes', examenesRoutes);

// Puerto
const PORT = process.env.PORT || 4000;

app.listen(PORT, () => {
  console.log(`🚀 Servidor corriendo en http://localhost:${PORT}`);
});