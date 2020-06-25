<%@ page import="java.sql.*"%>
<%
	String connectionURL = "jdbc:mysql://localhost:3306/sorcescannella?useLegacyDatetimeCode=false&serverTimezone=Europe/Rome";
	Connection connection = null;
	Statement statement = null;
	ResultSet rs = null;
%>
<!DOCTYPE html>
<html>
<head>
<title>Test22 DB</title>
</head>
<body>
	<%
		connection = DriverManager.getConnection(connectionURL, "root", "SistemiWeb2020");
		statement = connection.createStatement();
		rs = statement.executeQuery("SELECT * FROM piatto");
		while (rs.next()) {
			out.println(rs.getInt("id_piatto") + "): ");
			out.println(rs.getString("tipo") + ", ");
			out.println(rs.getString("nome") + ", ");
			out.println(rs.getFloat("prezzo") + ", ");
			out.println(rs.getString("disponibilita") + ", ");
			out.println(rs.getBoolean("menu_giorno") + "<br>");
			
		}
		rs.close();
		statement.close();
		connection.close();
	%>
</body>
</html>

