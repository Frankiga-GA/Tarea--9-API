# 📚 Sistema de Evaluaciones - Base de Datos

---

## 📂 Descripción General

Esta base de datos está diseñada para un sistema académico que gestiona usuarios, evaluaciones, preguntas, alternativas, asignaciones y registros de intentos y respuestas. Está orientada a facilitar la administración y evaluación de alumnos en diferentes áreas del conocimiento.

---

## 🗃️ Estructura de la Base de Datos

### Base de datos principal: `tarea_seminario`

---

### Tablas

| Tabla                   | Descripción                                         | Clave Primaria       | Claves Foráneas                              |
|-------------------------|-----------------------------------------------------|----------------------|----------------------------------------------|
| **usuarios**            | Datos de usuarios (alumnos y administradores)       | `id_usuario`         | —                                            |
| **evaluaciones**        | Detalles de exámenes o pruebas                       | `id_evaluacion`      | —                                            |
| **preguntas**           | Preguntas asociadas a evaluaciones                   | `id_pregunta`        | `id_evaluacion` → `evaluaciones.id_evaluacion` |
| **alternativas**        | Opciones para cada pregunta, indica la correcta     | `id_alternativa`     | `id_pregunta` → `preguntas.id_pregunta`     |
| **asignaciones_evaluacion** | Relación entre usuarios y evaluaciones asignadas | `id_asignacion`      | `id_usuario` → `usuarios.id_usuario` <br> `id_evaluacion` → `evaluaciones.id_evaluacion` |
| **intentos_evaluacion** | Registro de intentos de usuarios en evaluaciones    | `id_intento`         | `id_usuario` → `usuarios.id_usuario` <br> `id_evaluacion` → `evaluaciones.id_evaluacion` |
| **respuestas_usuario**  | Respuestas seleccionadas en cada intento            | `id_respuesta`       | `id_intento` → `intentos_evaluacion.id_intento` <br> `id_pregunta` → `preguntas.id_pregunta` <br> `id_alternativa_seleccionada` → `alternativas.id_alternativa` |

---

## 👥 Usuarios

| id_usuario | Nombre  | Apellido | Correo              | Tipo Usuario   |
|------------|---------|----------|---------------------|----------------|
| 1          | Admin   | Principal| admin@example.com    | administrador  |
| 2          | Carlos  | Lopez    | carlos@example.com  | alumno         |
| ...        | ...     | ...      | ...                 | ...            |

*(Total 11 usuarios, 1 administrador y 10 alumnos)*

---

## 📋 Evaluaciones

| id_evaluacion | Título             | Descripción                    | Inicio              | Fin                  | Tiempo (min) | Área         |
|---------------|--------------------|-------------------------------|---------------------|----------------------|--------------|--------------|
| 1             | Matemáticas I      | Examen básico de matemáticas   | 2025-04-01 08:00:00 | 2025-04-05 18:00:00  | 60           | matemáticas  |
| 2             | Historia del Perú  | Examen sobre historia nacional | 2025-04-02 09:00:00 | 2025-04-06 17:00:00  | 60           | historia     |
| ...           | ...                | ...                           | ...                 | ...                  | ...          | ...          |

---

## ❓ Preguntas y Alternativas (Ejemplo: Matemáticas I)

| Pregunta ID | Evaluación | Texto                           | Puntaje |
|-------------|------------|--------------------------------|---------|
| 1           | 1          | ¿Cuánto es 2 + 2?              | 2       |
| 2           | 1          | ¿Cuál es la raíz cuadrada de 16?| 2      |
| ...         | ...        | ...                            | ...     |

### Alternativas para Pregunta 1

| ID Alternativa | Pregunta ID | Texto | Es Correcta |
|----------------|-------------|-------|-------------|
| 1              | 1           | 3     | No          |
| 2              | 1           | 4     | Sí          |
| 3              | 1           | 5     | No          |
| 4              | 1           | 6     | No          |

---

## 📊 Asignaciones de Evaluaciones

| Usuario (ID) | Evaluación (ID) |
|--------------|-----------------|
| 2 (Carlos)   | 1, 2, 3         |
| 3 (María)    | 1, 2, 3         |
| 6 (Andrés)   | 4, 5            |
| ...          | ...             |

---

## 📝 Intentos de Evaluación

| ID Intento | Usuario | Evaluación | Inicio                | Fin                   | Puntaje Obtenido | Estado      |
|------------|---------|------------|-----------------------|-----------------------|------------------|-------------|
| 1          | 2       | 1          | 2025-04-02 10:00:00   | 2025-04-02 10:45:00   | 9.5              | completado  |
| 2          | 3       | 1          | 2025-04-02 11:00:00   | 2025-04-02 11:45:00   | 15.0             | completado  |
| ...        | ...     | ...        | ...                   | ...                   | ...              | ...         |

---

## 📌 Consultas Ejemplos

- **Número total de desaprobados (puntaje < 11):**
  ```sql
  SELECT COUNT(*) AS total_desaprobados
  FROM intentos_evaluacion
  WHERE puntaje_obtenido < 11;
