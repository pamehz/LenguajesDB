    <?php 
    require_once 'include/funciones/recogeRequest.php';

    $Nombre = recogePost("nombre-completo");
    $Correo = recogePost("correo");
    $Issue = recogePost("issue");

    $NombreOK = false;
    $CorreoOK = false;
    $IssueOK = false;

    $errores = [];

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
    }else {
        require_once 'formularioDB2.php';
    }
?>
