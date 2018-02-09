<%-- 
    Document   : login
    Created on : 07-02-2018, 18:05:57
    Author     : Jorge Silva Borda
--%>
<%@include file="funciones.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="js/jquery-3.1.1.min.js?=<%out.print(randomNumber());%>" type="text/javascript"></script>
        <script src="js/bootstrap.js?=<%out.print(randomNumber());%>" type="text/javascript"></script>
        <script src="js/jqueryrut.js?=<%out.print(randomNumber());%>" type="text/javascript"></script>

        <link href="css/bootstrap.css?=<%out.print(randomNumber());%>" rel="stylesheet" type="text/css"/>

        <title>Login</title>
    </head>
    <body>
        <script type="text/javascript">
            String.prototype.replaceAll = function (target, replacement) {
                return this.split(target).join(replacement);
            };
            $(document).ready(function () {
                $('#rutUsuario').Rut({
                    on_error: function () {
                        alert('Rut incorrecto.');
                        $('#rutUsuario').focus();
                    },
                    format_on: 'keyup'
                });
                $(document).keypress(function (event) {
                    var keycode = (event.keyCode ? event.keyCode : event.which);
                    if (keycode === 13) {
                        $('#btnLogin').click();
                    }
                });
            });

            var ctx = "${pageContext.request.contextPath}";
            function validar() {
                var rut = $('#rutUsuario').val().replaceAll('.', '');
                var pass = $('#passUsuario').val();
                if (rut.length < 9) {
                    alert('Debe ingresar el rut correctamente.');
                    return false;
                }
                if (pass.length < 1) {
                    alert('Debe ingresar la contraseña');
                    return false;
                }
                return true;
            }

            function login() {
                if (validar()) {
                    var rut = $('#rutUsuario').val().replaceAll('.', '');
                    var pass = $('#passUsuario').val();

                    var info = {
                        rut: rut,
                        pass: pass
                    };
                    var dat = JSON.stringify(info);

                    $.ajax({
                        type: 'post',
                        url: ctx + '/Login',
                        data: {
                            datos: dat
                        },
                        success: function (res) {
                            console.log(res);
                            if (res === 'ok') {
                                window.location.href = "index.jsp";
                            } else if (res === 'invalido') {
                                alert('Usuario o contraseña inválidos. Por favor intente nuevamente.');
                            }
                        },
                        error: function (a, b, c) {
                            console.log(a);
                            console.log(b);
                            console.log(c);
                        }
                    });
                }
                return false;
            }
        </script>
        <div class="container-fluid">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4">
                    <div class="page-header">
                        <div class="h1">Login</div>
                    </div>
                    <form role="form">
                        <div class="form-group">
                            <label for="rutUsuario">Rut: </label>
                            <input type="text" class="form-control" id="rutUsuario" maxlength="12" placeholder="12345678-9"/>
                        </div>
                        <div class="form-group">
                            <label for="passUsuario">Password: </label>
                            <input type="password" class="form-control" id="passUsuario"/>
                        </div>
                        <div class="form-group">
                            <button type="button" class="btn btn-default" id="btnLogin" onclick="login();">Entrar</button>
                        </div>
                    </form>
                </div>
                <div class="col-md-4"></div>
            </div>
        </div>
    </body>
</html>
