-- a. ¿Cuántos alumnos desaprobados tenemos en total?

SELECT COUNT(DISTINCT ie.id_usuario) AS alumnos_desaprobados
FROM intentos_evaluacion ie
WHERE ie.estado = 'completado' AND ie.puntaje_obtenido < 11;

-- b. ¿Cuántos alumnos aprobados en un determinado curso tenemos?

SELECT COUNT(DISTINCT id_usuario) AS alumnos_aprobados
FROM intentos_evaluacion
WHERE id_evaluacion = 1 
  AND estado = 'completado' 
  AND puntaje_obtenido >= 11;


--c. ¿A cuántos exámenes está inscrito un alumno y cuántos de ellos están resueltos y pendientes?
SELECT 
    (SELECT COUNT(*) 
     FROM asignaciones_evaluacion 
     WHERE id_usuario = 2) AS total_asignados,

    (SELECT COUNT(DISTINCT id_evaluacion) 
     FROM intentos_evaluacion 
     WHERE id_usuario = 2 AND estado = 'completado') AS examenes_resueltos,

    (SELECT COUNT(*) 
     FROM asignaciones_evaluacion ae
     WHERE ae.id_usuario = 2
       AND ae.id_evaluacion NOT IN (
           SELECT id_evaluacion 
           FROM intentos_evaluacion 
           WHERE id_usuario = 2 AND estado = 'completado'
       )
    ) AS examenes_pendientes;


-- d. ¿Cuál es la mejor y peor calificación de una determinada evaluación?}
SELECT 
    MAX(puntaje_obtenido) AS mejor_calificacion,
    MIN(puntaje_obtenido) AS peor_calificacion
FROM intentos_evaluacion
WHERE id_evaluacion = 1 AND estado = 'completado';

--e. ¿Cómo calcularíamos el promedio de calificaciones de un estudiante?
SELECT 
    a.nombre,
    a.apellido,
    ROUND(AVG(ie.puntaje_obtenido), 2) AS promedio_calificaciones
FROM intentos_evaluacion ie
JOIN alumnos a ON ie.id_usuario = a.id_usuario
WHERE ie.estado = 'completado'
  AND ie.id_usuario = 2
GROUP BY a.id_usuario;