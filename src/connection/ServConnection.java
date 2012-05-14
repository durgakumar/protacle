package connection;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;

import exercise1.FileGenerator;

import net.neoremind.sshxcute.core.ConnBean;
import net.neoremind.sshxcute.core.Result;
import net.neoremind.sshxcute.core.SSHExec;
import net.neoremind.sshxcute.exception.TaskExecFailException;
import net.neoremind.sshxcute.task.CustomTask;
import net.neoremind.sshxcute.task.impl.ExecCommand;

public class ServConnection {
	
	SSHExec ssh = null;
	
	public void connection() {
		FileGenerator fileGenerator = new FileGenerator();
		try {
			ConnBean cb = new ConnBean(
					"i12k-biolab01.informatik.tu-muenchen.de", "orhann",
					"aqAdwhaD72Vd");
			CustomTask task = new ExecCommand("rm -r /mnt/home/student/orhann/ProteinPrediction");
			ssh = SSHExec.getInstance(cb);
			ssh.connect();
			ssh.exec(task);
			CustomTask task2 = new ExecCommand("mkdir /mnt/home/student/orhann/ProteinPrediction");
			ssh.exec(task2);
			String initialAdressSrc = "/Users/nevzatorhan/Documents/workspace/ProteinPrediction/src";
			String destinationAdress = "/mnt/home/student/orhann/ProteinPrediction";
			ssh.uploadAllDataToServer(initialAdressSrc, destinationAdress);
			
			/*CustomTask task1 = new ExecCommand("javac " + destinationAdress + "/src/exercise1/main.java");
			Result result = ssh.exec(task1);
			 if (result.isSuccess)
             {
                     System.out.println("Return code: " + result.rc);
                     System.out.println("sysout: " + result.sysout);
             }
             else
             {
                     System.out.println("Return code: " + result.rc);
                     System.out.println("error message: " + result.error_msg);
             }*/
		} catch (Exception e) {
			System.out.println(e.getMessage());
			e.printStackTrace();
		}
		finally{
			ssh.disconnect();
		}

	}
}
