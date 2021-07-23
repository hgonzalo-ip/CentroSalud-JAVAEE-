<%@include file="includes/heder.jsp" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
    </head>
    <body class="BodyLogin"><br>
        <div  class="row justify-content-center m-4">


            <div class="card shadow-lg p-3 mb-5 bg-white rounded" id="CardLogin">
                
                <form action="Ajax/Loguearme.jsp" method="POST">
                    <div class="card-body">
                        <div class="row justify-content-center pb-5">
                            <span>
                                <img src="img/Logo.jpeg" style="max-width: 100%; max-height: 105px;">
                                
                            </span>
                        </div>
                        <div class="row justify-content-center m-2">
                            <div class="col-md-10 form-group ">
                                
                                <input type="text" class="form-control" id="ImpUsuario" name="Txt_Name"  placeholder="Usuario">
                            </div>
                        </div>
                        <div class="row justify-content-center m-2">
                            <div class="col-md-10 form-group">
                                
                                <input type="password" class="form-control" id="ImpPasword"  name="Txt_Pass" placeholder="Contraseña">
                            </div>
                        </div> 
                         <div class="row justify-content-center pt-3">
                            <div class="col-md-4 form-group">
                                <button id="BtnIngresar" class="btn btn-block btn-lg text-white">INGRESAR</button>
                            </div>
                        </div>

                    </div>
                   
                       
            
                </form>
            </div>

        </div>


    </body>
</html>
