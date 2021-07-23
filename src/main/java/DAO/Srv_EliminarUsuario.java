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

@WebServlet("/EliminarUsuario")
public class Srv_EliminarUsuario extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdUsuario = Integer.parseInt(req.getParameter("IdUsuario"));
        int Validacion = 0;
        try {
            String EliminarUsu = "UPDATE usuarios SET Estado = 0 WHERE IdUsuario = " + IdUsuario;
            PreparedStatement ps = conn.prepareStatement(EliminarUsu);

            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("EliminarUsu = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }
}
