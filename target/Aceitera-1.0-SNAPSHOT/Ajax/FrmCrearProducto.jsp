<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();
%>

<form id="FrmCrearProducto">

    <div class="row justify-content-center">
        <div class="col-md-4 form-group">
            <label>Nombre Producto</label>
            <input type="text" required class="form-control" name="Txt_NombreProducto">
        </div>
        <div class="col-md-4 form-group">
            <label>Tipo Producto</label>
            <select class="form-control" name="Slt_IdTipoProducto">
                <option disabled selected>Elige una Opción</option>
                <%
                    try {
                        String ListTipoProdu = "SELECT * FROM tipoproducto WHERE Estado = 1";
                        PreparedStatement ps = conn.prepareStatement(ListTipoProdu);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <option value="<%=rs.getInt("IdTipoProducto")%>"><%= rs.getString("Descripcion")%> </option>
                <%
                        }
                    } catch (SQLException e) {
                        System.out.println("e = " + e);
                    }
                %>
            </select>
        </div>
        <div class="col-md-4 form-group">
            <label>Cantidad</label>
            <input type="number" required class="form-control" name="Txt_CantidadProducto">
        </div>
    </div>
</form>