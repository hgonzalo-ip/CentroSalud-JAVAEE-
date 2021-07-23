/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ModificarRol")
public class Srv_ModificarRol extends HttpServlet{
    
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{ 
        
          ///Hacer instancia a la clase conexion
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        
        int IdRol = Integer.parseInt(req.getParameter("Txt_IdRol"));
        String Descripcion = req.getParameter("Txt_Rol");
        int Estado = Integer.parseInt(req.getParameter("Slt_Estado"));
        
        
        int Validacion = 0;
        try {
            String Update_Rol = "UPDATE tipoempleado SET Descripcion = ?, Estado = ?  WHERE IdTipoEmpleado = "+ IdRol;
            PreparedStatement ps = conn.prepareStatement(Update_Rol);
            ps.setString(1, Descripcion);
            ps.setInt(2, Estado);
            
            Validacion = ps.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println("e = " + e);
        }
        
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();

    }
    
}
