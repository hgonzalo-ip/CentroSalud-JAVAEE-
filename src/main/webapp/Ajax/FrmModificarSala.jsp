<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>

<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();

    int IdSala = Integer.parseInt(request.getParameter("IdSala"));
    try {
        String ListarSalaModi = "SELECT * FROM cuartos WHERE IdCuarto = " + IdSala;
        PreparedStatement ps = conn.prepareStatement(ListarSalaModi);
        ResultSet rs = ps.executeQuery();

        if (rs.next()) {
            int Estado = rs.getInt("Estado");

%>

<form id="FrmModificarSala">
    <div class="row justify-content-center">
        <div class="col-md-3 form-group">
            <label>Nombre Sala</label>
            <input type="hidden" value="<%=IdSala%>" name="Txt_IdSala" >
            <input class="form-control" type="text" name="Txt_NombreSala" required value="<%=rs.getString("NombreCuarto")%>">
        </div>
        <div class="col-md-3 form-group">
            <label>Doctor Acargo</label>
            <select class="form-control" name="Slt_IdEmpleado">
                <option selected>Elige una opción</option>
                <%

                    try {
                        String ListarDoc = "SELECT IdEmpleado, Nombres , Apellidos,IdTipoEmpleado "
                                + "FROM empleados "
                                + " WHERE IdTipoEmpleado = 1 AND Estado = 1 ";
                        PreparedStatement ps2 = conn.prepareStatement(ListarDoc);
                        ResultSet rs2 = ps2.executeQuery();
                        while (rs2.next()) {
                %>
                <option value="<%=rs2.getInt("IdEmpleado")%>" <% if (rs.getInt("IdEmpleado") == rs2.getInt("IdEmpleado")) {%>selected <%}%> ><%=rs2.getString("Nombres") + " " + rs2.getString("Apellidos")%></option>
                <%
                        }
                    } catch (SQLException e) {
                        System.out.println("e1 = " + e);
                    }

                %>
            </select>
        </div>

    </div>
    <div class="row justify-content-center">
        <div class="col-md-3 form-group">
            <label>Estado</label>
            <select class="form-control" name="Slt_Estado">
                <option value="1"<%if (Estado == 1) {%> selected  <%}%>  >Activo</option>
                <option value="0"<%if (Estado == 0) {%> selected  <%}%>  >Inactivo</option>
            </select>
        </div>
    </div>
</form>
<%                            }

    } catch (SQLException e) {
        System.out.println("e = " + e);
    }

%>


