<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-12 form-group ">
    <div class="row p-4">
        <div class="col-md-4">
            <button class="btn btn-info " onclick="ModalCrearSala();"><span class="material-icons">
                    add
                </span>
            </button>

        </div>
        <div class="col-md-4 justify-content-center">
            <center><h3 class="text-center  p-2 w-50  shadow   rounded">Salas</h3></center>
        </div>
    </div>


    <%
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        try {
            String ListarSalas = " SELECT c.IdCuarto, c.IdEmpleado,c.NombreCuarto ,c.Estado, e.Nombres "
                    + "FROM cuartos AS c "
                    + "INNER JOIN empleados AS e ON c.IdEmpleado = e.IdEmpleado";
            PreparedStatement ps = conn.prepareStatement(ListarSalas);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int Estado = rs.getInt("Estado");
                int IdCuarto = rs.getInt("IdCuarto");


    %>

    <div class="card"id="CardSala" style="width: 20rem; display: inline-block;  border-radius: 0.5em;border: black 1.5px inset;  cursor: pointer; margin-top: 3%;">
        <div class="card-header bg-info" style="border-radius: .5em;">
            <h5 class="card-title text-dark text-center">Sala:  <%=rs.getString("NombreCuarto")%></h5>
        </div>
        <div class="card-body">
            <h5 class="card-title text-dark">Doc. <%=rs.getString("Nombres")%></h5>
            <%
                if (Estado == 1) {
            %>
            <h5 class="card-title text-dark">Activo</h5>
            <%
            } else {
            %>
            <h5 class="card-title text-dark">Inactivo</h5>
            <%
                }
            %>
        </div>
        <div class="card-footer">
            <center>
                <div class="row justify-content-center">
                    <div class="col-md-5 form-group">
                        <span class="material-icons" onclick="ModalModificarSala(<%=IdCuarto%>)">
                            <button class="btn btn-warning">

                                create

                            </button>
                        </span>
                        <span class="material-icons">
                            <button class="btn btn-danger" onclick="EliminarSala(<%=IdCuarto%>)">

                                delete_forever

                            </button>
                        </span>
                    </div>
                </div>
            </center>
        </div>
    </div>

    <%
            }
        } catch (SQLException e) {
            System.out.println("e Crear Sala = " + e);
        }
    %>

</div>
<!--Inicio de Modal-->

<div class="modal " id="ModalSala">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" id="Crear">Crear Sala</h4>
                <h4 class="modal-title" id="Modificar">Modificar Sala</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-info btn-block" id="Btn1" onclick="GuardarSala();">Crear Sala</button>
                <button class="btn btn-info btn-block" id="Btn2" onclick="ModificarSala()">Modificar Sala</button>
            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        //Funcion para Buscar en el body de la tabla
        $("#myInput").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });
    function IrSalas() {
        $.ajax({
            url: "Salas.jsp",
            type: 'POST',
            success: function (response) {
                $("#Dv_Contenido").html(response);
            },
            error: function (error) {
                alertify.error('No se enconto la direccion');
            }
        });
    }

    function ModalCrearSala() {
        $.ajax({
            url: "Ajax/FrmCrearSala.jsp",
            type: 'POST',
            success: function (response) {
                $("#Modificar").hide();
                $("#Btn2").hide();
                $("#Crear").show();
                $("#Btn1").show();

                $("#ModalSala").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }

    function GuardarSala() {
        var Formulario = document.getElementById("FrmCrearSala");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmCrearSala").serialize();

            $.ajax({
                url: 'CrearSala',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Agregado correctamente");
                        $("#ModalSala").modal('hide');
                        IrSalas();
                    } else {
                        alertify.error("Ocurrio une error");
                    }
                },
                error: function (error) {
                    alertify.error("Ocurrio un error inesperado");
                }
            });
        }
    }

    function ModalModificarSala(IdSala) {
        $.ajax({
            url: "Ajax/FrmModificarSala.jsp",
            type: 'POST',
            data: {IdSala},
            success: function (response) {
                $("#Crear").hide();
                $("#Btn1").hide();

                $("#Modificar").show();
                $("#Btn2").show();

                $("#ModalSala").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }
    function ModificarSala(){
        var Formulario = document.getElementById('FrmModificarSala');
        if (Formulario.reportValidity()) {
            var FrmEnviar = $("#FrmModificarSala").serialize();
            $.ajax({
                url: "ModificarsSala",
                type: 'POST',
                data: FrmEnviar,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Modificado correctamente");
                        $("#ModalSala").modal('hide');
                        IrSalas();
                    } else {

                    }
                },
                error: function (error) {
                    alertify.error("No se encontro la direccion");
                }
            });
        }
    }
        function EliminarSala(IdSala) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "Se Inavilitar esta Sala!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Lo quiero Inavilitar!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'EliminarSala',
                    type: 'POST',
                    data: {IdSala},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Tu eliminacion se esta Procesando...Aceptar para Continuar').set({onclosing: function () {
                                         IrSalas();
                                }});
                        } else {
                            swal({
                                icon: 'error',
                                text: 'Error '
                            });
                            return false;
                        }

                    },
                    error: function (error) {
                        alert('No se encontro la direccion');
                    }
                });
            }
        });
    }
</script>