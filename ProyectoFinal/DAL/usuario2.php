<?php

require_once "conexion2.php";

function InsercionUsuario($pNombre, $pIssue, $pCorreo) {
    $retorno = false;

    try {
        $conexion2 = Conecta();

        //formato de datos utf8
        if(mysqli_set_charset($conexion2, "utf8")){
            $stmt = $conexion2->prepare("insert into users(Nombre, Correo, Issue) values (?, ?, ?)");
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
        Desconecta($conexion2);
    }

    return $retorno;
}

function RetorneUsuarios() {
    try {
        
        $conexion2 = Conecta();
        
        $resultado = $conexion2->query("select id, Nombre, Correo, Issue from users");
        
        if($conexion2->error != ""){
            echo "Error al ejecutar la consulta: $conexion2->error";
        }

        //Mostrar los resultados de la consulta
        ImprimirDatos($resultado);

    } catch (\Throwable $th) {
        
    }finally{
        Desconecta($conexion2);
    }
}

function ImprimirDatos($datos)
{
    echo '<table style="border-collapse: collapse; width: 100%; border: 1px solid black;">';
    echo '<tr>';
    echo '<th style="border: 1px solid black; padding: 8px;">Nombre</th>';
    echo '<th style="border: 1px solid black; padding: 8px;">Correo</th>';
    echo '<th style="border: 1px solid black; padding: 8px;">Issue</th>';
    echo '</tr>';

    if ($datos->num_rows > 0) {
        while ($row = $datos->fetch_assoc()) {
            echo '<tr>';
            echo '<td style="border: 1px solid black; padding: 8px;">' . $row['Nombre'] . '</td>';
            echo '<td style="border: 1px solid black; padding: 8px;">' . $row['Correo'] . '</td>';
            echo '<td style="border: 1px solid black; padding: 8px;">' . $row['Issue'] . '</td>';
            echo '<td style="border: 1px solid black; padding: 8px;"><a href="mostrar2.php?id=' . $row['id'] . '">Mostrar</a></td>';
            echo '<td style="border: 1px solid black; padding: 8px;"><a href="?delete_id=' . $row['id'] . '">Delete</a></td>';
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
        $conexion2 = Conecta();
        //2. Ejecutar consulta
        $resultado = $conexion2->query("select id, Nombre, Correo, Issue from users where id = $id");
        
        if($conexion2->error != ""){
            echo "Ocurrió un error al ejecutar la consulta: $conexion2->error";
        }

        //Mostrar los resultados de la consulta
        $datos = $resultado->fetch_assoc();

        echo "El nombre es: {$datos['Nombre']} <br>";
        echo "El # de teléfono es: {$datos['Issue']} <br>";
        echo "El correo es: {$datos['Correo']} <br>";

        

    } catch (\Throwable $th) {
        echo "Ocurrió un error: " . $th->getMessage(); 
    }finally{
        Desconecta($conexion2);
    }
}

function delete($id) {
    $retorno = false;

    try {
        //1. Establecer conexión
        $conexion2 = Conecta();
        //2. Ejecutar consulta
        $stmt = $conexion2->prepare("DELETE FROM users WHERE id = ?");
        
        $stmt->bind_param("i", $id);

        if ($stmt->execute()) {
            $retorno = true;
            echo "Dato eliminado ->"; // Debugging message
        } else {
            echo "Error" . $conexion2->error; // Debugging message
        }

    } catch (\Throwable $th) {
        echo "Ocurrió un error: " . $th->getMessage(); 
    } finally {
        Desconecta($conexion2);
    }

    return $retorno;
}

// function ActualizarUsuario($id, $nuevoNombre, $nuevoTel, $nuevoCorreo) {
//     $retorno = false;

//     try {
//         //1. Establecer conexión
//         $conexion3 = Conecta();
//         //2. Ejecutar consulta
//         $stmt = $conexion3->prepare("UPDATE premios SET nombre = ?, correo = ?, tel = ? WHERE id = ?");
        
//         $stmt->bind_param("sssi", $nuevoNombre, $nuevoCorreo, $nuevoTel, $id);

//         if ($stmt->execute()) {
//             $retorno = true;
//             echo "Dato actualizado correctamente"; // Mensaje de éxito
//         } else {
//             echo "Error al actualizar el dato: " . $conexion3->error; // Mensaje de error
//         }

//     } catch (\Throwable $th) {
//         echo "Ocurrió un error: " . $th->getMessage(); 
//     } finally {
//         Desconecta($conexion3);
//     }

//     return $retorno;
// }







