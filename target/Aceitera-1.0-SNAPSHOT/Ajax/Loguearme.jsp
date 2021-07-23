
<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%
    Conexion conex = new Conexion();
    Connection conn = conex.getConnection();

    String UserName = request.getParameter("Txt_Name");
    String Pass = request.getParameter("Txt_Pass");
    try {
        String sql = "SELECT u.IdUsuario, u.Usuario, u.Contra, u.Estado, CONCAT(e.Nombres, ' ', e.Apellidos)AS Nombre,e.IdEmpleado ,e.Direccion,e.DPI,e.FechaNacimiento,e.Telefono, e.Foto,tp.IdTipoEmpleado, tp.Descripcion, c.IdCuarto "
                + "FROM usuarios AS u "
                + "INNER JOIN empleados AS e ON u.IdUsuario = e.IdUsuario "
                + "INNER JOIN tipoempleado AS tp ON e.IdTipoEmpleado = tp.IdTipoEmpleado "
                + "Left JOIN cuartos AS c ON e.IdEmpleado = c.IdEmpleado "
                + " WHERE u.Usuario = ? AND u.Contra = SHA1(?) AND u.Estado = 2 AND e.Estado = 1";
        PreparedStatement ps = conn.prepareStatement(sql);
        ps.setString(1, UserName);
        ps.setString(2, Pass);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            int IdTipoEmpleado = rs.getInt("IdTipoEmpleado");
            System.out.println("IdTipoEmpleado Loguearme = " + IdTipoEmpleado);
            // IdTipoEmpleado == 1 Es Doctor 
            System.out.println("IdTipoEmpleado = " + IdTipoEmpleado);
            if (IdTipoEmpleado == 1) {
                session.setAttribute("IdUsuario", rs.getInt("IdUsuario"));
                session.setAttribute("IdCuarto", rs.getString("IdCuarto"));
                session.setAttribute("IdEmpleado", rs.getString("IdEmpleado"));
                session.setAttribute("Usuario", rs.getString("Usuario"));
                session.setAttribute("Nombre", rs.getString("Nombre"));
                session.setAttribute("Direccion", rs.getString("Direccion"));
                session.setAttribute("DPI", rs.getString("DPI"));
                session.setAttribute("FechaNacimiento", rs.getString("FechaNacimiento"));
                session.setAttribute("Telefono", rs.getString("Telefono"));
                session.setAttribute("Descripcion", rs.getString("Descripcion"));
                session.setAttribute("IdTipoEmpleado", rs.getString("IdTipoEmpleado"));
                session.setAttribute("Foto", rs.getString("Foto"));
                response.sendRedirect("../VistaDoctor.jsp");
            } else if (IdTipoEmpleado == 2) {
                session.setAttribute("IdUsuario", rs.getInt("IdUsuario"));
                session.setAttribute("IdEmpleado", rs.getString("IdEmpleado"));
                session.setAttribute("Usuario", rs.getString("Usuario"));
                session.setAttribute("Nombre", rs.getString("Nombre"));
                session.setAttribute("Direccion", rs.getString("Direccion"));
                session.setAttribute("DPI", rs.getString("DPI"));
                session.setAttribute("FechaNacimiento", rs.getString("FechaNacimiento"));
                session.setAttribute("Telefono", rs.getString("Telefono"));
                session.setAttribute("Descripcion", rs.getString("Descripcion"));
                session.setAttribute("IdTipoEmpleado", rs.getString("IdTipoEmpleado"));
                session.setAttribute("Foto", rs.getString("Foto"));

                response.sendRedirect("../VistaSecretario.jsp");

            } else if (IdTipoEmpleado == 3) {
                session.setAttribute("IdUsuario", rs.getInt("IdUsuario"));
                session.setAttribute("IdEmpleado", rs.getString("IdEmpleado"));
                session.setAttribute("Usuario", rs.getString("Usuario"));
                session.setAttribute("Nombre", rs.getString("Nombre"));
                session.setAttribute("Direccion", rs.getString("Direccion"));
                session.setAttribute("DPI", rs.getString("DPI"));
                session.setAttribute("FechaNacimiento", rs.getString("FechaNacimiento"));
                session.setAttribute("Telefono", rs.getString("Telefono"));
                session.setAttribute("Descripcion", rs.getString("Descripcion"));
                session.setAttribute("IdTipoEmpleado", rs.getString("IdTipoEmpleado"));
                session.setAttribute("Foto", rs.getString("Foto"));

                response.sendRedirect("../VistaFarmacia.jsp");
            } else if (IdTipoEmpleado == 4) {
                session.setAttribute("IdUsuario", rs.getInt("IdUsuario"));
                session.setAttribute("IdEmpleado", rs.getString("IdEmpleado"));
                session.setAttribute("Usuario", rs.getString("Usuario"));
                session.setAttribute("Nombre", rs.getString("Nombre"));
                session.setAttribute("Direccion", rs.getString("Direccion"));
                session.setAttribute("DPI", rs.getString("DPI"));
                session.setAttribute("FechaNacimiento", rs.getString("FechaNacimiento"));
                session.setAttribute("Telefono", rs.getString("Telefono"));
                session.setAttribute("Descripcion", rs.getString("Descripcion"));
                session.setAttribute("IdTipoEmpleado", rs.getString("IdTipoEmpleado"));
                session.setAttribute("Foto", rs.getString("Foto"));

                response.sendRedirect("../VistaAdmin.jsp");
            }

        } else {
           
            response.sendRedirect("../index.jsp?Error=1");
        }
    } catch (SQLException e) {
        System.out.println("e = " + e);
    }
%>