require 'optparse'

max = 20
OptionParser.new do |opt|
  opt.banner = 'Usage: rbps.rb [option] PATTERN'
  opt.on('-n VAL', 'display long description') { |v| max = v.to_i - 1 }
  opt.version = [1, 0]

  begin
    opt.parse!(ARGV)
  rescue
    puts opt.help
    exit(-2)
  end

  if ARGV.empty?
    puts opt.help
    exit(-3)
  end
end

File.open(ARGV[0]) do |f|
  line = f.gets
  line = f.gets until line.match(/---------/)

  table = []
  loop do
    line = f.gets
    data = line.match(/(\d+) *(\d+\.?\d*)[ s]*(\d+.?\d*)[ s]*([\w.\[\],_ "<>]+)/)
    break if data.nil?

    row = { name: data[4], count: data[1].to_i, own: data[2], cumul: data[3] }
    table.append(row)
  end
  table.each_with_index do |item, i|
    print item[:cumul], ' ', item[:name], "\n"
    break if i == max
  end

  print "\n========== count ==========\n"
  table.sort_by { |x| x[:count] }.reverse.each_with_index do |item, i|
    print item[:count], ' ', item[:name], "\n"
    break if i == max
  end
  print "\n========== own ==========\n"
  table.sort_by { |x| x[:own] }.reverse.each_with_index do |item, i|
    print item[:own], ' ', item[:name], "\n"
    break if i == max
  end
end
