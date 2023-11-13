    <?php 
    require_once 'include/funciones/recogeRequest.php';

    $nombre = recogePost("nombre");
    $correo = recogePost("correo");
    $tel = recogePost("tel");

    $nombreOK = false;
    $correoOK = false;
    $telOK = false;

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

    if($tel === ""){
        $errores[] = "No digito el problema del usuario";
    }else{
        $telOK = true;
    }

    if($nombreOK && $correoOK && $telOK){
        //ingresar los datos a base de datos
        require_once 'DAL/usuario3.php';
    if(InsercionUsuario($nombre, $tel, $correo)){
        header("Location: consulta-datos3.php");
    }
    }else {
        require_once 'formularioDB3.php';
    }
?>
