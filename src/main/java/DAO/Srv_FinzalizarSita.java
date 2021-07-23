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

@WebServlet("/FinzalizarReserva")
public class Srv_FinzalizarSita extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ///Hacer instancia a la clase conexion

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdReserva = Integer.parseInt(req.getParameter("IdReserva"));
        int Validacion = 0;
        try {
            String Update_Reserva = "UPDATE reservas SET Estado = 2 , FechaaFin = NOW() WHERE IdReserva = " + IdReserva;
            PreparedStatement ps1 = conn.prepareStatement(Update_Reserva);
            if (ps1.executeUpdate() == 1) {
                String Update_Receta = "UPDATE recetas SET Estado = 1 WHERE IdReserva = " + IdReserva;
                PreparedStatement ps2 = conn.prepareStatement(Update_Receta);
                Validacion = ps2.executeUpdate();
            }

        } catch (SQLException e) {
            System.out.println("e Finzalizar Sita = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }
}
