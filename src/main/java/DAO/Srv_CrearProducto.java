package DAO;

import conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/CrearProducto")
public class Srv_CrearProducto extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        ///Hacer instancia a la clase conexion

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        String NombreProducto = req.getParameter("Txt_NombreProducto");
        int IdTipoProducto = Integer.parseInt(req.getParameter("Slt_IdTipoProducto"));
        int Cantidad = Integer.parseInt(req.getParameter("Txt_CantidadProducto"));

        int Validacion = 0;

        try {
            String Crear_Producto = "INSERT INTO productos(IdTipoProducto, NombreProducto,Cantida, Estado ) VALUES( ?, ?, ?,1)";
            PreparedStatement ps = conn.prepareStatement(Crear_Producto);
            ps.setInt(1, IdTipoProducto);
            ps.setString(2, NombreProducto);
            ps.setInt(3, Cantidad);

            Validacion = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("e CrearProducto = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();
    }

}
