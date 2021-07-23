<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>
<form id="FrmCrearSala">
    <div class="row justify-content-center">
        <div class="col-md-3 form-group">
            <label>Nombre Sala</label>
            <input class="form-control" type="text" name="Txt_NombreSala" required>
        </div>
        <div class="col-md-3 form-group">
            <label>Doctor Acargo</label>
            <select class="form-control" name="Slt_IdEmpleado">
                <option selected>Elige una opción</option>
                <%
                    Conexion conex = new Conexion();
                    Connection conn = conex.getConnection();

                    try {
                        String ListarDoc = "SELECT e.IdEmpleado, e.Nombres , e.Apellidos "
                                + "FROM empleados AS e "                                
                                + " WHERE e.IdTipoEmpleado = 1 AND e.Estado = 1 ";
                        PreparedStatement ps = conn.prepareStatement(ListarDoc);
                        ResultSet rs = ps.executeQuery();
                        while (rs.next()) {
                %>
                <option value="<%=rs.getInt("IdEmpleado")%>"><%=rs.getString("Nombres")%></option>
                <%
                        }
                    } catch (SQLException e) {
                        System.out.println("e = " + e);
                    }


                %>
            </select>
        </div>
    </div>

</form>