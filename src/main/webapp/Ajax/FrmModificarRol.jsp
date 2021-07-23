
<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();
    int IdRol = Integer.parseInt(request.getParameter("IdRol"));
    try {
        String RolID = "SELECT * FROM tipoempleado WHERE IdTipoEmpleado =  " + IdRol;
        PreparedStatement ps = conn.prepareStatement(RolID);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int Estado = rs.getInt("Estado");
%>
<form id="FrmModificarRol">
    <div class="row justify-content-center">
        <div class="col-md-4 form-group">
            <label>Rol</label>
            <input type="hidden" name="Txt_IdRol" value="<%=rs.getInt("IdTipoEmpleado")%>">
            <input class="form-control" type="text" required name="Txt_Rol" value="<%=rs.getString("Descripcion")%>">
        </div> 
         <div class="col-md-4 form-group">
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


