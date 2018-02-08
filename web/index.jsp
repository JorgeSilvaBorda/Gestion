<%-- 
    Document   : index
    Created on : 07-02-2018, 17:59:35
    Author     : Jorge Silva Borda
--%>
<%
    try {
        if (session.getAttribute("user") == null || session.getAttribute("user").equals("")) {
            response.sendRedirect("login.jsp");
        }
    } catch (Exception ex) {

    }

%>
<%@include file="funciones.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-3.1.1.min.js?=<%out.print(randomNumber());%>" type="text/javascript"></script>

        <script src="js/bootstrap.js?=<%out.print(randomNumber());%>" type="text/javascript"></script>
        <link href="css/bootstrap.css?=<%out.print(randomNumber());%>" rel="stylesheet" type="text/css"/>
        <title>Principal</title>
    </head>
    <body>
        <script type="text/javascript">

            $(document).ready(function () {
                init();
                mostrarModulos();
            });
            function init() {
                return false;
            }

            function cerrar() {
                var ctx = "${pageContext.request.contextPath}";
                $.ajax({
                    type: 'post',
                    url: ctx + '/Cerrar',
                    success: function () {
                        window.location.href = 'index.jsp';
                    }
                });
            }

            function cargarModulo(nombre) {
                $('#contenido').load('mod/' + nombre + '.jsp');
                return false;
            }

            function mostrarModulos() {
                $.ajax({
                    type: 'post',
                    url: 'Perfilador',
                    success: function (resp) {
                        $('#modulos').html(resp);
                    },
                    error: function (a, b, c) {
                        console.log(a);
                        console.log(b);
                        console.log(c);
                    }
                });
                return false;
            }
        </script>

        <div class="container-fluid">
            <div class="row">
                <div class="col-md-12">
                    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
                        <div class="navbar-header">

                            <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                                <span class="sr-only">Toggle navigation</span><span class="icon-bar"></span><span class="icon-bar"></span><span class="icon-bar"></span>
                            </button> <a class="navbar-brand" href="#">Gestión</a>
                        </div>

                        <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                            <ul class="nav navbar-nav">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown">Aplicaciones<strong class="caret"></strong></a>
                                    <ul class="dropdown-menu" id="modulos">
                                        <!-- Perfialmiento -->
                                        <!--li>
                                            <a href="#">Another action</a>
                                        </li>
                                        <li>
                                            <a href="#">Something else here</a>
                                        </li>
                                        <li class="divider">
                                        </li>
                                        <li>
                                            <a href="#">Separated link</a>
                                        </li>
                                        <li class="divider">
                                        </li>
                                        <li>
                                            <a href="#">One more separated link</a>
                                        </li-->
                                        <!-- /Perfilamiento -->

                                    </ul>
                                </li>
                            </ul>

                            <ul class="nav navbar-nav navbar-right">
                                <li class="dropdown">
                                    <a href="#" class="dropdown-toggle" data-toggle="dropdown"><%out.print(session.getAttribute("user"));%><strong class="caret"></strong></a>
                                    <ul class="dropdown-menu">
                                        <li>
                                            <a href="#">Cambiar clave</a>
                                        </li>
                                        <li onclick="cerrar();">
                                            <a href="#">Cerrar sesión</a>
                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </nav>
                </div>
            </div>
            <br />
            <div id="contenido">

            </div>
        </div>
    </body>
</html>
