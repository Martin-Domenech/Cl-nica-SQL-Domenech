-- VISTAS --

-- Vista que muestra el servicio al que pertenece el medico --
CREATE OR REPLACE VIEW vista_medico_servicio AS
SELECT m.id_medico, s.nombre_servicio
FROM medico m
JOIN servicio s ON m.id_servicio = s.id_servicio;

-- Vista que muestra la cantidad de medicos en un servicio --
CREATE OR REPLACE VIEW vista_cantidad_medicos_por_servicio AS
SELECT s.id_servicio, s.nombre_servicio, COUNT(m.id_medico) AS cantidad_medicos
FROM servicio s
LEFT JOIN medico m ON s.id_servicio = m.id_servicio
GROUP BY s.id_servicio, s.nombre_servicio;

-- Vista que muestra los turnos con su correspondiente horario, el paciente que lo solicito y el medico asignado. --
CREATE VIEW vista_turnos_detalle AS
SELECT t.id_turno, t.fecha_turno, t.hora_turno,
       p.nombre AS nombre_paciente, p.apellido AS apellido_paciente,
       m.nombre AS nombre_medico, m.apellido AS apellido_medico
FROM turno t
INNER JOIN paciente p ON t.id_paciente = p.id_paciente
INNER JOIN medico m ON t.id_medico = m.id_medico;

-- Vista que muestra la cantidad de camas disponibles por servicio. --
CREATE VIEW vista_camas_disponibles AS
SELECT s.nombre_servicio, COUNT(c.id_cama) AS camas_disponibles
FROM servicio s
LEFT JOIN cama c ON s.id_servicio = c.id_servicio AND c.estado = 0
GROUP BY s.id_servicio;

-- Vista que muestra la cantidad de consultas y de pacientes atendidos por cada medico (un paciente puede tener mas de una consulta y se cuanta como un paciente atendido) --
CREATE VIEW vista_turnos_medicos AS
SELECT m.id_medico, CONCAT(m.nombre, ' ', m.apellido) AS nombre_medico,
       COUNT(t.id_turno) AS total_consultas,
       COUNT(DISTINCT t.id_paciente) AS pacientes_atendidos
FROM medico m
LEFT JOIN turno t ON m.id_medico = t.id_medico
GROUP BY m.id_medico;