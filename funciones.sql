-- FUNCIONES --

-- Funcion que recibe el id de un turno y devuelve el nombre y apellido del medico y del paciente --
DELIMITER $$
CREATE FUNCTION info_turnos(id_turno_param INT)
RETURNS VARCHAR(100) deterministic
BEGIN
    DECLARE medico_nombre VARCHAR(100);
    DECLARE paciente_nombre VARCHAR(100);
    
    SELECT CONCAT(m.nombre, ' ', m.apellido)
    INTO medico_nombre
    FROM medico m
    INNER JOIN turno t ON m.id_medico = t.id_medico
    WHERE t.id_turno = id_turno_param;
    
    SELECT CONCAT(p.nombre, ' ', p.apellido)
    INTO paciente_nombre
    FROM paciente p
    INNER JOIN turno t ON p.id_paciente = t.id_paciente
    WHERE t.id_turno = id_turno_param;
    
    RETURN CONCAT('Médico: ', medico_nombre, ' || Paciente: ', paciente_nombre);
END $$
DELIMITER ;
-- Prueba info_turnos --
SELECT info_turnos(120);


-- Funcion que recibe el id del paciente, una fecha de inicio y otra de fin. Cuenta la cantidad de turnos del paciente entre esas fechas. --
DELIMITER $$
CREATE FUNCTION contar_turnos_por_paciente(
    id_paciente_param INT,
    fecha_inicio_param DATE,
    fecha_fin_param DATE
) RETURNS INT deterministic
BEGIN
    DECLARE cantidad_turnos INT;
SELECT 
    COUNT(*)
INTO cantidad_turnos FROM
    turno
WHERE
    id_paciente = id_paciente_param
        AND fecha_turno BETWEEN fecha_inicio_param AND fecha_fin_param;
    RETURN cantidad_turnos;
END $$
DELIMITER ;
-- prueba contar_turnos_por_paciente --
SELECT contar_turnos_por_paciente(5, '2000-01-01', '2022-12-31');
