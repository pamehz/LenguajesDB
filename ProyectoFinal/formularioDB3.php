<?php 


require 'include/funciones.php';
incluirTemplate('header');

$errores = [];

if($_SERVER['REQUEST_METHOD'] === 'POST'){
    require_once 'include/funciones/recogeRequest.php';

    $nombre = recogePost("nombre");
    $correo = recogePost("correo");
    $tel = recogePost("tel");

    $nombreOK = false;
    $correoOK = false;
    $telOK = false;

    if($nombre === ""){
        $errores[] = "No digito el nombre del participante";
    }else{
        $nombreOK = true;
    }

    if($correo === ""){
        $errores[] = "No digito el correo del participante";
    }else{
        $correoOK = true;
    }

    if($tel === ""){
        $errores[] = "No digito el problema del participante";
    }else{
        $telOK = true;
    }


    if($nombreOK && $correoOK && $telOK){
        //ingresar los datos a base de datos
        require_once 'DAL/usuario3.php';
        if(InsercionUsuario($nombre, $tel, $correo)){
            header("Location: consulta-datos3.php");
        }
    }
}

?>

    <main class="contenedor">
        <h1 class="text-white">Librería LBD</h1>
        

        <div class="contendor-estetica">

            <header class="header">
                <h2 class="text-white">Sección de Información <i class="fa-solid fa-sitemap fa-fade fa-1x" style="color: #000000;"></i></h2><br><br><br>
                <div>
                    <center>
                        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                        integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
                        crossorigin="anonymous" referrerpolicy="no-referrer" />

                        
                    </center>
                </div>
                
            </header>

            <?php foreach ($errores as $error): ?>
                <div class="alerta error">
                    <?php echo $error; ?>
                </div>
            <?php endforeach; ?>

            <form method="POST">
                

                <?php  incluirTemplate('formulario3'); ?>

                <button type="submit">Participar</button>
            </form>

        </div>

    </main>

