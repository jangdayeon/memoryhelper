package javabean;

import java.sql.*; 
import java.util.ArrayList; 


public class testDatabase {

	// 데이터베이스 연결 관련 상수 선언
	private static final String JDBC_DRIVER = "org.gjt.mm.mysql.Driver";
	private static final String JDBC_URL = "jdbc:mysql://localhost:3305/mh_db";
	private static final String USER = "root";
	private static final String PASSWD = "0304";

	// 데이터베이스 연결 관련 변수 선언
	private Connection con = null;
	private Statement stmt = null;

	// JDBC 드라이버를 로드하는 생성자
	public testDatabase() {
		// JDBC 드라이버 로드
		try {
			Class.forName(JDBC_DRIVER);
		} catch (Exception e) {
			e.printStackTrace();
		}		
	}

	// 데이터베이스 연결 메소드
	public void connect() {
		try {
			// 데이터베이스에 연결, Connection 객체 저장 
			con = DriverManager.getConnection(JDBC_URL, USER, PASSWD);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 데이터베이스 연결 해제 메소드 
	public void disconnect() {
		if(stmt != null) {
			try {
				stmt.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		} 
		if(con != null) {
			try {
				con.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}

	// 게시판의 모든 레코드를 반환하는 메소드
	public ArrayList<testBean> getTestList(String Tid) {	
		connect();
		
		ArrayList<testBean> list = new ArrayList<testBean>();

		String SQL = "select * from test where Tid = '"+Tid+"' order by Twhen";
		try {
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery(SQL);

			while (rs.next()) {		
				  
				testBean t = new testBean();

				  				
				t.setTid ( rs.getDate("Tid") );
				t.setTwhen ( rs.getDate("Twhen") );
				t.setTscore ( rs.getInt("Tscore") );
				t.setTtesting ( rs.getLong("Ttesting") );
				
				list.add(t);
			}
			rs.close();			
		} catch (SQLException e) {
			e.printStackTrace();
		} 
		finally {
			disconnect();
		}
		return list;
	}

}
