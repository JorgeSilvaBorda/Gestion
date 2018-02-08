
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * @author Jorge Silva Borda
 */
public class Conexion {

    private Connection conn;

    public ResultSet ejecutarQuery(String query) {
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    this.conn = DriverManager.getConnection("jdbc:mysql://" + Parametros.SERVIDOR + ":" + Parametros.PUERTO + "/" + Parametros.BASEDATOS, Parametros.USUARIO, Parametros.PASSWORD);
	    Statement st = this.conn.createStatement();
	    ResultSet rs = st.executeQuery(query);
	    return rs;
	} catch (ClassNotFoundException | SQLException ex) {
	    System.out.println("No se puede ejecutar la query: " + ex);
	}
	return null;
    }

    public void ejecutar(String query) {
	try {
	    Class.forName("com.mysql.jdbc.Driver");
	    this.conn = DriverManager.getConnection("jdbc:mysql://" + Parametros.SERVIDOR + ":" + Parametros.PUERTO + "/" + Parametros.BASEDATOS, Parametros.USUARIO, Parametros.PASSWORD);
	    this.conn.createStatement().execute(query);
	} catch (ClassNotFoundException | SQLException ex) {
	    System.out.println("No se puede ejecutar la query: " + ex);
	}
    }

    public void cerrar() {
	try {
	    this.conn.close();
	} catch (SQLException ex) {
	    System.out.println("No se puede cerrar la conexion.");
	    System.out.println(ex);
	}
    }
}
