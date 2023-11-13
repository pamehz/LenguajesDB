<?php

function Conecta() {
    $server = "localhost";
    $user = "root";
    $password = "";
    $dataBase = "rifa";

    //1. Establecer la conexión con el motor de base de datos
    $conexion3 = mysqli_connect($server, $user, $password, $dataBase);

    if(!$conexion3){
        echo "Error al establecer la conexión: " . mysqli_connect_error();
    }

    return $conexion3;
}

function Desconecta($conexion3) {
    // ultimo paso
    mysqli_close($conexion3);
}