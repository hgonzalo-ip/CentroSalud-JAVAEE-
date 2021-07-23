<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();

    int IdReserva = Integer.parseInt(request.getParameter("IdReserba"));

    try {
        String Listar = "SELECT r.IdReserva,r.IdCuarto,r.NombrePaciente, r.ApellidoPaciente, r.Edad, r.Alergias, r.DescripcionCosulta, r.FechaInicio, r.FechaaFin, r.Estado, e.Nombres AS Creador, c.NombreCuarto, em.Nombres AS Doctor "
                + "FROM reservas AS r "
                + "INNER JOIN empleados AS e ON r.IdEmpleado = e.IdEmpleado "
                + "INNER JOIN cuartos AS c ON r.IdCuarto = c.IdCuarto "
                + "INNER JOIN empleados AS em ON c.IdEmpleado = em.IdEmpleado "
                + " WHERE r.IdReserva = " + IdReserva;
        PreparedStatement ps = conn.prepareStatement(Listar);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
%>
<form>
    <div class="row justify-content-center">
        <div class="col-md-2 form-group">
            <label>Inicio</label>
            <input type="datetime" class="form-control" value="<%=rs.getString("FechaInicio")%>" disabled>
        </div>
        <div class="col-md-2 form-group">
            <label>Doctor</label>
            <input type="text" class="form-control" value="<%=rs.getString("Doctor")%>" disabled>
        </div>
        <div class="col-md-2 form-group">
            <label>Creador Sita</label>
            <input type="text" class="form-control" value="<%=rs.getString("Creador")%>" disabled>
        </div>
        <div class="col-md-2 form-group">
            <label>Sala</label>
            <input type="text" class="form-control" value="<%=rs.getString("NombreCuarto")%>" disabled>
        </div>
        <div class="col-md-2 form-group">
            <label>Fin</label>
            <input type="datetime" class="form-control" value="<%=rs.getString("FechaaFin")%>" disabled>
        </div>
    </div>
    <div class="row justify-content-center">
        <div class="col-md-4 form-group">
            <label>Nombres del Paciente</label>
            <input type="text" class="form-control" value="<%=rs.getString("NombrePaciente")%>" disabled>

        </div>
        <div class="col-md-4 form-group">
            <label>Apellidos del Paciente</label>
            <input type="text" class="form-control" value="<%=rs.getString("ApellidoPaciente")%>" disabled>

        </div>
        <div class="col-md-4 form-group">
            <label>Edad del Paciente</label>
            <input type="text" class="form-control" value="<%=rs.getString("Edad")%>" disabled>
        </div>
    </div> 
    <div class="row justify-content-center">
        <div class="col-md-5 ">
            <label>Alergias</label>
            <textarea class="form-control" rows="3" disabled>
                <%=rs.getString("Alergias")%>
            </textarea>

        </div>
        <div class="col-md-5">
            <label>Descripción</label>
            <textarea class="form-control" rows="3" disabled>
                <%=rs.getString("DescripcionCosulta")%>
            </textarea>

        </div>      
    </div> 

    <hr>
    <center><h3>Receta</h3></center>
    <table style="padding-left: 25%;" class="table table-hover table-primary mt-3 table-responsive">
        <thead>
        <th>#</th>
        <th>Prodcuto</th>
        <th>Cantidad</th>
        <th>Descripción</th>
        </thead>
        <tbody>
            <%
                try {
                    String ListarReceta = "SELECT rec.IdReserva, dtr.IdDetalleReceta, dtr.IdReceta, dtr.IdProducto, p.NombreProducto, dtr.Cantidad , dtr.Descripcion "
                            + "FROM recetas AS rec "
                            + "INNER JOIN detallereceta AS dtr ON rec.IdReceta = dtr.IdReceta "
                            + "INNER JOIN productos AS p ON dtr.IdProducto = p.IdProducto "
                            + "WHERE rec.IdReserva = " + IdReserva;
                    PreparedStatement ps2 = conn.prepareStatement(ListarReceta);
                    ResultSet rs2 = ps2.executeQuery();
                    int Contador = 0;
                    while (rs2.next()) {
                        Contador++;
            %>
            <tr>
                <td><%=Contador%></td>
                <td><%=rs2.getString("NombreProducto")%></td>
                <td><%=rs2.getString("Cantidad")%></td>
                <td><%=rs2.getString("Descripcion")%></td>
            </tr>

            <%
                    }

                } catch (SQLException er) {
                    System.out.println("e tablaReceta = " + er);
                }
            %>  
        </tbody>
    </table>
</form>

<%
        }
    } catch (SQLException e) {
        System.out.println("e Mas infor = " + e);
    }
%>