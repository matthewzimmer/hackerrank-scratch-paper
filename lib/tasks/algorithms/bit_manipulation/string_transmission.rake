namespace :algorithms do

  namespace :bit_manipulation do

    # integer to binary: 2.to_s(2)
    # binary to integer: "010".to_i(2)
    task :string_transmission, [:n, :k] => :environment do |t, args|
      include Cloneable

      n = (args[:n]||STDIN.gets.strip).to_i
      k = (args[:k]||STDIN.gets.strip).to_i

      buffer = Array.new(n){|a| [nil]}
      buffer2 = Array.new(n){|i| s=(1<<i).to_s(2); prepend_characters(s,'0',n-s.length)}

      puts 'Buffer:'
      print ''
      ap deep_clone(buffer)

      puts 'Buffer 2:'
      print ''
      ap deep_clone(buffer2)

    end

  end

end