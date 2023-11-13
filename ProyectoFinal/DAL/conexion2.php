<?php

function Conecta() {
    $server = "localhost";
    $user = "root";
    $password = "";
    $dataBase = "actualizados";

    //1. Establecer la conexión con el motor de base de datos
    $conexion2 = mysqli_connect($server, $user, $password, $dataBase);

    if(!$conexion2){
        echo "Error al establecer la conexión: " . mysqli_connect_error();
    }

    return $conexion2;
}

function Desconecta($conexion2) {
    // ultimo paso
    mysqli_close($conexion2);
}