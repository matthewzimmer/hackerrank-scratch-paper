def run!
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

  p = gets.strip.to_i
  p.times.each do |province_id|
    n = gets.strip.to_i
    s1 = gets.strip.scan(/\w/)
    s2 = gets.strip.scan(/\w/)
    provinces << [n, [s1, s2]]
  end

  provinces.each_with_index do |province, province_id|
    map = province.last
    m = map.size
    n = province.first

    row_bounds = (0...m)
    col_bounds = (0...n)

    voyages = []
    m.times.each do |row|
      n.times.each do |col|
        new_map = deep_clone(map)
        stack = [[row, col]]

        city_voyages_scan_both = find_next_cities(stack, new_map, row_bounds, col_bounds, SCAN_DIRECTION_COLUMN|SCAN_DIRECTION_ROW)
        city_voyages_scan_both.each do |voyage|
          voyages << voyage if voyage.size == (m*n)
        end

      end
    end

    voyage_words = voyages.map { |voyage| voyage_string(voyage, map) }
    uniq_voyages = voyage_words.uniq

    puts "#{uniq_voyages.size}"
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
def find_next_cities(journey, map, row_bounds, col_bounds, scan_direction_mask=SCAN_DIRECTION_COLUMN|SCAN_DIRECTION_ROW)
  next_cities = []
  journeys = []
  journeys << journey

  row = journey.last.first
  col = journey.last.last

  if row_bounds.cover?(row) && col_bounds.cover?(col)
    row_d = row+1
    row_u = row-1

    col_r = col+1
    col_l = col-1

    #  ------------------------------
    #  |    x    |   row_u   |    x    |
    #  ------------------------------
    #  |  col_l  | (row,col) |  col_r  |
    #  ------------------------------
    #  |    x    |   row_d   |    x    |
    #  ------------------------------

    possibilities = []
    possibilities << [row_d, col]
    possibilities << [row_u, col]
    possibilities << [row, col_r]
    possibilities << [row, col_l]

    possibilities.each do |coordinates|
      if safe_to_travel?(coordinates.first, coordinates.last, map, row_bounds, col_bounds)
        next_cities << coordinates
      end
    end
  end

  # We're done in this city so remove ourselves from the map marking us as traveled to.
  map[row][col] = nil

  # For all new cities, create a new journey and map and travel to new destinations.
  new_map = deep_clone(map)
  new_journey = deep_clone(journey)
  next_cities.each_with_index do |next_city, idx|
    if idx == 0
      journey << deep_clone(next_city)
      find_next_cities(journey, map, row_bounds, col_bounds, scan_direction_mask)
    else
      new_map = deep_clone(new_map)
      new_journey = deep_clone(new_journey)
      new_journey << deep_clone(next_city)
      new_stacks = find_next_cities(new_journey, new_map, row_bounds, col_bounds, scan_direction_mask)
      journeys += new_stacks
    end
  end

  journeys
end

def safe_to_travel?(m, n, map, row_bounds, col_bounds)
  row_bounds.cover?(m) && col_bounds.cover?(n) && !map[m][n].nil?
end

run!