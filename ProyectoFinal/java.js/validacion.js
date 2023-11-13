document.getElementById("validacion").addEventListener("submit", function(event) {
    var nombre = document.getElementById("nombre").value;
    var password = document.getElementById("password").value;
    var departamento = document.getElementById("departamento").value;
    
  
    if (!nombre || !email || !mensaje || !telefono) {
    //   alert("Por favor, complete todos los campos del formulario.");
      event.preventDefault();


      var advertenciaDiv = document.getElementById("advertencia");
      advertenciaDiv.innerHTML = "Por favor, complete todos los campos del formulario.";
      advertenciaDiv.style.display = "block";
      advertenciaDiv.style.backgroundColor = "red";
      advertenciaDiv.style.color = "white";
      advertenciaDiv.style.padding = "10px";
      advertenciaDiv.style.marginBottom = "10px";

      setTimeout(function() {
        advertenciaDiv.style.display = "none";
      }, 5000);
    }
  });
  