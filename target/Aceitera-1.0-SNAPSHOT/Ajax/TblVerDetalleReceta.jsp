<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>
<%@page import="java.sql.SQLException"%>
<table style="padding-left: 21%;" class="table table-hover table-primary mt-3 table-responsive">
    <thead>
    <th>#</th>
    <th>Nombre Producto</th>
    <th>Tipo Producto</th>
    <th>Cantidad</th>
    <th>Descripción</th>   
</thead>
<tbody>
    <%
        try {
            Conexion conex = new Conexion();
            Connection conn = conex.getConnection();
               int IdReceta = Integer.parseInt(request.getParameter("IdReceta"));
                       
            String ListarDetalleReceta = "SELECT r.IdReserva,r.IdReceta,p.NombreProducto,tp.Descripcion,dtl.Cantidad,dtl.Descripcion,dtl.Estado "
                                        +"FROM recetas AS r "
                                        +"INNER JOIN detallereceta AS dtl ON r.IdReceta = dtl.IdReceta "
                                        +"INNER JOIN productos AS p ON dtl.IdProducto = p.IdProducto "
                                        +"INNER JOIN tipoproducto AS tp ON p.IdTipoProducto = tp.IdTipoProducto "
                                        +"WHERE r.IdReceta = " + IdReceta;
            PreparedStatement ps2 = conn.prepareStatement(ListarDetalleReceta);
            ResultSet rs2 = ps2.executeQuery();
            int Contador = 0;
            while (rs2.next()) {
                Contador++;
    %>
    <tr>
        <td><%=Contador%></td>
        <td><%=rs2.getString("NombreProducto")%></td>
        <td><%=rs2.getString("Descripcion")%></td>
        <td><%=rs2.getString("Cantidad")%></td>
        <td><%=rs2.getString("Descripcion")%></td>
   
    </tr>

    <%
            }

        } catch (SQLException er) {
            System.out.println("e tabla Receta Pendientes FAR = " + er);
        }
    %>  
</tbody>
</table>