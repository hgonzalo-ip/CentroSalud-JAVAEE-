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

@WebServlet("/EliminarProducto")
public class Srv_EliminarProducto extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        ///Hacer instancia a la clase conexion
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdProducto = Integer.parseInt(req.getParameter("IdProducto"));
        int Validacion = 0;

        try {

            String Eliminar_Rol = "UPDATE productos SET Estado = 0 WHERE IdProducto = " + IdProducto;

            PreparedStatement ps = conn.prepareStatement(Eliminar_Rol);

            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println("e Update Producto = " + e);
        }

        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }

}
