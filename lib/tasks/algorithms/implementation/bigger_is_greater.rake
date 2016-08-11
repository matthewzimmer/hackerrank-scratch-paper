namespace :algorithms do
	namespace :implementation do

		task :bigger_is_greater_scratch_word, [:word, :expected_answer] do |t, args|
			w = args[:word]
			result = next_lexicographic_permutation(w)

			puts "input: #{args[:word]}"
			puts "expected: #{args[:expected_answer]}"
			puts "result: #{result}"

			puts 'WRONG' if result != args[:expected_answer]
			puts 'CORRECT' if result == args[:expected_answer]
		end

		task :bigger_is_greater_scratch, [:input, :output] do |t, args|
			args.with_defaults(input: 'data/bigger_is_greater/test2.in', output: 'data/bigger_is_greater/test2.out')

			input_file = File.read(File.join(Rails.root, args[:input]))
			output_file = File.read(File.join(Rails.root, args[:output]))

			input = input_file.gsub(/\r\n?/, "\n").split("\n")
			output = output_file.gsub(/\r\n?/, "\n").split("\n")

			n = input.shift
			input.each do |line|
				puts next_lexicographic_permutation(line)
			end
		end

	end
end

def next_lexicographic_permutation(w)
	result = nil
	s = w.dup.scan(/\w/)

	# 1. find highest i such that s[i] < s[i+1]. If no such index exists, the permutation is the last permutation.
	k = -1
	s.each_with_index do |char, i|
		begin
			if s[i] < s[i+1]
				k = i
			end
		rescue => e
		end
	end

	# 2. Find the highest index j > i such that s[j] > s[i]
	l = -1
	(k+1...s.length).each do |j|
		if s[k] < s[j]
			l = j
		end
	end

	if k >= 0 and l>k
		s[k], s[l] = s[l], s[k]
		result = "#{s[0..k].join('')}#{s[k+1...s.size].reverse.join('')}"
	end

	result.nil? ? 'no answer' : result
end
