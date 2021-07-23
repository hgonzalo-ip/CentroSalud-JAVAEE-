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

@WebServlet("/EliminarEmpleado")
public class Srv_EliminarEmpleado extends HttpServlet{
    
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
    
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        
       int IdEmpleado = Integer.parseInt(req.getParameter("IdEmpleado"));
       int Validacion = 0;
        try {
            String Eliminar  = "UPDATE empleados SET Estado = 0 WHERE IdEmpleado = ? ";
            PreparedStatement ps = conn.prepareStatement(Eliminar);
            ps.setInt(1, IdEmpleado);
            
            
            
            
            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("e = " + e);
        }
        
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    
    }
}
