// routes/examenes.js
const express = require('express');
const router = express.Router();
const {
  getPreguntasPorExamen,
  getExamenesPorAlumno,
  registrarRespuestasYCalcularPuntaje
} = require('../controllers/examenes');

// Obtener preguntas por examen
router.get('/preguntas/:id_evaluacion', getPreguntasPorExamen);

// Obtener exámenes asignados a un alumno
router.get('/:id_usuario', getExamenesPorAlumno);

// Registrar respuestas y calcular puntaje
router.post('/responder', registrarRespuestasYCalcularPuntaje);

module.exports = router;