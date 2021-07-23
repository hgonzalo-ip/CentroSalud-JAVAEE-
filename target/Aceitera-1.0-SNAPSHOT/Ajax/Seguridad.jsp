<%
    

    if (session.getAttribute("IdUsuario") == null) {
        response.sendRedirect("index.jsp");
    }

%>