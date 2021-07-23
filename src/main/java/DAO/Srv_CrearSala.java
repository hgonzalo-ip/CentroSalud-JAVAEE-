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

@WebServlet("/CrearSala")
public class Srv_CrearSala extends HttpServlet{
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException{
    
        
           ///Hacer instancia a la clase conexion

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        
        String NombreSala = req.getParameter("Txt_NombreSala");
        int IdEmpleado = Integer.parseInt(req.getParameter("Slt_IdEmpleado"));
        
        int Validacion = 0;
        
        try {
            String CrearSala = "INSERT INTO cuartos(NombreCuarto, IdEmpleado , Estado) VALUES( ?, ? , 1 )";
            PreparedStatement ps = conn.prepareStatement(CrearSala);
            ps.setString(1, NombreSala);
            ps.setInt(2, IdEmpleado);
            
            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("e Crear Sala = " + e);
        }
        
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }
    
}
