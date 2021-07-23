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

@WebServlet("/CrearSita")
public class Srv_CrearSita extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        ///Hacer instancia a la clase conexion
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        
        //Tomar las variables que vienen por la req
        
        int IdCuarto = Integer.parseInt(req.getParameter("Txt_IdCuarto"));
        int IdEmpleadoSesi = Integer.parseInt(req.getParameter("Txt_IdEmpleadoSes"));
        
        String NombresPaciente = req.getParameter("Txt_NombresPasiente");
        String ApellidosPaciente = req.getParameter("Txt_ApellidosPasiente");
         int Edad = Integer.parseInt(req.getParameter("Txt_Edad"));
         String Alergias = req.getParameter("TxA_Alergias");//LA BD ACEPTA NULOS 
         String Descripcion = req.getParameter("TxA_Descripcion");
         
         int Validacion = 0;
         try {
            String CrearSita = "INSERT INTO reservas(IdEmpleado, IdCuarto, NombrePaciente, ApellidoPaciente, Edad, Alergias, DescripcionCosulta ,FechaInicio, Estado) "
                    + " VALUES(?,?,?,?,?,?,?,NOW(),1)";
             PreparedStatement ps = conn.prepareStatement(CrearSita);
             ps.setInt(1, IdEmpleadoSesi);
             ps.setInt(2, IdCuarto);
             ps.setString(3, NombresPaciente);
             ps.setString(4, ApellidosPaciente);
             ps.setInt(5, Edad);
             ps.setString(6, Alergias);
             ps.setString(7, Descripcion);
             
             Validacion = ps.executeUpdate();
             
        } catch (SQLException e) {
             System.out.println("e CrearSala = " + e);
        }
         PrintWriter out = resp.getWriter();
         out.print(Validacion);
         out.close();
    }
}
