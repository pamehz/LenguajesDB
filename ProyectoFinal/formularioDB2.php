<?php 


require 'include/funciones.php';
incluirTemplate('header');

$errores = [];

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    require_once 'include/funciones/recogeRequest.php';

    $Nombre = recogePost("nombre-completo");
    $Correo = recogePost("correo");
    $Issue = recogePost("issue");

    $NombreOK = false;
    $CorreoOK = false;
    $IssueOK = false;

    if($Nombre === ""){
        $errores[] = "No digito el nombre del usuario";
    }else{
        $NombreOK = true;
    }

    if($Correo === ""){
        $errores[] = "No digito el correo del usuario";
    }else{
        $CorreoOK = true;
    }

    if($Issue === ""){
        $errores[] = "No digito el problema del usuario";
    }else{
        $IssueOK = true;
    }


    if($NombreOK && $CorreoOK && $IssueOK){
        //ingresar los datos a base de datos
        require_once 'DAL/usuario2.php';
        if(InsercionUsuario($Nombre, $Issue, $Correo)){
            header("Location: consulta-datos2.php");
        }
    }
}

?>

    <main class="contenedor">
        <h1 class="text-white">Ferretería AW</h1>
        

        <div class="contendor-estetica">

            <header class="header">
                <h2 class="text-white">Formulario de Actualización</h2>
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
                

                <?php  incluirTemplate('formulario2'); ?>

                <button type="submit">Procesar información</button>
            </form>

        </div>

    </main>

