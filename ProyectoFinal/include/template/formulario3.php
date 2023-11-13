<!-- <div class="mb-3">
    <label class="form-label" for="nombre">Nombre del participante:</label>
    <input class="form-control" type="text" name="nombre" id="nombre" placeholder="Digite el nombre del participante"/>
</div>
<div class="mb-3">
    <label class="form-label" for="correo">Correo del participante:</label>
    <input class="form-control" type="email" name="correo" id="correo" placeholder="Digita el correo electrónico del participante"/>
</div>
<div class="mb-3">
    <label class="form-label" for="issue">Número de teléfono del participante:</label>
    <input class="form-control" type="text" name="tel" id="tel" placeholder="Digite el teléfono del participante"/>
</div> -->



<div class="d-flex flex-column min-vh-100 justify-content-center">
    <div class="container">
        <div class="row">
            <div class="col-sm-12 col-md-8 col-lg-6 mx-auto bg-white rounded shadow p-5">
                <div class="text-center mb-4">
                    <h1>Calendario de Actividades 2023"</h1>
                    <center>
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
                integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
                crossorigin="anonymous" referrerpolicy="no-referrer" />


                <i class="fa-solid fa-dharmachakra fa-spin fa-spin-reverse fa-4x" style="color: #000000;"></i>
        </center>
                    
                    <p>Clubes de Lectura</p>
                    <p class="small"> Puede ver la lista completa de clubes en el siguiente *<a href="Lista-Premios_2023.txt" download>enlace* </a></p>
                    <br><br>
                    <p>Charla con autores nacionales</p>
                    <p class="small"> Puede ver la lista completa de autores participantes en el siguiente *<a href="Lista-Premios_2023.txt" download>enlace* </a></p>
                    <br><br>
                    <p>Venta de ediciones especiales</p>
                    <p class="small"> Puede ver la lista completa de libros disponibles en el siguiente *<a href="Lista-Premios_2023.txt" download>enlace* </a></p>
                    <br><br>
                    <p>Para consultas adicionales por favor complete el formulario a continuación:</p>
                </div>
                <form action="#" class="needs-validation" novalidate>
                    <div class="mb-3">
                        <label class="form-label" for="nombre">Nombre completo:</label>
                        <input class="form-control" type="text" name="nombre" id="nombre" placeholder="Digite el nombre del participante" required/>
                        <div class="invalid-feedback">Por favor ingresa un nombre válido.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="correo">Correo electrónico:</label>
                        <input class="form-control" type="email" name="correo" id="correo" placeholder="Digita el correo electrónico del participante" required/>
                        <div class="invalid-feedback">Por favor ingresa un correo válido.</div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label" for="tel">Número de teléfono:</label>
                        <input class="form-control" type="tel" name="tel" id="tel" placeholder="Digite el teléfono del participante" required/>
                        <div class="invalid-feedback">Por favor ingresa un número de teléfono válido.</div>
                    </div>
                    <button class="btn btn-primary" type="submit">¡Enviar!</button>
                </form>
            </div>
        </div>
    </div>
</div>