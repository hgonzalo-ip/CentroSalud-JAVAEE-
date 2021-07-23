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

@WebServlet("/EntregarReceta")
public class Srv_EntregarReceta extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdReceta = Integer.parseInt(req.getParameter("IdReceta"));
        int Validacion = 0;
        try {
            String EntregarReceta = "UPDATE recetas SET Estado = 2 WHERE IdReceta = " + IdReceta;
            PreparedStatement ps = conn.prepareStatement(EntregarReceta);
            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("e Entregar Receta = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }
}
