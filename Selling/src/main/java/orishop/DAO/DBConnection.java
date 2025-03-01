package orishop.DAO;

import java.sql.Connection;
import java.sql.DriverManager;

import orishop.DAO.DBConnection;

public class DBConnection {
	 private final static String serverName = "localhost"; // Thay đổi nếu dùng server khác
	    private final static String portNumber = "3306"; // Port mặc định của MySQL
	    private final static String dbName = "CosmeticStore"; // Đổi tên DB nếu cần
	    private final static String userID = "root"; // Tài khoản MySQL (thay nếu khác)
	    private final static String password = "1234"; // Mật khẩu MySQL
	    
	    public static Connection getConnection() throws Exception {
	        String url = "jdbc:mysql://" + serverName + ":" + portNumber + "/" + dbName +
	                     "?useSSL=false&serverTimezone=UTC";
	        Class.forName("com.mysql.cj.jdbc.Driver");
	        return DriverManager.getConnection(url, userID, password);
	    }
	    
	    public static void main(String[] args) {
	        try {
	            Connection conn = DBConnection.getConnection();
	            if (conn != null) {
	                System.out.println("✅ Kết nối MySQL thành công!");
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	    }
}
