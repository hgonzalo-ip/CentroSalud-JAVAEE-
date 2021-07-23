<%@page import="java.sql.*"%>
<%@page import="conexion.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<div class="col-md-12 form-group ">
    <div class="row p-4">       
        <div class="col-md-12 justify-content-center">
            <%
                Conexion conex = new Conexion();
                Connection conn = conex.getConnection();
                String IdCuartoSessionSTR = (String) session.getAttribute("IdCuarto");

                int IdCuartoSession = Integer.parseInt(IdCuartoSessionSTR);
               
            %>
            <center><h3 class="text-center  p-2 w-50  shadow   rounded">Citas Pendientes</h3></center>
        </div>
    </div>


    <%
        try {
            String ListarSalas = "SELECT IdReserva, IdCuarto , concat(NombrePaciente,' ',ApellidoPaciente)AS NombreC, Edad, Alergias, DescripcionCosulta AS Descripcion, Estado "
                    + "FROM reservas WHERE Estado = 1 AND IdCuarto =  " + IdCuartoSession;
            PreparedStatement ps = conn.prepareStatement(ListarSalas);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int Estado = rs.getInt("Estado");
                int IdReserva = rs.getInt("IdReserva");


    %>

    <div class="card" id="CardSala" style="width: 20rem; display: inline-block;  border-radius: 0.5em;border: black 1.5px inset;  cursor: pointer;">
        <div class="card-header bg-info" style="border-radius: .5em;">
            <h5 class="card-title text-dark text-center"><%=rs.getString("NombreC")%></h5>
        </div>
        <div class="card-body">
            <div class="row">                
                <div class="col-md-10">
                    <h5 class="card-title text-dark">Edad: <%=rs.getString("Edad")%> Años</h5>
                </div>
            </div>
            <div class="row">
                <div class="col-md-10">
                    <h5 class="card-title text-dark">Alergias: <%=rs.getString("Alergias")%></h5>
                </div>
            </div>
            <div class="row">
                <div class="col-md-10" >
                    <h6>  Descripciòn: <%=rs.getString("Descripcion")%></h6>
                </div>

            </div>

            <%
                if (Estado == 1) {
            %>
            <h5 class="card-title text-dark">En Espera</h5>
            <%
                }
            %>
        </div>

        <center>
            <div class="row justify-content-center">
                <div class="col-md-8 form-group">
                    <span class="material-icons" onclick="ModalAgregarReceta(<%=IdReserva%>)">
                        <button class="btn btn-warning mr-1">

                            receipt_long

                        </button>
                    </span>
                    <span class="material-icons">
                        <button class="btn btn-success" onclick="FinalizarSita(<%=IdReserva%>)">

                            assignment_turned_in

                        </button>
                    </span>
                </div>
            </div>
        </center>

    </div>

    <%
            }
        } catch (SQLException e) {
            System.out.println("e Crear Sala = " + e);
        }
    %>

</div>
<!--Modal Receta-->
<div class="modal " id="ModalReceta">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">                
                <h4 class="modal-title" id="Modificar">Agregar Receta</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>

            <!-- Modal footer -->
          

        </div>
    </div>
</div>
<script type="text/javascript">
    function ModalAgregarReceta(IdRecerva) {
        $.ajax({
            url: "Ajax/Tbl_AgregarReceta.jsp",
            type: 'POST',
            data: {IdRecerva},
            success: function (response) {
                $("#ModalReceta").modal('show');
                $("#Body").html(response);
            },
            error: function (error) {
                alertify.error("No se encontro la Dirección");
            }
        });
    }
    function FinalizarSita(IdReserva) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "Estas seguro de terminar la Cita!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Finalizar Cita!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'FinzalizarReserva',
                    type: 'POST',
                    data: {IdReserva},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Ya se finalizo la sita Por favor dar click en aceptar').set({onclosing: function () {
                                    location.reload();
                                }});
                        } else {
                            swal({
                                icon: 'error',
                                text: 'Error '
                            });
                            return false;
                        }

                    },
                    error: function (error) {
                        alert('No se encontro la direccion');
                    }
                });
            }
        });
    }
</script>