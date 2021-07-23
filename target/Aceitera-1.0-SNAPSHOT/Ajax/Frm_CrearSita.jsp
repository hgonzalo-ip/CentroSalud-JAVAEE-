
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();

    String IdCuarto = request.getParameter("IdSala");
    System.out.println("IdCuarto = " + IdCuarto);
    String IdEmpleado = request.getParameter("IdEmpleado");
    System.out.println("IdEmpleado = " + IdEmpleado);

    try {
        String Cuarto = " SELECT c.IdCuarto, c.IdEmpleado,c.NombreCuarto ,c.Estado, e.Nombres "
                + "FROM cuartos AS c "
                + "INNER JOIN empleados AS e ON c.IdEmpleado = e.IdEmpleado "
                + "WHERE c.Estado = 1 AND IdCuarto =  " + IdCuarto;
        PreparedStatement ps = conn.prepareStatement(Cuarto);
        ResultSet rs = ps.executeQuery();
        String IdEmpleadoS = (String) session.getAttribute("IdEmpleado");

        int IdEmpleadoInt = Integer.parseInt(IdEmpleadoS);
        if (rs.next()) {
%>
<form id="Frm_Crear_Sita">
    <div class="row justify-content-center">
        <div class="col-md-5 form-group">
            <label> Sala</label>
            <input type="text" disabled class="form-control" value="<%=rs.getString("NombreCuarto")%>">
            <input type="hidden" value="<%=rs.getInt("IdCuarto")%>" name="Txt_IdCuarto"><!--Id Sala en la que va a realizar la sita-->
            <input type="hidden" value="<%=IdEmpleadoInt%>" name="Txt_IdEmpleadoSes"><!--Id EMPLEADO quien crea la sita-->
        </div>

        <div class="col-md-5 form-group">
            <label>Doctor</label>
            <input type="text" disabled class="form-control" value="<%=rs.getString("Nombres")%>">
        </div>
    </div>
    <div class="row justify-content-center mt-2">
        <div class="col-md-3 form-group">
            <label>Nombres del Paciente</label>
            <input class="form-control" name="Txt_NombresPasiente" required type="text">
        </div>
        <div class="col-md-3 form-group">
            <label>Apellidos del Paciente</label>
            <input class="form-control" name="Txt_ApellidosPasiente" required type="text">
        </div>
        <div class="col-md-3 form-group">
            <label>Edad</label>
            <input type="number" name="Txt_Edad" required class="form-control">
        </div>

    </div>
    <div class="row justify-content-center">
        <div class="col-md-5 ">
            <label>Alergias</label>
            <textarea class="form-control" name="TxA_Alergias" rows="3" required>
                    
            </textarea>
        </div>
        <div class="col-md-5 ">
            <label>Descripcion De la Consulta</label>
            <textarea class="form-control" name="TxA_Descripcion" rows="3" required>
                    
            </textarea>
        </div>
    </div>
</form>
<%
        }
    } catch (SQLException e) {
        System.out.println("e = " + e);
    }
%>
