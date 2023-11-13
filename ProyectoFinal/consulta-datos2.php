<?php 
require 'include/funciones.php';
incluirTemplate('header');

?>


    <main class="contenedor">
        

        <div class="contendor-estetica">

            <header class="header">
                <h2 style="color: yellow;">Información</h2>
            </header>
            <center><div>
            <?php 
                require_once 'DAL/usuario2.php';
                RetorneUsuarios();
            ?>
            </div></center>


        </div>

    </main>

    <?php incluirTemplate('footer'); ?>