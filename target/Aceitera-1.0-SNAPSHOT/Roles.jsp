<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-12 form-group">
    <div class="row">
         <div class="col-md-4">
            <button class="btn btn-info " onclick="ModalCrearRol();"><span class="material-icons">
                    add
                </span>
            </button>
            
        </div>
         <div class="col-md-4 justify-content-center">
             <h3 class="text-center  p-2 w-50  shadow   rounded">Roles</h3>
        </div>
    </div>

    <input class="form-control mt-3" id="myInput" type="text" placeholder="Buscar..">
    <table style="padding-left: 25%;"  class="table table-hover table-primary mt-3 table-responsive">
        <thead>
        <th>ID</th>
        <th>Rol</th>
        <th>Estado</th>
           
        <th>Editar</th>
        <th>Eliminar</th>
        </thead>
        <tbody id="myTable">
            <%
                Conexion conex = new Conexion();
                Connection conn = conex.getConnection();
                try {
                    String ListarRoles = "SELECT IdTipoEmpleado, Descripcion, Estado FROM tipoempleado";
                    PreparedStatement ps = conn.prepareStatement(ListarRoles);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        int Estado = rs.getInt("Estado");
                        int IdTipoEmpleado = rs.getInt("IdTipoEmpleado");
            %>     
            <tr>
                <td><%=rs.getString("IdTipoEmpleado")%></td>
                <td><%=rs.getString("Descripcion")%></td>
                
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
                        }
                    %>  
                </td>
                <td>
                    <span class="material-icons">
                        <button class="btn btn-warning" onclick="ModalModificarRol(<%=IdTipoEmpleado%>)">

                            create

                        </button>
                    </span>
                </td>
                <td>
                    <span class="material-icons">
                        <button class="btn btn-danger" onclick="EliminarRol(<%=IdTipoEmpleado%>);">

                            delete_forever

                        </button>
                    </span>
                </td>   
            </tr>  
            <%
                    }
                } catch (SQLException e) {
                    System.out.println("e = " + e);
                }
            %>
        </tbody>
    </table>
</div>
        <!--Inicio de Modal-->

<div class="modal " id="ModalRoles">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" id="Titulo1">Crear Rol</h4>
                <h4 class="modal-title" id="Titulo2">Modificar Rol</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-info btn-block" id="Btn1" onclick="GuardarRol();">Crear Rol</button>
                <button class="btn btn-info btn-block" id="Btn2" onclick="ModificarRol()">Modificar Rol</button>
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
      function IrRoles() {
            $.ajax({
                url: "Roles.jsp",
                type: 'POST',
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se enconto la direccion');
                }
            });
        }
    
        function ModalCrearRol() {
        $.ajax({
            url: "Ajax/FrmCrearRol.jsp",
            type: 'POST',
            success: function (response) {
                $("#Titulo2").hide();
                $("#Btn2").hide();
                $("#Titulo1").show();
                $("#Btn1").show();

                $("#ModalRoles").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }
     function GuardarRol() {
        var Formulario = document.getElementById("FrmCrearRol");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmCrearRol").serialize();

            $.ajax({
                url: 'CrearRol',
                type: 'POST',
                data: formData,               
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Agregado correctamente");
                        $("#ModalRoles").modal('hide');
                        IrRoles();
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
        function EliminarRol(IdRol) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "Se Inavilitar este Rol!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Lo quiero Eliminar!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'EliminarRol',
                    type: 'POST',
                    data: {IdRol},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Tu eliminacion se esta Procesando...Aceptar para Continuar').set({onclosing: function () {
                                         IrRoles();
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
    
         function ModalModificarRol(IdRol) {
        $.ajax({
            url: "Ajax/FrmModificarRol.jsp",
            type: 'POST',
            data : { IdRol },
            success: function (response) {
                 $("#Titulo1").hide();
                $("#Btn1").hide();

                $("#Titulo2").show();
                $("#Btn2").show();

                $("#ModalRoles").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }
        function ModificarRol() {
        var Formulario = document.getElementById("FrmModificarRol");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmModificarRol").serialize();

            $.ajax({
                url: 'ModificarRol',
                type: 'POST',
                data: formData,               
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Modificado correctamente");
                        $("#ModalRoles").modal('hide');
                        IrRoles();
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