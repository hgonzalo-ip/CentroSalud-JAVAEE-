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

@WebServlet("/ModficarDatosSita")
public class Srv_ModificarDatosSita extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        //Hacer instancia a al clase Conexion 
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        //Variables que bienen por la req
        int IdReserba = Integer.parseInt(req.getParameter("Txt_IdReserba"));
        int IdSala = Integer.parseInt(req.getParameter("Slt_Sala"));
        String NombreP = req.getParameter("Txt_NombresP");
        String ApellidosP = req.getParameter("Txt_ApellidosP");
        int Edad = Integer.parseInt(req.getParameter("Txt_Edad"));
        String Alergias = req.getParameter("Txt_AlegiasP");
        String Descripcion = req.getParameter("Txt_DescripcionP");

        //Variable para la validación
        int Validacion = 0;
        try {
            String Update_Datos_Sita = "UPDATE reservas SET IdCuarto = ?, "
                    + "NombrePaciente = ?, "
                    + "ApellidoPaciente = ?, "
                    + "Edad = ?, "
                    + "Alergias = ?, "
                    + "DescripcionCosulta = ?  "
                    + "WHERE IdReserva = " + IdReserba;
            PreparedStatement ps = conn.prepareStatement(Update_Datos_Sita);
            ps.setInt(1, IdSala);
            ps.setString(2, NombreP);
            ps.setString(3, ApellidosP);
            ps.setInt(4, Edad);
            ps.setString(5, Alergias);
            ps.setString(6, Descripcion);

            Validacion = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("e uptade datos sita = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }

}
