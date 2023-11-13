<?php 
require 'include/funciones.php';
require 'include/funciones/recogeRequest.php';
incluirTemplate('header');

$id = recogeGet("id");
?>


    <main class="contenedor">
        <h1>Ferretería AW</h1>

        <div class="contendor-estetica">

            <header class="header">
                <h2>Detalles del participante</h2>
            </header>
            <div>
            <center><?php 
                require_once 'DAL/usuario3.php';
                RetorneUsuario($id);
            ?></center>
            </div>
        </div>

    </main>

<?php incluirTemplate('footer'); ?>