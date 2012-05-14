#this little script takes 2 parameters: 1 - the name of the input file and 2 -the command that it has to run
#the script connects to all the servers in the labs and calls the provided command on each server for a subset of
#the provided input. requires ssh and sshpass (linux system, probably works on mac too)

USERNAME="user"
PASSWORD="password"
KILLCOMMAND="killall -u #{USERNAME}"

input_size = ARGV[1].to_i
remote_command = ARGV[0]

machine_numbers = ["01","02","03","06","07","08"]

step_size = (input_size / machine_numbers.size).floor
start_index = 0
end_index = step_size

machine_numbers.each do |machine_num|
  end_index = input_size-1 if machine_num == machine_numbers.last
  puts "MACHINE #{machine_num} FROM #{start_index} TO #{end_index}"
  command = "sshpass -p #{PASSWORD} ssh \"#{USERNAME}@i12k-biolab#{machine_num}.informatik.tu-muenchen.de\" \"nohup ruby #{remote_command} #{start_index} #{end_index} > machine#{machine_num}.out &\""
  system(command)
  end_index += step_size
  start_index = end_index - step_size + 1
end
