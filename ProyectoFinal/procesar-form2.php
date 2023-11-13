    <?php 
    require_once 'include/funciones/recogeRequest.php';

    $nombre = recogePost("nombre-completo");
    $correo = recogePost("correo");
    $issue = recogePost("issue");

    $nombreOK = false;
    $correoOK = false;
    $issueOK = false;

    $errores = [];

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
    }else {
        require_once 'formularioDB.php';
    }
?>
