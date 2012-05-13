require 'fileutils' 

DATASET_FOLDER_FULLPATH = "/mnt/opt/data/pp1_12_exercise/dataset/fasta"
PROT_LIST_FILE_FULLPATH = "/mnt/opt/data/pp1_12_exercise/groups/101/101.txt"

#delete the old results
#FileUtils.rm_rf 'ppdir'
#Dir.mkdir 'ppdir'

#this array contains all the protein names as specified in the file
proteins = []

#read all the sequences and load them in memory: it's simple, efficient and requires
#not much memory
first_index = ARGV[0].to_i
last_index = ARGV[1].to_i

puts "WORKING FROM #{first_index} TO #{last_index}"

index = 0
File.open(PROT_LIST_FILE_FULLPATH, 'r') do |infile|
  while (prot_seq_name = infile.gets)
    if index >= first_index && index <= last_index
      proteins <<= prot_seq_name.chomp 
      puts "#{prot_seq_name} IN LIST"
    end
    index += 1
  end
end

#this array memorizes the threads in process
threads = []

proteins.each do |prot_seq_name|
  out_dir_path = "ppdir/#{prot_seq_name.gsub('.fasta','')}"
  unless File.exists? "#{out_dir_path}/query.asp"
  #create a new thread for every sequence
  puts "CALLED PREDICTPROTEIN FOR #{prot_seq_name}, OUTPUT DIR ppdir/#{prot_seq_name.gsub('.fasta','')}"
  threads << Thread.new(prot_seq_name) do |prot_seq_name|
    protein_file_fullpath = "#{DATASET_FOLDER_FULLPATH}/#{prot_seq_name}"
    local_out_dir_path = "ppdir/#{prot_seq_name.gsub('.fasta','')}"
    Dir.mkdir local_out_dir_path unless File.exists? local_out_dir_path
    command = "/usr/bin/predictprotein --seqfile #{protein_file_fullpath} --target=all --target=optional --output-dir #{local_out_dir_path}  --nouse-cache --bigblastdb=/var/tmp/rost_db/data/big/big --big80blastdb=/var/tmp/rost_db/data/big/big_80 --pfam2db=/var/tmp/rost_db/data/pfam_legacy/Pfam_ls --pfam3db=/var/tmp/rost_db/data/pfam/Pfam-A.hmm --prositeconvdat=/var/tmp/rost_db/data/prosite/prosite_convert.dat --prositedat=/var/tmp/rost_db/data/prosite/prosite.dat --swissblastdb=/var/tmp/rost_db/data/swissprot/uniprot_sprot"
    system(command)
    puts "PROTEIN #{prot_seq_name} DONE!"
  end
end
  #every 2 threads stop creating new threads and wait for the older ones to complete
  if threads.size == 2
     threads.each {|t| t.join} 
     threads = []
  end
end

puts "FINISHED!"
