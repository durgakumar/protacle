package connection;

import java.util.Scanner;


public class main {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		ServConnection connection = new ServConnection(args[0],Integer.parseInt(args[1]));
		System.out.println("username");
		Scanner sc;
		sc = new Scanner(System.in);
		String username = sc.next();
		System.out.println("password");
		sc = new Scanner(System.in);
		String password = sc.next();
		System.out.println(username +  "     " +password);
		connection.dispatchJobs(username,password);
	}

}
