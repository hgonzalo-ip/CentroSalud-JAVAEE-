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

@WebServlet("/ModificarsSala")
public class Srv_ModificarSala extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdSala = Integer.parseInt(req.getParameter("Txt_IdSala"));
        String NombreSala = req.getParameter("Txt_NombreSala");
        int IdEmpleado = Integer.parseInt(req.getParameter("Slt_IdEmpleado"));
        int Estado = Integer.parseInt(req.getParameter("Slt_Estado"));
        
        int Validacion = 0;
        
        try {
            String UpdateSala = "UPDATE cuartos SET NombreCuarto = ?, IdEmpleado = ? , Estado =? WHERE IdCuarto =  " + IdSala;
            PreparedStatement ps = conn.prepareStatement(UpdateSala);
            ps.setString(1, NombreSala);
            ps.setInt(2, IdEmpleado);
            ps.setInt(3, Estado);
            
            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("e update sala = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }

}
