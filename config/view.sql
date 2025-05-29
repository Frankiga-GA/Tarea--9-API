-- a. ¿Cuántos alumnos desaprobados tenemos en total?

SELECT COUNT(DISTINCT id_usuario) AS alumnos_desaprobados
FROM intentos_evaluacion
WHERE estado = 'completado' AND puntaje_obtenido < 11;

-- b. ¿Cuántos alumnos aprobados en un determinado curso tenemos?

SELECT COUNT(DISTINCT id_usuario) AS alumnos_aprobados
FROM intentos_evaluacion
WHERE id_evaluacion = 1 AND estado = 'completado' AND puntaje_obtenido >= 11;


--c. ¿A cuántos exámenes está inscrito un alumno y cuántos de ellos están resueltos y pendientes?

SELECT 
    (SELECT COUNT(*) FROM asignaciones_evaluacion WHERE id_usuario = 2) AS total_asignados,
    (SELECT COUNT(DISTINCT id_evaluacion) 
     FROM intentos_evaluacion 
     WHERE id_usuario = 2 AND estado = 'completado') AS exámenes_resueltos,
    (SELECT COUNT(*) FROM asignaciones_evaluacion ae
     WHERE ae.id_usuario = 2
       AND ae.id_evaluacion NOT IN (
         SELECT DISTINCT id_evaluacion FROM intentos_evaluacion WHERE id_usuario = 2 AND estado = 'completado'
       )
    ) AS exámenes_pendientes;


-- d. ¿Cuál es la mejor y peor calificación de una determinada evaluación?}
SELECT 
    MAX(puntaje_obtenido) AS mejor_calificacion,
    MIN(puntaje_obtenido) AS peor_calificacion
FROM intentos_evaluacion
WHERE id_evaluacion = 1 AND estado = 'completado';

--e. ¿Cómo calcularíamos el promedio de calificaciones de un estudiante?

SELECT AVG(puntaje_obtenido) AS promedio_calificaciones
FROM intentos_evaluacion
WHERE id_usuario = 2 AND estado = 'completado';
