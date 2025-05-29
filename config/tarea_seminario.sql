
CREATE DATABASE tarea_seminario;
USE tarea_seminario;

-- USUARIOS
CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    apellido VARCHAR(100),
    correo VARCHAR(100) UNIQUE,
    tipo_usuario ENUM('alumno', 'administrador') DEFAULT 'alumno'
);

-- TABLA EVALUACIONES
CREATE TABLE evaluaciones (
    id_evaluacion INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(255),
    descripcion TEXT,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    tiempo_limite INT,
    tipo_area VARCHAR(100)
);

-- TABLA PREGUNTAS
CREATE TABLE preguntas (
    id_pregunta INT AUTO_INCREMENT PRIMARY KEY,
    id_evaluacion INT,
    texto TEXT,
    puntaje DECIMAL(5,2), -- Ejemplo: 2.0, 4.5, etc.
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones(id_evaluacion)
);

-- TABLA ALTERNATIVAS
CREATE TABLE alternativas (
    id_alternativa INT AUTO_INCREMENT PRIMARY KEY,
    id_pregunta INT,
    texto TEXT,
    es_correcta BOOLEAN,
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta)
);

-- TABLA ASIGNACIONES
CREATE TABLE asignaciones_evaluacion (
    id_asignacion INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_evaluacion INT,
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones(id_evaluacion)
);

-- TABLA INTENTOS
CREATE TABLE intentos_evaluacion (
    id_intento INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT,
    id_evaluacion INT,
    fecha_inicio DATETIME,
    fecha_fin DATETIME,
    puntaje_obtenido DECIMAL(5,2), -- Guarda el puntaje obtenido (0 a 20 aprox.)
    estado ENUM('completado', 'abandonado'),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario),
    FOREIGN KEY (id_evaluacion) REFERENCES evaluaciones(id_evaluacion)
);

-- TABLA RESPUESTAS
CREATE TABLE respuestas_usuario (
    id_respuesta INT AUTO_INCREMENT PRIMARY KEY,
    id_intento INT,
    id_pregunta INT,
    id_alternativa_seleccionada INT,
    FOREIGN KEY (id_intento) REFERENCES intentos_evaluacion(id_intento),
    FOREIGN KEY (id_pregunta) REFERENCES preguntas(id_pregunta),
    FOREIGN KEY (id_alternativa_seleccionada) REFERENCES alternativas(id_alternativa)
);