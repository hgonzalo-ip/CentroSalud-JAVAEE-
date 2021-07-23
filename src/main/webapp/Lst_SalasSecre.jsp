<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-12 form-group ">
    <div class="row p-4 justify-content-center">


        <h3 class="text-center  p-2 w-25  shadow   rounded">Salas</h3>

    </div>


    <%
        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        try {
            String ListarSalas = " SELECT c.IdCuarto, c.IdEmpleado,c.NombreCuarto ,c.Estado, e.Nombres "
                    + "FROM cuartos AS c "
                    + "INNER JOIN empleados AS e ON c.IdEmpleado = e.IdEmpleado "
                    + "WHERE c.Estado = 1";
            PreparedStatement ps = conn.prepareStatement(ListarSalas);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int Estado = rs.getInt("Estado");
                int IdCuarto = rs.getInt("IdCuarto");
                int IdEmpleado = rs.getInt("IdEmpleado");

    %>

    <div class="card"id="CardSala" style="width: 20rem; display: inline-block;  border-radius: 0.5em;border: black 1.5px inset;  cursor: pointer;">
        <div class="card-header bg-info" style="border-radius: .5em;">
            <h5 class="card-title text-dark text-center">Sala:  <%=rs.getString("NombreCuarto")%></h5>
        </div>
        <div class="card-body">
            <h5 class="card-title text-dark">Doc. <%=rs.getString("Nombres")%></h5>
            <%
                if (Estado == 1) {
            %>
            <h5 class="card-title text-dark">Activo</h5>
            <%
            } else {
            %>
            <h5 class="card-title text-dark">Inactivo</h5>
            <%
                }
            %>
        </div>
        <div class="card-footer">
            <center><!--Botones-->
                <div class="row justify-content-center">
                    <div class="col-md-5 form-group">
                        <span class="material-icons">
                            <button class="btn btn-warning" onclick="VerSitasPendientes(<%= IdCuarto%>)">

                                format_list_numbered

                            </button>
                        </span>
                        <span class="material-icons" onclick="CrearSitaModal(<%= IdCuarto%>, <%=IdEmpleado%>)">
                            <button class="btn btn-success">

                                addchart

                            </button>
                        </span>
                    </div>
                </div>
            </center>
        </div>
    </div>

    <%
            }
        } catch (SQLException e) {
            System.out.println("e Crear Sala = " + e);
        }
    %>

</div>


<!--Inicio de Modal-->

<div class="modal " id="ModalSita">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title text-center" id="Crear">Crear Sita</h4>
                <h4 class="modal-title text-center" id="Sitas"> Sitas</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>

            <!-- Modal footer -->
            <div class="modal-footer">
                <button class="btn btn-info btn-block" id="Btn1" onclick="GuardarSita();">Crear Sita</button>

            </div>

        </div>
    </div>
</div>

<script type="text/javascript">
    $(document).ready(function () {
        //Funcion para Buscar en el body de la tabla
        $("#myInput").on("keyup", function () {
            var value = $(this).val().toLowerCase();
            $("#myTable tr").filter(function () {
                $(this).toggle($(this).text().toLowerCase().indexOf(value) > -1)
            });
        });
    });


    function CrearSitaModal(IdSala, IdEmpleado) {
        $.ajax({
            url: "Ajax/Frm_CrearSita.jsp",
            type: 'POST',
            data: {IdSala, IdEmpleado},
            success: function (response) {
                $("#Crear").show();
                $("#Btn1").show();
                $("#Sitas").hide();
                $("#ModalSita").modal('show');
                $("#Body").html(response);
            },
            error : function (error){
                alertify.error("No se encontro la direccion");
            }
        });

    }
      function GuardarSita() {
        var Formulario = document.getElementById("Frm_Crear_Sita");
        if (Formulario.reportValidity()) {
            var formData = $("#Frm_Crear_Sita").serialize();
        
                    $.ajax({
                url: 'CrearSita',
                type: 'POST',
                data: formData,
                success: function (response) {
                    if (response == 1) {
                        alertify.success("Agregado correctamente");
                        $("#ModalSita").modal('hide');
                        IrSalasSecre()();
                    } else {
                        alertify.error("Ocurrio une error");
                    }
                },
                error: function (error) {
                    alertify.error("Ocurrio un error inesperado");
                }
            });
                
            
        
        }
    }
    
      function VerSitasPendientes(IdSala) {
        $.ajax({
            url: "Ajax/Frm_ListarSitasPendientes.jsp",
            type: 'POST',
            data: {IdSala},
            success: function (response) {
                $("#Btn1").hide();
                $("#Crear").hide();
                $("#Sitas").show();
                $("#ModalSita").modal('show');
                $("#Body").html(response);
            },
            error: function (error) {
                alertify.error("No se encontro la direccion");
            }
        });

    }

</script>