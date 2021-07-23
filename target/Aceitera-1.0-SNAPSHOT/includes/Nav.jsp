
<%@include file="heder.jsp" %>
<nav class="navbar navbar-expand-lg navbar-light bg-light border" >
    <button id="menu-toggle" class="btn btn-success"  >
        <span class="material-icons">
            menu
        </span>
    </button>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarTogglerDemo02" aria-controls="navbarTogglerDemo02" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse " id="navbarTogglerDemo02">
        <ul class="navbar-nav ml-auto">
            <%
                String Foto = (String) session.getAttribute("Foto");
                if (Foto != null) {
                    System.out.println("Foto = " + Foto);
            %>
            <img  class="FotoPerfil" src="img/Fotos/<%=Foto%>" alt="Sin Foto">
            <%
            } else if(Foto == null){
            %>
            <img src="img/SinFoto.jpg" class="FotoPerfil">
            <%
                }
            %>

            <li class="nav-item dropdown">

                <a class="nav-link dropdown-toggle" data-toggle="dropdown" href="#" id="categories" aria-expanded="true">
                    <%= session.getAttribute("Nombre")%>
                    <span class="caret"></span></a>
                <div class="dropdown-menu" aria-labelledby="categories">
                    <a class="dropdown-item" href="#" onclick="MiPerfil()">Mi Perfil</a>
                    <div class="dropdown-divider"></div>

                    <a class="dropdown-item" onclick="CerrarSesion()">Cerrar Sesion</a>

                </div>
            </li>




            <li class="nav-item">
              
            </li>

        </ul>

    </div>
</nav>

<div class="modal " id="ModalPerfil">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" id="Titulo1">Mis Datos</h4>

                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body">
                <form>
                    <div class="row justify-content-center">
                        <div class="col-md-8 form-group">
                            <center>

                                <%
                                    String Foto2 = (String) session.getAttribute("Foto");
                                    if (Foto != null) {
                                        System.out.println("Fotodfs = " + Foto);
                                %>
                                <img  class="FotoPerfil2" src="img/Fotos/<%=Foto2%>" alt="Sin Foto">
                                <%
                                } else if(Foto == null) {
                                %>
                                <img src="img/SinFoto.jpg" class="FotoPerfil2">
                                <%
                                    }
                                %>
                            </center>
                        </div>
                    </div>  
                    <div class="row justify-content-center">
                        <div class="col-md-3 form-group">
                            <label>Nombre Completo</label>
                            <input class="form-control"  readonly  value="<%= session.getAttribute("Nombre")%>">
                        </div>
                        <div class="col-md-3 form-group">
                            <label>Usuario</label>
                            <input class="form-control" readonly value="<%= session.getAttribute("Usuario")%>">
                        </div>
                        <div class="col-md-3 form-group">
                            <label>Direccion</label>
                            <input class="form-control" readonly value="<%= session.getAttribute("Direccion")%>">
                        </div>
                        <div class="col-md-3 form-group">
                            <label>Rol</label>
                            <input class="form-control" readonly value="<%= session.getAttribute("Descripcion")%>">
                        </div>
                    </div>
                    <div class="row justify-content-center">
                        <div class="col-md-4 form-group">
                            <label>DPI</label>
                            <input class="form-control" readonly value="<%= session.getAttribute("DPI")%>">
                        </div>
                        <div class="col-md-4 form-group">
                            <label>FechaNacimiento</label>
                            <input class="form-control" readonly value="<%= session.getAttribute("FechaNacimiento")%>">
                        </div>
                        <div class="col-md-4 form-group">
                            <label>Telefono</label>
                            <input class="form-control" readonly value="<%= session.getAttribute("Telefono")%>">
                        </div>
                    </div>
                </form>
            </div>

            <!-- Modal footer -->


        </div>
    </div>
</div>
<script>

    //Funcion para Abri y cerrar el Menu 
    $("#menu-toggle").click(function (e) {
        e.preventDefault();
        $('#sidebar-container').toggleClass("ml-0");


    });

    function MiPerfil() {
        $.ajax({

            success: function () {


                $("#ModalPerfil").modal('show');

            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }

    function CerrarSesion() {
        $.ajax({
            url: "CerrarSesion",   
            type: 'POST',
            success: function () {
                        location.reload();
                    },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }

</script>