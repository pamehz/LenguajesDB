<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <link rel='stylesheet' href='css/bootstrap.min.css'>
    <link rel='stylesheet' href='css/estilos.css'>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Staatliches&display=swap" rel="stylesheet">
    <title>Document</title>
</head>

<h1 style="color: white;">Ferretería AW</h1><br>

<body class="bg-primary bg-opacity-25">

    <main class="contenedor">
        <div class="nav-bg">
            <nav class="navegacion">

            <a class="navegacion__enlace navegacion__enlace--activo" href="index.html">Inicio |</a>
                <a class="navegacion__enlace" href="category.html">Categorías</a>
                <a class="navegacion__enlace" href="newform copy.html">| Ingresar</a>
                <a class="navegacion__enlace" href="Soporte2.html">| Soporte de Cuenta</a>
                <a class="navegacion__enlace" href="php/procesar-form2.php">| Soporte Avanzado</a>

            </nav>
        </div><br>
        <h1 style="color: white;">Soporte / Ayuda</h1>
        <center>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
                crossorigin="anonymous" referrerpolicy="no-referrer" />

                <i class="fa-solid fa-gear fa-5x" style="color: #000000;"></i>
        </center>
    </main>
    <main>
        <div class="contendor-estetica">

            <header class="header">
                <h2>Solicitud de Soporte / Datos ingresados</h2>
            </header>

            <p>Nombre completo: <?= $_POST['nombre-completo'] ?> </p>
            <p>Correo electrónico del asociado: <?= $_POST['correo'] ?> </p>
            <p>Problema descrito: <?= $_POST['issue'] ?> </p>

            <?= var_dump($_POST['contactos']); ?>

            <ul>
                <p>Contacto por: </p>
                <?php
                    foreach ($_POST['contactos'] as $contactos) {
                        echo "<li>$contactos</li>";
                    }
                ?>
            </ul>


            <p>Fecha: <?= $_POST['fecha'] ?> </p>

            <?php
                $date = new DateTime($_POST['fecha']);
                echo "<p>Fecha: " .$date->format('d-m-Y H:i:s') . "</p>" ;
            ?>

<?php
function ActualizarDatosArchivo($nombre, $correo, $issue, $contactos) {
    $archivo = fopen('datos.txt', 'w');
    if (!$archivo) {
        // Manejar el error si no se puede abrir el archivo
        echo "Error al abrir el archivo.";
        return;
    }

 

    $ContactoFormato = json_encode($contactos); // Usar JSON para formatear los contactos

 

    $datos = "$nombre,$correo,$issue,$ContactoFormato\n";

 

    fwrite($archivo, $datos);

 

    fclose($archivo);
}

 

function AgregarDatosArchivo($nombre, $correo, $issue, $contactos) {
    $archivo = fopen('datosAgregados.txt', 'a');
    if (!$archivo) {
        // Manejar el error si no se puede abrir el archivo
        echo "Error al abrir el archivo.";
        return;
    }

 

    $ContactoFormato = json_encode($contactos); // Usar JSON para formatear los contactos

 

    $datos = "$nombre,$correo,$issue,$ContactoFormato\n";

 

    fwrite($archivo, $datos);

 

    fclose($archivo);
}

 

function LeerArchivo($nombreArchivo) {
    try {
        $archivo = fopen($nombreArchivo, 'r');
        if (!$archivo) {
            // Manejar el error si no se puede abrir el archivo
            echo "Error al abrir el archivo.";
            return;
        }

 

        echo '<table border="1">';
        while (($linea = fgets($archivo)) != null) {
            $arregloValores = explode(',', $linea);
            echo '<tr>';
            foreach ($arregloValores as $valor) {
                echo "<td>$valor</td>";
            }
            echo '</tr>';
        }
        echo '</table>';

 

        fclose($archivo);
    } catch (\Throwable $th) {
        echo "Error al leer el archivo: " . $th->getMessage();
    }
}

 

// Obtener datos del formulario y llamar a las funciones
if ($_SERVER["REQUEST_METHOD"] === "POST") {
    $nombre = $_POST['nombre-completo'];
    $correo = $_POST['correo'];
    $issue = $_POST['issue'];
    $contactos = $_POST['contactos'];

 

    ActualizarDatosArchivo($nombre, $correo, $issue, $contactos);
    AgregarDatosArchivo($nombre, $correo, $issue, $contactos);
    LeerArchivo('datosAgregados.txt');
}
?>

            


        </div>

    </main>
</body>

</html>