task :day3, [:n] => :environment do |t, args|

  N = if !args[:n].blank?
        args[:n].to_i
      else
        print 'N: '
        STDIN.gets.strip.to_i
      end

  if N%2 == 0
    print 'Not Weird' if (2..5).cover?(N)
    print 'Weird' if (6..20).cover?(N)
    print 'Not Weird' if N>20
  else
    print 'Weird'
  end

end