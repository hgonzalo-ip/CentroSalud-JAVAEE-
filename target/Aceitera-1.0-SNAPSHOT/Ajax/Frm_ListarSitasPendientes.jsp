<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>   
<table   class="table table-hover table-primary mt-3 table-responsive">
    <thead>
    <th>ID</th>     
    <th>Nombres Paciente</th> 
    <th>Apellidos Paciente</th> 
    <th>Edad</th>    
    <th>Sala</th> 
    <th>Doctor</th>
    <th>Alergias</th>
    <th>Descripción</th>
    <th>Estado</th>        

</thead>
<tbody id="myTable">
    <%
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        int IdSala = Integer.parseInt(request.getParameter("IdSala"));

        try {
            String ListarSitas = "SELECT r.IdReserva,r.IdCuarto,r.NombrePaciente, r.ApellidoPaciente, r.Edad, r.Alergias, r.DescripcionCosulta, r.FechaInicio, r.FechaaFin, r.Estado, e.Nombres AS Creador, c.NombreCuarto, em.Nombres AS Doctor "
                    + "FROM reservas AS r "
                    + "INNER JOIN empleados AS e ON r.IdEmpleado = e.IdEmpleado "
                    + "INNER JOIN cuartos AS c ON r.IdCuarto = c.IdCuarto "
                    + "INNER JOIN empleados AS em ON c.IdEmpleado = em.IdEmpleado "
                    + " WHERE r.Estado = 1 AND r.IdCuarto =  " + IdSala
                    + " ORDER BY  r.IdReserva DESC ";
            PreparedStatement ps = conn.prepareStatement(ListarSitas);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int Estado = rs.getInt("Estado");

    %>     
    <tr>
        <td><%=rs.getInt("IdReserva")%></td>
        <td><%=rs.getString("NombrePaciente")%></td>
        <td><%=rs.getString("ApellidoPaciente")%></td>
        <td><%=rs.getString("Edad")%> AÑOS</td>

        <td><%=rs.getString("NombreCuarto")%></td>
        <td><%=rs.getString("Doctor")%></td>
        <%
            if (rs.getString("Alergias") == null) {
        %>
        <td>No es alergico</td>
        <%
            } else {
            %>
            <td><%=rs.getString("Alergias")%></td>
            <%
            }
        %>        
        <td><%=rs.getString("DescripcionCosulta")%></td>
        <td>
            <%
                if (Estado == 1) {
            %>
            En Espera
            <%
            } else if (Estado == 0) {
            %>
            Inactivo
            <%
                }
            %>  
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