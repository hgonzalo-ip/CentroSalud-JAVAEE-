
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<div>

    <center>
        <h3 class="text-center  p-2 w-25  shadow   rounded">Recetas Pendientes</h3>
    </center><br>
    <table style="padding-left: 21%;" class="table table-hover table-primary mt-3 table-responsive">
        <thead>
        <th>#</th>
        <th>Nombre Paciente</th>
        <th>Edad</th>
        <th>Nombre Sala</th>
        <th>Doctor</th>
        <th>Detalles</th>
        <th>Entregar</th>
        </thead>
        <tbody>
            <%
                try {
                    Conexion conex = new Conexion();
                    Connection conn = conex.getConnection();

                    String ListarReceta = "SELECT re.IdReserva, re.IdReceta,re.Estado ,CONCAT(r.NombrePaciente,' ',r.ApellidoPaciente)AS NombreCom, r.Edad, c.NombreCuarto, CONCAT(e.Nombres,' ',e.Apellidos)AS Doctor "
                            + "FROM recetas AS re "
                            + "INNER JOIN reservas AS r ON re.IdReserva = r.IdReserva "
                            + "INNER JOIN cuartos AS c ON r.IdCuarto = c.IdCuarto "
                            + "INNER JOIN empleados AS e ON c.IdEmpleado = e.IdEmpleado "
                            + "WHERE re.Estado = 1";
                    PreparedStatement ps2 = conn.prepareStatement(ListarReceta);
                    ResultSet rs2 = ps2.executeQuery();
                    int Contador = 0;
                    while (rs2.next()) {
                        Contador++;
            %>
            <tr>
                <td><%=Contador%></td>
                <td><%=rs2.getString("NombreCom")%></td>
                <td><%=rs2.getString("Edad")%></td>
                <td><%=rs2.getString("NombreCuarto")%></td>
                <td><%=rs2.getString("Doctor")%></td>
                <td>
                    <span class="material-icons">
                        <button class="btn btn-success"  onclick="VerReceta(<%=rs2.getString("IdReceta")%>)">
                            remove_red_eye
                        </button>
                    </span>
                </td> 
                <td>
                    <span class="material-icons">
                        <button class="btn btn-success"  onclick="EntregarReceta(<%=rs2.getString("IdReceta")%>)">
                            playlist_add_check
                        </button>
                    </span>
                </td> 
            </tr>

            <%
                    }

                } catch (SQLException er) {
                    System.out.println("e tabla Receta Pendientes FAR = " + er);
                }
            %>  
        </tbody>
    </table>
</div>
<!--Modal Receta-->
<div class="modal " id="ModalVerDetalleReceta">
    <div class="modal-dialog modal-xl">
        <div class="modal-content">

            <!-- Modal Header -->
            <div class="modal-header">                
                <h4 class="modal-title" id="Modificar">Receta</h4>
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

    function VerReceta(IdReceta) {
        $.ajax({
            url: "Ajax/TblVerDetalleReceta.jsp",
            type: 'POST',
            data: {IdReceta},
            success: function (response) {
                $("#ModalVerDetalleReceta").modal('show');
                $("#Body").html(response);
            },
            error: function (error) {
                alertify.error("No se encontro la Dirección");
            }
        });
    }
    function EntregarReceta(IdReceta) {
        Swal.fire({
            title: 'Estas Seguro?',
            text: "En entregar esta Receta!",
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#3085d6',
            cancelButtonColor: '#d33',
            confirmButtonText: 'Si, Lo quiero Entregar!'
        }).then((result) => {
            if (result.value) {
                $.ajax({
                    url: 'EntregarReceta',
                    type: 'POST',
                    data: {IdReceta},
                    success: function (response) {
                        if (response == 1) {
                            alertify.confirm('Tu Entrega se esta Procesando...Aceptar para Continuar').set({onclosing: function () {
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