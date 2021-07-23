package DAO;

import conexion.Conexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ModificarProducto")
public class Srv_ModificarProducto extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {

        ///Hacer instancia a la clase conexion
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        int IdProducto = Integer.parseInt(req.getParameter("Txt_IdProducto"));

        int IdTipoProducto = Integer.parseInt(req.getParameter("Slt_IdTipoProducto"));
        String NombreProducto = req.getParameter("Txt_NombreProducto");
        int Cantidad = Integer.parseInt(req.getParameter("Txt_CantidadProducto"));
        int Estado = Integer.parseInt(req.getParameter("Slt_Estado"));

        int Validacion = 0;

        try {
            String Update = "UPDATE productos SET IdTipoProducto = ? , NombreProducto = ?,  Cantida = ?, Estado = ? WHERE IdProducto = " + IdProducto;
            PreparedStatement ps = conn.prepareStatement(Update);
            ps.setInt(1, IdTipoProducto);
            ps.setString(2, NombreProducto);
            ps.setInt(3, Cantidad);
            ps.setInt(4, Estado);

            Validacion = ps.executeUpdate();

        } catch (SQLException e) {
            System.out.println("e update Productos = " + e);
        }
        PrintWriter out = resp.getWriter();
        out.print(Validacion);
        out.close();

    }

}
