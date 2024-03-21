-- TRIGGERS --

-- eliminar_historias_clinicas hace que antes de que se elimine un paciente, se borren todas sus historias clinicas relacionadas a el. --
DELIMITER $$
CREATE TRIGGER eliminar_historias_clinicas
BEFORE DELETE ON paciente
FOR EACH ROW
BEGIN
    DELETE FROM historia_clinica
    WHERE id_paciente = OLD.id_paciente;
END $$
DELIMITER ;


-- eliminar_medicos_por_servicios hace que antes de que se elimine un servicio, se borren todos sus medicos asociados a el. --
DELIMITER $$
CREATE TRIGGER eliminar_medicos_por_servicios
BEFORE DELETE ON servicio
FOR EACH ROW
BEGIN
    DELETE FROM medico
    WHERE id_servicio = OLD.id_servicio;
END $$
DELIMITER ;


-- actualizar_estado_servicio hace que despues de que se modifique el estado de una de las camillas, compare con las camillas de los servicios, y si no quedan camillas desocupadas cambie el estado del servicio de disponible a lleno o viceversa. --
DELIMITER $$
CREATE TRIGGER actualizar_estado_servicio AFTER INSERT ON cama
FOR EACH ROW
BEGIN
    DECLARE servicio_id INT;
    DECLARE cantidad_camas INT;
    DECLARE cantidad_camas_ocupadas INT;
    DECLARE nuevo_estado VARCHAR(20);

    SET servicio_id = NEW.id_servicio;
    SELECT COUNT(*) INTO cantidad_camas FROM cama WHERE id_servicio = servicio_id;
    SELECT COUNT(*) INTO cantidad_camas_ocupadas FROM cama WHERE id_servicio = servicio_id AND estado = true;
    IF cantidad_camas = cantidad_camas_ocupadas THEN
        SET nuevo_estado = 'Lleno';
    ELSE
        SET nuevo_estado = 'Disponible';
    END IF;
    UPDATE servicio SET estado = nuevo_estado WHERE id_servicio = servicio_id;
END; $$

DELIMITER ;