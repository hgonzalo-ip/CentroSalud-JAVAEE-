/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package conexion;

import java.sql.*;
import java.util.logging.*;



public class Conexion {
    
    private static Connection conn;
    
    public Conexion(){
    
        conn = null;
        
        String url = "jdbc:mysql://localhost:3306/centrosalud?useSSL=false&serverTimezone=UTC";
        
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                conn = DriverManager.getConnection(url, "root" , "");
                
                if (conn != null) {
                    System.out.println("Conexion Establecida=");
                }
            } catch (ClassNotFoundException e) {
                
                System.out.println("error = " + e);
            
            } catch (SQLException ex){
                Logger.getLogger(Conexion.class.getName()).log(Level.SEVERE, null, ex);
            }
    }
        public Connection getConnection(){
        return conn;
    }
    
    
}
