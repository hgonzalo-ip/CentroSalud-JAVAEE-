<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%

    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();
    
    int IdUsuario = Integer.parseInt(request.getParameter("IdUsuario"));
            
            
            
            
            
    try {
            String Listar_Usuario = " SELECT * FROM usuarios WHERE IdUsuario = "+IdUsuario;
            PreparedStatement ps = conn.prepareStatement(Listar_Usuario);
            ResultSet rs = ps.executeQuery();
            if(rs.next()){
                int Estado = rs.getInt("Estado");
%>
    <form id="FrmModificarUsuario">
    <div class="row justify-content-center">
        <div class="col-md-4 form-group">
            <label>Usuario</label>
            <input type="hidden" value="<%=rs.getInt("IdUsuario") %>" name="Txt_IdUsuario">
            <input class="form-control" type="text" required name="Txt_UsuarioNuevo" value="<%=rs.getString("Usuario")%>">
        </div>
     
        <div class="col-md-6 form-group">
            <label>Nueva Contraseña</label>
            <input class="form-control" type="password" name="Txt_ContraNueva" placeholder="Escribe Nueva contraseña si la deseas cabiar">
        </div>
                 <div class="col-md-2 form-group">
                <label>Estado</label>
                <select class="form-control" name="Slt_Estado">
                    <option value="1"<%if(Estado ==1){%> selected  <%}%>  >Activo</option>
                    <option value="0"<%if(Estado ==0){%> selected  <%}%>  >Inactivo</option>
                    <option value="2"<%if(Estado ==2){%> selected  <%}%>  >Ocupado</option>
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

