require 'fileutils' 

dataset_folder_fullpath = "/mnt/opt/data/pp1_12_exercise/dataset/fasta"
prot_list_file_fullpath = "/mnt/opt/data/pp1_12_exercise/groups/101/101.txt"

#delete the old results
#FileUtils.rm_rf 'ppdir'
#Dir.mkdir 'ppdir'

#this array contains all the protein names as specified in the file
proteins = []

#read all the sequences and load them in memory: it's simple, efficient and requires
#not much memory
first_index = ARGV[0].to_i
last_index = ARGV[1].to_i

index = 0
File.open(prot_list_file_fullpath, 'r') do |infile|
  while (prot_seq_name = infile.gets)
    if index >= first_index and index <= last_index
      proteins <<= prot_seq_name.chomp
    end
    index += 1
  end
end

#this array memorizes the threads in process
threads = []

proteins.each do |prot_seq_name|
    protein_file_fullpath = "#{dataset_folder_fullpath}/#{prot_seq_name}"
    out_dir_path = "ppdir/#{prot_seq_name.gsub('.fasta','')}"
    unless File.exists? "#{out_dir_path}/query.asp"
      #create a new thread for every sequence
        threads << Thread.new(prot_seq_name) do |prot_seq_name|
          Dir.mkdir out_dir_path unless File.exists? out_dir_path
          command = "/usr/bin/predictprotein --seqfile #{protein_file_fullpath} --target=all --target=optional --output-dir #{out_dir_path}  --nouse-cache --bigblastdb=/var/tmp/rost_db/data/big/big --big80blastdb=/var/tmp/rost_db/data/big/big_80 --pfam2db=/var/tmp/rost_db/data/pfam_legacy/Pfam_ls --pfam3db=/var/tmp/rost_db/data/pfam/Pfam-A.hmm --prositeconvdat=/var/tmp/rost_db/data/prosite/prosite_convert.dat --prositedat=/var/tmp/rost_db/data/prosite/prosite.dat --swissblastdb=/var/tmp/rost_db/data/swissprot/uniprot_sprot"
          system(command)
      end
    end
    #every 4 threads stop creating new threads and wait for the older ones to complete
    if threads.size == 2
      threads.each {|t| t.join} 
      threads = []
    end
end