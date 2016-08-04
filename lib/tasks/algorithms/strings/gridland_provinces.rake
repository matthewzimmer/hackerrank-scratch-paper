# Max Score: 80
# Difficult: Difficult

# The Kingdom of Gridland contains P provinces. Each province is defined as a 2xN grid where each cell in the grid represents
# a city. Every cell in the grid contains a single lowercase character denoting the first character of the city name
# corresponding to that cell.
#
# From a city with the coordinates (i,j), it is possible to move to any of the following cells in 1 unit of time
# (provided that the destination cell is within the confines of the grid):
#
#     ( i-1, j )
#     ( i+1, j )
#     ( i, j-1 )
#     ( i, j+1 )
#
#
# A knight wants to visit all the cities in Gridland. He can start his journey in any city and immediately stops his
# journey after having visited each city at least once. Moreover, he always plans his journey in such a way that the
# total time required to complete it is minimum.
#
# After completing his tour of each province, the knight forms a string by concatenating the characters of all the
# cells in his path. How many distinct strings can he form in each province?
#
#
#  [Input Format]
#
# The first line contains a single integer, P, denoting the number of provinces. The 3*P subsequent lines describe
# each province over the following three lines:
#
#     The first line contains an integer, N, denoting the number of columns in the province.
#     Each of the next two lines contains a string, S, of length N denoting the characters for
#     the first and second row of the province.
#
#  [Constraints]
#
#     1 <= P <= 15
#     1 <= N <= 600
#     Si ∈ {a-z}
#
#
# [Output Format]
#
# For each province, print the number of distinct strings the knight can form on a new line.
#
#
# [Sample Input]
#
#   3       (P)
#   1       (N)

#   a       (P1 cities of length N)
#   a       (P1 cities of length N)
#   1       (Answer)

#   3       (N)
#   dab     (province 1 of length N)
#   abd     (province 2 of length N)
#   8       (Answer)

#   5       (N)
#   ababa   (province 1 of length N)
#   babab   (province 2 of length N)
#   2       (Answer)
#
#
#  [Sample Output]
#
#     1
#     8
#     2
#
namespace :algorithms do

  namespace :strings do

    SCAN_DIRECTION_COLUMN = 1
    SCAN_DIRECTION_ROW = 2

    task :mock => :environment do
      @provinces = []
      # @provinces << ['a'.scan(/\w/), 'a'.scan(/\w/)]
      # @provinces << ['dab'.scan(/\w/), 'abd'.scan(/\w/)]
      # @provinces << ['dab'.scan(/\w/), 'abd'.scan(/\w/), 'adb'.scan(/\w/)]
      # @provinces << ['ababa'.scan(/\w/), 'babab'.scan(/\w/)]
      # @provinces << ['aba'.scan(/\w/), 'aba'.scan(/\w/)]
      # @provinces << ['apslwodkejfitmgkflwodiendlficmeowlqnaifn'.scan(/\w/), 'qirofidklgofkcmdnrkrokdkwjwmckfldlwmvbvw'.scan(/\w/)]
      # @provinces << ['ereowereda'.scan(/\w/), 'prewodfdre'.scan(/\w/), 'cdrewqoeld'.scan(/\w/)]
      # @provinces << ['poiuytrewqep'.scan(/\w/), 'zasxcdfvgbxz'.scan(/\w/)]
      # @provinces << ['qwertyuioplkjhg'.scan(/\w/), 'zasxdcvfgbnhjmk'.scan(/\w/)]

      # @provinces << [ 'x'.scan(/\w/), 'x'.scan(/\w/) ]
      # @provinces << [ 'cccdd'.scan(/\w/),  'ccccc'.scan(/\w/) ]
      @provinces << ['abbaa'.scan(/\w/), 'aaaaa'.scan(/\w/)]

      @provinces
    end

    # task :gridland_provinces_scratch, [] => [:environment, :mock] do |t, args|
    #   # algorithm spec:
    #   #
    #   #  1. iterate over all items in mxn matrix from (0,0) ending at (m,n)
    #   #
    #   #  2. for every (i,j), travel through all of mxn marking each traveled location as nil
    #   #  3. Travel conditions:
    #   #
    #   #       * If (i+1,j), (i-1,j), (i,j+1) or (i,j-1) are not within mxn bounds, unsafe travels.
    #   #       * If (i,j) has right neighbors and left neighbors, safe travels.
    #   #       * If (i,j) has left,right,up,down neighbors, safe travels.
    #   #
    #   #  4. Travel to as many cities without hitting a dead end until all cities have been traveled to.
    #   #  6. Tally up all voyages with a traveled city counts equal to mxn.
    #   p = @provinces.size
    #
    #   p.times.each do |province_id|
    #     map = deep_clone(@provinces[province_id])
    #
    #     m = map.size
    #     n = map.first.size
    #
    #     row_bounds = (0...m)
    #     col_bounds = (0...n)
    #
    #     voyages = []
    #     m.times.each do |row| # rows
    #       n.times.each do |col| # columns
    #         stack = [[row, col]]
    #         city_voyages_column_only = find_next_cities(stack, deep_clone(map), row_bounds, 1)
    #         city_voyages_column_only.each do |voyage|
    #           if voyage.size == (m*n)
    #             voyages << voyage
    #           end
    #         end
    #
    #         city_voyages_rows_only = find_next_cities(stack, deep_clone(map), row_bounds, 2)
    #       end
    #     end
    #
    #
    #     puts 'Map: '
    #     puts ''
    #     puts map.first.join('')
    #     puts map.last.join('')
    #     puts ''
    #     puts ''
    #
    #     voyage_words = voyages.map { |voyage| voyage_string(voyage, map) }
    #     uniq_voyages = voyage_words.uniq
    #
    #     puts "p#{province_id} voyage words: "
    #     ap uniq_voyages
    #     puts ''
    #
    #     puts "p#{province_id} ANSWER: #{uniq_voyages.size}"
    #
    #     puts ''
    #     puts ''
    #
    #   end
    #
    # end


    task :gridland_provinces, [:mock] => [:environment, :mock] do |t, args|
      # algorithm spec:
      #
      #  1. iterate over all items in mxn matrix from (0,0) ending at (m,n)
      #
      #  2. for every (i,j), travel through all of mxn marking each traveled location as nil
      #  3. Travel conditions:
      #
      #       * If (i+1,j), (i-1,j), (i,j+1) or (i,j-1) are not within mxn bounds, unsafe travels.
      #       * If (i,j) has right neighbors and left neighbors, safe travels.
      #       * If (i,j) has left,right,up,down neighbors, safe travels.
      #
      #  4. Travel to as many cities without hitting a dead end until all cities have been traveled to.
      #  6. Tally up all voyages with a traveled city counts equal to mxn.

      provinces = []

      debug = args[:mock].to_b
      if debug
        provinces = @provinces.map { |province| [province.first.size, province] }
      else
        p = STDIN.gets.strip.to_i
        p.times.each do |province_id|
          n = STDIN.gets.strip.to_i
          s1 = STDIN.gets.strip.scan(/\w/)
          s2 = STDIN.gets.strip.scan(/\w/)
          provinces << [n, [s1, s2]]
        end
      end

      provinces.each_with_index do |province, province_id|
        map = province.last
        m = map.size
        n = province.first

        row_bounds = (0...m)
        col_bounds = (0...n)

        voyages = []
        m.times.each do |row| # rows
          n.times.each do |col| # columns
            new_map = deep_clone(map)
            stack = [[row, col]]

            city_voyages_column_scan_only = find_next_cities(stack, map, new_map, row_bounds, col_bounds, SCAN_DIRECTION_COLUMN|SCAN_DIRECTION_ROW)
            city_voyages_column_scan_only.each do |voyage|
              if voyage.size == (m*n)
                voyages << voyage
              end
            end

          end
        end

        # voyage_words = voyages.map { |voyage| voyage_string(voyage, map) }
        # uniq_voyages = voyage_words.uniq
        # uniq_voyages = voyage_words
        uniq_voyages = []
        voyages.each_with_index do |v, idx|
          # if idx > 0
            dup_found = false
            uniq_voyages.each_with_index do |saved_voyage, jdx|
              if v.to_s == saved_voyage.to_s
                # puts "Duplicate found at saved_voyages[#{jdx}] for voyages[#{idx}]: #{saved_voyage.to_s}"
                dup_found = true
                break
              end
            end
            unless dup_found
              uniq_voyages << v
            end
          # else
          #   uniq_voyages << voyage_string(v, map)
          # end
        end
        uniq_voyages_debug = uniq_voyages.map { |voyage| "#{voyage.first.to_s} --> #{voyage.to_s} --> #{voyage_string(voyage, map)}" }
        uniq_voyages = uniq_voyages.map { |voyage| voyage_string(voyage, map) }
        uniq_voyages = uniq_voyages.uniq


        if debug
          puts 'Map: '
          puts ''
          map.each { |m| puts m.join('') }
          puts ''
          puts ''

          # puts "p#{province_id} uniq voyages: "
          # ap uniq_voyages.sort
          # puts ''

          puts "p#{province_id} uniq voyage debug: "
          ap uniq_voyages_debug
          puts ''


          puts 'Map: '
          puts ''
          map.each { |m| puts m.join('') }
          puts ''
          puts ''

          puts "p#{province_id} uniq voyage words: "
          ap uniq_voyages.uniq.sort
          puts ''

          # puts "p#{province_id} ANSWER: #{uniq_voyages.size}"
          # puts ''
          puts "p#{province_id} ANSWER: #{uniq_voyages.uniq.sort..size}"

          puts ''
          puts ''
        else
          puts "#{uniq_voyages.size}"
        end

      end
    end
  end

end

def voyage_string(voyage, map)
  voyage.map { |c| map[c.first][c.last] }.join('')
end

def deep_clone(object)
  Marshal.load(Marshal.dump(object))
end

# scan_direction_mask:
#
#     1 - scan just across columns allow row scan only for edges of matrix
#     2 - scan just across columns allow row scan only for edges of matrix
#     3 - DEFAULT - scan both columns and rows
#
def find_next_cities(journey, globe, map, row_bounds, col_bounds, scan_direction_mask=SCAN_DIRECTION_COLUMN|SCAN_DIRECTION_ROW)
  next_cities = []
  journeys = []
  # journeys << journey

  row = journey.last.first
  col = journey.last.last

  if row_bounds.cover?(row) && col_bounds.cover?(col)
    #---------------------------------
    #|    x    |   row_u   |    x    |
    #---------------------------------
    #|  col_l  | (row,col) |  col_r  |
    #---------------------------------
    #|    x    |   row_d   |    x    |
    #---------------------------------
    row_d = row+1
    row_u = row-1

    col_r = col+1
    col_l = col-1

    next_cities << [row_d, col] if scan_direction_mask&SCAN_DIRECTION_ROW && safe_to_travel?(row_d, col, map, row_bounds, col_bounds)
    next_cities << [row, col_r] if scan_direction_mask&SCAN_DIRECTION_COLUMN && safe_to_travel?(row, col_r, map, row_bounds, col_bounds)
    next_cities << [row_u, col] if scan_direction_mask&SCAN_DIRECTION_ROW && safe_to_travel?(row_u, col, map, row_bounds, col_bounds)
    next_cities << [row, col_l] if scan_direction_mask&SCAN_DIRECTION_COLUMN && safe_to_travel?(row, col_l, map, row_bounds, col_bounds)

    # ap next_cities
  end

  # We're done in this city so remove ourselves from the map marking us as traveled to.
  map[row][col] = nil

  # For all new cities, create a new journey and map and travel to the next cities.
  new_map = deep_clone(map)
  new_journey = deep_clone(journey)
  next_cities.each_with_index do |next_city, idx|
    if idx == 0
      journey << deep_clone(next_city)
      safe_travels = find_next_cities(journey, globe, map, row_bounds, col_bounds, scan_direction_mask)
      # ap safe_travels
      journeys += safe_travels
    else
      new_map = deep_clone(new_map)
      new_journey = deep_clone(new_journey)
      new_journey << deep_clone(next_city)
      journeys += find_next_cities(new_journey, globe, new_map, row_bounds, col_bounds, scan_direction_mask)
    end
  end

  journeys << journey
  journeys
end

def safe_to_travel?(m, n, map, row_bounds, col_bounds)
  row_bounds.cover?(m) && col_bounds.cover?(n) && !map[m][n].nil?
end


def unit_test_4_input
  "
  15
  1
  x
  x
  5
  cccdd
  ccccc
  5
  abbaa
  aaaaa
  6
  aaaaaa
  aabbbb
  6
  ijklmi
  jklmij
  9
  aaaaaaaaa
  aabbaaaab
  7
  aaaaaaa
  acacdbd
  8
  baaaaabb
  ccccbbbc
  8
  aaaaaaaa
  aaaaaaaa
  7
  bbababa
  bbbabab
  9
  cbaacbbaa
  bbcacaaab
  10
  ababababab
  bababababa
  10
  rstrstrstr
  strstrstrs
  10
  bbaababbaa
  caccbbaaac
  10
  hggghggghg
  hhiigghihh
  "
end

def unit_test_4_output
  "
  1
  12
  16
  30
  24
  76
  78
  94
  1
  14
  110
  2
  60
  154
  152
  "
end