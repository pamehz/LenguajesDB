CREATE TABLE `usuarios`.`usuario` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `nombre` VARCHAR(50) NOT NULL,
    `tel` VARCHAR(50) NOT NULL,
    `correo` VARCHAR(50) NOT NULL,
    PRIMARY KEY (`id`)
) ENGINE = InnoDB;