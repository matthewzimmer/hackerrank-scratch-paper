namespace :tutorial do

  task :day6 do
    t = STDIN.gets.strip.to_i
    t_inputs = []
    t.times.each do |i|
      t_inputs << STDIN.gets.strip
    end
    t_inputs.each do |s|
      even_indexes = []
      odd_indexes = []
      s.scan(/\w/).each_with_index { |sj, idx| idx%2==0 ? even_indexes << sj : odd_indexes << sj }
      puts "#{even_indexes.join('')} #{odd_indexes.join('')}"
    end
  end

  task :day6_scratch do

    input = []
    input << 'Hacker'
    input << 'Rank'

    t = input.length
    puts "T = #{t}"
    t.times.each do |i|
      s = input[i]

      s.scan(/\w/).each_with_index.select { |sj, idx| idx%2==0 }.each { |sj| print "#{sj.first}" }.join('')
      print ' '
      s.scan(/\w/).each_with_index.select { |sj, idx| idx%2>0 }.each { |sj| print "#{sj.first}" }.join('')
      puts ''
    end

  end

end