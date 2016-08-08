namespace :tutorial do

	task :day10 do
		matrix = Array.new(6)
		for arr_i in (0..6-1)
			arr_t = STDIN.gets.strip
			matrix[arr_i] = arr_t.split(' ').map(&:to_i)
		end

		m = matrix.size
		n = matrix.first.size
		hourglass_matrices = []

		m.times.each do |row_i|
			n.times.each do |col_i|
				hourglass_matrix = detect_hourglass(row_i, col_i, matrix)
				unless hourglass_matrix.nil?
					hourglass_matrices << hourglass_matrix
				end
			end
		end

		hourglass_matrix_sizes = hourglass_matrices.map { |matrix| matrix.flatten.sum }
		print hourglass_matrix_sizes.max
	end

	task :day10_scratch do
		matrix = test7_input_output.first
		# matrix = test4_input_output.first
		# matrix = sample_input_output.first

		print_matrix(matrix)

		m = matrix.size
		n = matrix.first.size
		hourglass_matrices = []

		m.times.each do |row_i|
			n.times.each do |col_i|
				hourglass_matrix = detect_hourglass(row_i, col_i, matrix)

				unless hourglass_matrix.nil?
					hourglass_matrices << hourglass_matrix

					puts "(#{row_i}, #{col_i}):"
					print_matrix(hourglass_matrix)
				end
			end
		end

		hourglass_matrix_sizes = hourglass_matrices.map { |matrix| matrix.flatten.inject(0) { |sum, i| i+sum } }

		ap hourglass_matrix_sizes

		puts ''
		puts "Max: #{hourglass_matrix_sizes.max}"
	end

end

def sample_input_output
	[[
			 '1 1 1 0 0 0'.split(' ').map(&:to_i),
			 '0 1 0 0 0 0'.split(' ').map(&:to_i),
			 '1 1 1 0 0 0'.split(' ').map(&:to_i),
			 '0 0 2 4 4 0'.split(' ').map(&:to_i),
			 '0 0 0 2 0 0'.split(' ').map(&:to_i),
			 '0 0 1 2 4 0'.split(' ').map(&:to_i)
	 ],
	 19]
end

def test4_input_output
	[[
			 '-1 -1 0 -9 -2 -2'.split(' ').map(&:to_i),
			 '-2 -1 -6 -8 -2 -5'.split(' ').map(&:to_i),
			 '-1 -1 -1 -2 -3 -4'.split(' ').map(&:to_i),
			 '-1 -9 -2 -4 -4 -5'.split(' ').map(&:to_i),
			 '-7 -3 -3 -2 -9 -9'.split(' ').map(&:to_i),
			 '-1 -3 -1 -2 -4 -5'.split(' ').map(&:to_i)
	 ],
	 -6]
end

def test7_input_output
	[[
			 '0 -4 -6 0 -7 -6'.split(' ').map(&:to_i),
			 '-1 -2 -6 -8 -3 -1'.split(' ').map(&:to_i),
			 '-8 -4 -2 -8 -8 -6'.split(' ').map(&:to_i),
			 '-3 -1 -2 -5 -7 -4'.split(' ').map(&:to_i),
			 '-3 -5 -3 -6 -6 -6'.split(' ').map(&:to_i),
			 '-3 -6 0 -8 -6 -7'.split(' ').map(&:to_i)
	 ],
	 -19]

end

def detect_hourglass(start_m, start_n, matrix)
	m = matrix.size
	n = matrix.first.size

	glass_m_size = 3
	glass_n_size = 3

	hourglass_mask = []
	hourglass_mask << [1, 1, 1]
	hourglass_mask << [0, 1, 0]
	hourglass_mask << [1, 1, 1]


	if start_m+glass_m_size<=m && start_n+glass_n_size<=n
		hourglass_matrix = Array.new(glass_m_size)
		(start_m...start_m+glass_m_size).each_with_index do |i, row_idx|
			hourglass_matrix[row_idx] = Array.new(glass_n_size)
			(start_n...start_n+glass_n_size).each_with_index do |j, col_idx|
				if j<n && hourglass_mask[row_idx][col_idx]==1
					hourglass_matrix[row_idx][col_idx] = matrix[i][j]
				else
					hourglass_matrix[row_idx][col_idx] = 0
				end
			end
		end
	end

	hourglass_matrix
end

def print_matrix(matrix)
	matrix.each do |row|
		puts '| '+row.join(' ')+' |'
	end
	puts ''
end