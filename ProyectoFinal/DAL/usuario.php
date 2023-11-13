<?php

require_once "conexion.php";

function InsercionUsuario($pNombre, $pIssue, $pCorreo) {
    $retorno = false;

    try {
        $conexion = Conecta();

        //formato de datos utf8
        if(mysqli_set_charset($conexion, "utf8")){
            $stmt = $conexion->prepare("insert into usuario(nombre, correo, issue) values (?, ?, ?)");
            $stmt->bind_param("sss", $iNombre, $iCorreo, $iIssue);

            //set parametros y ejecutar
            $iNombre = $pNombre;
            $iCorreo = $pCorreo;
            $iIssue = $pIssue;

            if($stmt->execute()){
                $retorno = true;
            }
        }
    } catch (\Throwable $th) {
        
    }finally{
        Desconecta($conexion);
    }

    return $retorno;
}

function RetorneUsuarios() {
    try {
        
        $conexion = Conecta();
        
        $resultado = $conexion->query("select id, nombre, correo, issue from usuario");
        
        if($conexion->error != ""){
            echo "Error al ejecutar la consulta: $conexion->error";
        }

        //Mostrar los resultados de la consulta
        ImprimirDatos($resultado);

    } catch (\Throwable $th) {
        
    }finally{
        Desconecta($conexion);
    }
}

function ImprimirDatos($datos)
{
    echo '<table style="border-collapse: collapse; width: 100%; border: 1px solid black;">';
    echo '<tr>';
    echo '<th style="border: 1px solid black; padding: 8px;">Nombre</th>';
    echo '<th style="border: 1px solid black; padding: 8px;">Correo</th>';
    echo '<th style="border: 1px solid black; padding: 8px;">Problema</th>';
    echo '</tr>';

    if ($datos->num_rows > 0) {
        while ($row = $datos->fetch_assoc()) {
            echo '<tr>';
            echo '<td style="border: 1px solid black; padding: 8px;">' . $row['nombre'] . '</td>';
            echo '<td style="border: 1px solid black; padding: 8px;">' . $row['correo'] . '</td>';
            echo '<td style="border: 1px solid black; padding: 8px;">' . $row['issue'] . '</td>';
            echo '<td style="border: 1px solid black; padding: 8px;"><a href="mostrar.php?id=' . $row['id'] . '">Mostrar</a></td>';
            echo '<td style="border: 1px solid black; padding: 8px;"><a href="?delete_id=' . $row['id'] . '">Delete</a></td>';
            echo '<td style="border: 1px solid black; padding: 8px;"><a href="procesar-form4.php">Actualizar</a></td>';
            echo '</tr>';
        }
    } else {
        echo '<tr><td colspan="4" style="border: 1px solid black; padding: 8px; text-align: center;">No hay registros de usuarios</td></tr>';
    }

    echo '</table>';

    if (isset($_GET['delete_id'])) {
        $idToDelete = $_GET['delete_id'];
        
        if (delete($idToDelete)) {
            echo "El registro con ID $idToDelete se ha eliminado exitosamente de la tabla";
        } else {
            echo "Error eliminando el usuario con ID $idToDelete.";
        }
    }
}

function RetorneUsuario($id) {
    try {
        //1. Establecer conexión
        $conexion = Conecta();
        //2. Ejecutar consulta
        $resultado = $conexion->query("select id, nombre, correo, issue from usuario where id = $id");
        
        if($conexion->error != ""){
            echo "Ocurrió un error al ejecutar la consulta: $conexion->error";
        }

        //Mostrar los resultados de la consulta
        $datos = $resultado->fetch_assoc();

        echo "El nombre es: {$datos['nombre']} <br>";
        echo "El problema presentado es: {$datos['issue']} <br>";
        echo "El correo es: {$datos['correo']} <br>";

        

    } catch (\Throwable $th) {
        echo "Ocurrió un error: " . $th->getMessage(); 
    }finally{
        Desconecta($conexion);
    }
}

function delete($id) {
    $retorno = false;

    try {
        //1. Establecer conexión
        $conexion = Conecta();
        //2. Ejecutar consulta
        $stmt = $conexion->prepare("DELETE FROM usuario WHERE id = ?");
        
        $stmt->bind_param("i", $id);

        if ($stmt->execute()) {
            $retorno = true;
            echo "Dato eliminado ->"; // Debugging message
        } else {
            echo "Error" . $conexion->error; // Debugging message
        }

    } catch (\Throwable $th) {
        echo "Ocurrió un error: " . $th->getMessage(); 
    } finally {
        Desconecta($conexion);
    }

    return $retorno;
}

function ActualizarUsuario($id, $nuevoNombre, $nuevoIssue, $nuevoCorreo) {
    $retorno = false;

    try {
        //1. Establecer conexión
        $conexion = Conecta();
        //2. Ejecutar consulta
        $stmt = $conexion->prepare("UPDATE usuario SET nombre = ?, correo = ?, issue = ? WHERE id = ?");
        
        $stmt->bind_param("sssi", $nuevoNombre, $nuevoCorreo, $nuevoIssue, $id);

        if ($stmt->execute()) {
            $retorno = true;
            echo "Dato actualizado correctamente"; // Mensaje de éxito
        } else {
            echo "Error al actualizar el dato: " . $conexion->error; // Mensaje de error
        }

    } catch (\Throwable $th) {
        echo "Ocurrió un error: " . $th->getMessage(); 
    } finally {
        Desconecta($conexion);
    }

    return $retorno;
}







