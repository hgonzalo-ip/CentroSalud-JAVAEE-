<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>
<div class="row">
    <div class="col-md-4 form-group">
        <select class="form-control" id="Slt_FiltroSitas" onchange="VerBTN();">
            <option selected disabled>Filtro</option>
            <option value="1">En Espeta</option>
            <option value="">Todos</option>
            <option value="2">Finalizadas</option>
            <option value="0">Inactivas</option>
            <option value="3">Por Fechas</option>
        </select>
        <input class="form-control mt-3" name="FechaBuscar" id="FechaBuscar" type="date" style="display: none;">
        <button id="BtnBuscar" style="display: none;" class="btn btn-success mt-3" onclick="ListarSitasEstado()">Buscar</button>
    </div>
    <div class="col-md-4 justify-content-center">
        <h3 class="text-center">Citas</h3>
    </div>
    <div class="col-md-2 form-group">
        <span class="material-icons">                
            <button class="btn btn-success mr-5 form-control" onclick="ExportarSitas()">
                description                   
            </button>
        </span>
    </div>
</div>
<div id="Tbl_Sitas">


<table   class="table table-hover table-primary mt-3 table-responsive">
    <thead>
    <th>ID</th>     
    <th>Nombres Paciente</th> 
    <th>Apellidos Paciente</th> 
    <th>Creardor</th>
    <th>Sala</th> 
    <th>Doctor</th>
    <th>Fehca de Creación</th>
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

            int Estado = Integer.parseInt(request.getParameter("Estado"));
            System.out.println("Estado = " + Estado);
            String FechaBuscar = request.getParameter("FechaBuscar");
            System.out.println("FechaBuscar = " + FechaBuscar);
            String sql = " ";
            if (FechaBuscar.equals("")) {
                sql = "SELECT r.IdReserva, r.NombrePaciente, r.ApellidoPaciente, r.Edad, r.Alergias, r.DescripcionCosulta, DATE_FORMAT(r.FechaInicio, '%d-%m-%Y' ) AS FechaInicioF, r.FechaaFin, r.Estado, e.Nombres AS Creador, c.NombreCuarto, em.Nombres AS Doctor "
                        + "FROM reservas AS r "
                        + "INNER JOIN empleados AS e ON r.IdEmpleado = e.IdEmpleado "
                        + "INNER JOIN cuartos AS c ON r.IdCuarto = c.IdCuarto "
                        + "INNER JOIN empleados AS em ON c.IdEmpleado = em.IdEmpleado "
                        + "WHERE r.Estado = " + Estado;
                System.out.println("sql = " + sql);
            } else {
                if (Estado == 3) {
                    sql = "SELECT r.IdReserva, r.NombrePaciente, r.ApellidoPaciente, r.Edad, r.Alergias, r.DescripcionCosulta, DATE_FORMAT(r.FechaInicio, '%d-%m-%Y' ) AS FechaInicioF, r.FechaaFin, r.Estado, e.Nombres AS Creador, c.NombreCuarto, em.Nombres AS Doctor "
                            + "FROM reservas AS r "
                            + "INNER JOIN empleados AS e ON r.IdEmpleado = e.IdEmpleado "
                            + "INNER JOIN cuartos AS c ON r.IdCuarto = c.IdCuarto "
                            + "INNER JOIN empleados AS em ON c.IdEmpleado = em.IdEmpleado "
                            + "WHERE  DATE(r.FechaInicio) =  '" + FechaBuscar + "' ";
                    System.out.println("sql = " + sql);
                } else {
                    sql = "SELECT r.IdReserva, r.NombrePaciente, r.ApellidoPaciente, r.Edad, r.Alergias, r.DescripcionCosulta, DATE_FORMAT(r.FechaInicio, '%d-%m-%Y' ) AS FechaInicioF, r.FechaaFin, r.Estado, e.Nombres AS Creador, c.NombreCuarto, em.Nombres AS Doctor "
                            + "FROM reservas AS r "
                            + "INNER JOIN empleados AS e ON r.IdEmpleado = e.IdEmpleado "
                            + "INNER JOIN cuartos AS c ON r.IdCuarto = c.IdCuarto "
                            + "INNER JOIN empleados AS em ON c.IdEmpleado = em.IdEmpleado "
                            + "WHERE  r.Estado  = '" + Estado + "' AND DATE(r.FechaInicio) =  '" + FechaBuscar + "' ";
                }

            }
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            System.out.println("rs = " + rs);
            int Contador = 0;
            while (rs.next()) {
                int Estado2 = rs.getInt("Estado");
                System.out.println("Estado2 = " + Estado2);
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
                if (Estado2 == 1) {
            %>
            En Espera
            <%
            } else if (Estado2 == 2) {
            %>
            Finalizada
            <%
            } else if (Estado2 == 0) {
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
                <button class="btn btn-danger">

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
            System.out.println("e lsitar sitas Estado= " + e);
        }
    %>
</tbody>
</table>
</div>
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
</script>