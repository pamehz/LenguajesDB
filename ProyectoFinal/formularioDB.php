<?php 


require 'include/funciones.php';
incluirTemplate('header');

$errores = [];

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    require_once 'include/funciones/recogeRequest.php';

    $nombre = recogePost("nombre-completo");
    $correo = recogePost("correo");
    $telefono = recogePost("issue");

    $nombreOK = false;
    $correoOK = false;
    $telefonoOK = false;

    if($nombre === ""){
        $errores[] = "No digito el nombre del usuario";
    }else{
        $nombreOK = true;
    }

    if($correo === ""){
        $errores[] = "No digito el correo del usuario";
    }else{
        $correoOK = true;
    }

    if($issue === ""){
        $errores[] = "No digito el problema del usuario";
    }else{
        $issueOK = true;
    }


    if($nombreOK && $correoOK && $issueOK){
        //ingresar los datos a base de datos
        require_once 'DAL/usuario.php';
        if(InsercionUsuario($nombre, $issue, $correo)){
            header("Location: consulta-datos.php");
        }
    }
}

?>

    <main class="contenedor">
        <h1 class="text-white">Ferretería AW</h1>
        

        <div class="contendor-estetica">

            <header class="header">
                <h2 class="text-white">Formulario</h2>
                <center>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
                crossorigin="anonymous" referrerpolicy="no-referrer" />

                <i class="fa-solid fa-wrench fa-fade fa-4x" style="color: #000000;"></i>
        </center>
                
            </header>

            <?php foreach ($errores as $error): ?>
                <div class="alerta error">
                    <?php echo $error; ?>
                </div>
            <?php endforeach; ?>

            <form method="POST">
                

                <?php  incluirTemplate('formulario'); ?>

                <button type="submit">Procesar información</button>
            </form>

        </div>

    </main>

