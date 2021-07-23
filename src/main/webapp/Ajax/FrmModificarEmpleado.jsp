<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();

    int IdEmpleado = Integer.parseInt(request.getParameter("IdEmpleado"));

    try {
        String ListarEmpleados = "SELECT e.IdEmpleado, e.IdUsuario ,te.IdTipoEmpleado ,e.Nombres, e.Apellidos , u.Usuario, te.Descripcion, e.FechaNacimiento, e.Direccion, e.Telefono, e.DPI, e.Estado "
                + "FROM empleados AS e "
                + "INNER JOIN usuarios AS u ON e.IdUsuario = u.IdUsuario "
                + "INNER JOIN  tipoempleado AS te ON e.IdTipoEmpleado = te.IdTipoEmpleado "
                + " WHERE e.IdEmpleado = " + IdEmpleado;
        PreparedStatement ps = conn.prepareStatement(ListarEmpleados);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            
                    
            int IdUsuario = rs.getInt("IdUsuario");
            int IdTipoEmpleado = rs.getInt("IdTipoEmpleado");
            int EstadoE = rs.getInt("Estado");
%>
<form id="FrmModificarEmpleado" enctype="multipart/form-data">
    <div class="row justify-content-center">
        <div class="col-md-4 form-group">
            <label>Usuario</label>
            <input type="hidden" value="<%=IdEmpleado%>" name="IdEmpleado">
            <input type="hidden" value="<%=IdUsuario%>" name="IdUsuarioViejo">
            <select class="form-control" name="Slt_IdUsuarioNuevo">
                <option selected>Elije un Usuario</option>
                <%
                    String Usuarios = "SELECT * FROM Usuarios ";
                    try {
                        PreparedStatement ps2 = conn.prepareCall(Usuarios);
                        ResultSet rs2 = ps2.executeQuery();
                        while (rs2.next()) {
                            int EstadoUsu = rs2.getInt("Estado");
                            
                %>
                
                <option value="<%=rs2.getInt("IdUsuario")%>" <% if (IdUsuario == rs2.getInt("IdUsuario")) {%> selected  <% }  if(EstadoUsu == 1){ %>class="bg-success text-white" <%} else {%> disabled <%}%> >  <%=rs2.getString("Usuario")%></option>
                <%
                        }
                    } catch (SQLException e) {
                        System.out.println("e = " + e);
                    }
                %>
            </select>
        </div>
        <div class="col-md-4 form-group">
            <label>Tipo Empleado</label>
            <select class="form-control" name="Slt_IdTipoEmpleado">
                <option selected>Elije un Rol</option>
                <%
                    String TipoEmpleado = "SELECT * FROM tipoempleado WHERE Estado = 1";
                    try {
                        PreparedStatement ps3 = conn.prepareCall(TipoEmpleado);
                        ResultSet rs3 = ps3.executeQuery();
                        while (rs3.next()) {
                %>
                <option value="<%=rs3.getInt("IdTipoEmpleado")%>" <%  if (IdTipoEmpleado == rs3.getInt("IdTipoEmpleado")) {%>  selected <%}%> ><%=rs3.getString("Descripcion")%></option>
                <%
                        }
                    } catch (SQLException e) {
                        System.out.println("e = " + e);
                    }
                %>
            </select>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-4 form-group">
            <label>Nombres</label>
            <input class="form-control" type="text" name="Txt_Nombre" value="<%=rs.getString("Nombres")%>" required>
        </div>
        <div class="col-md-4 form-group">
            <label>Apellidos</label>
            <input class="form-control" type="text" name="Txt_Apellidos" value="<%=rs.getString("Apellidos")%>" required>
        </div>
        <div class="col-md-4 form-group">
            <label>Fecha Nacimiento</label>
            <input class="form-control" type="date" name="Txt_FechaNacimiento" value="<%=rs.getString("FechaNacimiento")%>" required>
        </div>
    </div>

    <div class="row justify-content-center">
        <div class="col-md-3 form-group">
            <label>Direcion</label>
            <input class="form-control" type="text" name="Txt_Direccion" value="<%=rs.getString("Direccion")%>" required>
        </div>
        <div class="col-md-3 form-group">
            <label>Telefono</label>
            <input class="form-control" type="tel" name="Txt_Telefono" value="<%=rs.getString("Telefono")%>">
        </div>
        <div class="col-md-3 form-group">
            <label>DPI</label>
            <input class="form-control" type="number" name="Txt_DPI" value="<%=rs.getString("DPI")%>">
        </div>
        <div class="col-md-3 form-group">
            <label>Foto Perfil</label>
            <input class="form-control-file" type="file" name="Archivo" >
        </div>
    </div>
        <div class="row justify-content-center">
            <div class="col-md-4 form-group">
                <label>Estado</label>
                <select class="form-control" name="Slt_Estado">
                    <option value="1"<%if(EstadoE ==1){%> selected  <%}%>  >Activo</option>
                    <option value="0"<%if(EstadoE ==0){%> selected  <%}%>  >Inactivo</option>
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





