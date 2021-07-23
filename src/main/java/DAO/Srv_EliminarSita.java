package DAO;
import conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
@WebServlet("/EliminarSita")
public class Srv_EliminarSita extends HttpServlet{
    
    protected void doPost(HttpServletRequest req , HttpServletResponse resp) throws IOException{
    
            Conexion conex = new Conexion();
            Connection conn = conex.getConnection();
            
            int IdReserva = Integer.parseInt(req.getParameter("IdReserva"));
            System.out.println("IdReserva = " + IdReserva);
            int Validacion = 0;
            try {
            
                String sql = "UPDATE reservas SET Estado = 0 WHERE IdReserva = " + IdReserva;
                PreparedStatement ps = conn.prepareStatement(sql);
                Validacion = ps.executeUpdate();
                
                
        } catch (SQLException e) {
                System.out.println(" e eliminar reserva = " + e);
        }
            PrintWriter out = resp.getWriter();
            out.print(Validacion);
            out.close();
    }    
}
