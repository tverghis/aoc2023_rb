class EngineSchematic
  attr_accessor :matrix

  def initialize(matrix)
    @matrix = matrix
  end

  def self.from_lines(lines)
    matrix = lines.map { |l| l.chars }
    EngineSchematic.new(matrix)
  end

  def num_rows
    @matrix.length
  end

  def num_cols
    @matrix.first.length
  end

  def part_numbers
    visited = @matrix.map { |row| row.map { |col| false } }
    part_numbers = []

    for i in 0...num_rows
      for j in 0...num_cols
        if symbol?(@matrix[i][j])
          adjacent_numbers(i, j, visited).each { |n| part_numbers << n }
        end
      end
    end

    part_numbers
  end

  def gear_ratios
    visited = matrix.map { |row| row.map { |col| false } }
    ratios = []

    for i in 0...num_rows
      for j in 0...num_cols
        if @matrix[i][j] == "*"
          adjacent = adjacent_numbers(i, j, visited)
          if adjacent.length == 2
            ratios << adjacent.inject(:*)
          end
        end
      end
    end

    ratios
  end

  private

  def adjacent_numbers(ridx, cidx, visited)
    adj = []
    for r in ridx-1..ridx+1
      for c in cidx-1..cidx+1
        if (r < 0) || (r >= num_rows) ||
            (c < 0) || (c >= num_rows) ||
            visited[r][c]
          next
        end

        if digit?(@matrix[r][c])
          n_start = n_end = c
          visited[r][c] = true

          while (n_start - 1 >= 0) && (digit?(@matrix[r][n_start - 1]))
            n_start -= 1
            visited[r][n_start] = true
          end

          while (n_end + 1 <= num_cols) && (digit?(@matrix[r][n_end + 1]))
            n_end += 1
            visited[r][n_end] = true
          end

          adj << @matrix[r][n_start..n_end].join.to_i
        end
      end
    end

    adj
  end
end

def digit?(c)
  c in "0".."9"
end

def symbol?(c)
  # Assumes that the input only contains digits, symbols and periods
  !digit?(c) && (c != ".")
end

if __FILE__ == $0
  m = EngineSchematic.from_lines(File.readlines("input.txt"))

  puts "Part 1: #{m.part_numbers.sum}"
  puts "Part 2: #{m.gear_ratios.sum}"
end
