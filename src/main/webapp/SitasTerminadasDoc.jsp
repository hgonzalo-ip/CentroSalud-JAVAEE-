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
            <center><h3 class="text-center  p-2 w-50  shadow   rounded">Citas Finalizadas</h3></center>
        </div>
    </div>


    <%
        try {
            String ListarSalas = "SELECT IdReserva, IdCuarto , concat(NombrePaciente,' ',ApellidoPaciente)AS NombreC, Edad, Alergias, DescripcionCosulta AS Descripcion, Estado, FechaaFin "
                    + "FROM reservas WHERE Estado = 2 AND IdCuarto =  " + IdCuartoSession;
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
            <h5 class="card-title text-dark">En Espera</h5>]
            <%
            } else if (Estado == 2) {
            %>
            <h5 class="card-title text-dark">Finalizada</h5>
            <%
                }
            %>
            <h5>Finalizó: <%=rs.getString("FechaaFin")%></h5>
        </div>

        <center>
            <div class="row justify-content-center">
                <div class="col-md-4 form-group" onclick="VerReceta(<%=IdReserva%>)">
                    <span class="material-icons">
                        <button class="btn btn-success mr-1">

                            visibility

                        </button>
                    </span>                    
                </div>
                <div class="col-md-4 form-group" onclick="AnularSita(<%=IdReserva%>)">
                    <span class="material-icons">
                        <button class="btn btn-success mr-1">

                            domain_disabled

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
<!--Modal ver Recta-->
<div class="modal " id="ModalVerReceta">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">                
                <h4 class="modal-title">Receta</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>

            <!-- Modal body -->
            <div class="modal-body" id="Body">

            </div>



        </div>
    </div>
</div>
<script type="text/javascript">


    function VerReceta(IdReserva) {
        $.ajax({
            url: "Ajax/VerReceta.jsp",
            type: 'POST',
            data: {IdReserva},
            success: function (response) {
                $("#ModalVerReceta").modal('show');
                $("#Body").html(response);
            },
            error: function (error) {
                alertify.error("No Se encontro la dirección");
            }
        });
    }

    function AnularSita(IdReserva) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "Estas seguro de Anular la sita!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Lo quiero Anular!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'AnularSita',
                    type: 'POST',
                    data: {IdReserva},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Ya se Anulo la sita Por favor dar click en aceptar').set({onclosing: function () {
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