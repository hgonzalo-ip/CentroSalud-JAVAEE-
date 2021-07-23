<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="conexion.Conexion"%>

<%
    int IdRecerva = Integer.parseInt(request.getParameter("IdRecerva"));
%>
<div class="col-md-4">
    <button id="BotonCrearReceta" class="btn btn-info " onclick="CrearReceta(<%=IdRecerva%>)"><span class="material-icons">
            add
        </span>
    </button>

</div>
<input class="form-control mt-3" id="myInput" type="text" placeholder="Buscar..">
<table style="display: none;"  class="table table-hover table-primary mt-3 table-responsive" id="TablaReceta">
    <thead>
    <th>ID</th>
    <th>Nombre Producto</th>
    <th>Tipo</th>
    <th>Stock</th>
    <th>Canditad</th>
    <th>Descripcion</th>
    <th>Estado</th>
    <th>Agregar</th>

</thead>

<tbody id="myTable">
    <%

        Conexion conex = new Conexion();
        Connection conn = conex.getConnection();
        try {
            String ListarProduc = "SELECT p.IdProducto, p.NombreProducto, tp.Descripcion , p.Cantida, p.Estado "
                    + "FROM productos AS p "
                    + "INNER JOIN tipoproducto AS tp ON p.IdTipoProducto = tp.IdTipoProducto "
                    + "WHERE p.Estado = 1 ";

            PreparedStatement ps = conn.prepareStatement(ListarProduc);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int Estado = rs.getInt("Estado");
                int IdProducto = rs.getInt("IdProducto");
    %>     
    <tr>
        <td><%=rs.getInt("IdProducto")%></td>
        <td><%=rs.getString("NombreProducto")%></td>
        <td><%=rs.getString("Descripcion")%></td>
        <td><%=rs.getInt("Cantida")%></td>



        <td>
            <input type="number"  id="Cantidad<%=rs.getInt("IdProducto")%>" class="form-control">
        </td>
        <td>
            <input type="text"  id="Descripcion<%=rs.getInt("IdProducto")%>" class="form-control">
        </td>

        <td>
            <%
                if (Estado == 1) {
            %>
            Activo
            <%
            } else if (Estado == 0) {
            %>
            Inactivo
            <%
                }
            %>  
        </td>

        <td>
            <span class="material-icons">
                <button class="btn btn-success"  onclick="AgregarProductos(<%=IdProducto%>);">

                    add

                </button>
            </span>
        </td>   
    </tr>  
    <%
            }
        } catch (SQLException e) {
            System.out.println("e = " + e);
        }
    %>
</tbody>
</table>
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
    function CrearReceta(IdRecerva) {
        $.ajax({
            url: "CrearReceta",
            type: 'POST',
            data: {IdRecerva},
            success: function (response) {
                if (response == 1) {
                    $("#TablaReceta").show();
                    $("#BotonCrearReceta").hide();
                } else {
                    alertify.error("Ocurrio un erro al crear la receta")
                }
            },
            error: function (error) {
                alertify.error("Error");
            }
        });

    }
    function AgregarProductos(IdProducto) {
        var Cantidad = $("#Cantidad" + IdProducto).val();
        var Descripcion = $("#Descripcion" + IdProducto).val();
        $.ajax({
            url: "CrearDetalleReceta",
            type: 'POST',
            data: {IdProducto, Cantidad, Descripcion},
            success: function (response) {
                if (response == 1) {
                    alertify.success("Agregado Correctamente");
                } else {
                    alertify.error("Erro al agregar");
                }

            },
            error: function (error) {
                alertify.error("Ocurrio un erro inesperado");
            }
        });








    }
</script>