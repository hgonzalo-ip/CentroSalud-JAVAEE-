<%@include file="../Ajax/Seguridad.jsp" %>
<%@include file="heder.jsp" %>

<%    String IdTipoEmpleado = "0";
    if (session.getAttribute("IdTipoEmpleado") != null) {
        IdTipoEmpleado = (String) session.getAttribute("IdTipoEmpleado");
    }
    int IdTipoEmpleadoInt = Integer.parseInt(IdTipoEmpleado);

    if (IdTipoEmpleadoInt == 1) {
        //1 Es Doctor
%>   
<div id="Content-wrapper " class="d-flex " >
    <div id="sidebar-container" class="border-right">
        <div class="logo">
            <h4 class="font-weight-bold text-center text-white">Menú</h4>
        </div>
        <div class="menu list-group-flush ">

            <div class="container-fluid"onclick="IrSitasPendientes()">
                <a href="#"  class="list-group-item list-group-action  p-3 border-0 text-white">
                    <span class="material-icons mr-2">
                        pending_actions
                    </span>  
                    Citas Pendientes
                </a>
            </div>
            <div class="container-fluid" onclick="IrSitasFinalizadas()">
                <a href="#"  class="list-group-item list-group-action  p-3 border-0 text-white">
                    <span class="material-icons mr-2">
                        event_available
                    </span>  
                    Citas Finalizadas
                </a>
            </div>

        </div>
    </div>
    <%
    } else if (IdTipoEmpleadoInt == 2) {
        // 2 Es Secretario

    %>
    <div id="Content-wrapper " class="d-flex " >
        <div id="sidebar-container" class="border-right">
            <div class="logo">
                <h4 class="font-weight-bold text-center text-white">Menú</h4>
            </div>
            <div class="menu list-group-flush ">
                <div class="container-fluid" onclick="IrSalasSecre()">
                    <a href="#"  class="list-group-item list-group-action  p-3 border-0 text-white">
                        <span class="material-icons mr-2">
                            create
                        </span>   
                        Crear Cita
                    </a>
                </div>
                <div class="container-fluid" onclick="IrSitasSecre()">
                    <a href="#"  class="list-group-item list-group-action  p-3 border-0 text-white">
                        <span class="material-icons mr-2">
                            format_list_numbered
                        </span>   
                        Listar Citas
                    </a>
                </div>

            </div>
        </div>
        <%    } else if (IdTipoEmpleadoInt == 3) {
            //3 es Farmacia

        %>
        <div id="Content-wrapper " class="d-flex " >
            <div id="sidebar-container" class="border-right">
                <div class="logo">
                    <h4 class="font-weight-bold text-center text-white">Menú</h4>
                </div>
                <div class="menu list-group-flush ">
                    <div class="container-fluid" onclick="irRecetasPendienteFar()">
                        <a   class="list-group-item list-group-action  p-3 border-0 text-white">
                            <span class="material-icons mr-2">
                                receipt_long
                            </span>   
                            Recetas Por Entregar
                        </a>
                    </div>
                    <div class="container-fluid" onclick="irRecetasEntregadasFar()">
                        <a   class="list-group-item list-group-action  p-3 border-0 text-white">
                            <span class="material-icons mr-2">
                                format_list_numbered
                            </span>   
                            Recetas Entregadas
                        </a>
                    </div>
                    <div class="container-fluid" onclick="irProductos()">
                        <a href="#"  class="list-group-item list-group-action  p-3 border-0 text-white">
                            <span class="material-icons mr-2">
                                category
                            </span>   
                            Productos
                        </a>
                    </div>
                </div>


            </div>
            <%             } else if (IdTipoEmpleadoInt == 4) {
                //4 es Admin

            %>
            <div id="Content-wrapper " class="d-flex " >
                <div id="sidebar-container" class="border-right">
                    <div class="logo">
                        <h4 class="font-weight-bold text-center text-white">Menú</h4>
                    </div>
                    <div class="menu list-group-flush ">
                        <div class="container-fluid" onclick="IrEmpleados()">
                            <a   class="list-group-item list-group-action  p-3 border-0 text-white">
                                <span class="material-icons mr-2">
                                    directions_walk
                                </span>   
                                Empleados
                            </a>
                        </div>
                        <div class="container-fluid" onclick="IrSitas();">
                            <a   class="list-group-item list-group-action  p-3 border-0 text-white">
                                <span class="material-icons mr-2">
                                    receipt_long
                                </span>   
                                Citas
                            </a>
                        </div>


                        <div class="container-fluid" onclick="IrUsuarios()">
                            <a  class="list-group-item list-group-action  p-3 border-0 text-white">
                                <span class="material-icons mr-2">
                                    people
                                </span>   
                                Usuarios
                            </a>
                        </div>
                        <div class="container-fluid" onclick="IrRoles()">
                            <a  class="list-group-item list-group-action  p-3 border-0 text-white">
                                <span class="material-icons mr-2">
                                    engineering
                                </span>   
                                Roles
                            </a>
                        </div>
                        <div class="container-fluid" onclick="IrProductos();">
                            <a class="list-group-item list-group-action  p-3 border-0 text-white">
                                <span class="material-icons mr-2">
                                    category
                                </span>   
                                Productos
                            </a>
                        </div>
                        <div class="container-fluid" onclick="IrSalas();">
                            <a class="list-group-item list-group-action  p-3 border-0 text-white">
                                <span class="material-icons mr-2">
                                    weekend
                                </span>   
                                Salas
                            </a>
                        </div>
                    </div>


                </div>
                <%                     }
                %>


















