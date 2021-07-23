/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;

import conexion.Conexion;
import java.io.*;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AnularSita")
public class Srv_AnularSita extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        int IdRecerva = Integer.parseInt(req.getParameter("IdReserva"));
        int Validacion = 0;

        try {
            String AnularSita = "UPDATE reservas SET Estado = 1 WHERE IdReserva = " + IdRecerva;
            PreparedStatement ps = conn.prepareStatement(AnularSita);
            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("e AnularSita = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }
}
