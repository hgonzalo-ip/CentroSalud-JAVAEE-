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

@WebServlet("/EliminarSala")
public class Srv_EliminarSala extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdSala = Integer.parseInt(req.getParameter("IdSala"));
        int Validacion = 0;
        try {
            String EliminarSala = " UPDATE cuartos SET Estado = 0 WHERE IdCuarto = " + IdSala;
            PreparedStatement ps = conn.prepareStatement(EliminarSala);
            
            Validacion = ps.executeUpdate();
            
        } catch (SQLException e) {
            System.out.println("e eliminar Sala = " + e);
        }
        
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }

}
