
<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();
    int IdReserva = Integer.parseInt(request.getParameter("IdReserva"));

%>
<input class="form-control mt-3" id="myInput" type="text" placeholder="Buscar..">
<table style="padding-left: 25%;" class="table table-hover table-primary mt-3 table-responsive">
    <thead>
    <th>#</th>
    <th>Prodcuto</th>
    <th>Cantidad</th>
    <th>Descripción</th>
</thead>
<tbody id="myTable">
    <%        try {
            String ListarReceta = "SELECT rec.IdReserva, dtr.IdDetalleReceta, dtr.IdReceta, dtr.IdProducto, p.NombreProducto, dtr.Cantidad , dtr.Descripcion "
                    + "FROM recetas AS rec "
                    + "INNER JOIN detallereceta AS dtr ON rec.IdReceta = dtr.IdReceta "
                    + "INNER JOIN productos AS p ON dtr.IdProducto = p.IdProducto "
                    + "WHERE rec.IdReserva = " + IdReserva;
            PreparedStatement ps2 = conn.prepareStatement(ListarReceta);
            ResultSet rs2 = ps2.executeQuery();

            int Contador = 0;

            while (rs2.next()) {
                int Cantidad = rs2.getInt("Cantidad");
                int IdProducto = rs2.getInt("IdProducto");
                String NombreProducto = rs2.getString("NombreProducto");
                System.out.println("NombreProducto = " + NombreProducto);

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
</script>