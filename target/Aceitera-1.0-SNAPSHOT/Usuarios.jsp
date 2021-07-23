<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-12 form-group">
    <div class="row">
        <div class="col-md-4">
            <button class="btn btn-info " onclick="ModalCrearUsua();"><span class="material-icons">
                    add
                </span>
            </button>

        </div>
        <div class="col-md-4 justify-content-center">
            <h3 class="text-center  p-2 w-50  shadow   rounded">Usuarios</h3>
        </div>
    </div>
    <input class="form-control mt-3" id="myInput" type="text" placeholder="Buscar..">
    <center>
        <table style="padding-left: 25%;" class="table table-hover table-primary mt-3 table-responsive" id="TablaUsuario">
            <thead>
            <th>ID</th>
            <th>Usuario</th>
            <th>Nombre</th>
            <th>Apellido</th>           
            <th>Estado</th>
            <th>Editar</th>
            <th>Eliminar</th>
            </thead>
            <tbody id="myTable">
                <%
                    Conexion conex = new Conexion();
                    Connection conn = conex.getConnection();
                    try {
                        String ListarUsuarios = "SELECT u.IdUsuario, u.Usuario, e.Nombres, e.Apellidos , u.Estado "
                                + "FROM usuarios AS u "
                                + "LEFT JOIN empleados AS e ON u.IdUsuario = e.IdUsuario";
                        PreparedStatement ps = conn.prepareStatement(ListarUsuarios);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                            int Estado = rs.getInt("Estado");
                            int IdUsuario = rs.getInt("IdUsuario");
                            String Nombre = rs.getString("Nombres");
                            String Apellidos = rs.getString("Nombres");
                %>     
                <tr>
                    <td><%=rs.getString("IdUsuario")%></td>
                    <td><%=rs.getString("Usuario")%></td>
                    <%
                        if (Nombre == null) {
                    %>
                    <td>..</td>
                    <%
                    } else {
                    %>
                    <td><%=rs.getString("Nombres")%></td>

                    <%
                        }
                    %>

                    <%
                        if (Apellidos == null) {
                    %>
                    <td>..</td>
                    <%
                    } else {
                    %>
                    <td><%=rs.getString("Apellidos")%></td>

                    <%
                        }
                    %>



                    <td>
                        <%
                            if (Estado == 1) {
                        %>
                        Activo
                        <%
                        } else if (Estado == 0) {
                        %>
                        Inactivo
                        <%
                        } else if (Estado == 2) {

                        %>
                        Ocupado
                        <%                        }
                        %>  
                    </td>
                    <td>
                        <span class="material-icons">
                            <button class="btn btn-warning" onclick="ModalModificarUsua(<%=IdUsuario%>)">

                                create

                            </button>
                        </span>
                    </td>
                    <td>
                        <span class="material-icons">
                            <button class="btn btn-danger" onclick="EliminarUsuario(<%=IdUsuario%>);">

                                delete_forever

                            </button>
                        </span>
                    </td>   
                </tr>  
                <%
                        }
                    } catch (SQLException e) {
                        System.out.println("erro usuario = " + e);
                    }
                %>
            </tbody>
        </table>
    </center>

</div>
<!--Inicio de Modal-->

<div class="modal " id="ModalUsuarios">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" id="Titulo1">Crear Usuario</h4>
                <h4 class="modal-title" id="Titulo2">Modificar Usuario</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-info btn-block" id="Btn1" onclick="GuardarUsuario();">Crear Usuario</button>
                <button class="btn btn-info btn-block" id="Btn2" onclick="ModificarUsuario()">Modificar Usuario</button>
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
    function IrUsuarios() {
        $.ajax({
            url: "Usuarios.jsp",
            type: 'POST',
            success: function (response) {
                $("#Dv_Contenido").html(response);
            },
            error: function (error) {
                alertify.error('No se enconto la direccion');
            }
        });
    }

    function ModalCrearUsua() {
        $.ajax({
            url: "Ajax/FrmCrearUsuario.jsp",
            type: 'POST',
            success: function (response) {
                $("#Titulo1").show();
                $("#Titulo2").hide();
                $("#Btn2").hide();
                
                $("#Btn1").show();

                $("#ModalUsuarios").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }
    function GuardarUsuario() {
        var Formulario = document.getElementById("FrmCrearUsuario");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmCrearUsuario").serialize();

            $.ajax({
                url: 'GuardarUsuario',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Agregado correctamente");
                        $("#ModalUsuarios").modal('hide');
                        IrUsuarios();
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
    function EliminarUsuario(IdUsuario) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "Se Inavilitar este Usuario!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Lo quiero Eliminar!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'EliminarUsuario',
                    type: 'POST',
                    data: {IdUsuario},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Tu eliminacion se esta Procesando...Aceptar para Continuar').set({onclosing: function () {
                                    IrUsuarios();
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


  function ModalModificarUsua(IdUsuario) {
        $.ajax({
            url: "Ajax/FrmModificarUsuario.jsp",
            type: 'POST',
            data : { IdUsuario },
            success: function (response) {
                 $("#Titulo1").hide();
                $("#Btn1").hide();

                $("#Titulo2").show();
                $("#Btn2").show();

                $("#ModalUsuarios").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }
    function ModificarUsuario() {
        var Formulario = document.getElementById("FrmModificarUsuario");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmModificarUsuario").serialize();

            $.ajax({
                url: 'ModificarUsuario',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Modificado correctamente");
                        $("#ModalUsuarios").modal('hide');
                        IrUsuarios();
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
</script>