/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/GuardarUsuario")
public class Srv_GuardarUsuario extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ///Hacer instancia a la clase conexion

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        //Tomar Variables del Form 
        String Usuario = req.getParameter("Txt_Usuario");
        String Contra = req.getParameter("Txt_Contra");
        
        int Validacion = 0;
        
        try {
            String Insert_Usuario = "INSERT INTO usuarios(Usuario, Contra, Estado) VALUES( ?, SHA1(?), 1)";
            PreparedStatement ps = conn.prepareStatement(Insert_Usuario);
            ps.setString(1, Usuario);
            ps.setString(2, Contra);
            
            Validacion = ps.executeUpdate();
            
            
            
        } catch (SQLException e) {
            System.out.println("e = " + e);
        }
        
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }

}
