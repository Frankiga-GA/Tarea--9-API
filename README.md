📚 Sistema de Evaluaciones - Base de Datos
📂 Descripción General
Esta base de datos está diseñada para un sistema académico que gestiona alumnos, evaluaciones, preguntas, alternativas de respuesta, asignaciones de pruebas, intentos de exámenes, y respuestas marcadas. Su propósito es facilitar el seguimiento y análisis del rendimiento de los alumnos en diversas áreas del conocimiento.

🗃️ Estructura de la Base de Datos
Base de datos principal: tarea_seminario
Tablas
Tabla	Descripción	Clave Primaria	Claves Foráneas
alumnos	Información básica de los alumnos	id_usuario	—
evaluaciones	Datos generales de cada evaluación	id_evaluacion	—
preguntas	Preguntas asociadas a cada evaluación	id_pregunta	id_evaluacion → evaluaciones.id_evaluacion
alternativas	Opciones por pregunta, incluyendo cuál es la correcta	id_alternativa	id_pregunta → preguntas.id_pregunta
asignaciones_evaluacion	Evaluaciones asignadas a cada alumno	id_asignacion	id_usuario → alumnos.id_usuario
id_evaluacion → evaluaciones.id_evaluacion
intentos_evaluacion	Registro de intentos de evaluación por cada alumno	id_intento	id_usuario → alumnos.id_usuario
id_evaluacion → evaluaciones.id_evaluacion
respuestas_usuario	Alternativas marcadas por el alumno durante un intento	id_respuesta	id_intento → intentos_evaluacion.id_intento
id_pregunta → preguntas.id_pregunta
id_alternativa_seleccionada → alternativas.id_alternativa

👥 Alumnos
id_usuario	Nombre	Apellido	Correo
1	Carla	Sánchez	carla@example.com
2	Luis	Ramos	luis@example.com
3	Ana	Torres	ana@example.com
...	...	...	...

(Todos los usuarios son alumnos — no se usa un campo de rol o tipo.)

📋 Evaluaciones
id_evaluacion	Título	Descripción	Inicio	Fin	Tiempo (min)	Área
1	Matemáticas Básicas	Evaluación sobre operaciones	2025-06-05 08:00:00	2025-06-10 18:00:00	60	Matemáticas
2	Historia del Perú	Línea de tiempo y eventos clave	2025-06-06 09:00:00	2025-06-11 17:00:00	60	Historia
...	...	...	...	...	...	...

❓ Preguntas y Alternativas (Ejemplo: Evaluación 1)
Preguntas
id_pregunta	id_evaluacion	Texto	Puntaje
1	1	¿Cuánto es 5 + 7?	2.00
2	1	¿Resultado de 8 × 6?	2.00

Alternativas para Pregunta 1
id_alternativa	id_pregunta	Texto	¿Es Correcta?
1	1	11	No
2	1	12	Sí
3	1	13	No
4	1	14	No

📊 Asignaciones de Evaluaciones
Alumno (ID)	Evaluaciones Asignadas
1 (Carla)	1, 2
2 (Luis)	1, 3
3 (Ana)	2
...	...

📝 Intentos de Evaluación
id_intento	Alumno	Evaluación	Fecha Inicio	Fecha Fin	Puntaje	Estado
1	1	1	2025-06-06 10:00:00	2025-06-06 10:45:00	10.5	completado
2	2	1	2025-06-07 11:00:00	2025-06-07 11:35:00	16.0	completado
3	1	2	2025-06-08 09:30:00	2025-06-08 10:20:00	8.0	completado


