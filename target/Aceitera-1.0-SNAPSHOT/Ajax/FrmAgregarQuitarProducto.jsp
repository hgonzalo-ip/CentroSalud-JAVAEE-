<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();

    int IdProducto = Integer.parseInt(request.getParameter("IdProducto"));

    try {
        String ListarProdId = "SELECT p.IdProducto, p.NombreProducto,tp.IdTipoProducto ,tp.Descripcion , p.Cantida, p.Estado "
                + "FROM productos AS p "
                + "INNER JOIN tipoproducto AS tp ON p.IdTipoProducto = tp.IdTipoProducto "
                + "WHERE p.IdProducto = " + IdProducto;
        PreparedStatement ps = conn.prepareStatement(ListarProdId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int IdTipoProductoL = rs.getInt("IdTipoProducto");
            int CantidadActual = rs.getInt("Cantida");
            int Estado = rs.getInt("Estado");
%>

<form id="FrmAgregarProducto">

    <div class="row justify-content-center">
        <div class="col-md-3 form-group">
            <label>Nombre Producto</label>
            <input type="hidden"  class="form-control" name="Txt_IdProducto" value="<%=rs.getString("IdProducto")%>">
            <input type="text" readonly required class="form-control" name="Txt_NombreProducto" value="<%=rs.getString("NombreProducto")%>">
        </div>
        <div class="col-md-3 form-group">
            <label>Tipo Producto</label>
            <input type="text" readonly required class="form-control"  value="<%=rs.getString("Descripcion")%>">
    
        </div>
        <div class="col-md-3 form-group">
            <label>Cantidad</label>
            <input type="hidden" required class="form-control" name="Txt_CantidadActual" value="<%=CantidadActual%>">
            <input type="number" required class="form-control" name="Txt_CantidadProducto" >
        </div>
       
    </div>
</form>
<%
        }
    } catch (SQLException e) {
        System.out.println("e = " + e);
    }
%>
