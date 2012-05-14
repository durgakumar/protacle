package connection;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.util.Scanner;

import exercise1.FileGenerator;
import java.util.ArrayList;
import java.util.Arrays;
import net.neoremind.sshxcute.core.ConnBean;
import net.neoremind.sshxcute.core.Result;
import net.neoremind.sshxcute.core.SSHExec;
import net.neoremind.sshxcute.exception.TaskExecFailException;
import net.neoremind.sshxcute.task.CustomTask;
import net.neoremind.sshxcute.task.impl.ExecCommand;

public class ServConnection {
	
	SSHExec ssh = null;
  ArrayList<String> machines = new ArrayList(Arrays.asList("01","02","03","06","07","08"));
  
  private int inputSize = 0;
  private String command;
  
  public void setInputSize(int size) {
    this.inputSize = size;
  }
  
  public void setCommand(String command) {
    this.command = command;
  }
	
	public void dispatchJobs(String username,String password) {
    int startIndex = 0;
    int stepSize = inputSize / machines.size();
    int endIndex = stepSize;
		FileGenerator fileGenerator = new FileGenerator();
    for (String machineNumber : machines) {
      try {
        if (inputSize - endIndex < stepSize) {
          endIndex = inputSize - 1;
        }
        String address = "i12k-biolab" + machineNumber + ".informatik.tu-muenchen.de";
        System.out.println(address);
        ConnBean cb = new ConnBean(address, username,password);
        ssh = SSHExec.getInstance(cb);
        ssh.connect();
        String remoteCommand = "nohup java "+remoteCommand+" "+startIndex+" "+endIndex+" > machine"+machineNum+".out &";
        System.out.println(remoteCommand);
        ssh.exec(remoteCommand);
        endIndex += stepSize;
        startIndex = endIndex - stepSize + 1;
      } catch (Exception e) {
        System.out.println(e.getMessage());
        e.printStackTrace();
      }
      finally{
        ssh.disconnect();
      }
    }
	}
  
  public ServConnection(String command, int inputSize) {
    this.setCommand(command);
    this.setInputSize(inputSize);
  }
}
