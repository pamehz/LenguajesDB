var nombre = document.getElementById("nombre");
var password = document.getElementById("password");
var work = document.getElementById("work");
var error = document.getElementById("error");
var boton = document.getElementById("envio");
error.style.color = 'red';

// Alternativa de enviar form

// function enviarForm() {
//     console.log('Enviando Formulario...');

//     var msjserror = [];

//     if (nombre.value === null || nombre.value === '') {
//         msjserror.push('¡Por favor ingrese su nombre!')
//     }

//     if (password.value === null || password.value === '') {
//         msjserror.push('¡Por favor ingrese su contraseña/password!')
//     }

//     if (work.value === null || work.value === '') {
//         msjserror.push('¡Por favor ingrese el departamento o área en que labora!')
//     }

//     error.innerHTML = msjserror.join(', ');

//     return false;



// }

function enviarForm() {
    
    window.location.href = "index.html";
}

var form = document.getElementById('validacion');
    form.addEventListener('submit', function (evt) {
        

    evt.preventDefault();
    var msjserror = [];

    if (nombre.value === null || nombre.value === '') {
        msjserror.push('¡Por favor ingrese su nombre!')
    }

    if (password.value === null || password.value === '') {
        msjserror.push('¡Por favor ingrese su contraseña/password!')
    }

    if (email.value === null || email.value === '') {
        msjserror.push('¡Por favor ingrese su correo electrónico')
    }

    error.innerHTML = msjserror.join(', ');
});

// Alternativa de encriptar contraseña

// function encriptar() {
//     var input_pass = document.getElementById("password");
//     input_pass.value = validacion_copy(input_pass.value)
// }

