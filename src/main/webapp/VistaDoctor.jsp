<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<!DOCTYPE html>

<%@include file="includes/heder.jsp" %>
<%@include file="includes/sidebar.jsp" %>

<html>


    <body ><br>
        <div id="page-container " class=" w-100">

            <%@include file="includes/Nav.jsp" %>

            <div  class="row justify-content-center m-4 ">

                <div id="Dv_Contenido" class="col-md-12 p-3">  
                    <br>
               
                    <br>
                </div>
            </div>

        </div>
        <!--Cierre del div del nav-->

        <!--Cierre del div del Menu del lado derecho-->

        <!--Cierre del div del Menu del lado derecho-->
    </body>

</html>
<script type="text/javascript">
    $(document).ready(function () {
        IrSitasPendientes();
    });


    function IrSitasPendientes() {
        $.ajax({
            url: 'SitasPendientesDoc.jsp',
            type: 'POST',
            success: function (response) {
                $("#Dv_Contenido").html(response);
            },
            error: function (error) {
                alertify.error('Por Favor Crear un sala');
            }
        });
    }
     function IrSitasFinalizadas() {
        $.ajax({
            url: 'SitasTerminadasDoc.jsp',
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