package exercise1;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;

public class FileGenerator {
	
	FileModel model = new FileModel();
	//String fileNumber = null;
	//String directoryList = "/mnt/opt/data/pp1_12_exercise/groups/101/101.txt";
	//String files = "/mnt/opt/data/pp1_12_exercise/dataset/fasta/" + fileNumber;
	String directoryList = "/Users/nevzatorhan/Desktop/proteinDirectory/101.txt";
	//String files = "/Users/nevzatorhan/Desktop/proteinDirectory/fasta/";
	
	ArrayList<String> proteinList;
	
	public void generator() throws IOException{
		System.out.println("*************************");
		proteinList = new ArrayList<String>();
		FileReader reader = new FileReader(new File(directoryList));
		
		BufferedReader bReader = new BufferedReader(reader);
		while((bReader.readLine()) != null && bReader.readLine().length() != 0){
			model.setFileNumber(bReader.readLine()); 
			String files = "/Users/nevzatorhan/Desktop/proteinDirectory/fasta/" + model.getFileNumber(); 
			dataSetReader(files);
		}
	}
	
	public void dataSetReader(String directory) throws IOException{
		String list = null;
		FileReader reader = new FileReader(new File(directory));
		BufferedReader bReader = new BufferedReader(reader);
		while((bReader.readLine()) != null && bReader.readLine().length() != 0){
			System.out.println(directory);
			System.out.println(bReader.readLine());
			System.out.println(bReader.read());
		}	
	}
}
