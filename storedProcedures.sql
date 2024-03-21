-- PROCEDIMIENTOS ALMACENADOS --

-- Se pasa por parametro el id del paciente y devuelve el listado de sus historias clinicas ordenadas por fecha --
DELIMITER $$
CREATE PROCEDURE obtener_historias_clinicas(IN id_paciente_param INT)
BEGIN
    SELECT *
    FROM historia_clinica
    WHERE id_paciente = id_paciente_param
    ORDER BY fecha;
END $$
DELIMITER ;
-- prueba de obtener_historias_clinicas --
CALL obtener_historias_clinicas(6);


-- Se pasa por parametro el id de la historia clinica y devuelve los datos del medico que la realizo --
DELIMITER $$
CREATE PROCEDURE obtener_medico_por_historia_clinica(IN historia_clinica_id INT)
BEGIN
    SELECT m.nombre, m.apellido
    FROM medico m
    INNER JOIN historia_clinica hc ON m.id_medico = hc.id_medico
    WHERE hc.id_historia_clinica = historia_clinica_id;
END $$
DELIMITER ;
-- prueba de obtener_historias_clinicas --
CALL obtener_medico_por_historia_clinica(123);
