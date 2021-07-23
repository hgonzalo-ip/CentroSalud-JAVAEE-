
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
import javax.servlet.annotation.*;
import javax.servlet.http.*;


@WebServlet("/GuardarEmpleado")
@MultipartConfig
public class Srv_GuardarEmpleado extends HttpServlet{
    
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException{
        ///Hacer instancia a la clase conexion
        
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        
        //Tomar Variables del Form 
      int IdUsuario = Integer.parseInt(req.getParameter("Slt_IdUsuario"));
      int IdTipoEmpleado = Integer.parseInt(req.getParameter("Slt_IdTipoEmpleado"));
      String Nombres = req.getParameter("Txt_Nombre");
      String Apellidos = req.getParameter("Txt_Apellidos");
      String FechaNacimiento = req.getParameter("Txt_FechaNacimiento");
      String Direccion = req.getParameter("Txt_Direccion");
      String Telefono = req.getParameter("Txt_Telefono");
      String DPI = req.getParameter("Txt_DPI");
      Part Archivo = req.getPart("Archivo");
      
      String uniqueID = UUID.randomUUID().toString();
        InputStream is = Archivo.getInputStream();
        String TypeMime = Archivo.getContentType();
        
        String Extencion = "";
        
         if(TypeMime.equals("image/png")){
            Extencion = ".png";
        }
        else{
            Extencion = ".jpg";
        }
         
            System.out.println("Extencion = " + Extencion);
         File file = new File("D:\\Certificacion JAVA\\CentroSalud\\src\\main\\webapp\\img\\Fotos\\" + uniqueID+Extencion );
         
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
            String Guardar = "INSERT INTO empleados(IdUsuario,IdTipoEmpleado,Nombres, Apellidos, FechaNacimiento, Direccion, Telefono, DPI, Foto, Estado) "
                          + "VALUES (?,?,?,?,?,?,?,?,?,1 )";
            
            PreparedStatement ps = conn.prepareStatement(Guardar);
            ps.setInt(1, IdUsuario);
            ps.setInt(2, IdTipoEmpleado);
            ps.setString(3, Nombres);
            ps.setString(4, Apellidos);
            ps.setString(5, FechaNacimiento);
            ps.setString(6, Direccion);
            ps.setString(7, Telefono);
            ps.setString(8, DPI);
            ps.setString(9, uniqueID+Extencion);
            
             if (ps.executeUpdate()==1) {
                 
                 //Hacer el cambio de estado del usuario
                 try {
                     String Update_Estado = "UPDATE usuarios SET Estado = 2 WHERE IdUsuario =  " + IdUsuario;
                     PreparedStatement ps2 = conn.prepareStatement(Update_Estado);
                     
                     
                     Validacion = ps2.executeUpdate();
                     
                 } catch (SQLException e) {
                     System.out.println("e = " + e);
                 }
             }
            
            
        } catch (SQLException e) {
             System.out.println("e = " + e);
        }
         
         PrintWriter out = resp.getWriter();
         out.print(Validacion);
         out.close();
    }
    
}
