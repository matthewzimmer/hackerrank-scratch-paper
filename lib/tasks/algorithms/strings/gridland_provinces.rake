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

    task :mock => :environment do
      p1r1 = ['a']
      p1r2 = ['a']

      p2r1 = %w(d a b)
      p2r2 = %w(a b d)

      p3r1 = %w(a b a b a)
      p3r2 = %w(b a b a b)

      @provinces = []
      p1 = [p1r1, p1r2]
      p2 = [p2r1, p2r2]
      p3 = [p3r1, p3r2]
      @provinces << p1
      @provinces << p2
      @provinces << p3

      @provinces
    end

    task :gridland_provinces, [] => :environment do |t, args|

    end

    task :gridland_provinces_scratch, [] => [:environment, :mock] do |t, args|
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
      P = @provinces.size

      P.times.each do |province_id|
        map = deep_clone(@provinces[province_id])

        m = map.size
        n = map.first.size

        row_bounds = (0...m)
        col_bounds = (0...n)

        voyages = []
        m.times.each do |row| # rows
          n.times.each do |col| # columns
            new_map = deep_clone(map)
            stack = [[row, col]]
            next_paths = find_paths_from_city(stack, new_map, row_bounds, col_bounds)
            ap next_paths
            next_paths.each do |voyage|
              if voyage.size == (m*n)
                voyages << voyage
              end
            end
          end
        end

        puts "p#{province_id} voyages: "
        ap voyages
        puts ''

        voyage_words = []
        voyages.each do |voyage|
          voyage_words << voyage.map{|c|map[c.first][c.last]}.join('')
        end

        uniq_voyages = voyage_words.uniq

        puts "p#{province_id} voyage words: "
        ap uniq_voyages
        puts ''

        puts "p#{province_id} ANSWER: #{uniq_voyages.size}"

        puts ''
        puts ''

      end

    end

  end

end

def deep_clone(object)
  Marshal.load(Marshal.dump(object))
end

def find_paths_from_city(stack, map, row_bounds, col_bounds)
  m = map.length
  n = map.map { |r| r.length }.max

  next_paths = []
  stacks = []
  stacks << stack

  row = stack.last.first
  col = stack.last.last

  if row_bounds.cover?(row) && col_bounds.cover?(col)
    #  ------------------------------
    #  |    x    | row_u  |    x    |
    #  ------------------------------
    #  |  col_l  |   *    |  col_r  |
    #  ------------------------------
    #  |    x    | row_d  |    x    |
    #  ------------------------------

    row_d = row+1
    row_u = row-1

    col_r = col+1
    col_l = col-1

    [
        [row_u, col],
        [row_d, col],
        [row, col_l],
        [row, col_r]
    # [row_d, col_r],
    # [row_u, col_l]
    ].each do |coordinates|
      if safe_to_travel?(coordinates.first, coordinates.last, map, row_bounds, col_bounds)
        next_paths << coordinates
      end
    end

    # We're done here so remove ourselves from the map marking us as traveled
    map[row][col] = nil
  end

  # For all new paths, create a new stack and map and travel to new destinations.
  new_map = deep_clone(map)
  new_stack = deep_clone(stack)
  next_paths.each_with_index do |next_city, idx|
    if idx == 0
      stack << next_city
      find_paths_from_city(stack, map, row_bounds, col_bounds)
    else
      new_map = deep_clone(new_map)
      new_stack = deep_clone(new_stack)
      new_stack << next_city
      new_stacks = find_paths_from_city(new_stack, new_map, row_bounds, col_bounds)
      stacks += new_stacks
    end
  end

  stacks
end

def safe_to_travel?(m, n, map, row_bounds, col_bounds)
  # ([row_bounds.min, col_bounds.min] != [m,n]) && ([row_bounds.max, col_bounds.max] != [m,n])
  row_bounds.cover?(m) && col_bounds.cover?(n) && !map[m][n].nil?
end