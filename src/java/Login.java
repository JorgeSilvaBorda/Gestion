
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONException;
import org.json.JSONObject;

/**
 * @author Jorge Silva Borda
 */
public class Login extends HttpServlet {
   
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {
        PrintWriter out = response.getWriter();
	JSONObject entrada = new JSONObject(request.getParameter("datos"));
	Conexion c = new Conexion();
	String passMd5 = Utiles.md5(entrada.getString("pass"));
	ResultSet rs = c.ejecutarQuery("CALL SP_GET_LOGIN('"+entrada.getString("rut")+"', '"+passMd5+"')");
	//System.out.println("El sp: " + "CALL SP_GET_LOGIN('"+entrada.getString("rut")+"', '"+passMd5+"')");
	JSONObject usuario = new JSONObject();
	int cont = 0;
	try{
	    while(rs.next()){
		usuario.put("idusuario", rs.getString("IDUSUARIO"));
		usuario.put("nombre", rs.getString("NOMBRE"));
		usuario.put("rut", rs.getString("RUT"));
		usuario.put("appaterno", rs.getString("APPATERNO"));
		usuario.put("apmaterno", rs.getString("APMATERNO"));
		usuario.put("idtipousuario", rs.getString("IDTIPOUSUARIO"));
		usuario.put("nomtipousuario", rs.getString("NOMTIPOUSUARIO"));
		usuario.put("nivelusuario", rs.getInt("NIVELUSUARIO"));
		//System.out.println("Usuario: " + usuario);
		cont ++;
	    }
	    c.cerrar();
	    if(cont == 0){
		HttpSession ses = request.getSession();
		ses.setAttribute("usuario", null);
		ses.setAttribute("user", null);
		out.print("invalido");
	    }else if(cont > 0){
		HttpSession ses = request.getSession();
		ses.setAttribute("usuario", usuario);
		ses.setAttribute("user", usuario.getString("nombre") + " " + usuario.getString("appaterno") + " - " + usuario.getString("nomtipousuario"));
		ses.setAttribute("jsonUsuario", usuario);
		System.out.println("Desde el Login, jsonUsuario:");
		System.out.println(usuario);
		System.out.println(ses.getAttribute("jsonUsuario"));
		out.print("ok");
	    }
	}catch (SQLException | JSONException ex) {
	    System.out.println("No se puede buscar el usuario: ");
	    System.out.println(ex);
	    out.print("error");
	}
    }
}