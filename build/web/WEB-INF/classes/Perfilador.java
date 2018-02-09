
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.json.JSONObject;

/**
 * @author Jorge Silva Borda
 */
public class Perfilador extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	PrintWriter out = response.getWriter();
	HttpSession ses = request.getSession();
	JSONObject usuario = new JSONObject(ses.getAttribute("jsonUsuario").toString());
	out.print(cargarModulos(usuario));
    }

    public String cargarModulos(JSONObject json) {
	String query = "CALL SP_GET_PERFILES('" + json.getString("idusuario") + "')";
	Conexion c = new Conexion();
	ResultSet rs = c.ejecutarQuery(query);
	StringBuilder builder = new StringBuilder();
	try {
	    while (rs.next()) {
		builder.append(""
			+ "<li onclick='cargarModulo(\"" + rs.getString("NOMMODULO").toLowerCase() + "\");'>"
			+ "<a href='#'>"+rs.getString("NOMMODULO")+"</a>"
			+ "</li>");
	    }
	    c.cerrar();
	    return builder.toString();
	} catch (SQLException ex) {
	    System.out.println("No se puede buscar los perfiles asociados al usuario.");
	    System.out.println(ex);
	    c.cerrar();
	    return "";
	}
    }
}
