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
import javax.servlet.annotation.*;
import javax.servlet.http.*;

@WebServlet("/CrearDetalleReceta")
public class Srv_CrearDetalleReceta extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ///Hacer instancia a la clase conexion

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdProducto = Integer.parseInt(req.getParameter("IdProducto"));
        int Cantidad = Integer.parseInt(req.getParameter("Cantidad"));
        String Descripcion = req.getParameter("Descripcion");
        int Validacion = 0;
        try {
            String Ultima_Receta = "SELECT IdReceta "
                    + "FROM recetas "
                    + "ORDER by IdReceta DESC "
                    + "LIMIT 1";
            PreparedStatement ps1 = conn.prepareStatement(Ultima_Receta);
            ResultSet rs1 = ps1.executeQuery();

            if (rs1.next()) {
                int IdUltimaReceta = rs1.getInt("IdReceta");//Tomo el id de la ultima receta que se creo para hacer los receta dellate

                String CantidadProducto = "SELECT IdProducto , cantida FROM productos WHERE IdProducto = " + IdProducto;
                PreparedStatement ps2 = conn.prepareStatement(CantidadProducto);
                ResultSet rs2 = ps2.executeQuery();
                if (rs2.next()) {
                    int StokProducto = rs2.getInt("cantida");

                    String InsertDetalleReceta = "INSERT INTO detallereceta(IdReceta,IdProducto,Cantidad,Descripcion,Estado) VALUES(?, ?,?,?,1) ";
                    PreparedStatement ps3 = conn.prepareStatement(InsertDetalleReceta);
                    ps3.setInt(1, IdUltimaReceta);
                    ps3.setInt(2, IdProducto);
                    ps3.setInt(3, Cantidad);
                    ps3.setString(4, Descripcion);

                    if (ps3.executeUpdate() == 1) {
                        int NuevoStok = StokProducto - Cantidad;

                        String Update_Producto = "UPDATE productos SET Cantida = ? WHERE IdProducto = " + IdProducto;
                        PreparedStatement ps4 = conn.prepareStatement(Update_Producto);
                        ps4.setInt(1, NuevoStok);

                        Validacion = ps4.executeUpdate();
                    }

                }
            }

        } catch (SQLException e) {
            System.out.println("e CrearDetalleReceta = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }

}
