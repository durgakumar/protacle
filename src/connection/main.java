package connection;

import java.util.Scanner;


public class main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub

		ServConnection connection = new ServConnection();
		System.out.println("username");
		Scanner sc;
		sc = new Scanner(System.in);
		String username = sc.next();
		System.out.println("password");
		sc = new Scanner(System.in);
		String password = sc.next();
		System.out.println(username +  "     " +password);
		connection.connection(username,password);
	}

}
