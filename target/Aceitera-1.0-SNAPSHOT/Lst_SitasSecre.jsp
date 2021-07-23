<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-12 form-group">
    <div class="row justify-content-center">
        <div class="col-md-4 form-group">
            <select  class="form-control" id="Slt_FiltroSitas" onchange="VerBTN();">
                <option selected disabled>Filtro</option>
                <option>Todos</option>
                <option value="1">En Espeta</option>
                <option value="2">Finalizadas</option>
                <option value="0">Inactivas</option>
                <option value="3">Por Fechas</option>
            </select>
            <input class="form-control mt-3" name="FechaBuscar" id="FechaBuscar" type="date" style="display: none;">
            <button id="BtnBuscar" style="display: none;" class="btn btn-success mt-3" onclick="ListarSitasEstado()">Buscar</button>
        </div>
        <div class="col-md-4">
            <center> <h3 class="text-center  p-2 w-25  shadow   rounded">Citas</h3> </center>
        </div>
        <div class="col-md-2 form-group">
            <span class="material-icons">                
                <button class="btn btn-success mr-5 form-control" onclick="ExportarSitas()">
                    description                   
                </button>
            </span>
        </div>
    </div>

    <input class="form-control mt-3" id="myInput" type="text" placeholder="Buscar..">
    <div id="Tbl_Sitas">
        <table   class="table table-hover table-primary mt-3 mr-1 table-responsive">
            <thead>
            <th>ID</th>     
            <th>Nombres Paciente</th> 
            <th>Apellidos Paciente</th> 
            <th>Creardor</th>
            <th>Sala</th> 
            <th>Doctor</th>
            <th>Fecha Creación</th>
            <th>Estado</th>        
            <th>Editar</th>
                <%
                    String IdTipoEmpleado = (String) session.getAttribute("IdTipoEmpleado");
                    int IdTipoEmpleadoInt = Integer.parseInt(IdTipoEmpleado);
                    if (IdTipoEmpleadoInt == 4) {
                %>
            <th>Eliminar</th>
                <%
                    }
                %>

            <th>Mas Información</th>
            </thead>
            <tbody id="myTable">
                <%
                    Conexion conex = new Conexion();
                    Connection conn = conex.getConnection();
                    try {
                        String ListarSitas = "SELECT r.IdReserva, r.NombrePaciente, r.ApellidoPaciente, r.Edad, r.Alergias, r.DescripcionCosulta, DATE_FORMAT(r.FechaInicio, '%d-%m-%Y' ) AS FechaInicioF, r.FechaaFin, r.Estado, e.Nombres AS Creador, c.NombreCuarto, em.Nombres AS Doctor "
                                + "FROM reservas AS r "
                                + "INNER JOIN empleados AS e ON r.IdEmpleado = e.IdEmpleado "
                                + "INNER JOIN cuartos AS c ON r.IdCuarto = c.IdCuarto "
                                + "INNER JOIN empleados AS em ON c.IdEmpleado = em.IdEmpleado "
                                + "ORDER BY  r.IdReserva DESC ";
                        PreparedStatement ps = conn.prepareStatement(ListarSitas);
                        ResultSet rs = ps.executeQuery();
                        int Contador = 0;
                        while (rs.next()) {
                            int Estado = rs.getInt("Estado");
                            Contador++;

                %>     
                <tr>
                    <td><%=Contador%></td>
                    <td><%=rs.getString("NombrePaciente")%></td>
                    <td><%=rs.getString("ApellidoPaciente")%></td>
                    <td><%=rs.getString("Creador")%></td>
                    <td><%=rs.getString("NombreCuarto")%></td>
                    <td><%=rs.getString("Doctor")%></td>
                    <td><%=rs.getString("FechaInicioF")%></td>

                    <td>
                        <%
                            if (Estado == 1) {
                        %>
                        En Espera
                        <%
                        } else if (Estado == 2) {
                        %>
                        Finalizada
                        <%
                        } else if (Estado == 0) {
                        %>
                        Inactiva
                        <%
                            }
                        %>  
                    </td>

                    <td>
                        <span class="material-icons">
                            <button class="btn btn-warning" onclick="ModalEditar(<%=rs.getString("IdReserva")%>)">

                                create

                            </button>
                        </span>
                    </td>
                    <%
                        String IdTipoEmpleado2 = (String) session.getAttribute("IdTipoEmpleado");
                        int IdTipoEmpleadoInt2 = Integer.parseInt(IdTipoEmpleado2);
                        if (IdTipoEmpleadoInt2 == 4) {
                    %>
                    <td>
                        <span class="material-icons">
                            <button class="btn btn-danger" onclick="EliminarRecerva(<%=rs.getString("IdReserva")%>)">

                                delete_forever

                            </button>
                        </span>
                    </td>
                    <%
                        }
                    %>

                    <td>
                        <span class="material-icons">
                            <button  class="btn btn-success ml-2" onclick="ModalVerMas(<%=rs.getString("IdReserva")%>)">

                                visibility

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


    </div><!--Div de la tabla para imprimir en exel-->
</div>

<!--Inicio de Modal-->

<div class="modal " id="ModalVerSitas">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title text-center" id="info">Información</h4>
                <h4 class="modal-title text-center" id="Editar">Editar</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-info btn-block" id="Btn1" onclick="ModificarDatosSita();">Modificar Datos</button>

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
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1);
            });
        });
    });
    function IrSitasSecre() {
        $.ajax({
            url: 'Lst_SitasSecre.jsp',
            type: 'POST',
            success: function (response) {
                $("#Dv_Contenido").html(response);
            },
            error: function (error) {
                alertify.error('No se encontro la direccion');
            }
        });
    }
    function ExportarSitas() {
        window.open('data:application/vnd.ms-excel,' + encodeURIComponent($('#Tbl_Sitas').html()));
        e.preventDefault();
    }

    function ListarSitasEstado() {
        var Estado = $("#Slt_FiltroSitas").val();
        var FechaBuscar = $("#FechaBuscar").val();

        if (Estado != "") {
            $.ajax({
                url: 'Ajax/Tbl_Lis_SitasEstado.jsp',
                type: 'POST',
                data: {Estado, FechaBuscar},
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se encontro la direccion');
                }
            });
        } else {
            IrSitasSecre();
        }
    }
    function VerBTN() {
        var Estado = $("#Slt_FiltroSitas").val();
        if (Estado != "") {
            $("#BtnBuscar").show();
            $("#FechaBuscar").show();
        } else if (Estado == 1 || Estado == 2 || Estado == 0) {
            $("#BtnBuscar").show();
            $("#FechaBuscar").show();
        }

    }

    function ModalVerMas(IdReserba) {
        $.ajax({
            url: "Ajax/FrmVerInfoSita.jsp",
            type: 'POST',
            data: {IdReserba},
            success: function (response) {
                $("#Editar").hide();

                $("#info").show();
                $("#Btn1").hide();

                $("#ModalVerSitas").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });

    }
    function ModalEditar(IdReserba) {
        $.ajax({
            url: "Ajax/FrmEditarInfoSita.jsp",
            type: 'POST',
            data: {IdReserba},
            success: function (response) {
                $("#Editar").show();

                $("#info").hide();
                $("#Btn1").show();

                $("#ModalVerSitas").modal('show');
                $("#Body").html(response);
            },
            error: function (erro) {
                alertify.error("No se encontro la dirección");
            }
        });

    }

    function ModificarDatosSita() {
        var Formulario = document.getElementById("Frm_ModificarInfoSita");
        if (Formulario.reportValidity()) {
            var formData = $("#Frm_ModificarInfoSita").serialize();

            $.ajax({
                url: 'ModficarDatosSita',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Modificado correctamente");
                        $("#ModalVerSitas").modal('hide');
                        IrSitasSecre();
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
    function EliminarRecerva(IdReserva) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "Se Inavilitar esta Reserva!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Lo quiero Inavilitar!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'EliminarSita',
                    type: 'POST',
                    data: {IdReserva},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Tu eliminacion se esta Procesando...Aceptar para Continuar').set({onclosing: function () {
                                    IrSitasSecre();
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
