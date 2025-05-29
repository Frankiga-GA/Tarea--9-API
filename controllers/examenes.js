// controllers/examenes.js
const pool = require('../config/db');

// Obtener exámenes asignados a un alumno
const getExamenesPorAlumno = async (req, res) => {
  const { id_usuario } = req.params;

  try {
    const [rows] = await pool.query(
      `SELECT e.id_evaluacion, e.titulo, e.tipo_area, e.fecha_inicio, e.fecha_fin
       FROM asignaciones_evaluacion a
       JOIN evaluaciones e ON a.id_evaluacion = e.id_evaluacion
       WHERE a.id_usuario = ?`,
      [id_usuario]
    );

    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener exámenes' });
  }
};

// Obtener preguntas y alternativas por examen
const getPreguntasPorExamen = async (req, res) => {
  const { id_evaluacion } = req.params;

  try {
    const [rows] = await pool.query(
      `SELECT p.id_pregunta, p.texto AS pregunta, p.puntaje,
       a.id_alternativa, a.texto AS alternativa, a.es_correcta
       FROM preguntas p
       JOIN alternativas a ON p.id_pregunta = a.id_pregunta
       WHERE p.id_evaluacion = ?`,
      [id_evaluacion]
    );

    // Agrupar alternativas por pregunta
    const preguntas = {};
    rows.forEach(row => {
      if (!preguntas[row.id_pregunta]) {
        preguntas[row.id_pregunta] = {
          id_pregunta: row.id_pregunta,
          texto: row.pregunta,
          puntaje: row.puntaje,
          alternativas: []
        };
      }
      preguntas[row.id_pregunta].alternativas.push({
        id_alternativa: row.id_alternativa,
        texto: row.alternativa,
        es_correcta: Boolean(row.es_correcta)
      });
    });

    res.json(Object.values(preguntas));
  } catch (error) {
    console.error(error);
    res.status(500).json({ error: 'Error al obtener preguntas' });
  }
};


const registrarRespuestasYCalcularPuntaje = async (req, res) => {
  const { id_usuario, id_evaluacion, respuestas } = req.body || {};

    if (!id_usuario || !id_evaluacion || !Array.isArray(respuestas)) {
      return res.status(400).json({ error: "Faltan datos obligatorios" });
        }

  console.log('Datos recibidos:', { id_usuario, id_evaluacion, respuestas });

  let connection;
  try {
    connection = await pool.getConnection();

    console.log('Conexión establecida');

    await connection.beginTransaction();

    console.log('Iniciando transacción');

    // Registrar intento
    const fecha_inicio = new Date();
    const fecha_fin = new Date();
    const estado = 'completado';

    console.log('Insertando intento...');
    const [intentoResult] = await connection.query(
      `INSERT INTO intentos_evaluacion 
       (id_usuario, id_evaluacion, fecha_inicio, fecha_fin, puntaje_obtenido, estado) 
       VALUES (?, ?, ?, ?, ?, ?)`,
      [id_usuario, id_evaluacion, fecha_inicio, fecha_fin, 0, estado]
    );

    const id_intento = intentoResult.insertId;

    console.log('Intento registrado con ID:', id_intento);

    let puntaje_total = 0;

// Procesar cada respuesta
for (const respuesta of respuestas) {
  const { id_pregunta, id_alternativa_seleccionada } = respuesta;

  await connection.query(
    `INSERT INTO respuestas_usuario 
     (id_intento, id_pregunta, id_alternativa_seleccionada) 
     VALUES (?, ?, ?)`,
    [id_intento, id_pregunta, id_alternativa_seleccionada]
  );

  // Verificar si la respuesta es correcta
  const [fila] = await connection.query(
    `SELECT es_correcta FROM alternativas WHERE id_alternativa = ?`,
    [id_alternativa_seleccionada]
  );

  if (fila[0]?.es_correcta === 1) {
    const [pregunta] = await connection.query(
      `SELECT puntaje FROM preguntas WHERE id_pregunta = ?`,
      [id_pregunta]
    );
    puntaje_total += parseFloat(pregunta[0].puntaje);
  }
}


if (puntaje_total > 20) {
  puntaje_total = 20;
}

// Actualizar puntaje total del intento
await connection.query(
  `UPDATE intentos_evaluacion SET puntaje_obtenido = ? WHERE id_intento = ?`,
  [puntaje_total, id_intento]
);

    console.log('Puntaje actualizado');

    await connection.commit();

    console.log('Transacción confirmada');

    res.json({
      mensaje: 'Respuestas registradas correctamente',
      puntaje_obtenido: puntaje_total
    });

  } catch (error) {
    if (connection) await connection.rollback();
    console.error('Error en la transacción:', error);
    res.status(500).json({ error: 'Error al procesar respuestas' });
  } finally {
    if (connection) connection.release();
    console.log('Conexión liberada');
  }
};

module.exports = {
  getExamenesPorAlumno,
  getPreguntasPorExamen,
  registrarRespuestasYCalcularPuntaje
};
