
package DAO;

import com.mysql.cj.PreparedQuery;
import conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;


@WebServlet("/ModificarUsuario")
public class Srv_ModificarUsuario extends HttpServlet{
    
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
        
                ///Hacer instancia a la clase conexion
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        
        //Variables
        int IdUsuario = Integer.parseInt(req.getParameter("Txt_IdUsuario"));
        String Usuario = req.getParameter("Txt_UsuarioNuevo");
        String ContraNueva = req.getParameter("Txt_ContraNueva");
        
        int Estado = Integer.parseInt(req.getParameter("Slt_Estado"));
                
        int Validacion = 0;
            if (ContraNueva.equals("")) {
            //Si la Variable es nula no va a modificar la contra 
            try {
                
                String Update_Usuario = "UPDATE usuarios SET Usuario = ? , Estado = ? WHERE IdUsuario = " + IdUsuario;
                PreparedStatement ps = conn.prepareStatement(Update_Usuario);
                ps.setString(1, Usuario);
                ps.setInt(2, Estado);
                
                Validacion = ps.executeUpdate();
                
            } catch (SQLException e) {
                System.out.println("e Update Usuario 1 = " + e);  
            }
            
            PrintWriter out = resp.getWriter();
            out.print(Validacion);
            
        }else{
            
            
            
                   try {
                
                String Update_Usuario = "UPDATE usuarios SET Usuario = ?, Contra = SHA1(?), Estado = ?  WHERE IdUsuario = " + IdUsuario;
                PreparedStatement ps = conn.prepareStatement(Update_Usuario);
                ps.setString(1, Usuario);
                ps.setString(2, ContraNueva);
                ps.setInt(3, Estado);
                
                Validacion = ps.executeUpdate();
                
            } catch (SQLException e) {
                System.out.println("e Update Usuario 2 = " + e);  
            }
            
            PrintWriter out = resp.getWriter();
            out.print(Validacion);
            
        
        }
        
    
    }
    
}
