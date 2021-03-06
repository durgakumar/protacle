FILE_HEADER = <<-eos
@RELATION       'prot.arff' ( name of the file)

@ATTRIBUTE      pos     NUMERIC 
@ATTRIBUTE      class   {+,-}
@DATA
eos

STRUCT_DATASET_FOLDER_FULLPATH = "/mnt/opt/data/pp1_12_exercise/dataset/structure"
struct_dataset_dir = Dir.new(STRUCT_DATASET_FOLDER_FULLPATH)
MY_DATASET_FOLDER_FULLPATH = "/mnt/opt/data/pp1_12_exercise/groups/101/ppdir"
my_dataset_dir = Dir.new(MY_DATASET_FOLDER_FULLPATH)

struct = {}
Dir.foreach(STRUCT_DATASET_FOLDER_FULLPATH) do |filename|
  unless filename == '.' || filename == '..'
    seq_no = filename[/(\d)+/]
    puts filename
    lines = IO.readlines("#{STRUCT_DATASET_FOLDER_FULLPATH}/#{filename}")
    start_tm_indicator_index = (lines[1].length-1) * 2 / 3 - 1
    number_residues = (lines[1].length / 3).floor
    ind = 0
    tm_arr = []
    puts lines[1][start_tm_indicator_index..-1]
    lines[1][start_tm_indicator_index..-1].each_char do |c|      
      tm_arr[ind] = (c == 'L' || c == 'H' ? '+' : '-') unless c == '\n'
      ind += 1
    end
    struct[seq_no] = tm_arr
    tm_arr.each {|a| puts a}
  end
end

Dir.foreach(MY_DATASET_FOLDER_FULLPATH) do |dirname|
  unless dirname == '.' || dirname == '..'
    seq_no = dirname[/(\d)+/] 
    if struct.has_key? seq_no
      File.open("#{MY_DATASET_FOLDER_FULLPATH}/#{dirname}/prot.arff", 'w') do |file|
        file.puts FILE_HEADER
        struct[seq_no].each_with_index do |char, ind|
          file.puts "#{ind},#{char}"
        end
      end
    end
  end
end
