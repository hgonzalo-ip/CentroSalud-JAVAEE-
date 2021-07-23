<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();

    int IdReserva = Integer.parseInt(request.getParameter("IdReserba"));

    try {
        String Listar = "SELECT r.IdReserva,r.IdCuarto,r.NombrePaciente, r.ApellidoPaciente, r.Edad, r.Alergias, r.DescripcionCosulta, r.FechaInicio, r.FechaaFin, r.Estado, CONCAT(e.Nombres ,' ', e.Apellidos )AS Creador ,c.IdCuarto ,c.NombreCuarto, em.Nombres AS Doctor "
                + "FROM reservas AS r "
                + "INNER JOIN empleados AS e ON r.IdEmpleado = e.IdEmpleado "
                + "INNER JOIN cuartos AS c ON r.IdCuarto = c.IdCuarto "
                + "INNER JOIN empleados AS em ON c.IdEmpleado = em.IdEmpleado "
                + " WHERE r.IdReserva = " + IdReserva;
        PreparedStatement ps = conn.prepareStatement(Listar);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int IdSala = rs.getInt("IdCuarto");
%>
<form id="Frm_ModificarInfoSita">
    <div class="row justify-content-center">
        <div class="col-md-3 form-group">
            <label>Creacion de la Sita</label>
            <input type="hidden" class="form-control" value="<%=rs.getInt("IdReserva")%>"  name="Txt_IdReserba">
            <input type="datetime" class="form-control" value="<%=rs.getString("FechaInicio")%>" disabled>
        </div>
      
        <div class="col-md-2 form-group">
            <label>Creador Sita</label>
            <input type="text" class="form-control" value="<%=rs.getString("Creador")%>" disabled>
        </div>
          <div class="col-md-2 form-group">
            <label>Doctor</label>
            <input type="text" class="form-control" value="<%=rs.getString("Doctor")%>" disabled>
        </div>
        <div class="col-md-2 form-group">
            <label>Sala</label>            
            <select class="form-control" name="Slt_Sala">
                <%
                    try {
                            String ListarSalas = "SELECT * FROM cuartos";
                            PreparedStatement ps2 = conn.prepareStatement(ListarSalas);
                            ResultSet rs2 = ps2.executeQuery();
                            while(rs2.next()){
                 %>
                 <option value="<%=rs2.getInt("IdCuarto")%>"  <% if(IdSala == rs2.getInt("IdCuarto")){%> selected <%}%>  ><%=rs2.getString("NombreCuarto")%></option>
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
            <label>Nombres del Paciente</label>
            <input type="text" class="form-control" value="<%=rs.getString("NombrePaciente")%>" name="Txt_NombresP" >

        </div>
        <div class="col-md-4 form-group">
            <label>Apellidos del Paciente</label>
            <input type="text" class="form-control" value="<%=rs.getString("ApellidoPaciente")%>" name="Txt_ApellidosP">

        </div>
        <div class="col-md-4 form-group">
            <label>Edad del Paciente</label>
            <input type="text" class="form-control" value="<%=rs.getString("Edad")%>" name="Txt_Edad">
        </div>
    </div> 
    <div class="row justify-content-center">
        <div class="col-md-5 ">
            <label>Alergias</label>
            <textarea class="form-control" rows="3" name="Txt_AlegiasP" >
                <%=rs.getString("Alergias")%>
            </textarea>

        </div>
        <div class="col-md-5">
            <label>Descripción</label>
            <textarea class="form-control" rows="3" name="Txt_DescripcionP" >
                <%=rs.getString("DescripcionCosulta")%>
            </textarea>

        </div>      
    </div> 

</form>

<%
        }
    } catch (SQLException e) {
        System.out.println("e Mas infor = " + e);
    }
%>