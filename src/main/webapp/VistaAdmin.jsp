<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@include file="includes/heder.jsp" %>
<%@include file="includes/sidebar.jsp" %>


<html>

    <body ><br>

        <div id="page-container " class=" w-100 ">

            <%@include file="includes/Nav.jsp" %>

            <div  class="row justify-content-center m-4 ">

                <div id="Dv_Contenido" class="col-md-12 p-3">  
                    <br>

                    <br>
                </div>
            </div>

        </div><!--Cierre del div del nav-->

        <!--Cierre del div del Menu del lado derecho-->
    </body>
    <script type="text/javascript">
        $(document).ready(function () {
            IrEmpleados();
        });
        function IrEmpleados() {
            $.ajax({
                url: "Empleados.jsp",
                type: 'POST',
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se enconto la direccion');
                }
            });
        }
        function IrUsuarios() {
            $.ajax({
                url: "Usuarios.jsp",
                type: 'POST',
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se enconto la direccion');
                }
            });
        }
        function IrRoles() {
            $.ajax({
                url: "Roles.jsp",
                type: 'POST',
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se enconto la direccion');
                }
            });
        }
        function IrProductos() {
            $.ajax({
                url: "Productos.jsp",
                type: 'POST',
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se enconto la direccion');
                }
            });
        }

        function IrSalas() {
            $.ajax({
                url: "Salas.jsp",
                type: 'POST',
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se enconto la direccion');
                }
            });
        }
        function IrSitas() {
            $.ajax({
                url: 'Lst_SitasSecre.jsp',
                type: 'POST',
                success: function (response) {
                    $("#Dv_Contenido").html(response);
                },
                error: function (error) {
                    alertify.error('No se encontro la direccion');
                }
            });
        }
    </script>
</html>
