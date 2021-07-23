<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-12 form-group">
    <div class="row">
        <div class="col-md-4">
            <button class="btn btn-info " onclick="ModalCrearProd()"><span class="material-icons">
                    add
                </span>
            </button>

        </div>
        <div class="col-md-4 justify-content-center">
            <h3 class="text-center  p-2 w-50  shadow   rounded">Productos</h3>
        </div>
    </div>

    <input class="form-control mt-3" id="myInput" type="text" placeholder="Buscar..">
    <table style="padding-left: 25%;"  class="table table-hover table-primary mt-3 table-responsive">
        <thead>
        <th>ID</th>
        <th>Nombre Producto</th>
        <th>Tipo</th>
        <th>Cantidad</th>
        <th>Estado</th>
        <th>Editar</th>
        <th>Eliminar</th>
        <th>Agregar/Quitar</th>
        </thead>
        <tbody id="myTable">
            <%
                Conexion conex = new Conexion();
                Connection conn = conex.getConnection();
                try {
                    String ListarProduc = "SELECT p.IdProducto, p.NombreProducto, tp.Descripcion , p.Cantida, p.Estado "
                            + "FROM productos AS p "
                            + "INNER JOIN tipoproducto AS tp ON p.IdTipoProducto = tp.IdTipoProducto ";

                    PreparedStatement ps = conn.prepareStatement(ListarProduc);
                    ResultSet rs = ps.executeQuery();
                    while (rs.next()) {
                        int Estado = rs.getInt("Estado");
                        int IdProducto = rs.getInt("IdProducto");
            %>     
            <tr>
                <td><%=rs.getInt("IdProducto")%></td>
                <td><%=rs.getString("NombreProducto")%></td>
                <td><%=rs.getString("Descripcion")%></td>
                <td><%=rs.getInt("Cantida")%></td>


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
                        <button class="btn btn-warning" onclick="ModalModificarProduc(<%=IdProducto%>)">

                            create

                        </button>
                    </span>
                </td>
                <td>
                    <span class="material-icons">
                        <button class="btn btn-danger" onclick="EliminarProducto(<%=IdProducto%>);">

                            delete_forever

                        </button>
                    </span>
                </td>  
                <td>
                    <span class="material-icons">
                        <button class="btn btn-secondary" onclick="ModalAgregarProducto(<%=IdProducto%>);">

                            control_point_duplicate

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

<div class="modal " id="ModalProductos">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" id="CrearPro">Crear Producto</h4>
                <h4 class="modal-title" id="ModificarPro">Modificar Producto</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-info btn-block" id="Btn1" onclick="GuardarProducto();">Crear Producto</button>
                <button class="btn btn-info btn-block" id="Btn2" onclick="ModificarProducto();">Modificar Producto</button>
            </div>

        </div>
    </div>
</div>

<!--Modal Agregar o Quitar Producto-->
<div class="modal " id="ModalAgregarProductos">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title"> Productos</h4>

                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="BodyAgregar">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-info btn-block" id="Btn1" onclick="AgregarProducto();">Agregar Producto</button>
                <button class="btn btn-info btn-block" id="Btn2" onclick="QuitarProducto();">Quitar Producto</button>
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

    function IrProductos() {
        $.ajax({
            url: "Productos.jsp",
            type: 'POST',
            success: function (response) {
                $("#Dv_Contenido").html(response);
            },
            error: function (error) {
                alertify.error('No se enconto la direccion');
            }
        });
    }

    function ModalCrearProd() {
        $.ajax({
            url: "Ajax/FrmCrearProducto.jsp",
            type: 'POST',
            success: function (response) {
                $("#ModificarPro").hide();
                $("#Btn2").hide();
                $("#CrearPro").show();
                $("#Btn1").show();

                $("#ModalProductos").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }
    function GuardarProducto() {
        var Formulario = document.getElementById("FrmCrearProducto");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmCrearProducto").serialize();

            $.ajax({
                url: 'CrearProducto',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Agregado correctamente");
                        $("#ModalProductos").modal('hide');
                        IrProductos();
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
    function ModalModificarProduc(IdProducto) {
        $.ajax({
            url: "Ajax/FrmModificarProducto.jsp",
            type: 'POST',
            data: {IdProducto},
            success: function (response) {
                $("#CrearPro").hide();
                $("#Btn1").hide();
                $("#ModificarPro").show();
                $("#Btn2").show();

                $("#ModalProductos").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });
    }
    function ModificarProducto() {
        var Formulario = document.getElementById("FrmModificarProducto");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmModificarProducto").serialize();

            $.ajax({
                url: 'ModificarProducto',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Modificado correctamente");
                        $("#ModalProductos").modal('hide');
                        IrProductos();
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

    function EliminarProducto(IdProducto) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "Se Inavilitar este Producto!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Lo quiero Eliminar!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'EliminarProducto',
                    type: 'POST',
                    data: {IdProducto},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Tu eliminacion se esta Procesando...Aceptar para Continuar').set({onclosing: function () {
                                    IrProductos();
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
    function ModalAgregarProducto(IdProducto) {
        $.ajax({
            url: "Ajax/FrmAgregarQuitarProducto.jsp",
            type: 'POST',
            data: {IdProducto},
            success: function (response) {
                $("#ModalAgregarProductos").modal('show');
                $("#BodyAgregar").html(response);
            },
            error: function (error) {
                alertify.error("No se encontro la dirección");
            }
        });
    }

    function AgregarProducto() {
        var Formulario = document.getElementById("FrmAgregarProducto");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmAgregarProducto").serialize();
            $.ajax({
                url: 'AgregarProducto',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Agregado correctamente");
                        $("#ModalAgregarProductos").modal('hide');
                        IrProductos();
                    } else {
                        alertify.error("Ocurrio un error");
                    }
                },
                error: function (error) {f
                    alertify.error("Ocurrio un error inesperado");
                }
            });
        }
    }    function QuitarProducto() {
        var Formulario = document.getElementById("FrmAgregarProducto");
        if (Formulario.reportValidity()) {
            var formData = $("#FrmAgregarProducto").serialize();
            $.ajax({
                url: 'QuitarProducto',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Modificacion correctamente");
                        $("#ModalAgregarProductos").modal('hide');
                        IrProductos();
                    } else {
                        alertify.error("Ocurrio un error");
                    }
                },
                error: function (error) {
                    alertify.error("Ocurrio un error inesperado");
                }
            });
        }
    }
</script>