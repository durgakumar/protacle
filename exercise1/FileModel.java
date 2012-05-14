package exercise1;

import java.util.ArrayList;

public class FileModel {

	private String fileNumber;
	private String combinedLines;
	ArrayList<String> proteinList;
	
	public String getFileNumber() {
		return fileNumber;
	}
	public void setFileNumber(String fileNumber) {
		this.fileNumber = fileNumber;
	}
	public String getCombinedLines() {
		return combinedLines;
	}
	public void setCombinedLines(String combinedLines) {
		this.combinedLines = combinedLines;
	}
	public ArrayList<String> getProteinList() {
		return proteinList;
	}
	public void setProteinList(ArrayList<String> proteinList) {
		this.proteinList = proteinList;
	}
}
