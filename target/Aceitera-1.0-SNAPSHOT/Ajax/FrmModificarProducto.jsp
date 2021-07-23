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

<form id="FrmModificarProducto">

    <div class="row justify-content-center">
        <div class="col-md-3 form-group">
            <label>Nombre Producto</label>
            <input type="hidden"  class="form-control" name="Txt_IdProducto" value="<%=rs.getString("IdProducto")%>">
            <input type="text" required class="form-control" name="Txt_NombreProducto" value="<%=rs.getString("NombreProducto")%>">
        </div>
        <div class="col-md-3 form-group">
            <label>Tipo Producto</label>
            <select class="form-control" name="Slt_IdTipoProducto">
                <option disabled selected>Elige una Opción</option>
                <%
                    try {
                        String ListTipoProdu = "SELECT * FROM tipoproducto WHERE Estado = 1";
                        PreparedStatement ps2 = conn.prepareStatement(ListTipoProdu);
                        ResultSet rs2 = ps2.executeQuery();
                        while (rs2.next()) {
                %>
                <option value="<%=rs2.getInt("IdTipoProducto")%>"  <%if(IdTipoProductoL == rs2.getInt("IdTipoProducto")){%> selected <%} %>   ><%= rs2.getString("Descripcion")%> </option>
                <%
                        }
                    } catch (SQLException e) {
                        System.out.println("e = " + e);
                    }
                %>
            </select>
        </div>
        <div class="col-md-3 form-group">
            <label>Cantidad</label>
            <input type="number" required class="form-control" name="Txt_CantidadProducto" value="<%=CantidadActual%>" >
        </div>
             <div class="col-md-3 form-group">
                <label>Estado</label>
                <select class="form-control" name="Slt_Estado">
                    <option value="1"<%if(Estado ==1){%> selected  <%}%>  >Activo</option>
                    <option value="0"<%if(Estado ==0){%> selected  <%}%>  >Inactivo</option>
                </select>
            </div>
    </div>
</form>
<%
        }
    } catch (SQLException e) {
        System.out.println("e = " + e);
    }
%>
