require 'fileutils' 

dataset_folder_fullpath = "/mnt/opt/data/pp1_12_exercise/dataset/fasta"
prot_list_file_fullpath = "/mnt/opt/data/pp1_12_exercise/groups/101/101.txt"
FileUtils.rm_rf 'ppdir'
Dir.mkdir 'ppdir'
proteins = []
File.open(prot_list_file_fullpath, 'r') do |infile|
  while (prot_seq_name = infile.gets)
    proteins = proteins << prot_seq_name.chomp
  end
end

threads = []
proteins.each do |prot_seq_name|
  threads << Thread.new(prot_seq_name) do |prot_seq_name|
    protein_file_fullpath = "#{dataset_folder_fullpath}/#{prot_seq_name}"
    uniprot_code = "UNIDENTIFIED"
    File.open(protein_file_fullpath, 'r') {|infile| uniprot_code = infile.gets.split('|')[1]}
    out_dir_path = "ppdir/#{uniprot_code}"
    Dir.mkdir out_dir_path
    command = "/usr/bin/predictprotein --seqfile #{protein_file_fullpath} --target=all --target=optional --output-dir #{out_dir_path}  --nouse-cache --bigblastdb=/var/tmp/rost_db/data/big/big --big80blastdb=/var/tmp/rost_db/data/big/big_80 --pfam2db=/var/tmp/rost_db/data/pfam_legacy/Pfam_ls --pfam3db=/var/tmp/rost_db/data/pfam/Pfam-A.hmm --prositeconvdat=/var/tmp/rost_db/data/prosite/prosite_convert.dat --prositedat=/var/tmp/rost_db/data/prosite/prosite.dat --swissblastdb=/var/tmp/rost_db/data/swissprot/uniprot_sprot"
    system(command)
  end
  threads.each {|t| t.join} if threads.size == 5
end