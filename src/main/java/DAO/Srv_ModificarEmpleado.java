/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package DAO;


import conexion.Conexion;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.sql.*;
import java.util.UUID;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/ModificarEmpleado")
@MultipartConfig
public class Srv_ModificarEmpleado extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        ///Hacer instancia a la clase conexion

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();

        //Tomar Variables del Form 
        String IdUsuarioNuevo = req.getParameter("Slt_IdUsuarioNuevo");
        System.out.println("IdUsuarioNuevo = " + IdUsuarioNuevo);
        String IdUsuarioLi = req.getParameter("IdUsuarioViejo");
//Validar si se hizo un cabio de usuario
        System.out.println("IdUsuarioLi = " + IdUsuarioLi);
        int IdEmpleado = Integer.parseInt(req.getParameter("IdEmpleado"));
        
        String IdTipoEmpleado = req.getParameter("Slt_IdTipoEmpleado");
        String Nombres = req.getParameter("Txt_Nombre");
        String Apellidos = req.getParameter("Txt_Apellidos");
        String FechaNacimiento = req.getParameter("Txt_FechaNacimiento");
        String Direccion = req.getParameter("Txt_Direccion");
        String Telefono = req.getParameter("Txt_Telefono");
        String DPI = req.getParameter("Txt_DPI");

        Part Archivo = req.getPart("Archivo");
        int Estado = Integer.parseInt(req.getParameter("Slt_Estado"));

        if (Archivo.equals("")) {

              if (IdUsuarioNuevo == null) {// Si el usuario es el mismo no cambiara el estado del Usuario solo se hara el update a empleados

                String uniqueID = UUID.randomUUID().toString();
                InputStream is = Archivo.getInputStream();
                String TypeMime = Archivo.getContentType();

                String Extencion = "";

                if (TypeMime.equals("image/png")) {
                    Extencion = ".png";
                } else {
                    Extencion = ".jpg";
                }

                System.out.println("Extencion = " + Extencion);
                File file = new File("D:\\Certificacion JAVA\\CentroSalud\\src\\main\\webapp\\img\\Fotos\\" + uniqueID + Extencion);

                FileOutputStream ous = new FileOutputStream(file);

                int dato = is.read();

                while (dato != -1) {
                    ous.write(dato);
                    dato = is.read();

                }

                ous.close();
                is.close();

                int Validacion = 0;

                try {
                    String UptadeEmp = "UPDATE empleados SET IdUsuario = ? , IdTipoEmpleado = ? , Nombres = ?, Apellidos = ? , FechaNacimiento =?,Direccion = ?, Telefono = ?, DPI =? ,Estado =? "
                            + "WHERE IdEmpleado = " + IdEmpleado;

                    PreparedStatement ps = conn.prepareStatement(UptadeEmp);
                    ps.setString(1, IdUsuarioLi);
                    ps.setString(2, IdTipoEmpleado);
                    ps.setString(3, Nombres);
                    ps.setString(4, Apellidos);
                    ps.setString(5, FechaNacimiento);
                    ps.setString(6, Direccion);
                    ps.setString(7, Telefono);
                    ps.setString(8, DPI);                    
                    ps.setInt(9, Estado);

                    Validacion = ps.executeUpdate();
                   
                } catch (SQLException e) {
                    System.out.println("e 1= " + e);
                }
                 PrintWriter out = resp.getWriter();
                    out.print(Validacion);
                    out.close();
            } else {
                /// Si el usuario cambia se realiza el update del estado a 1 
                String uniqueID = UUID.randomUUID().toString();
                InputStream is = Archivo.getInputStream();
                String TypeMime = Archivo.getContentType();

                String Extencion = "";

                if (TypeMime.equals("image/png")) {
                    Extencion = ".png";
                } else {
                    Extencion = ".jpg";
                }

                System.out.println("Extencion = " + Extencion);
                File file = new File("D:\\Certificacion JAVA\\CentroSalud\\src\\main\\webapp\\img\\Fotos\\" + uniqueID + Extencion);

                FileOutputStream ous = new FileOutputStream(file);

                int dato = is.read();

                while (dato != -1) {
                    ous.write(dato);
                    dato = is.read();

                }

                ous.close();
                is.close();

                int Validacion = 0;

                try {
                    String UptadeEmp = "UPDATE empleados SET IdUsuario = ? , IdTipoEmpleado = ? , Nombres = ?, Apellidos = ? , FechaNacimiento =?,Direccion = ?, Telefono = ?, DPI =? ,Estado =? "
                            + "WHERE IdEmpleado = " + IdEmpleado;

                    PreparedStatement ps = conn.prepareStatement(UptadeEmp);
                    ps.setString(1, IdUsuarioNuevo);
                    ps.setString(2, IdTipoEmpleado);
                    ps.setString(3, Nombres);
                    ps.setString(4, Apellidos);
                    ps.setString(5, FechaNacimiento);
                    ps.setString(6, Direccion);
                    ps.setString(7, Telefono);
                    ps.setString(8, DPI);
                    
                    ps.setInt(9, Estado);

                    if (ps.executeUpdate() == 1) {
                        String Update_Estado_Usuario = "UPDATE usuarios SET Estado = 1 WHERE IdUsuario = ?";
                        PreparedStatement ps2 = conn.prepareStatement(Update_Estado_Usuario);
                        ps2.setString(1, IdUsuarioLi);

                       Validacion = ps2.executeUpdate();
                    }

                } catch (SQLException e) {
                    System.out.println("e 2 = " + e);
                }
                   PrintWriter out = resp.getWriter();
                        out.print(Validacion);
                        out.close();

            }

        } else {
            
            if (IdUsuarioNuevo == null) {// Si el usuario es el mismo no cambiara el estado del Usuario solo se hara el update a empleados

                String uniqueID = UUID.randomUUID().toString();
                InputStream is = Archivo.getInputStream();
                String TypeMime = Archivo.getContentType();

                String Extencion = "";

                if (TypeMime.equals("image/png")) {
                    Extencion = ".png";
                } else {
                    Extencion = ".jpg";
                }

                System.out.println("Extencion = " + Extencion);
                File file = new File("D:\\Certificacion JAVA\\CentroSalud\\src\\main\\webapp\\img\\Fotos\\" + uniqueID + Extencion);

                FileOutputStream ous = new FileOutputStream(file);

                int dato = is.read();

                while (dato != -1) {
                    ous.write(dato);
                    dato = is.read();

                }

                ous.close();
                is.close();

                int Validacion = 0;

                try {
                    String UptadeEmp = "UPDATE empleados SET IdUsuario = ? , IdTipoEmpleado = ? , Nombres = ?, Apellidos = ? , FechaNacimiento =?,Direccion = ?, Telefono = ?, DPI =?, Foto = ? ,Estado =? "
                            + "WHERE IdEmpleado = " + IdEmpleado;

                    PreparedStatement ps = conn.prepareStatement(UptadeEmp);
                    ps.setString(1, IdUsuarioLi);
                    ps.setString(2, IdTipoEmpleado);
                    ps.setString(3, Nombres);
                    ps.setString(4, Apellidos);
                    ps.setString(5, FechaNacimiento);
                    ps.setString(6, Direccion);
                    ps.setString(7, Telefono);
                    ps.setString(8, DPI);
                     ps.setString(9, uniqueID + Extencion);
                    ps.setInt(10, Estado);

                   Validacion = ps.executeUpdate();
                } catch (SQLException e) {
                    System.out.println("e 3 = " + e);
                }
                 
                    PrintWriter out = resp.getWriter();
                    out.print(Validacion);
                    out.close();

            } else {
                /// Si el usuario cambia se realiza el update del estado a 1 
                String uniqueID = UUID.randomUUID().toString();
                InputStream is = Archivo.getInputStream();
                String TypeMime = Archivo.getContentType();

                String Extencion = "";

                if (TypeMime.equals("image/png")) {
                    Extencion = ".png";
                } else {
                    Extencion = ".jpg";
                }

                System.out.println("Extencion = " + Extencion);
                File file = new File("D:\\Certificacion JAVA\\CentroSalud\\src\\main\\webapp\\img\\Fotos\\" + uniqueID + Extencion);

                FileOutputStream ous = new FileOutputStream(file);

                int dato = is.read();

                while (dato != -1) {
                    ous.write(dato);
                    dato = is.read();

                }

                ous.close();
                is.close();

                int Validacion = 0;

                try {
                    String UptadeEmp = "UPDATE empleados SET IdUsuario = ? , IdTipoEmpleado = ? , Nombres = ?, Apellidos = ? , FechaNacimiento =?,Direccion = ?, Telefono = ?, DPI =?, Foto = ? ,Estado =? "
                            + "WHERE IdEmpleado = " + IdEmpleado;

                    PreparedStatement ps = conn.prepareStatement(UptadeEmp);
                    ps.setString(1, IdUsuarioNuevo);
                    ps.setString(2, IdTipoEmpleado);
                    ps.setString(3, Nombres);
                    ps.setString(4, Apellidos);
                    ps.setString(5, FechaNacimiento);
                    ps.setString(6, Direccion);
                    ps.setString(7, Telefono);
                    ps.setString(8, DPI);
                    ps.setString(9, uniqueID + Extencion);
                    ps.setInt(10, Estado);

                    if (ps.executeUpdate() == 1) {
                        String Update_Estado_Usuario = "UPDATE usuarios SET Estado = 2 WHERE IdUsuario = ?";
                        PreparedStatement ps2 = conn.prepareStatement(Update_Estado_Usuario);
                        ps2.setString(1, IdUsuarioNuevo);

                       

                        if(ps2.executeUpdate()== 1){
                            String Update_Estado_Usuario_viejo = "UPDATE usuarios SET Estado = 1 WHERE IdUsuario = ?";
                        PreparedStatement ps3 = conn.prepareStatement(Update_Estado_Usuario_viejo);
                        ps3.setString(1, IdUsuarioLi);
                        Validacion=ps3.executeUpdate();
                        }
                    }

                } catch (SQLException e) {
                    System.out.println("e 4 = " + e);
                }
                 PrintWriter out = resp.getWriter();
                        out.print(Validacion);
                        out.close();
            }

        }

    }

}
