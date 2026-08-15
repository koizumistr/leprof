require 'optparse'

max = 20
OptionParser.new do |opt|
  opt.banner = 'Usage: leprof.rb [option] <profile.se>'
  opt.on('-n VAL', 'display VAL rows') { |v| max = v.to_i - 1 }
  opt.version = [1, 0]

  begin
    opt.parse!(ARGV)
  rescue OptionParser::ParseError => e
    puts "Error: #{e.message}"
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

    row = { name: data[4], count: data[1].to_i, own: data[2].to_f, cumul: data[3].to_f }
    table.append(row)
  end
  table.each_with_index do |item, i|
    puts "#{item[:cumul]} #{item[:name]}"
    break if i == max
  end

  print "\n========== count ==========\n"
  crsored = table.sort_by { |x| x[:count] }.reverse
  width = crsored[0][:count].to_s.length
  crsored.each_with_index do |item, i|
    puts "#{item[:count].to_s.rjust(width)} #{item[:name]}"
    break if i == max
  end
  print "\n========== own ==========\n"
  table.sort_by { |x| x[:own] }.reverse.each_with_index do |item, i|
    puts "#{item[:own]} #{item[:name]}"
    break if i == max
  end
end
