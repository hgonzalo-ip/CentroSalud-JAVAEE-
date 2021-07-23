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

@WebServlet("/CrearReceta")
public class Srv_CrearReceta extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        ///Hacer instancia a la clase conexion
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdRecerva = Integer.parseInt(req.getParameter("IdRecerva"));
        int Validacion = 0;
        try {
            String CrearReceta = " INSERT INTO recetas(IdReserva , Estado) VALUES(?,0)";
            PreparedStatement ps = conn.prepareStatement(CrearReceta);
            ps.setInt(1, IdRecerva);

            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("e CrearReseta = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }
}
