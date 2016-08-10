namespace :algorithms do
	namespace :implementation do

		task :jumping_on_the_clouds, [:n, :clouds] do |t, args|
			n = (args[:n]||STDIN.gets.strip).to_i
			clouds = (args[:clouds]||STDIN.gets.strip).split(' ').map(&:to_i)

			hops = next_cloud_from_current_position(clouds, 0)
			print hops.size > 0 ? hops.map(&:size).min : 0
		end

	end
end

def build_cloud_permutations(clouds)

end

def next_cloud_from_current_position(clouds, current_position, hops=[])
	all_hops = []
	if current_position >= clouds.size-1
		all_hops << hops unless hops.nil?
	else
		# next_hops = clouds[current_position+1..current_position+2]
		hop_counts = [2, 1]
		hops_dup = Marshal.load(Marshal.dump(hops))
		hop_counts.each_with_index do |hop_count, idx|
			next_position = current_position+hop_count
			next_hop = clouds[next_position] rescue nil
			if next_hop == 0
				hops_alt = Marshal.load(Marshal.dump(hops_dup))
				hops_alt << next_position
				result = next_cloud_from_current_position(clouds, next_position, hops_alt)
				all_hops << result.first unless result.first.nil?
			# else
			# 	puts "~-~-~~-~-~~~-~~~------ YOU DIED at cloud #{next_position} from cloud #{current_position}!"
			end
		end
	end
	all_hops
end