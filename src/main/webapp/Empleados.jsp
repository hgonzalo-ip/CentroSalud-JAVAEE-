<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-12 form-group">
    <div class="row">
        <div class="col-md-4">
            <button class="btn btn-info " onclick="ModalCrearEm();"><span class="material-icons">
                    add
                </span>
            </button>

        </div>
        <div class="col-md-4 justify-content-center">
            <h3 class="text-center  p-2 w-50  shadow   rounded">Empleados</h3>
        </div>
    </div>

    <input class="form-control mt-3" id="myInput" type="text" placeholder="Buscar..">
    <table class="table table-hover table-primary mt-3 table-responsive">
        <thead>
        <th>ID</th>
        <th>Nombre</th>
        <th>Foto</th>
        <th>Usuario</th>
        <th>Rol</th>
        <th>Fecha Nacimiento</th>
        <th>Direccion</th>
        <th>Telefono</th>
        <th>DPI</th>
        <th>Estado</th>
        <th>Editar</th>
        <th>Eliminar</th>
        </thead>
        <tbody id="myTable">
            <%
                Conexion conex = new Conexion();
                Connection conn = conex.getConnection();
                try {
                    String ListarEmpleados = "SELECT e.IdEmpleado, e.IdUsuario , CONCAT(e.Nombres, ' ', e.Apellidos)AS Nombre , u.Usuario, te.Descripcion, e.FechaNacimiento, e.Direccion, e.Telefono, e.DPI,e.Foto ,e.Estado "
                            + "FROM empleados AS e "
                            + "INNER JOIN usuarios AS u ON e.IdUsuario = u.IdUsuario "
                            + "INNER JOIN  tipoempleado AS te ON e.IdTipoEmpleado = te.IdTipoEmpleado";
                    PreparedStatement ps = conn.prepareStatement(ListarEmpleados);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        int Estado = rs.getInt("Estado");
                        int IdEmpleado = rs.getInt("IdEmpleado");
            %>     
            <tr>

                <td><%=rs.getString("IdEmpleado")%></td>               
                <td><%=rs.getString("Nombre")%></td>
                <td>
                    <%
                        String Foto = rs.getString("Foto");
                        if( Foto != null) {
                            System.out.println("Foto = " + Foto);
                    %>
                    <img  class="FotoPerfil" src="img/Fotos/<%=Foto%>" alt="Sin Foto">
                    <%
                    } else if (Foto == null){
                    %>
                      <img src="img/SinFoto.jpg" class="FotoPerfil">
                    <%
                        }
                    %>
                </td>
                <td><%=rs.getString("Usuario")%></td>
                <td><%=rs.getString("Descripcion")%></td>
                <td><%=rs.getString("FechaNacimiento")%></td>
                <td><%=rs.getString("Direccion")%></td>
                <td><%=rs.getString("Telefono")%></td>
                <td><%=rs.getString("DPI")%></td>
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
                        <button class="btn btn-warning" onclick="ModalModificar(<%=IdEmpleado%>)">

                            create

                        </button>
                    </span>
                </td>
                <td>
                    <span class="material-icons">
                        <button class="btn btn-danger" onclick="EliminarEmp(<%=IdEmpleado%>);">

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

<div class="modal " id="ModalEmpleados">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4  id="CrearEm">Crear Empleado</h4>
                <h4  id="ModificarEm">Modificar Empleado</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-info btn-block" id="Btn1" onclick="GuardarEmpleado();">Crear Empleado</button>
                <button class="btn btn-info btn-block" id="Btn2" onclick="ModificarEmpleado()">Modificar Empleado</button>
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
        function IrEmpleados() {
            $.ajax({
                url: "Empleados.jsp",
                type: 'POST',
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se enconto la direccion');
                }
            });
        }
    function ModalCrearEm() {
        $.ajax({
            url: "Ajax/FrmCrearEmpleado.jsp",
            type: 'POST',
            success: function (response) {
                $("#ModificarEm").hide();
                $("#Btn2").hide();
                $("#CrearEm").show();
                $("#Btn1").show();

                $("#ModalEmpleados").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }

    function GuardarEmpleado() {
        var Formulario = document.getElementById("FrmCrarEmpleado");
        if (Formulario.reportValidity()) {
            var formData = new FormData(Formulario);

            $.ajax({
                url: 'GuardarEmpleado',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Agregado correctamente");
                        $("#ModalEmpleados").modal('hide');
                        IrEmpleados();
                        
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
    function EliminarEmp(IdEmpleado) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "De Inavilitar este Empleado!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Lo quiero Eliminar!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'EliminarEmpleado',
                    type: 'POST',
                    data: {IdEmpleado},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Tu eliminacion se esta Procesando...Aceptar para Continuar').set({onclosing: function () {
                                    location.reload();
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
    function ModalModificar(IdEmpleado) {
        $.ajax({
            url: "Ajax/FrmModificarEmpleado.jsp",
            type: 'POST',
            data: {IdEmpleado},
            success: function (response) {
             
                $("#Btn1").hide();
                   $("#CrearEm").hide();
                $("#ModificarEm").show();
                $("#Btn2").show();
                $("#ModalEmpleados").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }
    function ModificarEmpleado() {
        var Formulario = document.getElementById("FrmModificarEmpleado");
        if (Formulario.reportValidity()) {
            var formData = new FormData(Formulario);

            $.ajax({
                url: 'ModificarEmpleado',
                type: 'POST',
                data: formData,
                cache: false,
                contentType: false,
                processData: false,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Modificardo correctamente");
                        location.reload();
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