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

@WebServlet("/QuitarProducto")
public class Srv_QuitarProducto extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdProducto = Integer.parseInt(req.getParameter("Txt_IdProducto"));
        int CantidadActual = Integer.parseInt(req.getParameter("Txt_CantidadActual"));
        int CantidadNueva = Integer.parseInt(req.getParameter("Txt_CantidadProducto"));

        int Validacion = 0;
        try {

            //Opreacion 
            int NuevaCantidad = CantidadActual - CantidadNueva;
            String UpdateCatidad = "UPDATE productos SET Cantida = ? WHERE IdProducto = " + IdProducto;
            PreparedStatement ps = conn.prepareStatement(UpdateCatidad);
            ps.setInt(1, NuevaCantidad);

            Validacion = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(" e Update Quitar Cantidad Productos = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }

}
