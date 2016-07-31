namespace :sherlock_and_array do

  task :run do

    print 'T: '
    T = STDIN.gets.strip.to_i
    T.times.each do |i|
      print 'N: '
      n = STDIN.gets.strip.to_i
      print 'Input (e.g., "1 2 4 6 4"): '
      arr = STDIN.gets.strip.split(' ').map(&:to_i)
      result = 'NO'
      n.times.each do |idx|
        l_sum = arr[0...idx].inject(0){|sum,i|sum+i}
        r_sum = arr[idx+1...n].inject(0){|sum,i|sum+i}
        if l_sum==r_sum
          result = 'YES'
          break
        end
      end
      puts result
    end

  end

end