<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();
    
%>
<form id="FrmCrarEmpleado" enctype="multipart/form-data">
    <div class="row justify-content-center">
        <div class="col-md-4 form-group">
            <label>Usuario</label>
            <select class="form-control" name="Slt_IdUsuario">
                <option selected>Elije un Usuario</option>
                <%
                    String Usuarios = "SELECT * FROM Usuarios WHERE Estado = 1";
                    try {
                            PreparedStatement ps = conn.prepareCall(Usuarios);
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()){
                 %>
                 <option value="<%=rs.getInt("IdUsuario")%>"><%=rs.getString("Usuario")%></option>
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
                            PreparedStatement ps = conn.prepareCall(TipoEmpleado);
                            ResultSet rs = ps.executeQuery();
                            while(rs.next()){
                 %>
                 <option value="<%=rs.getInt("IdTipoEmpleado")%>"><%=rs.getString("Descripcion")%></option>
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
            <input class="form-control" type="text" name="Txt_Nombre" required>
        </div>
          <div class="col-md-4 form-group">
            <label>Apellidos</label>
            <input class="form-control" type="text" name="Txt_Apellidos" required>
        </div>
          <div class="col-md-4 form-group">
            <label>Fecha Nacimiento</label>
            <input class="form-control" type="date" name="Txt_FechaNacimiento" required>
        </div>
    </div>

      <div class="row justify-content-center">
        <div class="col-md-3 form-group">
            <label>Direcion</label>
            <input class="form-control" type="text" name="Txt_Direccion" required>
        </div>
          <div class="col-md-3 form-group">
            <label>Telefono</label>
            <input class="form-control" type="tel" name="Txt_Telefono" >
        </div>
          <div class="col-md-3 form-group">
            <label>DPI</label>
            <input class="form-control" type="number" name="Txt_DPI" >
        </div>
           <div class="col-md-3 form-group">
            <label>Foto Perfil</label>
            <input class="form-control-file" type="file" name="Archivo" >
        </div>
    </div>
</form>