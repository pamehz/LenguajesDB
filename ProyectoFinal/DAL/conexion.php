<?php

function Conecta() {
    $server = "localhost";
    $user = "root";
    $password = "";
    $dataBase = "usuarios";

    //1. Establecer la conexión con el motor de base de datos
    $conexion = mysqli_connect($server, $user, $password, $dataBase);

    if(!$conexion){
        echo "Error al establecer la conexión: " . mysqli_connect_error();
    }

    return $conexion;
}

function Desconecta($conexion) {
    // ultimo paso
    mysqli_close($conexion);
}