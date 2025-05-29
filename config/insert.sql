
-- INSERTAR USUARIOS
INSERT INTO usuarios (nombre, apellido, correo, tipo_usuario) VALUES
('Admin', 'Principal', 'admin@example.com', 'administrador'),
('Carlos', 'Lopez', 'carlos@example.com', 'alumno'),
('Maria', 'Garcia', 'maria@example.com', 'alumno'),
('Javier', 'Perez', 'javier@example.com', 'alumno'),
('Lucia', 'Torres', 'lucia@example.com', 'alumno'),
('Andres', 'Romero', 'andres@example.com', 'alumno'),
('Camila', 'Diaz', 'camila@example.com', 'alumno'),
('Sofia', 'Flores', 'sofia@example.com', 'alumno'),
('Diego', 'Mendez', 'diego@example.com', 'alumno'),
('Valeria', 'Ruiz', 'valeria@example.com', 'alumno'),
('Fernando', 'Ortega', 'fernando@example.com', 'alumno');

-- INSERTAR EVALUACIONES
INSERT INTO evaluaciones (titulo, descripcion, fecha_inicio, fecha_fin, tiempo_limite, tipo_area) VALUES
('Matemáticas I', 'Examen básico de matemáticas', '2025-04-01 08:00:00', '2025-04-05 18:00:00', 60, 'matematicas'),
('Historia del Perú', 'Examen sobre historia nacional', '2025-04-02 09:00:00', '2025-04-06 17:00:00', 60, 'historia'),
('Ciencias Naturales', 'Preguntas sobre biología y física', '2025-04-03 10:00:00', '2025-04-07 16:00:00', 60, 'ciencias'),
('Gramática y Redacción', 'Prueba de comprensión lectora y gramática', '2025-04-04 11:00:00', '2025-04-08 15:00:00', 60, 'literatura'),
('Tecnología', 'Conocimientos básicos de informática', '2025-04-05 12:00:00', '2025-04-09 14:00:00', 60, 'tecnologia');

-- INSERTAR PREGUNTAS Y ALTERNATIVAS (ejemplo para Matemáticas I)
INSERT INTO preguntas (id_evaluacion, texto, puntaje) VALUES
(1, '¿Cuánto es 2 + 2?', 2),
(1, '¿Cuál es la raíz cuadrada de 16?', 2),
(1, '¿Qué número falta en 3 + _ = 7?', 2),
(1, '¿Cuánto es 5 * 6?', 2),
(1, '¿Cuál es el resultado de 10 / 2?', 2);

INSERT INTO alternativas (id_pregunta, texto, es_correcta) VALUES
(1, '3', 0), (1, '4', 1), (1, '5', 0), (1, '6', 0),
(2, '4', 1), (2, '5', 0), (2, '6', 0), (2, '7', 0),
(3, '3', 0), (3, '4', 1), (3, '5', 0), (3, '6', 0),
(4, '25', 0), (4, '30', 1), (4, '35', 0), (4, '40', 0),
(5, '5', 1), (5, '6', 0), (5, '7', 0), (5, '8', 0);

-- REPETIR PARA LAS OTRAS EVALUACIONES (se omite por brevedad, pero se sigue el mismo patrón)

-- INSERTAR ASIGNACIONES
-- Carlos, María, Javier, Lucía -> 3 exámenes
INSERT INTO asignaciones_evaluacion (id_usuario, id_evaluacion) VALUES
(2, 1), (2, 2), (2, 3),
(3, 1), (3, 2), (3, 3),
(4, 1), (4, 2), (4, 3),
(5, 1), (5, 2), (5, 3);

-- Andrés, Camila, Sofía -> 2 exámenes
INSERT INTO asignaciones_evaluacion (id_usuario, id_evaluacion) VALUES
(6, 4), (6, 5),
(7, 4), (7, 5),
(8, 4), (8, 5);

-- Diego, Valeria, Fernando no tienen asignaciones

-- INSERTAR INTENTOS SIMULADOS (7 alumnos)
INSERT INTO intentos_evaluacion (id_usuario, id_evaluacion, fecha_inicio, fecha_fin, puntaje_obtenido, estado) VALUES
(2, 1, '2025-04-02 10:00:00', '2025-04-02 10:45:00', 9.5, 'completado'), -- Carlos - Desaprobado
(3, 1, '2025-04-02 11:00:00', '2025-04-02 11:45:00', 15.0, 'completado'), -- María - Aprobado
(4, 1, '2025-04-02 12:00:00', '2025-04-02 12:45:00', 10.0, 'completado'), -- Javier - Desaprobado
(5, 1, '2025-04-02 13:00:00', '2025-04-02 13:45:00', 18.0, 'completado'), -- Lucía - Aprobado
(6, 4, '2025-04-03 09:00:00', '2025-04-03 09:50:00', 12.0, 'completado'), -- Andrés - Aprobado
(7, 4, '2025-04-03 10:00:00', '2025-04-03 10:50:00', 9.0, 'completado'), -- Camila - Desaprobado
(8, 4, '2025-04-03 11:00:00', '2025-04-03 11:50:00', 14.0, 'completado'); -- Sofía - Aprobado

-- INSERTAR RESPUESTAS SELECCIONADAS (ejemplo)
INSERT INTO respuestas_usuario (id_intento, id_pregunta, id_alternativa_seleccionada) VALUES
(1, 1, 2), (1, 2, 5), (1, 3, 8), (1, 4, 12), (1, 5, 17), -- Carlos
(2, 1, 2), (2, 2, 5), (2, 3, 9), (2, 4, 11), (2, 5, 17), -- María
(3, 1, 1), (3, 2, 5), (3, 3, 8), (3, 4, 12), (3, 5, 16); -- Javier
